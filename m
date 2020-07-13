Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72280C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400FA20771
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjMoJMtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400FA20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3IB-0007Al-Fo
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FT-00020M-Hx; Mon, 13 Jul 2020 14:32:19 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:41452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FR-0004G8-Ck; Mon, 13 Jul 2020 14:32:19 -0400
Received: by mail-ej1-x643.google.com with SMTP id dp18so18410471ejc.8;
 Mon, 13 Jul 2020 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JAR9oox63Wn3FnDmGAuJvp7q5cpJDHy+VCBHheQotfo=;
 b=EjMoJMtm7RgLdr5ivo5D66D4hFKpZ4/B+NVZ0vyD+8uTyCp9HSFkbm4swtTzPyxcTP
 HSRdXAut6yk5UQNmDS8Cc7eKqLfkcQeqGT3cb73GPljQuaWHB1TvqJLRuSKaKNtEQwgM
 5gCC+DMrocSyR8WVFD55UxQDmtswXpvZuGutKl6oJMXUElmCM2wcTAFD9TJjaHiwjZ3Q
 KTpWj2Jiqqwh9fSyJMg6V2PZ5SSOWBjBstUt/8ano8h97ka7LL5S2QQW3xiX7MJ6KJml
 8b85SOFfelB/gnZ232Fl+2haaerZtZFvZzdN+tV/CPPw9LvMW73mNKNqAjT5kCDXKojV
 8fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JAR9oox63Wn3FnDmGAuJvp7q5cpJDHy+VCBHheQotfo=;
 b=swh4156SJ1se916hLHEq2lBohi1WD+9a9bddBShJ54c7kpWx4wtD1oZ1XE19tmjvg+
 2gyPejYlZ1fBti493v/PIbCybtFrIBK5fMwE4+L4ao35+QBw5rS7zZfnxj//Jplrotg2
 Qq7bJFGoL0Dr1GMCIRCJZz1wXH61aPMaWNaRwjv8kmvUJwm60WdbTyAFDRTFUACe6iiS
 36NJX27K6XKva0N4wilxF+oNcIwD7fUVyeDR9xoQoXZMq0+sZ41EnVud9Ao8BQ7rF4UD
 MIZoDSyhwinEx2xkDx5HRySFwBbF60rCQLFZFyKY+Wnv8MWzjjTJNQTIjkn4uvn8S6eK
 LCiw==
X-Gm-Message-State: AOAM531IAZIL1XkyNlfiNubFr9ntW4ydT7245aAi3WGOGwGReOokmmMh
 Rbt2Hn6F+RhoK6/e7nHSxuNe0P1XmZM=
X-Google-Smtp-Source: ABdhPJyFLkbgvGN8bwS7sD20H/6L7iExHZScKHX4jAParnUbHNSk7nvm627mWuW07ZNJYBLZc3Ye2w==
X-Received: by 2002:a17:907:1051:: with SMTP id
 oy17mr1051861ejb.394.1594665135563; 
 Mon, 13 Jul 2020 11:32:15 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id ce12sm4353148edb.4.2020.07.13.11.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 11:32:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/9] tests/acceptance/boot_linux: Tag tests using a SD card
 with 'device:sd'
Date: Mon, 13 Jul 2020 20:32:03 +0200
Message-Id: <20200713183209.26308-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200713183209.26308-1-f4bug@amsat.org>
References: <20200713183209.26308-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avocado tags are handy to automatically select tests matching
the tags. Since these tests use a SD card, tag them.

We can run all the tests using a SD card at once with:

  $ avocado --show=app run -t u-boot tests/acceptance/
  $ AVOCADO_ALLOW_LARGE_STORAGE=ok \
    avocado --show=app \
      run -t device:sd tests/acceptance/
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_sd
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_bionic
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9
   (1/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_sd: PASS (19.56 s)
   (2/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_bionic: PASS (49.97 s)
   (3/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9: PASS (20.06 s)
  RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 90.02 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 3d02519660..b7e8858c2d 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -620,6 +620,7 @@ def test_arm_orangepi_sd(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
                    'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
@@ -669,6 +670,7 @@ def test_arm_orangepi_bionic(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
         """
 
         # This test download a 196MB compressed image and expand it to 932MB...
@@ -710,6 +712,7 @@ def test_arm_orangepi_uboot_netbsd9(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
         """
         # This test download a 304MB compressed image and expand it to 1.3GB...
         deb_url = ('http://snapshot.debian.org/archive/debian/'
-- 
2.21.3


