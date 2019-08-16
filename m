Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B449C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074C820578
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Temk+DzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074C820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55977 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycBz-0001TE-UF
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6m-0003KF-DE
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6k-0005OS-EI
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6i-0005MP-FR
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:29 -0400
Received: by mail-wm1-x344.google.com with SMTP id g67so4054221wme.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=76ecM/cWxU2pi1qdezlFa30IZV4ybXEykWFXG4uli2k=;
 b=Temk+DzGTKIPpy9wvpuyzjyxDfdzQXCBLZxskC1vuP2nCe0vp5iwG+BTVzeegQ+Xdl
 L3RXkJz+LOzk7IsGQZMs6K3Vzn3VQ4UDqMkXx/FUtOHRhbVS6luc6qa7Lbk1V19CQKOc
 3OW14efJie9VNJLny5qdzECE919LMGfPRG/j1ZsD6guZGFy5aITI80LOBSf1Kren6Qm/
 qh0++P3/F/plmTFPqGKpiS2SunBXoLP/W0Zjlcn8sfDfs+96uOCsyXRdr2p73JIFN7x1
 HsXGDlucPLrB4tonmFnJA1tanTCrDoULRkH6AW2mty90lz0srn1d2BrN1Dcujoi7ntIc
 AvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=76ecM/cWxU2pi1qdezlFa30IZV4ybXEykWFXG4uli2k=;
 b=thdpiHq1j5tdMP2/skmcocjSu4k1+ESjDFBKQCkRptesXvL9nJ5cPzze0GoIZvu5gK
 1igaGb5nmCgscIyf4/HlkoCG8uOxXGHQ2YmFpa+zAHzY6ei4vlNolrGrDFDEUq17VY43
 V9tCil7DvbJoLXWCNlbGIK85MRvP35lRsWaP0GZ7AeimloK1RxeqQMP7g+PdS/bc5qOC
 hCXQrGHce7aSfhsbs6Mqjrzs4QRmkrnXx6ZKMChdTkaBCAugsLwps2lwADWr/YwhJXL2
 Vn/XVgK8tLoabw/o6E/cyCrJcgkQpUURN94PnghFF5sppw475TzL4O/qkaJK48w82las
 OUWg==
X-Gm-Message-State: APjAAAUeNHpWpO0IjRvP9kOJa5e7DnPZfHulp5vDtPzfb15ukjTbSduV
 iQwYIPxHbH5Io8E2CDm1M5fELHTaO1hZPg==
X-Google-Smtp-Source: APXvYqz3ot4eNN3pe5h2DYzwXLyhX6CcDEdjWh+lxPiMVBukv74MjuCiW4zbDEGCr82hvwu3XCHSug==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr2647889wmh.156.1565961446675; 
 Fri, 16 Aug 2019 06:17:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:16:55 +0100
Message-Id: <20190816131719.28244-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 05/29] target/arm: Fix routing of singlestep
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190805130952.4415-3-peter.maydell@linaro.org
---
 target/arm/cpu.h           |  5 +++++
 target/arm/translate.h     | 15 +++++++++++----
 target/arm/helper.c        |  6 ++++++
 target/arm/translate-a64.c |  2 +-
 target/arm/translate.c     |  4 +++-
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 67f2af0e169..d12c7460859 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3148,6 +3148,11 @@ FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)
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


