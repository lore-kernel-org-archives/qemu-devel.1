Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0125DC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B182075B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Skq7d1PQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B182075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huclX-00034W-3G
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 09:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52778)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huckS-0000Zk-0f
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huckQ-00048e-6J
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:09:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huckP-00047q-W2
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:09:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so59286444wrr.4
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EGU+/MpxT8YGsEWvI+W5cKlSVCq/nVM+/LNMb9QzO4c=;
 b=Skq7d1PQQKXxFfH2kBZuqrlsKs2tQBGi3UzIQBCmxL67trB3L7Vk26REcFp7wkj1Dd
 rXBhaaHOYFtjnCEiYv/6JOeo/cnMxX89KCrMKy+yXypK8dDMdk3ohpwjlBcVDrU2nAVG
 NHCmJft3LidBo8Y7lAcuMoxYSWKdoQhhMljJFfTrGY428O8ywENkxrhSB4IwVaAGvLGx
 hagIdEQ8DM4xNPXD3Kw9IssVdLlTeB69IWiSR24Ak4fht072PqcAEAWdamZ6+T9UvyYA
 h80S5IlHdlsNo/QnJeIcpKDphmsO2u4R4oOX2oIcwQIwsOgf9r34ote8wU90nu4+Wu9k
 o0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EGU+/MpxT8YGsEWvI+W5cKlSVCq/nVM+/LNMb9QzO4c=;
 b=K+A2kRQMhWsdRH52aztsR9K6goBbizouxdKHw+v6ZpHkymYtENS6jYUW5D8lx2L6QY
 efu8EJsss6TdSLj5thL8LTwKIJw2SiuIdxFFlq6NO/2gktgXbPgl5kQwnKKYuy2mkrax
 /bMOEL4mX6zlkVJr/jUJyuERH2OATbeNptr+IBAHFUHs1tEzvCMReETHlM7pSpPN9rRt
 oaWH4ggwUfuqMmzz0FMTJ6Vm2lm4QcKZFYYiJRGaWt1KmsWCwC2VaVDwhc8hUcUh3zmt
 2VEsiCHeGdB1Bps87VfLWW5p+BpmHtr4MBpOjuMJ61ZEi5xfcfq1JJiTjen5YkAuiJy3
 abDw==
X-Gm-Message-State: APjAAAWIdZtasPNBXd5hp4DUlKWvSUPNJQqy3kOi5BvchSiFzNEwyzI5
 IUb96/BbQGMR3wGOzy9ARFPkkg==
X-Google-Smtp-Source: APXvYqxMQVQ0c1c2tYLsA8gBlQWBr8kNv1iLHwt/IedU9qG50h+w9Mx613ojRnZLxVngj+m1WHHQJQ==
X-Received: by 2002:adf:df10:: with SMTP id
 y16mr140679568wrl.302.1565010596914; 
 Mon, 05 Aug 2019 06:09:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x20sm65233782wmc.1.2019.08.05.06.09.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 05 Aug 2019 06:09:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 14:09:52 +0100
Message-Id: <20190805130952.4415-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805130952.4415-1-peter.maydell@linaro.org>
References: <20190805130952.4415-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 2/2] target/arm: Fix routing of singlestep
 exceptions
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When generating an architectural single-step exception we were
routing it to the "default exception level", which is to say
the same exception level we execute at except that EL0 exceptions
go to EL1. This is incorrect because the debug exception level
can be configured by the guest for situations such as single
stepping of EL0 and EL1 code by EL2.

We have to track the target debug exception level in the TB
flags, because it is dependent on CPU state like HCR_EL2.TGE
and MDCR_EL2.TDE. (That we were previously calling the
arm_debug_target_el() function to determine dc->ss_same_el
is itself a bug, though one that would only have manifested
as incorrect syndrome information.) Since we are out of TB
flag bits unless we want to expand into the cs_base field,
we share some bits with the M-profile only HANDLER and
STACKCHECK bits, since only A-profile has this singlestep.

Fixes: https://bugs.launchpad.net/qemu/+bug/1838913
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
In theory it would be possible to use just a single TB flag
bit, because other than the route_to_el2 bool, all the
state arm_debug_target_el() checks is either constant or
known from other TB flags. But I think trying to do this
would be pretty hard to maintain and might well break
anyway with future architectural changes.

Slightly less painfully we could reclaim the existing
TBFLAG_ANY_SS_ACTIVE, since the debug target EL can't
be 0 and is irrelevant if SS is not active, so we
could arrange for SS_ACTIVE to be DEBUG_TARGET_EL == 0.
But we're going to have to overspill into cs_base pretty
soon anyway so I'm not too keen on being very stingy with
the current flags word at the expense of maintainability.
---
 target/arm/cpu.h           |  5 +++++
 target/arm/translate.h     | 15 +++++++++++----
 target/arm/helper.c        |  6 ++++++
 target/arm/translate-a64.c |  2 +-
 target/arm/translate.c     |  4 +++-
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 94c990cddbd..23ca6c79144 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3142,6 +3142,11 @@ FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)
 /* Target EL if we take a floating-point-disabled exception */
 FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
 FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
+/*
+ * For A-profile only, target EL for debug exceptions.
+ * Note that this overlaps with the M-profile-only HANDLER and STACKCHECK bits.
+ */
+FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 21, 2)
 
 /* Bit usage when in AArch32 state: */
 FIELD(TBFLAG_A32, THUMB, 0, 1)
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 45053190baa..b65954c669b 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -50,6 +50,8 @@ typedef struct DisasContext {
     uint32_t svc_imm;
     int aarch64;
     int current_el;
+    /* Debug target exception level for single-step exceptions */
+    int debug_target_el;
     GHashTable *cp_regs;
     uint64_t features; /* CPU features bits */
     /* Because unallocated encodings generate different exception syndrome
@@ -70,8 +72,6 @@ typedef struct DisasContext {
      * ie A64 LDX*, LDAX*, A32/T32 LDREX*, LDAEX*.
      */
     bool is_ldex;
-    /* True if a single-step exception will be taken to the current EL */
-    bool ss_same_el;
     /* True if v8.3-PAuth is active.  */
     bool pauth_active;
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
@@ -251,8 +251,15 @@ static inline void gen_exception(int excp, uint32_t syndrome,
 /* Generate an architectural singlestep exception */
 static inline void gen_swstep_exception(DisasContext *s, int isv, int ex)
 {
-    gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, isv, ex),
-                  default_exception_el(s));
+    bool same_el = (s->debug_target_el == s->current_el);
+
+    /*
+     * If singlestep is targeting a lower EL than the current one,
+     * then s->ss_active must be false and we can never get here.
+     */
+    assert(s->debug_target_el >= s->current_el);
+
+    gen_exception(EXCP_UDEF, syn_swstep(same_el, isv, ex), s->debug_target_el);
 }
 
 /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b74c23a9bc0..24806c16ca2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11170,6 +11170,12 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     }
 
+    if (!arm_feature(env, ARM_FEATURE_M)) {
+        int target_el = arm_debug_target_el(env);
+
+        flags = FIELD_DP32(flags, TBFLAG_ANY, DEBUG_TARGET_EL, target_el);
+    }
+
     *pflags = flags;
     *cs_base = 0;
 }
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f6729b96fd0..90850eadc1b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14180,7 +14180,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->ss_active = FIELD_EX32(tb_flags, TBFLAG_ANY, SS_ACTIVE);
     dc->pstate_ss = FIELD_EX32(tb_flags, TBFLAG_ANY, PSTATE_SS);
     dc->is_ldex = false;
-    dc->ss_same_el = (arm_debug_target_el(env) == dc->current_el);
+    dc->debug_target_el = FIELD_EX32(tb_flags, TBFLAG_ANY, DEBUG_TARGET_EL);
 
     /* Bound the number of insns to execute to those left on the page.  */
     bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 19b9d8f2725..b32508cd2f9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11882,7 +11882,9 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->ss_active = FIELD_EX32(tb_flags, TBFLAG_ANY, SS_ACTIVE);
     dc->pstate_ss = FIELD_EX32(tb_flags, TBFLAG_ANY, PSTATE_SS);
     dc->is_ldex = false;
-    dc->ss_same_el = false; /* Can't be true since EL_d must be AArch64 */
+    if (!arm_feature(env, ARM_FEATURE_M)) {
+        dc->debug_target_el = FIELD_EX32(tb_flags, TBFLAG_ANY, DEBUG_TARGET_EL);
+    }
 
     dc->page_start = dc->base.pc_first & TARGET_PAGE_MASK;
 
-- 
2.20.1


