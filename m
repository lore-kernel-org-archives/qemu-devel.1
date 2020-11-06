Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEC1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB89208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O70VBhbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB89208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb3fm-0004zZ-F9
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 10:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3eU-0003Q7-Ml
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:27:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3eS-0001H6-51
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:27:46 -0500
Received: by mail-wr1-x442.google.com with SMTP id g12so1723202wrp.10
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 07:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r8tx3kzrnnukFrD0hkvRYpxfc/p9hgOCDrl4XseNEZY=;
 b=O70VBhbRoIoWRqHOsU6iDEeg3OePISMX7xc+h0nCtsIzNDolThMZWjVJAo+4bXAwGF
 0XzAXXpPxH1dmGjoidy2QKnhTqE0M2ogtx3MCxYALzBSO+V000g+a2P6WkBvmaGb/fFh
 YGqrvGWxSdopGSb2eJKao0AZNhYqNZm0hhgDC+LqV+GWk653iPiZOnXAU317pryBHzDQ
 y0U5hSY+0lf9z9KBd9CnbO/vMC4q82VDP5IEafq4MVfX4spolx1V6VGwgatLXAr7kVX6
 8yrgJ/236dMj1bacz2jGKdurkMdyDUfQQlEcysItga/Bs1WQPXgf4UKmGFHmyV63V1Eh
 A7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r8tx3kzrnnukFrD0hkvRYpxfc/p9hgOCDrl4XseNEZY=;
 b=ilMG9+Ie2O/7OMBBvEiC26SwPrKz8pROWNXc1TifvHTZdOqzCs9DyFFc9MKOqA+49M
 DpYpHL4sTneODtS56ck2cvHJ+rONpsvrrsPQGg7slCo9zbeTCfliYO4dS053eHgFDDft
 7I0v31fIov/NtK+nXcRHyjefl/Aw0Uywepao4fkVRYIjGuehYdKxUkQZpOp20WrE47Aj
 eOCGwyFWwVxdpou8fkyHibfmFxZXI8Rp7mR5xZcbTgWum3HZTkL2hdEy/tOCY9Xu0JTM
 qTBfHd6wlWIAjvaj8GUqn+R3ZOn8s4fU6PAN99HOenlqLwhhe1QOn4BhqqiOvDKhWvIb
 CDbA==
X-Gm-Message-State: AOAM532NyFOWrQw857alZbstUkGsCWeig3GQ9fkChSZemFmij6Zqv7Hf
 gMe6jdWcBZb4lXQWSO8/J4E0UtdH3p2eLA==
X-Google-Smtp-Source: ABdhPJyOj+FS4e4eJhnhs3R7uTqcV4PpnMHqaefb+FJLj/msqQXgCW2MeqOI0gTLkITRrcUSshfwEQ==
X-Received: by 2002:adf:e950:: with SMTP id m16mr2967236wrn.0.1604676462005;
 Fri, 06 Nov 2020 07:27:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 109sm2723462wra.29.2020.11.06.07.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 07:27:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] linux-user/sparc: Correct sparc64_get/set_context()
 FPU handling
Date: Fri,  6 Nov 2020 15:27:35 +0000
Message-Id: <20201106152738.26026-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106152738.26026-1-peter.maydell@linaro.org>
References: <20201106152738.26026-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The handling of the FPU state in sparc64_get_context() and
sparc64_set_context() is not the same as what the kernel actually
does: we unconditionally read and write the FP registers and the
FSR, GSR and FPRS, but the kernel logic is more complicated:
 * in get_context the kernel has code for saving FPU registers,
   but it is hidden inside an "if (fenab) condition and the
   fenab flag is always set to 0 (inside an "#if 1" which has
   been in the kernel for over 15 years). So the effect is that
   the FPU state part is always written as zeroes.
 * in set_context the kernel looks at the fenab field in the
   structure from the guest, and only restores the state if
   it is set; it also looks at the structure's FPRS to see
   whether either the upper or lower or both halves of the
   register file have valid data.

Bring our implementations into line with the kernel:
 * in get_context:
    - clear the entire target_ucontext at the top of the
      function (as the kernel does)
    - then don't write the FPU state, so those fields remain zero
    - this fixes Coverity issue CID 1432305 by deleting the code
      it was complaining about
 * in set_context:
    - check the fenab and the fpsr to decide which parts of
      the FPU data to restore, if any
    - instead of setting the FPU registers by doing two
      32-bit loads and filling in the .upper and .lower parts
      of the CPU_Double union separately, just do a 64-bit
      load of the whole register at once. This fixes Coverity
      issue CID 1432303 because we now access the dregs[] part
      of the mcfpu_fregs union rather than the sregs[] part
      (which is not large enough to actually cover the whole of
      the data, so we were accessing off the end of sregs[])

We change both functions in a single commit to avoid potentially
breaking bisection.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/cpu.h        |  4 ++-
 linux-user/sparc/signal.c | 74 +++++++++++++++++++++++----------------
 2 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index b9369398f24..277254732b9 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -156,7 +156,9 @@ enum {
 #define PS_IE    (1<<1)
 #define PS_AG    (1<<0) /* v9, zero on UA2007 */
 
-#define FPRS_FEF (1<<2)
+#define FPRS_DL (1 << 0)
+#define FPRS_DU (1 << 1)
+#define FPRS_FEF (1 << 2)
 
 #define HS_PRIV  (1<<2)
 #endif
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index d12adc8e6ff..e661a769cb1 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -402,8 +402,10 @@ void sparc64_set_context(CPUSPARCState *env)
     abi_ulong ucp_addr;
     struct target_ucontext *ucp;
     target_mc_gregset_t *grp;
+    target_mc_fpu_t *fpup;
     abi_ulong pc, npc, tstate;
     unsigned int i;
+    unsigned char fenab;
 
     ucp_addr = env->regwptr[WREG_O0];
     if (!lock_user_struct(VERIFY_READ, ucp, ucp_addr, 1)) {
@@ -467,26 +469,42 @@ void sparc64_set_context(CPUSPARCState *env)
     __get_user(env->regwptr[WREG_FP], &(ucp->tuc_mcontext.mc_fp));
     __get_user(env->regwptr[WREG_I7], &(ucp->tuc_mcontext.mc_i7));
 
-    /* FIXME this does not match how the kernel handles the FPU in
-     * its sparc64_set_context implementation. In particular the FPU
-     * is only restored if fenab is non-zero in:
-     *   __get_user(fenab, &(ucp->tuc_mcontext.mc_fpregs.mcfpu_enab));
-     */
-    __get_user(env->fprs, &(ucp->tuc_mcontext.mc_fpregs.mcfpu_fprs));
-    {
-        uint32_t *src = ucp->tuc_mcontext.mc_fpregs.mcfpu_fregs.sregs;
-        for (i = 0; i < 64; i++, src++) {
-            if (i & 1) {
-                __get_user(env->fpr[i/2].l.lower, src);
-            } else {
-                __get_user(env->fpr[i/2].l.upper, src);
+    fpup = &ucp->tuc_mcontext.mc_fpregs;
+
+    __get_user(fenab, &(fpup->mcfpu_enab));
+    if (fenab) {
+        abi_ulong fprs;
+
+        /*
+         * We use the FPRS from the guest only in deciding whether
+         * to restore the upper, lower, or both banks of the FPU regs.
+         * The kernel here writes the FPU register data into the
+         * process's current_thread_info state and unconditionally
+         * clears FPRS and TSTATE_PEF: this disables the FPU so that the
+         * next FPU-disabled trap will copy the data out of
+         * current_thread_info and into the real FPU registers.
+         * QEMU doesn't need to handle lazy-FPU-state-restoring like that,
+         * so we always load the data directly into the FPU registers
+         * and leave FPRS and TSTATE_PEF alone (so the FPU stays enabled).
+         * Note that because we (and the kernel) always write zeroes for
+         * the fenab and fprs in sparc64_get_context() none of this code
+         * will execute unless the guest manually constructed or changed
+         * the context structure.
+         */
+        __get_user(fprs, &(fpup->mcfpu_fprs));
+        if (fprs & FPRS_DL) {
+            for (i = 0; i < 16; i++) {
+                __get_user(env->fpr[i].ll, &(fpup->mcfpu_fregs.dregs[i]));
             }
         }
+        if (fprs & FPRS_DU) {
+            for (i = 16; i < 31; i++) {
+                __get_user(env->fpr[i].ll, &(fpup->mcfpu_fregs.dregs[i]));
+            }
+        }
+        __get_user(env->fsr, &(fpup->mcfpu_fsr));
+        __get_user(env->gsr, &(fpup->mcfpu_gsr));
     }
-    __get_user(env->fsr,
-               &(ucp->tuc_mcontext.mc_fpregs.mcfpu_fsr));
-    __get_user(env->gsr,
-               &(ucp->tuc_mcontext.mc_fpregs.mcfpu_gsr));
     unlock_user_struct(ucp, ucp_addr, 0);
     return;
 do_sigsegv:
@@ -509,7 +527,9 @@ void sparc64_get_context(CPUSPARCState *env)
     if (!lock_user_struct(VERIFY_WRITE, ucp, ucp_addr, 0)) {
         goto do_sigsegv;
     }
-    
+
+    memset(ucp, 0, sizeof(*ucp));
+
     mcp = &ucp->tuc_mcontext;
     grp = &mcp->mc_gregs;
 
@@ -572,19 +592,11 @@ void sparc64_get_context(CPUSPARCState *env)
     __put_user(env->regwptr[WREG_FP], &(mcp->mc_fp));
     __put_user(env->regwptr[WREG_I7], &(mcp->mc_i7));
 
-    {
-        uint32_t *dst = ucp->tuc_mcontext.mc_fpregs.mcfpu_fregs.sregs;
-        for (i = 0; i < 64; i++, dst++) {
-            if (i & 1) {
-                __put_user(env->fpr[i/2].l.lower, dst);
-            } else {
-                __put_user(env->fpr[i/2].l.upper, dst);
-            }
-        }
-    }
-    __put_user(env->fsr, &(mcp->mc_fpregs.mcfpu_fsr));
-    __put_user(env->gsr, &(mcp->mc_fpregs.mcfpu_gsr));
-    __put_user(env->fprs, &(mcp->mc_fpregs.mcfpu_fprs));
+    /*
+     * We don't write out the FPU state. This matches the kernel's
+     * implementation (which has the code for doing this but
+     * hidden behind an "if (fenab)" where fenab is always 0).
+     */
 
     if (err)
         goto do_sigsegv;
-- 
2.20.1


