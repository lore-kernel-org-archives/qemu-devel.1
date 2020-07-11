Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8395FC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494F620786
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4ie+uru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494F620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juJ2t-0003T5-Id
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 13:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyX-0003XQ-Bi
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:54762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyV-0006hw-JC
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id o8so9175267wmh.4
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hPhTqz5FqxPdoao+KBnHV5n1AZ1vgALGZMoVskPrMRs=;
 b=h4ie+urup1BHAsTSD+wImw+6d8SO2ZceeoYnBQKzsP3vdFiflRGvgU2giLcag2ttJu
 F8L4kbsEEXasoeDht5XlBdx6W6WhDAfc07ELH7FrmJ5MYBcZK6zlmD7KDL+QyriokvLi
 21z6LxqhWyd9raNbxQQkpn4pATk1cdcx2Q3/Q5zWx8tJ4i+XwFZuSfxnTkhaLYnu9YN9
 WTe0+W/vl4IdgZC9s+9bpSOXvxtyDtfhggvGlUf2py0m84WaF0SbuN/xGkaf808cjTV3
 9yubS56R1u6oNtu39DcnloCgPR7G/LNFoQnC5ki6+24/VcQiL4KMz/OulpWTZtC17OZ9
 IQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hPhTqz5FqxPdoao+KBnHV5n1AZ1vgALGZMoVskPrMRs=;
 b=JyXD9RNuLkXtc9gm6mO74eqS65wsHdt0L18Kl2TGs4qVCBjSpDU/ssKO7WdLJq4BsC
 frnSLCxDk1rryeB39nPFoGLNujQS1edX1L6etnqGiGFXmAQiE+jmZzkt/FdCIAUWAm6O
 2YRMCYVGps99oUYrSkezm4n8AHN5wer+wZeXB8l2oFVJsKWljjSxXmuxQ2Xn8zwm3HPI
 Zg+w0t+H1WlZ7GQgpPA+hbcDERyMscdO/vCyTOYkcQI9ZmXCnr3El9zM+rNaKeZzZO4x
 0GRHygHWXqDlmWW/dDKm9hTh68KixfdS5r8WIqGiSjLn0pv+XRJbo3X8Hyc/68lv6Teu
 PLGw==
X-Gm-Message-State: AOAM532bGncDJWacAlWo8Ol2+ZVz3/2QbsBBoP9qXFn8c7+fD8PeCHju
 Ip95oaW5zOAHsltlJ30qidP+rA==
X-Google-Smtp-Source: ABdhPJyUd7/vRbXIWQFygDbbwHMh2kDH+Jf4aifiB9RFQ+iFrRhnZDqTTQ82+5Y325wvunpOD5EKiQ==
X-Received: by 2002:a1c:48c5:: with SMTP id v188mr10552024wma.58.1594487262220; 
 Sat, 11 Jul 2020 10:07:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j6sm16042566wro.25.2020.07.11.10.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 10:07:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A902C1FF92;
 Sat, 11 Jul 2020 18:07:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 46/50] tests/docker: update toolchain set in
 debian-xtensa-cross
Date: Sat, 11 Jul 2020 18:07:28 +0100
Message-Id: <20200711170732.26213-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711170732.26213-1-alex.bennee@linaro.org>
References: <20200711170732.26213-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Filippov <jcmvbkbc@gmail.com>

Switch to the prebuilt xtensa toolchains release 2020.07.
Drop csp toolchain as the csp core is not a part of QEMU.
Add de233_fpu and dsp3400 toolchains to enable DFPU and FPU2000 tests.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[AJB: fix path in configure.sh]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200708082347.27318-1-jcmvbkbc@gmail.com>
Message-Id: <20200709141327.14631-13-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index beb73f46ba..ba4148299c 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -18,12 +18,12 @@ RUN apt-get update && \
         git \
         python3-minimal
 
-ENV CPU_LIST csp dc232b dc233c
-ENV TOOLCHAIN_RELEASE 2018.02
+ENV CPU_LIST dc232b dc233c de233_fpu dsp3400
+ENV TOOLCHAIN_RELEASE 2020.07
 
 RUN for cpu in $CPU_LIST; do \
         curl -#SL http://github.com/foss-xtensa/toolchain/releases/download/$TOOLCHAIN_RELEASE/x86_64-$TOOLCHAIN_RELEASE-xtensa-$cpu-elf.tar.gz \
         | tar -xzC /opt; \
     done
 
-ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-csp-elf/bin
+ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 37e49736ca..102578caa5 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -182,7 +182,7 @@ for target in $target_list; do
       container_image=debian-xtensa-cross
 
       # default to the dc232b cpu
-      container_cross_cc=/opt/2018.02/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-gcc
+      container_cross_cc=/opt/2020.07/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-gcc
       ;;
   esac
 
-- 
2.20.1


