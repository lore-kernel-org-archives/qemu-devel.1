Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B546CC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E46B2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNsp3J2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E46B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtZ9-0001MO-JO
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtU6-0001yA-Qp
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtU5-0000qX-2v
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:34 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34239)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHtU4-0000oZ-Pa
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id 65so12596047wrl.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+VoMivlcvCf+pGhQz2DwJ+dxCP3nmc4/WScJnu17j8E=;
 b=RNsp3J2lkNED/AQ/aRyUPH6eV6U6poLNNtSC0RC/YYs0d4NAhEUJdsFJ+qKWi26zgo
 3LvKLYi9PiD2zQPVAnowAg7JyqGwbqYRnOKUQtIWyekJPVFmyoSeOgzAzLleATVx9MLT
 023FdLj5Jzt4xgeH5eweSO0x3KEjWGzSQN6RohH+RSRONAJ3crfEGqxwdP71pyiiC1Je
 1+FxQG1qj0YH2T9aMTKnzEiU9bczrqqS7iQLLc5p1cmZsP5ys2RYRv3GygIeK6Ik+MlR
 I7ZkCe4C8ulE1pBGlu/5yAlU4zT4H45n6nT/OWQOTS8bei0VL8TQQPk01JPpxD1gATDO
 zEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+VoMivlcvCf+pGhQz2DwJ+dxCP3nmc4/WScJnu17j8E=;
 b=cXWgAsId/+b8wY87hApNg5d2PFAA3nc0yQD2YXmmzRd8P7El5Cocc1Eqkl4EnIt7ua
 fu2OXeXh9LufNSbUu9WsVwe6PoFJBp+J+ULuaSJxHneuqbbx00SYQRo9pzFsY3IHhDyh
 TzR9zTZ0X3HvPZWCkMQzcbFaBDc3MEy62I3LpJgfhGrPiUlMIpehQLgL8KTENzA2E7Yw
 +sicthKhOY35U3xOPWGJ8G2iyuQ0LyhQRJsnkWNilBmm9I4cxNeDjmtkREB7YtjM6OvO
 MXTEkoGYl6yJPvrvlfC2OWH3mvmsUDnXJ34Ya+wBba1mlSwgdZXQj/vq8tU9DwOKFyVR
 0Zng==
X-Gm-Message-State: ANhLgQ1wbQ9iPenxKQrGZIETgD7vVYf2vJ0O/4IqfnKbcqn1zOzIvGch
 Ve3gIFGOobfrOpV9kNt7wM53jA==
X-Google-Smtp-Source: ADFU+vtxCk/kUol5rLB28zKxjdvlQi4t0pC21jncyUJnaipcng/4l28NyC+amQb0X+5CKA1e7aQLUw==
X-Received: by 2002:adf:ec02:: with SMTP id x2mr646562wrn.365.1585332811715;
 Fri, 27 Mar 2020 11:13:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v11sm9479752wrm.43.2020.03.27.11.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:13:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E499F1FF93;
 Fri, 27 Mar 2020 18:13:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 07/12] configure: disable MTTCG for MIPS guests
Date: Fri, 27 Mar 2020 18:13:15 +0000
Message-Id: <20200327181320.23329-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327181320.23329-1-alex.bennee@linaro.org>
References: <20200327181320.23329-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While debugging check-acceptance failures I found an instability in
the mips64el test case. Briefly the test case:

  retry.py -n 100 -c -- ./mips64el-softmmu/qemu-system-mips64el \
    -display none -vga none -serial mon:stdio \
    -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
    -cpu I6400 -smp 8 -vga std \
    -append "printk.time=0 clocksource=GIC console=tty0 console=ttyS0 panic=-1" \
    --no-reboot

Reports about a 9% failure rate:

  Results summary:
  0: 91 times (91.00%), avg time 5.547 (0.45 varience/0.67 deviation)
  -6: 9 times (9.00%), avg time 3.394 (0.02 varience/0.13 deviation)
  Ran command 100 times, 91 passes

When re-run with "--accel tcg,thread=single" the instability goes
away.

  Results summary:
  0: 100 times (100.00%), avg time 17.318 (249.76 varience/15.80 deviation)
  Ran command 100 times, 100 passes

Which seems to indicate there is some aspect of the MIPS MTTCG fixes
that has been missed. Ideally we would fix that but I'm afraid I don't
have time to investigate and am not super familiar with the
architecture anyway. In lieu of someone tracking down the failure lets
disable it for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Message-Id: <20200323161514.23952-7-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 89fe881dd46..e225a1e3ffe 100755
--- a/configure
+++ b/configure
@@ -7887,7 +7887,7 @@ case "$target_name" in
     TARGET_SYSTBL_ABI=n32
   ;;
   mips64|mips64el)
-    mttcg="yes"
+    mttcg="no"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
     echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
-- 
2.20.1


