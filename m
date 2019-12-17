Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C8C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1262072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YI+XW194"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1262072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHdb-00062o-TD
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ihHZL-00017F-CP
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ihHZJ-0003aN-Qm
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:27:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:34836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ihHZJ-0003YM-KT; Tue, 17 Dec 2019 13:27:37 -0500
Received: by mail-wm1-x334.google.com with SMTP id p17so4317021wmb.0;
 Tue, 17 Dec 2019 10:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7DH7DYNU1Zm5xKKx/ruGWzKOcjnoaA8MF93LyBj0E9Y=;
 b=YI+XW194dAe4lQ6BLazs6JQoseizfLTAqOds28elDmgHrVtYsOqmGu2DGpreH5FNvo
 llVse3WE1QrSqQh6kZ0ULD4r7WRo7SIqqIQi/41dP4mPGn4iRC+TcBRFTLYt0RLsrjW7
 IU5JjQ/cdV4//B7YKtRMrXGqnPt8rhSyJSV3TpmsZX5OBhozRY6tSOf2mwDeGmVGnyQV
 AVKQBLPCFu77HwpUI5COxyu194V6C4E0jw2nMiKjZU9iQgLvnYUCwVPo8Np+G5Jeel03
 jlhJP1TTEEt6iX+R2e0PPp/Q0Cnz2r8pzPTtbNyOkeCmGFwqGOQimlvMSlmUMGvz8lxP
 /PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7DH7DYNU1Zm5xKKx/ruGWzKOcjnoaA8MF93LyBj0E9Y=;
 b=XdsnTC2f10wGkMda0NvuhnrGYwDdgXVmK2lPYXx+1m6tXxdyZhVyWUCPbnhv92BvQ6
 DYJAEu6XEjg6S2DqJ+fJ/4RDDB7f0Y+G3DNcrPX0SC4x7S+xfnaVlO3jsPPRBFrYAHzs
 ct9WtBrNt4Xyy0qU4jsfNDC09GFg2uWNwWYni5GVgTiIsh/gEDKaHtSnFJn3NI0DEcua
 DP44XEWHXMZwdLIBzd2e5ZKJLMWOZ9cv4wHBEEu/6JQM0O/0cFxt+unqJuvslE1VpSh5
 9PHvSlH+/HD/hedKywCZ/JtoMK43JF/2kdN7No5+MLTCeT8cDRBV7JllV9TxWXmOXb3y
 4Kvg==
X-Gm-Message-State: APjAAAUzO12/3/DNFKyC3+PrK2wlgsX6j76y8nPOcmHNzBdq4fQWxfo6
 vBXafJxYwB9OOwPhzfAqP0NYX2zC
X-Google-Smtp-Source: APXvYqwtBdu+Nwk8MFp9WedywRxSmPNgQSUC28j3Y0R59rHL7c5nTxxPwFYuKLdGJc9YFLJkCLavMQ==
X-Received: by 2002:a1c:6202:: with SMTP id w2mr6743047wmb.141.1576607256378; 
 Tue, 17 Dec 2019 10:27:36 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id u18sm26006975wrt.26.2019.12.17.10.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 10:27:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] tests/boot_linux_console: Add a SD card test for the
 OrangePi PC board
Date: Tue, 17 Dec 2019 19:27:28 +0100
Message-Id: <20191217182730.943-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217182730.943-1-f4bug@amsat.org>
References: <20191217182730.943-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel image and DeviceTree blob are built by the Raspbian
project (based on Debian):
https://www.raspbian.org/RaspbianImages

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
---
 tests/acceptance/boot_linux_console.py | 42 ++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index daabd47404..8179b45910 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -478,6 +478,48 @@ class BootLinuxConsole(Test):
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
2.21.0


