Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAC9C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 21:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164C320724
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 21:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ba9F4Hih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164C320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kamlv-0004Xg-1v
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 16:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kamj7-0002nm-Ue
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 16:23:25 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kamj5-0005TT-B1
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 16:23:25 -0500
Received: by mail-wr1-x444.google.com with SMTP id x7so3420586wrl.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 13:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dntSroN4PEJG85PNzlPGrDsZDRwQHf/tT20jV6J3Txc=;
 b=ba9F4HihJrNDdByQaEdDCrXdFXqY0dJVQ/R1ZShL2TT21yiNIuiGaVxA+IhVgXEwHA
 X8YQs3P2m7NXSE6TbRZedibAeOiGkZ4fJdBS/HfVJ2F7uHBYYgBLsU94/OLrhRAHb273
 f/qvOqwS5pX45wRhneMBGuRqnJhtYu0U644YflOrPeXBKuDv4xUMlMTZPIWm2I4+PkgH
 xI3cgehPxTut5oETfUbIf4zuw0878hyxyKiNLjHGyDInzf6OLz9X0wl+NKoKLfjenD9Z
 ourwW6DW44w3TSOj0YTeIBEyErbn1mZ3YbMREDBQI5unj/4OifsrWftEUcLTfADPF+Do
 Lzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dntSroN4PEJG85PNzlPGrDsZDRwQHf/tT20jV6J3Txc=;
 b=I6pjUbDanlgwVUhvjwm1f+A3oi617kPgOHEbExVbhsg/3mKhwOHiIWT+PuS4GWR8K2
 e9nFsd/4PY6ZsoBLqS0gvqL+j7WZkFz3cYgsYRGRDJDW/QCLo6ANG7+XunG6Amsfmsdn
 k3pVVASYqQ4UmcYcsuOFGwGAElzi1sJk3MqsZzJL9iGwzQSbXR42EcPyXDGA7nTN876X
 uM5K7V4ypuKLYEhZTFnTVVHDx7g+KalSuCiIlbV6YW0uIOaiWp4Xw2cCRysJSdF+/d+B
 RkU2bni8TGnSMbSQuYiufJQ9tanT2srgcBtTDyYhceI60/C5k1KYI/rLEimbeoDdtMob
 vTGg==
X-Gm-Message-State: AOAM530sGaO04lkJ8gec46GBbH1CDw/yRBiad1SWnjgxWQ6lgXd3NQ/3
 hhkkDN1eGARR4nMFLnAOBDHxDyZfduFpOQ==
X-Google-Smtp-Source: ABdhPJxJFydpCyakzzlQcL5NDX+lYXAI0MzoCOitLYtiVHN/k0jhitzGmiGv/Xelr3JTaL2Xy2MuEg==
X-Received: by 2002:adf:f382:: with SMTP id m2mr5512796wro.342.1604611398424; 
 Thu, 05 Nov 2020 13:23:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e25sm4861587wrc.76.2020.11.05.13.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 13:23:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 1/3] linux-user/sparc: Fix errors in target_ucontext
 structures
Date: Thu,  5 Nov 2020 21:23:12 +0000
Message-Id: <20201105212314.9628-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105212314.9628-1-peter.maydell@linaro.org>
References: <20201105212314.9628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The various structs that make up the SPARC target_ucontext had some
errors:
 * target structures must not include fields which are host pointers,
   which might be the wrong size.  These should be abi_ulong instead
 * because we don't have the 'long double' part of the mcfpu_fregs
   union in our version of the target_mc_fpu struct, we need to
   manually force it to be 16-aligned

In particular, the lack of 16-alignment caused sparc64_get_context()
and sparc64_set_context() to read and write all the registers at the
wrong offset, which triggered a guest glibc stack check in
siglongjmp:
  *** longjmp causes uninitialized stack frame ***: terminated
when trying to run bash.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/sparc/signal.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index d796f50f665..57ea1593bfc 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -349,10 +349,15 @@ typedef abi_ulong target_mc_greg_t;
 typedef target_mc_greg_t target_mc_gregset_t[SPARC_MC_NGREG];
 
 struct target_mc_fq {
-    abi_ulong *mcfq_addr;
+    abi_ulong mcfq_addr;
     uint32_t mcfq_insn;
 };
 
+/*
+ * Note the manual 16-alignment; the kernel gets this because it
+ * includes a "long double qregs[16]" in the mcpu_fregs union,
+ * which we can't do.
+ */
 struct target_mc_fpu {
     union {
         uint32_t sregs[32];
@@ -362,11 +367,11 @@ struct target_mc_fpu {
     abi_ulong mcfpu_fsr;
     abi_ulong mcfpu_fprs;
     abi_ulong mcfpu_gsr;
-    struct target_mc_fq *mcfpu_fq;
+    abi_ulong mcfpu_fq;
     unsigned char mcfpu_qcnt;
     unsigned char mcfpu_qentsz;
     unsigned char mcfpu_enab;
-};
+} __attribute__((aligned(16)));
 typedef struct target_mc_fpu target_mc_fpu_t;
 
 typedef struct {
@@ -377,7 +382,7 @@ typedef struct {
 } target_mcontext_t;
 
 struct target_ucontext {
-    struct target_ucontext *tuc_link;
+    abi_ulong tuc_link;
     abi_ulong tuc_flags;
     target_sigset_t tuc_sigmask;
     target_mcontext_t tuc_mcontext;
-- 
2.20.1


