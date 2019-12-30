Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E5C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31497206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpvCtBNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31497206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilsxL-0007JX-Mn
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 06:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvv-0005SI-Ci
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvu-000376-0p
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:09:59 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvt-00036q-RC; Mon, 30 Dec 2019 06:09:57 -0500
Received: by mail-wr1-x441.google.com with SMTP id d16so32323473wre.10;
 Mon, 30 Dec 2019 03:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0VHBWRhd3KqP211ZzR+SgyokvYmniIT+KSexWzYW+s8=;
 b=PpvCtBNsAsOshF6Mh6IJ76rG1Vk1YFBPmaasDrb0/9508RJjWDIS6nlPBmLwchlMLI
 kX37HKxWQUMyB5sfJBjGjfsC8peWdOrHk8r+zPjHFTXGoF7zrPzjOWO2LAM8q1bxB5Gr
 sxCJa/d/5rfJGQsc7kMtn8MsjZoBZcs71BiG2OSlJ1GvHoDUNf8gF1edoklnSceV29D8
 yx7HEif7sb9DVs/jgmLMR09GXog7r2NQpuJoh2YBpj+z61ig+k9/rtwiHsSWe5p9aJNg
 oZmO+tkKDwNn9sPeIi1BjhF5NfMx5mdqpQIqWAevyOfhZ5J1q1kbUJRZU8tqs+j987XI
 5Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0VHBWRhd3KqP211ZzR+SgyokvYmniIT+KSexWzYW+s8=;
 b=dnxvAUf55+95WFfpKPeVn7EdwjyYzDC7GHux5RjtwqY11QjoFj3yV3aSM8HeaI28Vx
 xOyafUt530/y0ham7VLPyQuVS60NSAqgFEjHqLfJzrFERIG1Bx+KrMsIQcEAK08VB3eL
 OV30u1oIJmd2yPwP+X4dJXhQ3W+grap2tvNgBD0iXk34Sv9/M4Wa1o3vcCQuK55lW8Jq
 F6OHaL8fEuQqXLqvp+UMtp1FO2ZvN1/oAoUgiK2UoFDka9Dkl1AUTAcBjfWK+6gEQp6f
 KT8Im2hPmLqUQ/MCXjURZ3wlXX66mFUIR2HVzNdFSsYsbAYcT1jKsUWZ+N+s2wV0hBpr
 KmJg==
X-Gm-Message-State: APjAAAVSMyFLLNZmVNZOxLOTVdPN5It1LL8pJV9rulWip7MD6nGhnTGP
 bRmRuB5Jnz1Q0NL82OKfZwAChRVJvm4=
X-Google-Smtp-Source: APXvYqyQiyZqj0JWubnyplhi7MmFgi2PRddKeEy1ba6GkWj40ZHpNhdJiqq/MK7VsB1Wc5S8Ky2Ccg==
X-Received: by 2002:a5d:5452:: with SMTP id w18mr51941433wrv.333.1577704196590; 
 Mon, 30 Dec 2019 03:09:56 -0800 (PST)
Received: from x1w.redhat.com ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id p15sm20442738wma.40.2019.12.30.03.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2019 03:09:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] tests/boot_linux_console: Add initrd test for the
 CubieBoard
Date: Mon, 30 Dec 2019 12:09:48 +0100
Message-Id: <20191230110953.25496-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191230110953.25496-1-f4bug@amsat.org>
References: <20191230110953.25496-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test boots a Linux kernel on a CubieBoard and verify
the serial output is working.

The kernel image and DeviceTree blob are built by the Armbian
project (based on Debian):
https://docs.armbian.com/Developer-Guide_Build-Preparation/

The cpio image used comes from the linux-build-test project:
https://github.com/groeck/linux-build-test

If ARM is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:arm" tags.

Alternatively, this test can be run using:

  $ avocado --show=console run -t machine:cubieboard tests/acceptance/boot_linux_console.py
  console: Uncompressing Linux... done, booting the kernel.
  console: Booting Linux on physical CPU 0x0
  console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019
  console: CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7), cr=50c5387d
  console: CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
  console: OF: fdt: Machine model: Cubietech Cubieboard
  [...]
  console: Boot successful.
  console: cat /proc/cpuinfo
  console: / # cat /proc/cpuinfo
  console: processor      : 0
  console: model name     : ARMv7 Processor rev 0 (v7l)
  console: BogoMIPS       : 832.51
  [...]
  console: Hardware       : Allwinner sun4i/sun5i Families
  console: Revision       : 0000
  console: Serial         : 0000000000000000
  console: cat /proc/iomem
  console: / # cat /proc/iomem
  console: 01c00000-01c0002f : system-control@1c00000
  console: 01c02000-01c02fff : dma-controller@1c02000
  console: 01c05000-01c05fff : spi@1c05000
  console: 01c0b080-01c0b093 : mdio@1c0b080
  console: 01c0c000-01c0cfff : lcd-controller@1c0c000
  console: 01c0d000-01c0dfff : lcd-controller@1c0d000
  console: 01c0f000-01c0ffff : mmc@1c0f000
  [...]
  PASS (54.35 s)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 9c6aa2040a..4643f60e37 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -400,6 +400,47 @@ class BootLinuxConsole(Test):
         self.wait_for_console_pattern('Boot successful.')
         # TODO user command, for now the uart is stuck
 
+    def test_arm_cubieboard_initrd(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:cubieboard
+        """
+        deb_url = ('https://apt.armbian.com/pool/main/l/'
+                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
+        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-4.20.7-sunxi')
+        dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
+                      'arm/rootfs-armv5.cpio.gz')
+        initrd_hash = '2b50f1873e113523967806f4da2afe385462ff9b'
+        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        archive.gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'usbcore.nousb '
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun4i/sun5i')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
+                                                'system-control@1c00000')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.21.0


