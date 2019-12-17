Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C10C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB062072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4esM/wI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB062072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHb3-0002oG-8P
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ihHZN-0001BY-S7
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ihHZM-0003dS-CL
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:27:41 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:45602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ihHZM-0003cn-5h; Tue, 17 Dec 2019 13:27:40 -0500
Received: by mail-wr1-x431.google.com with SMTP id j42so8205416wrj.12;
 Tue, 17 Dec 2019 10:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2/FzkBv2p4X12H/+2U7qu7eJmZZZlUhmWwgrYm57BRk=;
 b=I4esM/wInfAajD5fjP2FN5D/DtuPeSkz7Rz9wzeBG8TJMI3r8yllu6LpJTuDBTe/36
 qbCrXGMuwOZjAIcYnoEDROFPd5PJayl0LHOIQm3JAX06bcFDos9VhMW9NbAc9B3uNHI6
 kgJ5cnQR7I0hmcNX7RLAP6ONR32vepz9RGDi4jKF+dV8+ySV5D65av2OpzgGBlgMp7eb
 hwZXXRZGCsMBLFWXjUxv8851AoW800fHAeZdFLW03qF+EjSj+6BJwVof3oy78OL2ygop
 f9uKG32B9LerkRnfxj8tSgywHjDj42FamycLuyfyhs/tyxvyI2LGErVvIr9fcfSceFQQ
 owcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2/FzkBv2p4X12H/+2U7qu7eJmZZZlUhmWwgrYm57BRk=;
 b=RE5EQAhKXjnxBfd6hPXXMd6QfFFzBQ1Q4lA71U1ihmXSM6pqHj8jrZIJYn9QIuCllH
 bfFRTly7HeEWscOa/naObnCuv/XVel88f+O+23qJaF44wpPzh8mXX9qsr+LdX3OtgWuG
 MXNoSlTT2tZ9Vsy2QH4lVHtvY3nbDZFjz+rp/VIWWO4zH7syY0hySHB0SpIpr0dgvFWh
 M/3+SzRehobd/KnSIRZLk7e/o4yDKp285qKKzeg4ie0ForDO8FG4ea2xQLQUEwvCJOoQ
 ncyXkkya/cJctmNgxTSZNiJQAxuxaai8duWE2LRx6XYFeXNufmB1I3BpHPGsq9ev+RqF
 hDyg==
X-Gm-Message-State: APjAAAXTxDjzafgesGFl900Dxc1A0RsULVv+JyJfnkPU8lXKTUPOvIvK
 b1y4IfBFcZdZqUkD/niNKjg9qnVQ
X-Google-Smtp-Source: APXvYqxLOhGl9Qj+8rVMc+HHu+QL9rH2y2oSRpiKD3Sqgd1lb7V4UXWUqNQhyFaFd73AwXvz48zTTg==
X-Received: by 2002:a05:6000:1288:: with SMTP id
 f8mr38305876wrx.66.1576607258930; 
 Tue, 17 Dec 2019 10:27:38 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id u18sm26006975wrt.26.2019.12.17.10.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 10:27:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 5/5] tests/boot_linux_console: Add a SLOW test booting
 Ubuntu on OrangePi PC
Date: Tue, 17 Dec 2019 19:27:30 +0100
Message-Id: <20191217182730.943-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217182730.943-1-f4bug@amsat.org>
References: <20191217182730.943-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test boots Ubuntu Bionic on a OrangePi PC board.

As it requires 1GB of storage, and is slow, this test is disabled
on automatic CI testing.

It is useful for workstation testing. Currently Avocado timeouts too
quickly, so we can't run userland commands.

The kernel image and DeviceTree blob are built by the Raspbian
project (based on Debian):
https://www.raspbian.org/RaspbianImages

The Ubuntu image is downloaded from:
https://dl.armbian.com/orangepipc/Bionic_current

This test can be run using:

  $ AVOCADO_ALLOW_LARGE_STORAGE=yes \
    avocado --show=app,console run -t machine:orangepi-pc \
      tests/acceptance/boot_linux_console.py
  console: Uncompressing Linux... done, booting the kernel.
  console: Booting Linux on physical CPU 0x0
  console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019
  console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=50c5387d
  console: CPU: div instructions available: patching division code
  console: CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
  console: OF: fdt: Machine model: Xunlong Orange Pi PC
  [...]
  console: sunxi-mmc 1c0f000.mmc: initialized, max. request size: 16384 KB
  console: NET: Registered protocol family 10
  console: mmc0: host does not support reading read-only switch, assuming write-enable
  console: mmc0: Problem switching card into high-speed mode!
  console: mmc0: new SD card at address 4567
  console: mmcblk0: mmc0:4567 QEMU! 932 MiB
  console: Segment Routing with IPv6
  console: NET: Registered protocol family 17
  console: NET: Registered protocol family 15
  console: bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
  console: 8021q: 802.1Q VLAN Support v1.8
  console: Key type dns_resolver registered
  console: Registering SWP/SWPB emulation handler
  console: mmcblk0: p1
  [...]
  console: Freeing unused kernel memory: 1024K
  console: Run /sbin/init as init process
  console: random: fast init done
  console: systemd[1]: System time before build time, advancing clock.
  console: systemd[1]: systemd 237 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
  console: systemd[1]: Detected architecture arm.
  console: Welcome to Ubuntu 18.04.3 LTS!
  console: systemd[1]: Set hostname to <orangepipc>.
  console: random: systemd: uninitialized urandom read (16 bytes read)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because this is not the definitive test, but it is helpful so
for for testing Niek work.
---
 tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 8179b45910..663290e0c7 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -520,6 +520,47 @@ class BootLinuxConsole(Test):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
 
+    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
+    def test_arm_orangepi_bionic(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:orangepi-pc
+        """
+        # This test download a 196MB compressed image and expand it to 932MB...
+        deb_url = ('https://apt.armbian.com/pool/main/l/'
+                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
+        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-4.20.7-sunxi')
+        dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        image_url = ('https://dl.armbian.com/orangepipc/archive/'
+                     'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z')
+        image_hash = '196a8ffb72b0123d92cea4a070894813d305c71e'
+        image_path_xz = self.fetch_asset(image_url, asset_hash=image_hash)
+        image_name = 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
+        image_path = os.path.join(self.workdir, image_name)
+        archive.lzma_uncompress(image_path_xz, image_path)
+
+        self.vm.set_machine('orangepi-pc')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'root=/dev/mmcblk0p1 rootwait rw '
+                               'systemd.mask=dev-ttyS0.device '
+                               'systemd.mask=armbian-zram-config.service '
+                               'systemd.mask=armbian-ramlog.service')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-drive', 'file=' + image_path + ',if=sd,format=raw',
+                         '-append', kernel_command_line,
+                         '-nic', 'user',
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Welcome to Ubuntu 18.04.3 LTS!')
+        self.wait_for_console_pattern('Started Armbian filesystem resize.')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.21.0


