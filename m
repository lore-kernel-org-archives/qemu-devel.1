Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE460C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B884208B6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/bqX5iv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B884208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWRTH-0006mh-41
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 17:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWRSL-0006E3-Kq; Sat, 24 Oct 2020 17:52:09 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:43211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWRSJ-0004QI-KK; Sat, 24 Oct 2020 17:52:09 -0400
Received: by mail-ej1-x642.google.com with SMTP id k3so7678261ejj.10;
 Sat, 24 Oct 2020 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1YMyM0uvJjng4NpdrtrASF2qdl8mCrwPAZo1XEhle8s=;
 b=s/bqX5ivU+/mRvi0lvbLoCGklUn06GVxI/CtpHNFHuirEUI3AoS/Myf0isGfSEeSMx
 +2LhF2fZOjrxxBwzDHMGfJAbLxj8Wr67t6HIYkFmJ89U5mD+xcjBDCO0pt+r3O4maXvm
 0P22EEV+s4lAYZSU1bA79Bx/dc/8XA5UFiEobSDMYPdQC1o/zzJrX0opo4ReNaUQRucJ
 tdqnHMcLuftlBgSztCmS6L64rSxDI+n7kEKsGriSyVT1xia/T4JCs0pVA03djqk7GE80
 hcqvBTsTmcn9spWA7aEM60KXG2iukb7trBcXw0DYy64qrFla+AFqlSg5cR6fzjoh6YVL
 U7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1YMyM0uvJjng4NpdrtrASF2qdl8mCrwPAZo1XEhle8s=;
 b=roN7thQO95CgToaJnKUCkRdro1TjSyk+atj//5g6rIvMIYKcNAkmd9/jyVH+kPN5/+
 L4Bwci7oESn75W++p6tZ/th9ga6XaO5VK1BNpI9FHF2XeZAOd7OitcLy2yKWzm7sHuj+
 ioMRfBR9sCtf/pS3HEqKLrJJC/GoH/dXvndf9PSLypK2vUj4eLlF1SpNsP4F4BXT3HyJ
 D6tBdSpmBLSZDWJ570ki3V5y1IYkASCPOetq4OnUrIPJuoOgKsD5mDGUlZn1Vrkv8ei4
 xORAGiz+w7N0p+s5YEo9qv326hZ4LADsoTUW4wC13IjgbVnJIOgEvbuFc0QMtnKdrdP/
 3rQw==
X-Gm-Message-State: AOAM533MYMG2cb2D2m06XuhF4xfzrrgQKUrC2W8TZ7CEzDBE1SKEhAnm
 1LzV7sgpYyFIkfC+lU2EVTGt5fUkPv6p3RQh
X-Google-Smtp-Source: ABdhPJw1OEAlYvUsL3KU9rXBKQ5wxBQGDTMjFa+M49LncRhfWDWKkrIFiylBrD7XI8qkjIGJmqeUGQ==
X-Received: by 2002:a17:906:f205:: with SMTP id
 gt5mr8503691ejb.48.1603576325356; 
 Sat, 24 Oct 2020 14:52:05 -0700 (PDT)
Received: from tuf.home (2a02-a456-6be8-1-74b3-9e98-3c9c-45ea.fixed6.kpn.net.
 [2a02:a456:6be8:1:74b3:9e98:3c9c:45ea])
 by smtp.gmail.com with ESMTPSA id r4sm2669322edv.16.2020.10.24.14.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2020 14:52:04 -0700 (PDT)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/acceptance: expand Orange Pi PC SD images for NetBSD,
 Armbian above nearest power of two
Date: Sat, 24 Oct 2020 23:52:00 +0200
Message-Id: <20201024215200.494209-1-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, philmd@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The acceptance tests for the Orange Pi PC need to expand the SD card images
to a size which is a power of two. As Qemu uses the size of the SD image file
as well for the size of the emulated SD card, this can sometimes give problems
for guests that assume a certain minimum size of the SD card.

This commit resolves the following acceptance test error for the NetBSD 9.0 test
of the Orange Pi PC by increasing the size of the expanded SD card image to two times
the nearest power of two:

   (5/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9: |console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
  console: DRAM: 1024 MiB
  console: Failed to set core voltage! Can't set CPU frequency
  /console: Trying to boot from MMC1
  console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner Technology
  ...
  console: Starting kernel ...
  console: [   1.0000000] NetBSD/evbarm (fdt) booting ...
  ...
  console: [   1.3300167] sdmmc0: SD card status: 4-bit, C0
  console: [   1.3300167] ld0 at sdmmc0: <0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
  console: [   1.3430678] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec, 512 bytes/sect x 2097152 sectors
  console: [   1.4102580] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
  console: [   2.0674392] WARNING: 4 errors while detecting hardware; check system log.
  console: [   2.0674392] boot device: ld0
  console: [   2.0775401] root on ld0a dumps on ld0b
  console: [   2.0977679] vfs_mountroot: can't open root device
  console: [   2.0977679] cannot mount root, error = 6
  INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reached.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Based-on: ("[RFC PATCH 0/4] tests/acceptance: Test U-Boot/Linux from Armbian 20.08 on Orange Pi PC")
---
 tests/acceptance/boot_linux_console.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index b604cfe7da..40835904bb 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -35,11 +35,11 @@ def pow2ceil(x):
     return 1 if x == 0 else 2**(x - 1).bit_length()
 
 """
-Expand file size to next power of 2
+Expand file size to next power of 2 or higher
 """
-def image_pow2ceil_expand(path):
+def image_pow2ceil_expand(path, multiply_factor = 1):
         size = os.path.getsize(path)
-        size_aligned = pow2ceil(size)
+        size_aligned = pow2ceil(size) * multiply_factor
         if size != size_aligned:
             with open(path, 'ab+') as fd:
                 fd.truncate(size_aligned)
@@ -850,7 +850,7 @@ class BootLinuxConsole(LinuxKernelTest):
         image_path_xz = self.fetch_asset(image_url, asset_hash=image_hash,
                                          algorithm='sha256')
         image_path = archive.extract(image_path_xz, self.workdir)
-        image_pow2ceil_expand(image_path)
+        image_pow2ceil_expand(image_path, 2)
 
         self.do_test_arm_orangepi_uboot_armbian(image_path)
 
@@ -879,7 +879,7 @@ class BootLinuxConsole(LinuxKernelTest):
         image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash)
         image_path = os.path.join(self.workdir, 'armv7.img')
         archive.gzip_uncompress(image_path_gz, image_path)
-        image_pow2ceil_expand(image_path)
+        image_pow2ceil_expand(image_path, 2)
         image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
 
         # dd if=u-boot-sunxi-with-spl.bin of=armv7.img bs=1K seek=8 conv=notrunc
-- 
2.25.1


