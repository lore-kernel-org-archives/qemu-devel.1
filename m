Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6911EC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345602072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONlRKys3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345602072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSdW-00086d-Jn
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbt-0006Hf-TE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbs-00073d-B7
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:29 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:38527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSbs-00072x-2m
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:28 -0500
Received: by mail-wr1-x432.google.com with SMTP id y17so22924112wrh.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UIJjBBrcEssCJUvEirLVLBLNjRWDmjlxVAfKAEb3+ko=;
 b=ONlRKys3HFHCKhWX6oeBUJHN5I0VGkP31+9wB01e6rx7H2DMJhPuoS3fVdjl03URzk
 9dQf4V95ZothMFpJRgG53820RlYJxsfE5D4fmg86b+5N9iT7ZOWHDelrguQEQxtw/0bl
 +f9Rk70R3sRlytHVJA7umHAXHevkWHE/X15SjLkZikspeitOdtnK1tslJWKWjI90wAnV
 QFq5SPOnBx9R83Cs7av37VyKaf4y7P0blClyxdNR0hr0+9iV36DibEqh/XUW/VLva6Ji
 dBk64KaacXxLjjjeRDXCbce0B++KYHpq7Iz+yvN3CU1AfCQqDw9GQdwLohGPA7hNYUAZ
 UxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UIJjBBrcEssCJUvEirLVLBLNjRWDmjlxVAfKAEb3+ko=;
 b=Lz3tB3hluoJcHXUMEh+mF75O093NdDbG4HFiz5XgdJJrxeju4qtb3oD/v2pWVKutkM
 aW6WqyiNyIl7YCi6Wsb4eheeyfPavQr/DyCAGYqwKZvgD7jovqzwxdLd8jqIoIogLZuG
 NfVNGXeGnbICA5b1VbOBGWdPU2RExxZu81WEuFuX77H4LXoCruzEBkeNvZglJ27Lkuax
 xK4ITOxi8soRAQ4DK95BxOomjE257RDnCoEuKYrvkbAUB/FhK8fO5rH1v0C1/FJ2CaRW
 1/Cryjkoc5oX2mwuO+TuDSJa6F3+GzVf0oRNOtDphD7lo0lEYb3cISQnIV3Y94qGdqI8
 1lVA==
X-Gm-Message-State: APjAAAVYEaiIarV2Kae5bfjgyFAt/mNOyD2l+cn83izMZEp9OyCE0aJ3
 UE2hMWE3KVVyaXFnWgZQQe7pP98nW2QN6w==
X-Google-Smtp-Source: APXvYqyGw4XMZrozlx5SAwk3XyMZtH9DdY09VDOKWkeumXr1HXg8wXWUANs0iWZvd3NM/lK2bCYrnw==
X-Received: by 2002:adf:cf12:: with SMTP id o18mr3361926wrj.361.1579271306700; 
 Fri, 17 Jan 2020 06:28:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/15] tests/boot_linux_console: Add a SD card test for the
 CubieBoard
Date: Fri, 17 Jan 2020 14:28:07 +0000
Message-Id: <20200117142816.15110-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Message-id: 20191230110953.25496-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/acceptance/boot_linux_console.py | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 4643f60e376..e40b84651b0 100644
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
2.20.1


