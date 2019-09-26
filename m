Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1330EC352A9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CBD222CC
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZSw6xRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CBD222CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDY17-0007Ey-Hn
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgZ-0004s2-KU
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgW-00038e-0p
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:36:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgV-00038R-R9; Thu, 26 Sep 2019 13:36:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so3426437wrw.8;
 Thu, 26 Sep 2019 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xoacbOd8UyUj66KJoz5CJtwAwcD7yLUS/+XI1DIJ904=;
 b=aZSw6xRUhvHOfj9MMOOIGfrU6BTC5zijJNv2xZTIZ7wMOLihCJuaT9H4eo4dfhufnl
 1fxMe56/zUJGGEe3qR5HBcPANG13kg6fPUnWRRVYqAZOKwhin7E4P0wAEGOy916FEZKk
 e4kqZb8vizTJ4Sq86vDg1gg9kdgYUhkHlXPM0nnTeEhilaVxRzcOjcdkzF//egLJpaz1
 Sqxl89uX/sw2W1tPHEa9pSsDRCrOkLY71Acgcu7XSrFhqkbMZTlzE0pSNyYh2fZKW4oz
 BjsSKYAHcJuZr5PWcszl3HV8zN/B9ztOBP/Rz6GnlwitXIB7Wv11lqnjmGw4s7sDPBiB
 khUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xoacbOd8UyUj66KJoz5CJtwAwcD7yLUS/+XI1DIJ904=;
 b=KMzUDqQAg1SCE8Cv5XhLt5N3llDmuDJc8291p9PAhzbpceZXzbjVNBSC5hTDDuksAz
 s5Li2jlehQk5kE1XgFJRvT1EKN4uFrmMcTFpAOimeRKx+Xs9HEuOMeoU8Y5c0oLgAY5K
 oXVULLoACGDGT/uAX5uKJNuGL7w/lldnBMfM3uUHv0UZHnJHKUHKIXNCe/6qhJ8X/SCi
 l0BbSAGwuVY1SFaR3p/5Wgbo+pffkzTYHN0rQR7UN9VFBI+m94uK+RiHiE+4zm8vsHDx
 SYXRtnVKLEy4QCr4+M2DOk/y2P8b9Y+14opfuvFiRykxeaqdDGDqA46wiIuW+ddZWVx5
 vkoQ==
X-Gm-Message-State: APjAAAWRTQqJ7ExdgPOFrXE5urMlG5cCLaNr4mf8Lhtfiosy3gEotsBz
 pJ2biSSsuw8VUjz/gCnV89WB2vlMKwE=
X-Google-Smtp-Source: APXvYqwoyS2ioBkz0dl3A6iyTnSJnuWhlA3zhW9aYOckS4DI6CISJaxH8vgC9eMXcfY9xHaH5XgFVA==
X-Received: by 2002:adf:de0d:: with SMTP id b13mr3824717wrm.140.1569519306690; 
 Thu, 26 Sep 2019 10:35:06 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:35:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/19] tests/boot_linux_console: Add a test for the Raspberry
 Pi 2
Date: Thu, 26 Sep 2019 19:34:24 +0200
Message-Id: <20190926173428.10713-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to the x86_64/pc test, it boots a Linux kernel on a raspi2
board and verify the serial is working.

The kernel image and DeviceTree blob are built by the Raspbian
project (based on Debian):
https://www.raspbian.org/RaspbianImages
as recommended by the Raspberry Pi project:
https://www.raspberrypi.org/downloads/raspbian/

If ARM is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:arm" tags.

Alternatively, this test can be run using:

    $ avocado run -t arch:arm tests/acceptance
    $ avocado run -t machine:raspi2 tests/acceptance

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: removed debug printf (Cleber)
    use serial_kernel_cmdline dict
---
 tests/acceptance/boot_linux_console.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 079590f0c8..7eaf6cb60e 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -318,6 +318,42 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         self.wait_for_console_pattern('init started: BusyBox')
 
+    def do_test_arm_raspi2(self, uart_id):
+        """
+        The kernel can be rebuilt using the kernel source referenced
+        and following the instructions on the on:
+        https://www.raspberrypi.org/documentation/linux/kernel/building.md
+        """
+        serial_kernel_cmdline = {
+            0: 'earlycon=pl011,0x3f201000 console=ttyAMA0',
+        }
+        deb_url = ('http://archive.raspberrypi.org/debian/'
+                   'pool/main/r/raspberrypi-firmware/'
+                   'raspberrypi-kernel_1.20190215-1_armhf.deb')
+        deb_hash = 'cd284220b32128c5084037553db3c482426f3972'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel7.img')
+        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-b.dtb')
+
+        self.vm.set_machine('raspi2')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               serial_kernel_cmdline[uart_id])
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+
+    def test_arm_raspi2_uart0(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:raspi2
+        :avocado: tags=device:pl011
+        """
+        self.do_test_arm_raspi2(0)
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.20.1


