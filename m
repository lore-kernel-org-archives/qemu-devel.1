Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B215C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B1F208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+td8bYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B1F208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqiv-0000rJ-Ij
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8d-0003R3-1I
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:33891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8a-0007fO-RK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id l15so5967774wmh.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0FaOrIvwECqqJ9dWUAOuxBZXhvhN/JzG4HntJwUKbeI=;
 b=T+td8bYsh2JPRvFbUsU3EPnyHP0khzVgp74Uu0xasS8MaqvzCSoA84EQFBf9xzPw25
 VeM4rVpPwUdaVwWTNQnZn/2plxRt3LecuaWaDDHVARACkd4lJUguQQp4tmQWtrbqAf7v
 UM7Tv3IdEXWmvCh0sDZv2gbogtE9YMAZqSK5DsHZFbxqS9ElvaSHMlnbBKVwA/BEs9Ye
 lxF4Tm5HysLNQ5u+2XN7iQ+oSLAIsKURPMKM8IkVECjeUO/a41vc/3bTzsph80P3rP3m
 91l4ZNgO9lkV+Sn8lWs2lY5S0wlG8KCRAECIo55QSfaMknyImqrMJ3WwqmmUAU079X5p
 8A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0FaOrIvwECqqJ9dWUAOuxBZXhvhN/JzG4HntJwUKbeI=;
 b=n4YestiCG81O2S7rhO7B4CESzhVIWfRbTAVyNFmuCVeKMGwpraA35DcTF6b2AOhauF
 Enjc7NN4VkkkstUr6hmBrrmwlUdDefcYNw/a8apBfEZScgaTwbgnM6aUr9nD70lF94Eb
 YO5ydZfx6ZFYGIOmaOvWq+kcPyMCQ+1OtrmMuw1orxpaVNUBA65Z6ySip0OmRriMPN68
 5HrV/+3B+mQofAR0pQwbx76NtJp6LuI7KCcOc+E0MgUc/ILDyzv/gOiCqaqf85Y+Aftk
 HsGBhv0fn3u4TrVxzoLd8Q/VzDsujLAYBw8ua+9O0nDl+1jshOujBZ8EtZEc3yD2zM3a
 EWqg==
X-Gm-Message-State: AOAM53228whgenlcRpHsE/6zOsQ6i7c4FJQlz4tnSvErptz4lGc/Myoi
 fJO3QAavuh0ial39+HG4gGdP543AvtVd+p2h
X-Google-Smtp-Source: ABdhPJwS/SKlRNU9QIkyjLeE+eEBTbrLCjszIZfqJ2Uu64E5QmWgRh0mgGTLh/QARnEBEtxpQNtuCA==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr15242386wmc.100.1600092439077; 
 Mon, 14 Sep 2020 07:07:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.07.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:07:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/36] tests/acceptance: console boot tests for quanta-gsj
Date: Mon, 14 Sep 2020 15:06:37 +0100
Message-Id: <20200914140641.21369-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Havard Skinnemoen <hskinnemoen@google.com>

This adds two acceptance tests for the quanta-gsj machine.

One test downloads a lightly patched openbmc flash image from github and
verifies that it boots all the way to the login prompt.

The other test downloads a kernel, initrd and dtb built from the same
openbmc source and verifies that the kernel detects all CPUs and boots
to the point where it can't find the root filesystem (because we have no
flash image in this case).

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
Message-id: 20200911052101.2602693-15-hskinnemoen@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/acceptance/boot_linux_console.py | 83 ++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index aaa781a5813..4a366ce93e4 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -568,6 +568,89 @@ class BootLinuxConsole(LinuxKernelTest):
                                                 'sda')
         # cubieboard's reboot is not functioning; omit reboot test.
 
+    def test_arm_quanta_gsj(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:quanta-gsj
+        """
+        # 25 MiB compressed, 32 MiB uncompressed.
+        image_url = (
+                'https://github.com/hskinnemoen/openbmc/releases/download/'
+                '20200711-gsj-qemu-0/obmc-phosphor-image-gsj.static.mtd.gz')
+        image_hash = '14895e634923345cb5c8776037ff7876df96f6b1'
+        image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash)
+        image_name = 'obmc.mtd'
+        image_path = os.path.join(self.workdir, image_name)
+        archive.gzip_uncompress(image_path_gz, image_path)
+
+        self.vm.set_console()
+        drive_args = 'file=' + image_path + ',if=mtd,bus=0,unit=0'
+        self.vm.add_args('-drive', drive_args)
+        self.vm.launch()
+
+        # Disable drivers and services that stall for a long time during boot,
+        # to avoid running past the 90-second timeout. These may be removed
+        # as the corresponding device support is added.
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + (
+                'console=${console} '
+                'mem=${mem} '
+                'initcall_blacklist=npcm_i2c_bus_driver_init '
+                'systemd.mask=systemd-random-seed.service '
+                'systemd.mask=dropbearkey.service '
+        )
+
+        self.wait_for_console_pattern('> BootBlock by Nuvoton')
+        self.wait_for_console_pattern('>Device: Poleg BMC NPCM730')
+        self.wait_for_console_pattern('>Skip DDR init.')
+        self.wait_for_console_pattern('U-Boot ')
+        interrupt_interactive_console_until_pattern(
+                self, 'Hit any key to stop autoboot:', 'U-Boot>')
+        exec_command_and_wait_for_pattern(
+                self, "setenv bootargs ${bootargs} " + kernel_command_line,
+                'U-Boot>')
+        exec_command_and_wait_for_pattern(
+                self, 'run romboot', 'Booting Kernel from flash')
+        self.wait_for_console_pattern('Booting Linux on physical CPU 0x0')
+        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0')
+        self.wait_for_console_pattern('OpenBMC Project Reference Distro')
+        self.wait_for_console_pattern('gsj login:')
+
+    def test_arm_quanta_gsj_initrd(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:quanta-gsj
+        """
+        initrd_url = (
+                'https://github.com/hskinnemoen/openbmc/releases/download/'
+                '20200711-gsj-qemu-0/obmc-phosphor-initramfs-gsj.cpio.xz')
+        initrd_hash = '98fefe5d7e56727b1eb17d5c00311b1b5c945300'
+        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        kernel_url = (
+                'https://github.com/hskinnemoen/openbmc/releases/download/'
+                '20200711-gsj-qemu-0/uImage-gsj.bin')
+        kernel_hash = 'fa67b2f141d56d39b3c54305c0e8a899c99eb2c7'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        dtb_url = (
+                'https://github.com/hskinnemoen/openbmc/releases/download/'
+                '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb')
+        dtb_hash = '18315f7006d7b688d8312d5c727eecd819aa36a4'
+        dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200n8 '
+                               'earlycon=uart8250,mmio32,0xf0001000')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Booting Linux on physical CPU 0x0')
+        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0')
+        self.wait_for_console_pattern(
+                'Give root password for system maintenance')
+
     def test_arm_orangepi(self):
         """
         :avocado: tags=arch:arm
-- 
2.20.1


