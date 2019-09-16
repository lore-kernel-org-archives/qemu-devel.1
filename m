Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF60EC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C49D21670
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbvTCq9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C49D21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9rqc-0006bn-H8
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnG-0004MM-Dn
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnE-0006tT-7V
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:54 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnD-0006t3-O5
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id b9so5490514wrs.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QMiXNxopmp/Lfafa2rBITuXAv6CIJtSHxYMTRHI7jeA=;
 b=sbvTCq9xJLnYTTXmU+ghUk3Ze9TNp67+MuZaKRNtNc/py54VOl3kf2F0CqwOxPR3ec
 Nnn2nGdzip3bWKK/bzCyryi8VsVMCTfN5ceBagb2V+R5HKM8D21fFXjIpXjGML4mQXYH
 z1tWHQL+TeHfJLnvQsf+1LxcpeTD2yNtilMN6Lc0oun+FJuQiVO4xOQCoF/kGmIXAOyM
 NZ7XZfLko24omWFK3sDArecVfXyVT8iDDsCnsKn0U6sH7P/3+6DhdYV4CrZJCETWCRcT
 XwrRyNyLSHYZKxIDY/WLMueSl41J4TFOSEFQaVafzZohsc6Wg/6trvZQDabxs0LbCLSH
 /9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QMiXNxopmp/Lfafa2rBITuXAv6CIJtSHxYMTRHI7jeA=;
 b=WRpv1/jK2Te+rnhA8zgeq/l5XcbcR4dLqYRMdz6TU5xgkDwxZM7fLfMBa5pKwo5XzI
 Tlp0bBeWF/W9MY4QuTbm/qU7s7+2CsXia4NMLbPStV+k0TCxd8w2lt77UUBCYRGIWCQ0
 uSNrr3ufbJ2eMk80eBEOlB74Xff1FmzEoAMajxvjqpmfx2z1ZKOyfxqa+fnzg75l1JeZ
 c5iQj54uOR27/k695Vui1h8l2tEI2Fbn9LZrjVLBHqlb3Q0eqdi6Bv1md/cCN6sFZQr/
 Dsl8tqHY9aLgYzOzbs2pGcAh3OILwpNCn5DKp9OoFdDeIozA0T98+bQx1I5tk9j/tc6N
 FErw==
X-Gm-Message-State: APjAAAUbAN8mlqlYk/pbx87lrfH3d/w6lu7TbESzz8ogWFSRyNHPyS4t
 WNTKfgi9IK4JyGrk6z4GSEomSw==
X-Google-Smtp-Source: APXvYqyy04H7vlHdZW+qF+FUwmMKFWOPSrvWPU9/z0qU957EL/RiQ9xSxPjBdja+YcnAqursU5QUUA==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr294643wrq.165.1568643350660;
 Mon, 16 Sep 2019 07:15:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:15:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:32 +0100
Message-Id: <20190916141544.17540-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
References: <20190916141544.17540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 03/15] target/arm/arm-semi: Correct comment
 about gdb syscall races
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In arm_gdb_syscall() we have a comment suggesting a race
because the syscall completion callback might not happen
before the gdb_do_syscallv() call returns. The comment is
correct that the callback may not happen but incorrect about
the effects. Correct it and note the important caveat that
callers must never do any work of any kind after return from
arm_gdb_syscall() that depends on its return value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I'll come back to do the cleanup later, but I preferred
not to tangle it up with the rest of the refactoring in
this series; I also think it's probably easier done
afterwards rather than before.
---
 target/arm/arm-semi.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 51b55816faf..302529f2278 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -217,10 +217,21 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
     gdb_do_syscallv(cb, fmt, va);
     va_end(va);
 
-    /* FIXME: we are implicitly relying on the syscall completing
-     * before this point, which is not guaranteed. We should
-     * put in an explicit synchronization between this and
-     * the callback function.
+    /*
+     * FIXME: in softmmu mode, the gdbstub will schedule our callback
+     * to occur, but will not actually call it to complete the syscall
+     * until after this function has returned and we are back in the
+     * CPU main loop. Therefore callers to this function must not
+     * do anything with its return value, because it is not necessarily
+     * the result of the syscall, but could just be the old value of X0.
+     * The only thing safe to do with this is that the callers of
+     * do_arm_semihosting() will write it straight back into X0.
+     * (In linux-user mode, the callback will have happened before
+     * gdb_do_syscallv() returns.)
+     *
+     * We should tidy this up so neither this function nor
+     * do_arm_semihosting() return a value, so the mistake of
+     * doing something with the return value is not possible to make.
      */
 
     return is_a64(env) ? env->xregs[0] : env->regs[0];
-- 
2.20.1


