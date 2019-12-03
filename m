Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098FEC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDFD220684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edKy5gsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFD220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyEz-0007wd-IY
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxF-0003Ke-OW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxB-0008St-Au
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:19 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxA-0008JL-Sq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:17 -0500
Received: by mail-pj1-x1041.google.com with SMTP id l4so820902pjt.5
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bOBBih3JRg5ecnanCNy6UVzBnae0IWceZ3dWmja0LB0=;
 b=edKy5gsqSGsIb/Aqrmu0qeeKI61BFr9bt/o0qqxYEGF+lQDctNPGEMbqsFq0/bmaO6
 MZwR1OemnaTSNANgBoK8dgxPg3WQocTHMMN9r8mMURq4Qv4nrA9HDKPM0ctAOWOG55w9
 XcocPm3qRE1j1j3sNN+yyTc97TKQ4+MuPJDdPuIacCbDL6roV/cyNdFH7GbIow3L0M3g
 C/UVgElaX9sTrAA1fzuBPhM47s4MoEStcVIj6hsVfRz+qE38ztDRG3sx5Xh8C1CMNc6r
 MlPsgTfBZXQik8+HyG6niii47+zRiPE++DHnKoPz8nguZCGyXeAmX2PcS/YT0mN0fAlP
 2Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bOBBih3JRg5ecnanCNy6UVzBnae0IWceZ3dWmja0LB0=;
 b=SUo7kjESgMLE+10BqS8enmdr3bhnupWRcaY+9vHYuthzQ89qNWTLwrGdu0MdRE6yls
 C2OPJaGQkM6XsnAwEUGusF3cvhO3xAYGBgkiszU88AlOwbe54ySYf009rXVnGj3pjqVs
 IxGJoHC6a2SK2iEbQUCHbclt7t4De8kEkhRsdkDzsiwy7oDrwMs3unuzO3Ga0JGxH4bB
 EAh6hzGt4HENtG7BK20rw5g6om4hZaetZ9zFxNiNE+v0zs51RxuAwtwQKlrvTEjUTr8D
 90FsJDNBrUgF8gLqSoPIoR89fTuPPGRhzq0vNwFn18KgWEH+G2St3JvrXPQCJJChvOx3
 ll+w==
X-Gm-Message-State: APjAAAU1IAa0HXx1jNJmpxM/lJbW4NHc/NGGokSryey8KNjsiN3Zi8wp
 VRt5WbEf0ZhV7eSdEA5Vchi5PlJernw=
X-Google-Smtp-Source: APXvYqw4vPzxpEryNUONVsjLoHitknAN7OaJAi57P4XVvRvgjMwUbcladx0doFl1XAU92j4188ioAA==
X-Received: by 2002:a17:902:b188:: with SMTP id
 s8mr2570088plr.206.1575340209136; 
 Mon, 02 Dec 2019 18:30:09 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 23/40] target/arm: Update ctr_el0_access for EL2
Date: Mon,  2 Dec 2019 18:29:20 -0800
Message-Id: <20191203022937.1474-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update to include checks against HCR_EL2.TID2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ffa82b5509..9ad5015d5c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5212,11 +5212,27 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
 static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
-    /* Only accessible in EL0 if SCTLR.UCT is set (and only in AArch64,
-     * but the AArch32 CTR has its own reginfo struct)
-     */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
-        return CP_ACCESS_TRAP;
+    int cur_el = arm_current_el(env);
+
+    if (cur_el < 2) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        if (cur_el == 0) {
+            if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                if (!(env->cp15.sctlr_el[2] & SCTLR_UCT)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            } else {
+                if (!(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
+                    return CP_ACCESS_TRAP;
+                }
+                if (hcr & HCR_TID2) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            }
+        } else if (hcr & HCR_TID2) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
     return CP_ACCESS_OK;
 }
-- 
2.17.1


