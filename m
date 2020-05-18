Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83023C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517C220756
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rD4snTRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517C220756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jagoB-00064W-ED
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 10:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jagmc-0003yX-0u
 for qemu-devel@nongnu.org; Mon, 18 May 2020 10:30:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jagmY-0001U4-ST
 for qemu-devel@nongnu.org; Mon, 18 May 2020 10:30:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so12208344wru.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8TBzzcsFazlljQPoOpAMIzgSdLt0n2ByqDt37jz37+s=;
 b=rD4snTRV3Wwn3W3X1jN40jdKx5l3FCSpwB7/3dBRSKfHRpcCf67NZFaz9DbiLFOE4P
 t/Vry0Kf3vdMl9+zMMBvFkehxo6KD7umFIltUk5k+APjCnaZ40zGKfyR2ls8KnHgO0Nq
 J/wUf2498NYLLUYOv+kqe+AiBd3ki/72QyBJcMSEBGFHNyvy15ql7URnbhuPCaT4nEY2
 Bl4XNl9de1w1IVCiEpGbCaoVUzLXSQRK0ncL0e4DRlGPrFDck7KJzX5QGMs4MVQdbcjx
 avPjA0fkwmxgIbzJ2iFbEpa0opGAp7m61ps7OM6Wp1B7mgkjye+1MSUuIDTWN2ouATo9
 f39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8TBzzcsFazlljQPoOpAMIzgSdLt0n2ByqDt37jz37+s=;
 b=iSGb9uj4t+rcn9JZbobhXMuW3Ih1XwjSbFDr8emnwmY9haFMJu9PFADs4gXpsL/GnG
 gb5lXRblWmQyDVnFeetWmuzoGGXXEnIMbkkV5rGmeXiANU7kIV6gWI/G7ABVMQEM6AXM
 bB2VbgvWsXi/GPM+hRCHURUcbMfwJCBwBSUtfdBBaUfJoeXfxUplsjcQiZzfwpWNy7FA
 uJYYqUrYG8MI2C4FAAAMbMYGnPpms+Tphl9aawAnX7/WQJ03fNau/j/oj1gbApkLLpxK
 McqV98uy1usGp7KlV08+9dvJnsHRIgJZFDl1kewL5KOdyZeNeAMJBk85W6520dO4ExMZ
 JP1Q==
X-Gm-Message-State: AOAM533DTvG2aMvUWuNHiblRVJrst+AQrdAJxmTlwCRuCn/seq2t6zvp
 roZqDZhza/L0hP9tDXumbUpfEQ==
X-Google-Smtp-Source: ABdhPJxqb6Cxnd1sG32koSvumhLJM+CoWGxJnefpHXSR3VV+jERTOHAoLjbVfsL4i9HNkXNIk7Nd9Q==
X-Received: by 2002:adf:c38c:: with SMTP id p12mr21142380wrf.357.1589812216950; 
 Mon, 18 May 2020 07:30:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x24sm17756487wrd.51.2020.05.18.07.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 07:30:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] linux-user/arm/signal.c: Drop TARGET_CONFIG_CPU_32
Date: Mon, 18 May 2020 15:30:14 +0100
Message-Id: <20200518143014.20689-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Arm signal-handling code has some parts ifdeffed with a
TARGET_CONFIG_CPU_32, which is always defined. This is a leftover
from when this code's structure was based on the Linux kernel
signal handling code, where it was intended to support 26-bit
Arm CPUs. The kernel dropped its CONFIG_CPU_32 in kernel commit
4da8b8208eded0ba21e3 in 2009.

QEMU has never had 26-bit CPU support and is unlikely to ever
add it; we certainly aren't going to support 26-bit Linux
binaries via linux-user mode. The ifdef is just unhelpful
noise, so remove it entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Based-on: <20200518142801.20503-1-peter.maydell@linaro.org>
("[PATCH v2] target/arm: Allow user-mode code to write CPSR.E via MSR")
to avoid a textual conflict.

 linux-user/arm/signal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index 698985a647e..f21d1535e4d 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -126,8 +126,6 @@ struct rt_sigframe_v2
     abi_ulong retcode[4];
 };
 
-#define TARGET_CONFIG_CPU_32 1
-
 /*
  * For ARM syscalls, we encode the syscall number into the instruction.
  */
@@ -187,9 +185,7 @@ setup_sigcontext(struct target_sigcontext *sc, /*struct _fpstate *fpstate,*/
     __put_user(env->regs[13], &sc->arm_sp);
     __put_user(env->regs[14], &sc->arm_lr);
     __put_user(env->regs[15], &sc->arm_pc);
-#ifdef TARGET_CONFIG_CPU_32
     __put_user(cpsr_read(env), &sc->arm_cpsr);
-#endif
 
     __put_user(/* current->thread.trap_no */ 0, &sc->trap_no);
     __put_user(/* current->thread.error_code */ 0, &sc->error_code);
@@ -549,11 +545,9 @@ restore_sigcontext(CPUARMState *env, struct target_sigcontext *sc)
     __get_user(env->regs[13], &sc->arm_sp);
     __get_user(env->regs[14], &sc->arm_lr);
     __get_user(env->regs[15], &sc->arm_pc);
-#ifdef TARGET_CONFIG_CPU_32
     __get_user(cpsr, &sc->arm_cpsr);
     cpsr_write(env, cpsr, CPSR_USER | CPSR_EXEC, CPSRWriteByInstr);
     arm_rebuild_hflags(env);
-#endif
 
     err |= !valid_user_regs(env);
 
-- 
2.20.1


