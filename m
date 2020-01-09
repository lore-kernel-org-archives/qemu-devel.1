Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89945C33CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562E620705
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jqLvji6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562E620705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNuj-0004dM-Qh
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNsv-0002mg-M1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNss-00061s-Sh
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:21 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNss-0005zX-KJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:18 -0500
Received: by mail-pj1-x1043.google.com with SMTP id bg7so464912pjb.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oYo91seWJSqDhs3XCiSQHvutnJwwuv/GyZ2g9/2606w=;
 b=jqLvji6f8WTRRN7e7Bp3O7yyqgwDG4DaAmt5URX3fMbc0lIRWBRpZwcdbejZtPO+Ai
 4BiflENdMsF+y6FYjL9kIz+UB6qpHVXzAJIOmRb2FF4AdYtLMZIYWytF12gR7OBw0UgG
 YfHlGO/N+1LjDd9xuYHo2EH+2k7LcjuZ3TBKSuaLt/5BK9hzNPt2icvx02QX0yCevxKA
 CT9xBScazARDa4b62CpfjrNepQDqikZLgwaU+z/SHyQd9EKhozRCrpjqa9O3x/rXFqgF
 h2wtJCSqNuH7TbeLCvD/oAPy0B5EMA7/NXYR/DkEPWrX9GR46GZc26/psKRyay5d/29W
 L0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oYo91seWJSqDhs3XCiSQHvutnJwwuv/GyZ2g9/2606w=;
 b=VkX/7Vf05LW7BwGYqXe5XY9eytlwmfzIbD/ejaxqbUmCGC46Damy2TGAXDlHXjm/DE
 ciX4QsO+kH79B26eUuST+K5gODdleXq5vT90QuEaUzuoEJEK7WC2LAQKeOL+T05nGCLf
 5Mwcn6EzEFWRmXFvMfCbaNdaX5BAOsirB1qNMdZhSS4y/dBQfzPPtpWLjRNg+9UgwCKj
 /LNtFroXuSQTffpYeEp6X1BeICGXyfcG8mbwjdLcteYxDPnONsLg/PObQgxGha65nALi
 08WLE+kJIw3n80olgQlFIpBPRfco6rgxk1hDsuo6IzpTzcSHMif5c7kFKVE+degqJogj
 Rqiw==
X-Gm-Message-State: APjAAAU0i3+jLKdkiZhlN2CkvZ5Z3eY0O7R/0rQroOcH0o0LTJyLC5eK
 bpHJEFR5jZewtxZzeScL2yNBk5orwM92uQ==
X-Google-Smtp-Source: APXvYqzsZYImwwUgjb49sHvfUoYeXtnlhX1V7lHOkJIE1ujwBh9N0nKTssVvMX4Oh7zK9pOBPR46PA==
X-Received: by 2002:a17:902:248:: with SMTP id
 66mr9302085plc.158.1578538157239; 
 Wed, 08 Jan 2020 18:49:17 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id b4sm5337844pfd.18.2020.01.08.18.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:49:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/9] cputlb: Make tlb_n_entries private to cputlb.c
Date: Thu,  9 Jan 2020 13:49:00 +1100
Message-Id: <20200109024907.2730-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109024907.2730-1-richard.henderson@linaro.org>
References: <20200109024907.2730-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are no users of this function outside cputlb.c,
and its interface will change in the next patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 5 -----
 accel/tcg/cputlb.c      | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index a46116167c..53de19753a 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -234,11 +234,6 @@ static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
     return (addr >> TARGET_PAGE_BITS) & size_mask;
 }
 
-static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
-{
-    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
-}
-
 /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
 static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
                                      target_ulong addr)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 1a81886e58..e4a8ed9534 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -80,6 +80,11 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
 QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
+static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
+{
+    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
+}
+
 static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
 {
     return env_tlb(env)->f[mmu_idx].mask + (1 << CPU_TLB_ENTRY_BITS);
-- 
2.20.1


