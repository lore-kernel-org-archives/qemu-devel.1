Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223C2C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49D32073E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3Vdo5VR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49D32073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrxj-00082r-7p
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 03:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyrx0-0007J7-Td
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:17:02 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyrwz-0005Fi-BP
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:17:02 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so7346255wrw.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 00:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lX3y9F5vD4bG79N8x0RuPu9En9J7gVavKPlg4rMZGbI=;
 b=D3Vdo5VRb5V6HgfjeQRV2gztub3WoYN0yo50+YRAyFczNLaxJX+hGl3We2T+ITTFGS
 iKLW2MgeY1UaF8M0OE73xRThGvSmoIpz+9AJC2UKO/1FSCNLM7bCl4ORtQFoLzE/pc1d
 QvZm6oExS/CPVaSayB1i6i9Us8sVEQ+k85ubfXhI36VW9Z1uJPeTjQ/j2Y+CqCTrcije
 0V75tPie8lHtLZOgEKy0GxtUSXZvKWTeCNcnSb2UWDINFyEq0lB+OL85R4xgb5beH7ux
 9GdHeh1RdPEH1KN+WSZPvTZ6f0e47t0mbPE9iUPjdpDJZRuGxPpxyQ1hHbW4+3fb0prk
 A/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=lX3y9F5vD4bG79N8x0RuPu9En9J7gVavKPlg4rMZGbI=;
 b=UnK2abFNX6Vz5nS+EjK5H1dh1JCtFsPx+UniuLjfeFAgCZqM80xFbX6cVoUXi29qbx
 B+8MRI+WJ5ziin9Hg08QrYF8IiaLI1cxIf/Ppr3tKEoFxg4Wo/OK7Q0RzKu12hxyfJsV
 EoB2Geu/HFaM11jjYEhSa3VEUvbJd3GxuOHthBmGBUVhrVTuH2AKGYKm6b0Pd56ULfj2
 F1PI06keIo91X1rKXZZdL4H+T/L6N65/XNfPyDvNW62IKLf864PJyza0J1MVx+x/cJob
 cxp3PXbqJDEwEXed2V7HyOxpXaNqSGlKR4M0Rn/2eT5S42sMxR5R/o5pX8dCQ/7DxB1j
 KHfg==
X-Gm-Message-State: AOAM532koSgQpPZOOEW4r3p6hIWpIRB1nc5j6zbMLIXuiFcfoiptZefM
 bKkHbgDRms48ujkICDVApgjgzjP61cg=
X-Google-Smtp-Source: ABdhPJwzZ6ZhuCgAL882KfBXW0zaqMnWkrmPwT8dw66aglz3dmwL4FRGsXg9B4VBFrrOHjgyt/osLQ==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr7869740wrq.166.1595575019564; 
 Fri, 24 Jul 2020 00:16:59 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f15sm214640wrx.91.2020.07.24.00.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 00:16:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] buildsys: Only build capstone if softmmu/user mode is
 enabled
Date: Fri, 24 Jul 2020 09:16:57 +0200
Message-Id: <20200724071657.21508-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At least one of softmmu or user mode has to be enabled to use
capstone. If not, don't clone/built it.

This save CI time for the tools/documentation-only build jobs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index 4bd80ed507..bc5757159a 100755
--- a/configure
+++ b/configure
@@ -5381,6 +5381,10 @@ fi
 ##########################################
 # capstone
 
+if test -z "$capstone" && test $tcg = 'no' ; then # !tcg implies !softmmu
+  capstone="no"
+fi
+
 case "$capstone" in
   "" | yes)
     if $pkg_config capstone; then
-- 
2.21.3


