Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDEEC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142B42053B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThQeaFGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142B42053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipHmi-0007hQ-4s
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVe-0001U2-OB
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVc-0002iC-0R
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:54 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ipHVb-0002h5-P4; Wed, 08 Jan 2020 15:00:51 -0500
Received: by mail-wm1-x344.google.com with SMTP id f129so223058wmf.2;
 Wed, 08 Jan 2020 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/o4bDn3dx+hvLpJNubHBy3g8/kBOKMigvDbQowCoNJI=;
 b=ThQeaFGe9J0v0sdaKlhaToTQuzjLxJqbSrnIQAHGMl2G4+i7w1UDNcjYZ0kFn+9HSg
 vvvy0Jvcy/KE9+1MWtf8BgSG25tbeAyuMIduk3INwyWb/kaE/IszgxAztZyjL3EO/xLx
 OT6+itXYNdh4SLJ3Z6Tc9eStrNmE3hSfAZgET9lUHjJomPwU5Y2yrOd21kSVvFIWY5Qu
 vyY5zjDIyBe3Xgkm3Rq/mnY4Y4/fMmRvU3hWJz+YQqkACRizyOjgTEZL4N33KtP/3yCI
 4BxYDrvAQm5b/BR3XCMrbhAXF2d0h6ye19eCNYNC4QKYlZKRJIb5FmmqgjB6c80j/PGK
 WBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/o4bDn3dx+hvLpJNubHBy3g8/kBOKMigvDbQowCoNJI=;
 b=TsLE7ieLyNET/p9Qayn0n13nrtC25x0EzloUkghAwRqdiD+wwyavp+tb+MhVcQbbpe
 X0z39BaucLnZ8X0M1+sPd8UMR0dHF/JGx98dh5EnT5h4fEEnWfzazgVCRB3nDet6rs7B
 wEfI1+KoPmHxggVY1lBosZ2JLzV25ZSTfFd76AW8QNmjb5S0BTMhI6qcldlOjNiMwq1v
 1p2BIJKGtrF5bd83SqQAkYQGJLPlP8h69pCG5LGG69XN4GzHyMujSdML52E40Rn8CykV
 ln1EJJomBRq4EjY1OMbbZ42F07+aBSNBRcmfb49uH71YiQELtcrllto2tVmYg7AiCvW4
 b7aw==
X-Gm-Message-State: APjAAAVEoHV+zg68Ry/NLHPphpqoERRADCPrh2FWj6f8p6v4/IVkdH/X
 I3m9oPJ6sr55fxGm9wBaWrCDmbe0
X-Google-Smtp-Source: APXvYqzQcDkdnF090Iw3/QXyFjZEXXsbk645gCs54mZqgnjgpzVb9EOi7vKqF6HI/k0GLvD9Kh25SA==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr357854wmf.60.1578513650402;
 Wed, 08 Jan 2020 12:00:50 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id u18sm4970099wrt.26.2020.01.08.12.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 12:00:49 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/17] tests/boot_linux_console: Add a SD card test for the
 OrangePi PC board
Date: Wed,  8 Jan 2020 21:00:18 +0100
Message-Id: <20200108200020.4745-16-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108200020.4745-1-nieklinnenbank@gmail.com>
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, philmd@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The kernel image and DeviceTree blob are built by the Armbian
project (based on Debian):
https://www.armbian.com/orange-pi-pc/

The SD image is from the kernelci.org project:
https://kernelci.org/faq/#the-code

If ARM is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:arm" tags.

Alternatively, this test can be run using:

  $ avocado --show=console run -t machine:orangepi-pc tests/acceptance/boot_linux_console.py
  console: Uncompressing Linux... done, booting the kernel.
  console: Booting Linux on physical CPU 0x0
  console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019
  console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=50c5387d
  [...]
  console: sunxi-wdt 1c20ca0.watchdog: Watchdog enabled (timeout=16 sec, nowayout=0)
  console: sunxi-mmc 1c0f000.mmc: Linked as a consumer to regulator.2
  console: sunxi-mmc 1c0f000.mmc: Got CD GPIO
  console: ledtrig-cpu: registered to indicate activity on CPUs
  console: hidraw: raw HID events driver (C) Jiri Kosina
  console: usbcore: registered new interface driver usbhid
  console: usbhid: USB HID core driver
  console: Initializing XFRM netlink socket
  console: sunxi-mmc 1c0f000.mmc: initialized, max. request size: 16384 KB
  console: NET: Registered protocol family 10
  console: mmc0: host does not support reading read-only switch, assuming write-enable
  console: mmc0: Problem switching card into high-speed mode!
  console: mmc0: new SD card at address 4567
  console: mmcblk0: mmc0:4567 QEMU! 60.0 MiB
  [...]
  console: EXT4-fs (mmcblk0): mounting ext2 file system using the ext4 subsystem
  console: EXT4-fs (mmcblk0): mounted filesystem without journal. Opts: (null)
  console: VFS: Mounted root (ext2 filesystem) on device 179:0.
  console: Run /sbin/init as init process
  console: EXT4-fs (mmcblk0): re-mounted. Opts: block_validity,barrier,user_xattr,acl
  console: Starting syslogd: OK
  console: Starting klogd: OK
  console: Populating /dev using udev: udevd[203]: starting version 3.2.7
  console: /bin/sh: can't access tty; job control turned off
  console: cat /proc/partitions
  console: / # cat /proc/partitions
  console: major minor  #blocks  name
  console: 1        0       4096 ram0
  console: 1        1       4096 ram1
  console: 1        2       4096 ram2
  console: 1        3       4096 ram3
  console: 179        0      61440 mmcblk0
  console: reboot
  console: / # reboot
  console: umount: devtmpfs busy - remounted read-only
  console: EXT4-fs (mmcblk0): re-mounted. Opts: (null)
  console: The system is going down NOW!
  console: Sent SIGTERM to all processes
  console: Sent SIGKILL to all processes
  console: Requesting system reboot
  console: reboot: Restarting system
  JOB TIME   : 68.64 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[NL: rename in commit message Raspbian to Armbian]
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 tests/acceptance/boot_linux_console.py | 42 ++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index eeab4fa62a..d663106694 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -467,6 +467,48 @@ class BootLinuxConsole(Test):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
 
+    def test_arm_orangepi_sd(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:orangepi-pc
+        """
+        deb_url = ('https://apt.armbian.com/pool/main/l/'
+                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
+        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-4.20.7-sunxi')
+        dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
+                      'kci-2019.02/armel/base/rootfs.ext2.xz')
+        rootfs_hash = '692510cb625efda31640d1de0a8d60e26040f061'
+        rootfs_path_xz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
+        rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
+        archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
+
+        self.vm.set_machine('orangepi-pc')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'root=/dev/mmcblk0 rootwait rw '
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-drive', 'file=' + rootfs_path + ',if=sd,format=raw',
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        shell_ready = "/bin/sh: can't access tty; job control turned off"
+        self.wait_for_console_pattern(shell_ready)
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun8i Family')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
+                                                'mmcblk0')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.17.1


