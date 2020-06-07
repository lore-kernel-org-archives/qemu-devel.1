Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CD6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 20:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF302074B
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 20:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExFNrSwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF302074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1Wk-0007qG-D0
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 16:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1Fi-0003y8-AG
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:43 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1Fg-0004n3-3D
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:41 -0400
Received: by mail-wr1-x42c.google.com with SMTP id e1so15169754wrt.5
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 12:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JJdgGNmD+Xij1ICoEW9/1LslSZLxJsuLiu6yxyxEF/g=;
 b=ExFNrSwOoBgRSyIrXqBGgxp5Zpu2g+CiqDGR4fLB0Bea3jUo1ifX3Mm994HQK/AptK
 EDevaxkGnvpojGq0vazp2Gh/phyVux2S3rJcviTCMO1c2s4+pgh/ENv1oHZzC9SopasT
 x9MBW26Uys5ek/ukLdKyfgumELszsLsm1wpuxLN76Wx2jShC8mVg9CQfk1pwEF+WXr34
 BuzjkCQpQ5Ffpk/s+U0PmJbhVmyRJs0CaOa4kCYNbpvt4399Gb68iftZw8OHoJQaQVSO
 y6Sq/kRWXocBG+PJ475uTiJrq0BpHZLbI/WHz6zxzGbzWXIs+zMuqWLEk22avG1pX3Cw
 Er+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JJdgGNmD+Xij1ICoEW9/1LslSZLxJsuLiu6yxyxEF/g=;
 b=GuQvPVNgiKnaG4fUZsAqQP2In2/lc7eMrBmGEf4pBS/ECmHBokCbLbMcT93PlR/4Ma
 Ue0ETG8Yu8w11kVczkFuvRxcxDe8LmiO57P8dp7w8GAvsoylDRtBdddkaU3WLfEIcioY
 G16vE2Tl/gs2a5VjBkYXOT/4kemMXsxulAAIDafqbuMX5pu5UoRZYyGshVCFnHvTnQLT
 A/R1kwOj0rE7HbAxoTKReC37O/rXB3H/GKiHnQIcwZ+GTd3V1sPwpqG+PtpKiolTlylO
 W9cHrBB/M/jzW/LaPIvq0GNKPWewkZ/7jsqErf341C26Iq9x3jBTf7fMqIBTClczedad
 2i6g==
X-Gm-Message-State: AOAM531ZrKe+aB2Z6yYBIYNmDqA0/nXNCDTVpUAyTRcDTgeMwJ8i7+qu
 PX4hqweJJoeGtCDi3ms9ufhkW1xS
X-Google-Smtp-Source: ABdhPJyWJK1CmmQOVG5wKQUIWQUHeL5kWCkUJOR1VbQfPF+EDAodkNxqkSN5XzqNXmGk/0zHPeiK8w==
X-Received: by 2002:adf:f8cc:: with SMTP id f12mr19618144wrq.418.1591559197937; 
 Sun, 07 Jun 2020 12:46:37 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u130sm21091339wmg.32.2020.06.07.12.46.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2020 12:46:37 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 16/21] target/mips: fpu: Remove now unused FLOAT_RINT macro
Date: Sun,  7 Jun 2020 21:46:20 +0200
Message-Id: <1591559185-31287-17-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After demacroing RINT.<D|S>, this macro is not needed anymore.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200518200920.17344-15-aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index dae1331..56ba491 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1102,19 +1102,6 @@ uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
     return ((uint64_t)fsth2 << 32) | fst2;
 }
 
-#define FLOAT_RINT(name, bits)                                              \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,                 \
-                                         uint ## bits ## _t fs)             \
-{                                                                           \
-    uint ## bits ## _t fdret;                                               \
-                                                                            \
-    fdret = float ## bits ## _round_to_int(fs, &env->active_fpu.fp_status); \
-    update_fcr31(env, GETPC());                                             \
-    return fdret;                                                           \
-}
-
-#undef FLOAT_RINT
-
 uint64_t helper_float_rint_d(CPUMIPSState *env, uint64_t fs)
 {
     uint64_t fdret;
-- 
2.7.4


