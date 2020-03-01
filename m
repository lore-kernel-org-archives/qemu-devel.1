Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C9CC3F2D4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 21:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB0820CC7
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 21:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkDhRGz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB0820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52203 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8WYW-0001Fu-FR
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 16:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j8WUA-0001NB-Qo
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 16:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j8WU8-0006XJ-JI
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 16:50:54 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:52089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j8WU8-0006Wp-AN; Sun, 01 Mar 2020 16:50:52 -0500
Received: by mail-wm1-x331.google.com with SMTP id 9so2808686wmo.1;
 Sun, 01 Mar 2020 13:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2mKODY9BkFzTTukE61uRoAjpmkBWxek0KkThNs8pY2g=;
 b=NkDhRGz3QWbVoh/f2zT5NRoAhcoMoCmjEyw6hgSJ/PQUG7CUJz49NTR4M2VqcDv+o6
 Qdjlqfx30j3B/6WDl0Hr9e5L94maUia0w/7mOCe8H00v7++F+ZoYMufZqie7uE6c19jx
 T4QtyfnJpcZN5Dl+1p0FDBR0HMsChnhVX0qicKXOVuov1oyfAkxX0k1PhTVr/899+RNx
 rjyYLLcS2tykg8e9GaXf0wIcByQ/hSLagEnzwdDIA9optwlltrfNJdRWIqOclRohd3hw
 on3T3z2sWqM5k5znCDS/1rdx1hJzfFqyZIKw00knhxJWp0C0lVtnw1HPODYiifNvG5Nh
 qjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2mKODY9BkFzTTukE61uRoAjpmkBWxek0KkThNs8pY2g=;
 b=FlX30wKbL0vIYjcH1RiV/VFchv8ndGsqSeZuPkQw4D8V/kla4pR+KwqKCEW2v6i/2o
 2DBC0bThdKF6vhKcfECMo9NzfJDYfz1Yv4LCt23Mn8HSuJGuOmpmpAqf/h+j7Fe3yRjh
 nM1zjg7/5gWPNRzg8H3dU9MzrhTOixfVdMbEyauPFkLrRDpen4gjFPCvuXIp4EIStFK3
 T4sPvR3lHIdJSWwl0xORCDVWnVP08o8Hw0YzRFkPRFF6A6Q0OpSkhxICwGlrb1KiMIYZ
 7xCaAeuomfVC3sLYQMKX1NMG/kvOfsdruP8lGQ9dMOgbdn6U8ZKePH3zvH1MYOIM9p+5
 athw==
X-Gm-Message-State: APjAAAWANkAKrPuusxzJC8MG7r8jQVOtQ2uaVNiexEb5fh5Q5N5qXHIi
 NAMCEoKGIr/9mykvp29LFwdkRu+j
X-Google-Smtp-Source: APXvYqyC24At7e9TtmIdurvPJF1i9A90Jf/owcJj4QWn4F8sIEpNrP50FVxjm6vik0tVYOiDHQVguw==
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr16210790wmm.79.1583099450627; 
 Sun, 01 Mar 2020 13:50:50 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id e8sm25033124wrr.69.2020.03.01.13.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2020 13:50:50 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 17/18] tests/boot_linux_console: Test booting NetBSD via
 U-Boot on OrangePi PC
Date: Sun,  1 Mar 2020 22:50:28 +0100
Message-Id: <20200301215029.15196-18-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200301215029.15196-1-nieklinnenbank@gmail.com>
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, jasowang@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 b.galvani@gmail.com, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This test boots U-Boot then NetBSD (stored on a SD card) on
a OrangePi PC board.

As it requires ~1.3GB of storage, it is disabled by default.

U-Boot is built by the Debian project [1], and the SD card image
is provided by the NetBSD organization [2].

Once the compressed SD card image is downloaded (304MB) and
extracted, this test is fast:

  $ AVOCADO_ALLOW_LARGE_STORAGE=yes \
    avocado --show=app,console run -t machine:orangepi-pc \
      tests/acceptance/boot_linux_console.py
  console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
  console: DRAM: 1024 MiB
  console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner Technology
  console: CPU:   Allwinner H3 (SUN8I 0000)
  console: scanning bus usb@1c1b000 for devices... 1 USB Device(s) found
  console: scanning bus usb@1c1d000 for devices... 1 USB Device(s) found
  console: scanning usb for storage devices... 0 Storage Device(s) found
  console: Hit any key to stop autoboot:  0
  console: => setenv bootargs root=ld0a
  console: => setenv kernel netbsd-GENERIC.ub
  console: => setenv fdtfile dtb/sun8i-h3-orangepi-pc.dtb
  console: => boot
  console: ## Booting kernel from Legacy Image at 42000000 ...
  console: Image Name:   NetBSD/earmv7hf 9.0_RC1
  console: Image Type:   ARM Linux Kernel Image (no loading done) (uncompressed)
  console: XIP Kernel Image (no loading done)
  console: Loading Device Tree to 49ff6000, end 49fffe01 ... OK
  console: Starting kernel ...
  console: [   1.0000000] NetBSD/evbarm (fdt) booting ...
  console: [   1.0000000] NetBSD 9.0 (GENERIC) #0: Fri Feb 14 00:06:28 UTC 2020
  console: [   1.0000000]         mkrepro@mkrepro.NetBSD.org:/usr/src/sys/arch/evbarm/compile/GENERIC
  console: [   1.0000000] total memory = 1024 MB
  console: [   1.0000000] avail memory = 1003 MB
  console: [   1.0000000] armfdt0 (root)
  console: [   1.0000000] simplebus0 at armfdt0: Xunlong Orange Pi PC
  console: [   1.0000000] cpu0 at cpus0: Cortex-A7 r0p5 (Cortex V7A core)
  console: [   1.0000000] cpu0: DC enabled IC enabled WB enabled LABT branch prediction enabled
  console: [   1.0000000] cpu0: 32KB/64B 2-way L1 VIPT Instruction cache
  console: [   1.0000000] cpu0: 32KB/64B 2-way write-back-locking-C L1 PIPT Data cache
  console: [   1.0000000] cpu0: 2304KB/64B 16-way write-through L2 PIPT Unified cache
  console: [   1.0000000] vfp0 at cpu0: NEON MPE (VFP 3.0+), rounding, NaN propagation, denormals
  ...
  console: [   2.3812082] sdmmc0: SD card status: 4-bit, C0
  console: [   2.3812082] ld0 at sdmmc0: <0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
  console: [   2.4012856] ld0: 1226 MB, 622 cyl, 64 head, 63 sec, 512 bytes/sect x 2511872 sectors
  console: [   2.5321222] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
  console: [   3.1068718] WARNING: 4 errors while detecting hardware; check system log.
  console: [   3.1179868] boot device: ld0
  console: [   3.1470623] root on ld0a dumps on ld0b
  console: [   3.2464436] root file system type: ffs
  console: [   3.2897123] kern.module.path=/stand/evbarm/9.0/modules
  console: Mon Feb 17 20:33:35 UTC 2020
  console: Starting root file system check:
  PASS (35.96 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 36.09 s

Note, this test only took ~65 seconds to run on Travis-CI, see: [3].

This test is based on a description from Niek Linnenbank from [4].

[1] https://wiki.debian.org/InstallingDebianOn/Allwinner#Creating_a_bootable_SD_Card_with_u-boot
[2] https://wiki.netbsd.org/ports/evbarm/allwinner/
[3] https://travis-ci.org/philmd/qemu/jobs/638823612#L3778
[4] https://www.mail-archive.com/qemu-devel@nongnu.org/msg669347.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[NL: changed test to use NetBSD 9.0 final release and -global allwinner-rtc.base-year]
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 tests/acceptance/boot_linux_console.py | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index a70ac4a6cc..4f09e559c8 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -16,6 +16,7 @@ import shutil
 from avocado import skipUnless
 from avocado_qemu import Test
 from avocado_qemu import exec_command_and_wait_for_pattern
+from avocado_qemu import interrupt_interactive_console_until_pattern
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import process
 from avocado.utils import archive
@@ -661,6 +662,75 @@ class BootLinuxConsole(Test):
                                       'to <orangepipc>')
         self.wait_for_console_pattern('Starting Load Kernel Modules...')
 
+    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
+    def test_arm_orangepi_uboot_netbsd9(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:orangepi-pc
+        """
+        # This test download a 304MB compressed image and expand it to 1.3GB...
+        deb_url = ('http://snapshot.debian.org/archive/debian/'
+                   '20200108T145233Z/pool/main/u/u-boot/'
+                   'u-boot-sunxi_2020.01%2Bdfsg-1_armhf.deb')
+        deb_hash = 'f67f404a80753ca3d1258f13e38f2b060e13db99'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        # We use the common OrangePi PC 'plus' build of U-Boot for our secondary
+        # program loader (SPL). We will then set the path to the more specific
+        # OrangePi "PC" device tree blob with 'setenv fdtfile' in U-Boot prompt,
+        # before to boot NetBSD.
+        uboot_path = '/usr/lib/u-boot/orangepi_plus/u-boot-sunxi-with-spl.bin'
+        uboot_path = self.extract_from_deb(deb_path, uboot_path)
+        image_url = ('https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/'
+                     'evbarm-earmv7hf/binary/gzimg/armv7.img.gz')
+        image_hash = '2babb29d36d8360adcb39c09e31060945259917a'
+        image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash)
+        image_path = os.path.join(self.workdir, 'armv7.img')
+        image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
+        archive.gzip_uncompress(image_path_gz, image_path)
+
+        # dd if=u-boot-sunxi-with-spl.bin of=armv7.img bs=1K seek=8 conv=notrunc
+        with open(uboot_path, 'rb') as f_in:
+            with open(image_path, 'r+b') as f_out:
+                f_out.seek(8 * 1024)
+                shutil.copyfileobj(f_in, f_out)
+
+                # Extend image, to avoid that NetBSD thinks the partition
+                # inside the image is larger than device size itself
+                f_out.seek(0, 2)
+                f_out.seek(64 * 1024 * 1024, 1)
+                f_out.write(bytearray([0x00]))
+
+        self.vm.set_console()
+        self.vm.add_args('-nic', 'user',
+                         '-drive', image_drive_args,
+                         '-global', 'allwinner-rtc.base-year=2000',
+                         '-no-reboot')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'U-Boot 2020.01+dfsg-1')
+        interrupt_interactive_console_until_pattern(self,
+                                       'Hit any key to stop autoboot:',
+                                       'switch to partitions #0, OK')
+
+        exec_command_and_wait_for_pattern(self, '', '=>')
+        cmd = 'setenv bootargs root=ld0a'
+        exec_command_and_wait_for_pattern(self, cmd, '=>')
+        cmd = 'setenv kernel netbsd-GENERIC.ub'
+        exec_command_and_wait_for_pattern(self, cmd, '=>')
+        cmd = 'setenv fdtfile dtb/sun8i-h3-orangepi-pc.dtb'
+        exec_command_and_wait_for_pattern(self, cmd, '=>')
+        cmd = ("setenv bootcmd 'fatload mmc 0:1 ${kernel_addr_r} ${kernel}; "
+               "fatload mmc 0:1 ${fdt_addr_r} ${fdtfile}; "
+               "fdt addr ${fdt_addr_r}; "
+               "bootm ${kernel_addr_r} - ${fdt_addr_r}'")
+        exec_command_and_wait_for_pattern(self, cmd, '=>')
+
+        exec_command_and_wait_for_pattern(self, 'boot',
+                                          'Booting kernel from Legacy Image')
+        wait_for_console_pattern(self, 'Starting kernel ...')
+        wait_for_console_pattern(self, 'NetBSD 9.0 (GENERIC)')
+        # Wait for user-space
+        wait_for_console_pattern(self, 'Starting root file system check')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.17.1


