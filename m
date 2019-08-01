Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D97C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23962064A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsTooEge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23962064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFrl-0007cP-6A
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59325)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqS-0005vY-Ue
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqR-0002SU-Ba
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htFqP-0002Ow-3v
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id p17so74604463wrf.11
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 11:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=11BLBQ0I862n2ukesABdkLLx6WuBlDoZA+ndLGv2CEc=;
 b=EsTooEge+SI5kpnI6euvICmDAKqpDk5m+i6T93iri3R+khApxn9Kf7ZMMHJcLcpJ0C
 XUajEkcoxwRr4EGE8RDpEHeR6kTRH+LOerDdhyprt7xrcyNkrYQDvZo+VCvYr/qgmNNy
 R1vpE+ItvEgDI5p0e+pu2ZYzhMnsASXYpIWWOF+ZIY9DQRiaXR42iGRu0We8XIgg+ep3
 OzM1mIjGrUB7GQWBuNk5/V3FlES4BDHQTjfkOrvI3kcbw2BYFviI58MIUgGG+iO9Lo8M
 6JFkCvnF+EmLB3zFA1KzU401dvljmTExu3biRYRaBn6UnAh0aWElvz2Q5bl4FduDJTsU
 43eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=11BLBQ0I862n2ukesABdkLLx6WuBlDoZA+ndLGv2CEc=;
 b=GwlZ0PB4dV25dVJR+PqKHX6AgR8Hb/i8OGWNnPeBajqcZK5E4ANC6CIBBSoWmrO7wo
 vvVIXoeHU/ZgYTe1lC03i0iZ2JgB27sJe6JLSBCEPG/7qP/zJlD3rVkC7t6fD/YuTMc7
 xRA34VNsvhCbyX+E58FXNL7l3TbB/Hw9sn75/KodqcvA2CNrPh9fn6Zo/8xldRketR02
 V0sfjqjQ454eiZ9ovBFffIFMiCiPOJSpLYI3gFHaDrPnef7tLsfbQWIMY9Hql7j/kWwa
 00IqS59y9PuGInAMf3lWEiyLuF5BSq5H1z/G6MsQ7/5z1PaBKl6rdgo2xOgFG5eavo2e
 r/eA==
X-Gm-Message-State: APjAAAVpr11Dx5JCVr4koHhpG861k5BHaR6C2ppMuczCxeVQHp/5Ffgd
 U/lueD0aSGSka6b+lVRTQtOUmh7E4kf6CA==
X-Google-Smtp-Source: APXvYqxxAIV04XBxqmVbbDv5zW+cZaxSJOBwy69kRmQn4Zl7NxgeFlNJ9CbbikI1Ni/ow2p1pYoLyg==
X-Received: by 2002:a05:6000:1043:: with SMTP id
 c3mr89266727wrx.236.1564684220251; 
 Thu, 01 Aug 2019 11:30:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e6sm71702104wrw.23.2019.08.01.11.30.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 11:30:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 19:30:10 +0100
Message-Id: <20190801183012.17564-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801183012.17564-1-peter.maydell@linaro.org>
References: <20190801183012.17564-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 5/7] target/sparc: Handle bus errors in
 mmu_probe()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the mmu_probe() function to using address_space_ldl()
rather than ldl_phys(), so we can explicitly detect memory
transaction failures.

This makes no practical difference at the moment, because
ldl_phys() will return 0 on a transaction failure, and we
treat transaction failures and 0 PDEs identically. However
the spec says that MMU probe operations are supposed to
update the fault status registers, and if we ever implement
that we'll want to distinguish the difference. For the
moment, just add a TODO comment about the bug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/mmu_helper.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 351055a09b1..d90aabfa4d2 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -287,11 +287,20 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
     CPUState *cs = env_cpu(env);
     hwaddr pde_ptr;
     uint32_t pde;
+    MemTxResult result;
+
+    /*
+     * TODO: MMU probe operations are supposed to set the fault
+     * status registers, but we don't do this.
+     */
 
     /* Context base + context number */
     pde_ptr = (hwaddr)(env->mmuregs[1] << 4) +
         (env->mmuregs[2] << 2);
-    pde = ldl_phys(cs->as, pde_ptr);
+    pde = address_space_ldl(cs->as, pde_ptr, MEMTXATTRS_UNSPECIFIED, &result);
+    if (result != MEMTX_OK) {
+        return 0;
+    }
 
     switch (pde & PTE_ENTRYTYPE_MASK) {
     default:
@@ -304,7 +313,11 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
             return pde;
         }
         pde_ptr = ((address >> 22) & ~3) + ((pde & ~3) << 4);
-        pde = ldl_phys(cs->as, pde_ptr);
+        pde = address_space_ldl(cs->as, pde_ptr,
+                                MEMTXATTRS_UNSPECIFIED, &result);
+        if (result != MEMTX_OK) {
+            return 0;
+        }
 
         switch (pde & PTE_ENTRYTYPE_MASK) {
         default:
@@ -318,7 +331,11 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
                 return pde;
             }
             pde_ptr = ((address & 0xfc0000) >> 16) + ((pde & ~3) << 4);
-            pde = ldl_phys(cs->as, pde_ptr);
+            pde = address_space_ldl(cs->as, pde_ptr,
+                                    MEMTXATTRS_UNSPECIFIED, &result);
+            if (result != MEMTX_OK) {
+                return 0;
+            }
 
             switch (pde & PTE_ENTRYTYPE_MASK) {
             default:
@@ -332,7 +349,11 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
                     return pde;
                 }
                 pde_ptr = ((address & 0x3f000) >> 10) + ((pde & ~3) << 4);
-                pde = ldl_phys(cs->as, pde_ptr);
+                pde = address_space_ldl(cs->as, pde_ptr,
+                                        MEMTXATTRS_UNSPECIFIED, &result);
+                if (result != MEMTX_OK) {
+                    return 0;
+                }
 
                 switch (pde & PTE_ENTRYTYPE_MASK) {
                 default:
-- 
2.20.1


