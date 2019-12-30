Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C1DC2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4198B206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFV8HTDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4198B206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilsxN-0007Lu-Pi
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 06:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvw-0005TC-R5
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:10:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvv-00037U-Ai
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:10:00 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvv-00037F-4d; Mon, 30 Dec 2019 06:09:59 -0500
Received: by mail-wr1-x443.google.com with SMTP id b6so32383486wrq.0;
 Mon, 30 Dec 2019 03:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lDvl9OWYCQ+LaIr8sH3FxUkOS9yo66/i86UY7kFYO98=;
 b=MFV8HTDgPYP4dOq+ORH7gOSXdEnuV93fMKiChRUMlv0CJ+RJOZzI2WfapcMkUFwyvm
 96jf64uNwdfCoArtuhFJBb3KCKrUfvJ2VQ2LRxnIbgUIGbp4wLMksbtr+jNOVqMShUpX
 haaghnbORtrIaQweP5wD7Azardn2xduDvuvtk2dP+ZQpBSQ7DR3GM1qUZoA6EQqjw6/y
 sT8/NCc93PZ/OPbYRtovWDdWc9CdtawXui7v9CNwRPG/MVFwE6zT3YzqvPLex2DN4i27
 TEyxruwg6jkQwrHWcf70ShKxajl8/29SVlKLrpqa/VZg21gO60MSDgSoqljVlimCYr+/
 CMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lDvl9OWYCQ+LaIr8sH3FxUkOS9yo66/i86UY7kFYO98=;
 b=kHgfr+GwODoJy//Xd2LZC/Qf3ao+LAIR2+kZODqDthAWp01NSBg404+1Yv1DmAnc03
 DtTbaveO+kU2+BNd5G+kSMRvfPL2w1jvoLQ6+RQranInWs/+KzTT6rqcvPjrtj4lvEpt
 0RBBA46mbesbwx24S3ceUr/3AqTXJcfAhDI+/KVzFtdhv0j5+lqdNy3bKt7rJNcBUQOQ
 fNAXyuqChXe+IZGrLqLe3lrZtUGbKQBgwEM1zcxS0Caw1mxMepgZD/bNs6g7zVd6XFLj
 lxW/cJ6WlCIBXJSPu2P21pZzj5DxwHi4erwYLT4599So0BvSyZveSv3QVUper+OYc5U0
 STng==
X-Gm-Message-State: APjAAAWgzb9m8k+ISFMyyfcKSZ5N8VvooN6C2EGHkwt4Z0FbJWdNo3eU
 +5iHXONvEZythU3KN+IkL2+Q5ylYxl0=
X-Google-Smtp-Source: APXvYqzVxi8rRQLiB8oWvny3QTy1St40R7j78PvKI0GFN7i82av/g1vd7X6bRaC3Rcj0/82Qu32hAA==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr64528295wrt.70.1577704197905; 
 Mon, 30 Dec 2019 03:09:57 -0800 (PST)
Received: from x1w.redhat.com ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id p15sm20442738wma.40.2019.12.30.03.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2019 03:09:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] tests/boot_linux_console: Add a SD card test for the
 CubieBoard
Date: Mon, 30 Dec 2019 12:09:49 +0100
Message-Id: <20191230110953.25496-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191230110953.25496-1-f4bug@amsat.org>
References: <20191230110953.25496-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
  [...]
  console: ahci-sunxi 1c18000.sata: Linked as a consumer to regulator.4
  console: ahci-sunxi 1c18000.sata: controller can't do 64bit DMA, forcing 32bit
  console: ahci-sunxi 1c18000.sata: AHCI 0001.0000 32 slots 1 ports 1.5 Gbps 0x1 impl platform mode
  console: ahci-sunxi 1c18000.sata: flags: ncq only
  console: scsi host0: ahci-sunxi
  console: ata1: SATA max UDMA/133 mmio [mem 0x01c18000-0x01c18fff] port 0x100 irq 27
  console: of_cfs_init
  console: of_cfs_init: OK
  console: vcc3v0: disabling
  console: vcc5v0: disabling
  console: usb1-vbus: disabling
  console: usb2-vbus: disabling
  console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  console: ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
  console: ata1.00: 40960 sectors, multi 16: LBA48 NCQ (depth 32)
  console: ata1.00: applying bridge limits
  console: ata1.00: configured for UDMA/100
  console: scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
  console: sd 0:0:0:0: Attached scsi generic sg0 type 0
  console: sd 0:0:0:0: [sda] 40960 512-byte logical blocks: (21.0 MB/20.0 MiB)
  console: sd 0:0:0:0: [sda] Write Protect is off
  console: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  console: sd 0:0:0:0: [sda] Attached SCSI disk
  console: EXT4-fs (sda): mounting ext2 file system using the ext4 subsystem
  console: EXT4-fs (sda): mounted filesystem without journal. Opts: (null)
  console: VFS: Mounted root (ext2 filesystem) readonly on device 8:0.
  [...]
  console: cat /proc/partitions
  console: / # cat /proc/partitions
  console: major minor  #blocks  name
  console: 1        0       4096 ram0
  console: 1        1       4096 ram1
  console: 1        2       4096 ram2
  console: 1        3       4096 ram3
  console: 8        0      20480 sda
  console: reboot
  console: / # reboot
  [...]
  console: sd 0:0:0:0: [sda] Synchronizing SCSI cache
  console: reboot: Restarting system
  PASS (48.39 s)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 4643f60e37..e40b84651b 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -441,6 +441,50 @@ class BootLinuxConsole(Test):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
 
+    def test_arm_cubieboard_sata(self):
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
+        rootfs_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
+                      'arm/rootfs-armv5.ext2.gz')
+        rootfs_hash = '093e89d2b4d982234bf528bc9fb2f2f17a9d1f93'
+        rootfs_path_gz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
+        rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
+        archive.gzip_uncompress(rootfs_path_gz, rootfs_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'usbcore.nousb '
+                               'root=/dev/sda ro '
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-drive', 'if=none,format=raw,id=disk0,file='
+                                   + rootfs_path,
+                         '-device', 'ide-hd,bus=ide.0,drive=disk0',
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun4i/sun5i')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
+                                                'sda')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.21.0


