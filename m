Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE9EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9076D22B48
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKAF37rD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9076D22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFsY-0002Zg-Uc
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFfB-00016n-Ad
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFfA-0004XO-04
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:17 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFf9-0004Vw-QA
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:15 -0500
Received: by mail-pl1-x642.google.com with SMTP id x13so443510plr.9
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JWpl4dTJywBw8dk4WBNibniYDIKR8WNVBGRxmrDjrqI=;
 b=lKAF37rDeJwPJJzCVjRsrmVOwoq2hL4644wwI/qCwCYqryAMD88LiuofJSjSc2wbx1
 L+ali8Cl+rvvOXZDCOdY2yqCQwz01B6uLU6X3f2//gZhf/ndHjU4zyBjcCkiPiNkrz4C
 i6SgCednOhD+cK05Y/08UsbAHvzN7FqQGmwnI64I23E7UxI7Px7nBzW5CeaqKa6LN0+K
 mLIRH31VOO4pc+BYw5g9MK0XRljkZ/O/cj2IEFwtsA+DLZe7whzvtL6Bcz5XQDifTcM9
 PPiGZyV6to7o1o0M6x1wOgJLrlX9CTq+sbkGn2uidWNJUzHHBs/vjMTfaWgPwMOrlbxv
 tJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JWpl4dTJywBw8dk4WBNibniYDIKR8WNVBGRxmrDjrqI=;
 b=SRxpjtnjuW7+HliNEKHPNL83zFLEQ1a8DHJeW+hgAr0MoDOWiQnhUx+p/lQvg7AiR0
 m1geQY7WpZM6xtxyyO3exiTwqiX6+7NcBb7nn/qJtphDWwDKQrfS1xCAPTcdg0ctbnjj
 6wVZLrzn4JawNeQ4zA6A4Vg/UlIQz1cRg9djGmFwjuppPKtVgTgnYzIT35K7KOPvrFLA
 oNgIkCzZMeaKSvMmkNNf5srrer6wir3bu1hqhzFXO+pCIy4nQnrv5bxuqbUX66t60RBV
 traPPSh7KCaBI3uZ11CtXqmcRp4DYX4qz8EANUgSobEbfcrgIRHdZhIZbuOeD7N8iXCy
 dkfw==
X-Gm-Message-State: APjAAAVm6hLQzw/h6FOcna6+zkQtn6IFt1OPSGcU4WdNhv9E9nh5bQCJ
 JYKMk8FnABwmYQFADAevzHEVH5ZQzc8=
X-Google-Smtp-Source: APXvYqx80jEZM4tYvc2SvKg0t14l04dBqVCLsJrpRibL1qYFzamtq4K8QgFGXU2NbpOf5BCUnEkyWA==
X-Received: by 2002:a17:90b:8cf:: with SMTP id
 ds15mr7663891pjb.134.1576123274493; 
 Wed, 11 Dec 2019 20:01:14 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:01:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/28] target/ppc: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
Date: Wed, 11 Dec 2019 20:00:37 -0800
Message-Id: <20191212040039.26546-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are only two uses.  Within dcbz_common, the local variable
mmu_idx already contains the epid computation, and we can avoid
repeating it for the store.  Within helper_icbiep, the usage is
trivially expanded using PPC_TLB_EPID_LOAD.

Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h        |  2 --
 target/ppc/mem_helper.c | 11 ++---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e3e82327b7..3bd983adaa 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -951,8 +951,6 @@ struct ppc_radix_page_info {
  * + real/paged mode combinations. The other two modes are for
  * external PID load/store.
  */
-#define MMU_MODE8_SUFFIX _epl
-#define MMU_MODE9_SUFFIX _eps
 #define PPC_TLB_EPID_LOAD 8
 #define PPC_TLB_EPID_STORE 9
 
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 1351b53f28..56855f2381 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -177,14 +177,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     } else {
         /* Slow path */
         for (i = 0; i < dcbz_size; i += 8) {
-            if (epid) {
-#if !defined(CONFIG_USER_ONLY)
-                /* Does not make sense on USER_ONLY config */
-                cpu_stq_eps_ra(env, addr + i, 0, retaddr);
-#endif
-            } else {
-                cpu_stq_data_ra(env, addr + i, 0, retaddr);
-            }
+            cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
         }
     }
 }
@@ -216,7 +209,7 @@ void helper_icbiep(CPUPPCState *env, target_ulong addr)
 #if !defined(CONFIG_USER_ONLY)
     /* See comments above */
     addr &= ~(env->dcache_line_size - 1);
-    cpu_ldl_epl_ra(env, addr, GETPC());
+    cpu_ldl_mmuidx_ra(env, addr, PPC_TLB_EPID_LOAD, GETPC());
 #endif
 }
 
-- 
2.20.1


