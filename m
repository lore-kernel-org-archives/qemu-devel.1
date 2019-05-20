Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F148C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B6FC21479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSNh9kfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6FC21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42709 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSqTk-0004As-AY
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 18:09:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSqQc-00024v-04
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSqQa-0007xT-RI
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:06:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSqQa-0007wy-Kk; Mon, 20 May 2019 18:06:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id g12so15977819wro.8;
	Mon, 20 May 2019 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=RpBHMO/Gvr5r85Ip4+FKU+7BM1/SoeQOc8XHwm4/D0g=;
	b=TSNh9kfK2W24a9/vQGROiYNRLUY5Bym/pTjTsuWSJTWNks9wAt6zTNxoGz1rlGJj25
	dHy/ZUTUzuHq4UOZjaGXLM+o8X7CyKAZ2XyirfmbR9wSMPY0/becDhS8PJQDwGCeQrEd
	j8P38uWwjwXxMRc2fWvuZIWsSCDeyyE87uz+06jxN5Du18SZky3dikem+bdsNrZBYmh0
	5wV+nbhCN+knApE9WEKjQOPg8lHUseUO5FoZG0YmvtU+Xn2Q6aTsNzumhhUUKHmqFHjR
	rq47KLccsXEwTb5cUIOPeQKQZD2JR4Nb4SxlPQffFlqsb5S6RnNd5td5ulAH/fxEzSeL
	wpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=RpBHMO/Gvr5r85Ip4+FKU+7BM1/SoeQOc8XHwm4/D0g=;
	b=AUvx+TwFPvSWt7fxIcbKzQ0mwDg4LNmG5Q8trElaWXnNBDx/MgsT0e3Cw9VQO9suda
	RKoUa10G2phqu2mwHIN8Gw6sTG0i6ZcoQzYk6ZiyTGLnZ94lBTEwXxiy2doxb9YV37Xk
	Q4r0ascD2nPIS7GfdcvlFGSyNkSS+eRkXdivD8oYOjCBb89R+WaQnVh4UiFAPl+JcfjP
	v0yPlsSqIWQL5EjTL5laUTA0KeXFJXWPdsDp2OKgP3i9RtIWXctlEwk+JkrtJsFeaMkS
	VGV7qg6+E09rKF30Q+05Kyo1UDJvixoCC2chmaN0YU7DM6zy13fSJog6uCskTO6OqAx+
	NJXQ==
X-Gm-Message-State: APjAAAW9+J+kfJR4xSYYkNO4fUNWeKxj94KbpTnyVq7++qlFQUiaGUAT
	pLMiNOLeHs+n3Uj/rKb1vWWTy7c0fZg=
X-Google-Smtp-Source: APXvYqzjcQRuNzXxvdxg6ptiMtc/NAmGolAko3ei6E4Z7Wf9NAvIKTj0RhKyt+Gf4fujcPmVSGZfEA==
X-Received: by 2002:a5d:4211:: with SMTP id n17mr500695wrq.131.1558389999544; 
	Mon, 20 May 2019 15:06:39 -0700 (PDT)
Received: from x1.local (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	y40sm35462259wrd.96.2019.05.20.15.06.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 15:06:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 00:06:35 +0200
Message-Id: <20190520220635.10961-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190520220635.10961-1-f4bug@amsat.org>
References: <20190520220635.10961-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 2/2] BootLinuxConsoleTest: Test the
 SmartFusion2 board
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Caio Carrara <ccarrara@redhat.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
	Cleber Rosa <crosa@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to the x86_64/pc test, it boots a Linux kernel on an
Emcraft board and verify the serial is working.

If ARM is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:arm" tags.

Alternatively, this test can be run using:

  $ avocado run -t arch:arm tests/acceptance
  $ avocado run -t machine:emcraft-sf2 tests/acceptance

Based on the recommended test setup from Subbaraya Sundeep:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03810.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index f593f3858e..844cb80bb5 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -178,6 +178,33 @@ class BootLinuxConsole(Test):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    def test_arm_emcraft_sf2(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:emcraft-sf2
+        :avocado: tags=endian:little
+        """
+        uboot_url = ('https://raw.githubusercontent.com/'
+                     'Subbaraya-Sundeep/qemu-test-binaries/'
+                     'fa030bd77a014a0b8e360d3b7011df89283a2f0b/u-boot')
+        uboot_hash = 'abba5d9c24cdd2d49cdc2a8aa92976cf20737eff'
+        uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash)
+        spi_url = ('https://raw.githubusercontent.com/'
+                   'Subbaraya-Sundeep/qemu-test-binaries/'
+                   'fa030bd77a014a0b8e360d3b7011df89283a2f0b/spi.bin')
+        spi_hash = '85f698329d38de63aea6e884a86fbde70890a78a'
+        spi_path = self.fetch_asset(spi_url, asset_hash=spi_hash)
+
+        self.vm.set_machine('emcraft-sf2')
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
+        self.vm.add_args('-kernel', uboot_path,
+                         '-append', kernel_command_line,
+                         '-drive', 'file=' + spi_path + ',if=mtd,format=raw',
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('init started: BusyBox')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.19.1


