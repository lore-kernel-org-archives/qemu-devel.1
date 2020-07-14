Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4E4C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0F8224F9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHHnRI+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0F8224F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLTM-0006Bn-HM
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLRx-00049P-Pt; Tue, 14 Jul 2020 09:58:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:45838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLRv-0003RD-WB; Tue, 14 Jul 2020 09:58:25 -0400
Received: by mail-wr1-x42c.google.com with SMTP id s10so21729482wrw.12;
 Tue, 14 Jul 2020 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5I6k15BzbxNW4yNX/t4jNCAcu35UtS7fJs1XxZN10R0=;
 b=YHHnRI+P0gG4nIRZRwsYF24p36aNG8+O+pJufhLsg9q8J1uIi+1qKVMwv/y458Hb6p
 QM/I/MJKoaBjuurGba2EboQGmvdsuqnBUXWv8IX2gYviBCS2gplU3+eEu2iUdDsYoPpK
 ++xMIW4eLuRPBLRtvKCEWVC93ysSGzIT4NqEpXRNqa2kubX5jgQhZq5RoWUd6HmIkn3r
 TfgIspd8IdW+kJk+arvrrSSb3IGA0d7FLlVItVQqsijjEHqzXquuS/+OAZz8+VvYQTLR
 /V5qSRKC2oWrdtWEwTXcH4JvA5Fl9fAJXxpxrzQBOahdM4EDdXqrXw+krKXcldJiQTNG
 Zf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5I6k15BzbxNW4yNX/t4jNCAcu35UtS7fJs1XxZN10R0=;
 b=JbI6o+xy38AIUcnzvgnqwZoIT/Uzk/FNxhKPDjPPybm4e03SquPDGOyOIx0b1oAGc/
 cLx/LPTNwwAoS7pZfN1itwhiWhHZEUf/Gvdyjj66dEpAT+0aX1W3ZLe+HvW8RdZK8ud/
 WUidyIzz1UGXpv12XXvNtUUep5NH/69r4wJhsvB3eqiwgMU8rGkdzZKCp0o6qej4BY2L
 zeMD7WNcV87+qi3g/Q6LpER2sJRMV//yHV75hKuOBh9xTLGUSzJqS7tzO/NNlWc1sx6H
 hfRUKhAxLHPUiV9IBWOfy4qkLH57xsdOJsRV4fbG5ekD5fO48EzK8kLEdX9hZYxfBkWy
 69ng==
X-Gm-Message-State: AOAM530AN3wRRIot/lsjvZtsUfTQByhMbrgkr7s+nkD41V4funW0Ehu5
 2X6xOffW3ZL+SpcV5kpYoD10+R2AIk0=
X-Google-Smtp-Source: ABdhPJz5bROAe8qtRtC4SXchBBTLcoHaGNu4uhXmxoaPlu/ZATMOPalWf2Y4KweluI+pIBEaF36gWA==
X-Received: by 2002:adf:81c7:: with SMTP id 65mr5441231wra.47.1594735101989;
 Tue, 14 Jul 2020 06:58:21 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k14sm29145343wrn.76.2020.07.14.06.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 06:58:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] tests/acceptance/boot_linux: Expand SD card image to power
 of 2
Date: Tue, 14 Jul 2020 15:58:09 +0200
Message-Id: <20200714135814.19910-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714135814.19910-1-f4bug@amsat.org>
References: <20200714135814.19910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Prasad J Pandit <ppandit@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Alistair Francis <alistair.francis@wdc.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In few commits we won't allow SD card images with invalid size
(not aligned to a power of 2). Prepare the tests: add the
pow2ceil() and image_pow2ceil_expand() methods and resize the
images (expanding) of the tests using SD cards.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200713183209.26308-5-f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 31 ++++++++++++++++++--------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index b7e8858c2d..67c3b2f3d1 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -28,6 +28,22 @@
 except CmdNotFoundError:
     P7ZIP_AVAILABLE = False
 
+"""
+Round up to next power of 2
+"""
+def pow2ceil(x):
+    return 1 if x == 0 else 2**(x - 1).bit_length()
+
+"""
+Expand file size to next power of 2
+"""
+def image_pow2ceil_expand(path):
+        size = os.path.getsize(path)
+        size_aligned = pow2ceil(size)
+        if size != size_aligned:
+            with open(path, 'ab+') as fd:
+                fd.truncate(size_aligned)
+
 class LinuxKernelTest(Test):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
@@ -636,6 +652,7 @@ def test_arm_orangepi_sd(self):
         rootfs_path_xz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
         rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
         archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
+        image_pow2ceil_expand(rootfs_path)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -673,7 +690,7 @@ def test_arm_orangepi_bionic(self):
         :avocado: tags=device:sd
         """
 
-        # This test download a 196MB compressed image and expand it to 932MB...
+        # This test download a 196MB compressed image and expand it to 1GB
         image_url = ('https://dl.armbian.com/orangepipc/archive/'
                      'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z')
         image_hash = '196a8ffb72b0123d92cea4a070894813d305c71e'
@@ -681,6 +698,7 @@ def test_arm_orangepi_bionic(self):
         image_name = 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
         image_path = os.path.join(self.workdir, image_name)
         process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
+        image_pow2ceil_expand(image_path)
 
         self.vm.set_console()
         self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
@@ -714,7 +732,7 @@ def test_arm_orangepi_uboot_netbsd9(self):
         :avocado: tags=machine:orangepi-pc
         :avocado: tags=device:sd
         """
-        # This test download a 304MB compressed image and expand it to 1.3GB...
+        # This test download a 304MB compressed image and expand it to 2GB
         deb_url = ('http://snapshot.debian.org/archive/debian/'
                    '20200108T145233Z/pool/main/u/u-boot/'
                    'u-boot-sunxi_2020.01%2Bdfsg-1_armhf.deb')
@@ -731,8 +749,9 @@ def test_arm_orangepi_uboot_netbsd9(self):
         image_hash = '2babb29d36d8360adcb39c09e31060945259917a'
         image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash)
         image_path = os.path.join(self.workdir, 'armv7.img')
-        image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
         archive.gzip_uncompress(image_path_gz, image_path)
+        image_pow2ceil_expand(image_path)
+        image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
 
         # dd if=u-boot-sunxi-with-spl.bin of=armv7.img bs=1K seek=8 conv=notrunc
         with open(uboot_path, 'rb') as f_in:
@@ -740,12 +759,6 @@ def test_arm_orangepi_uboot_netbsd9(self):
                 f_out.seek(8 * 1024)
                 shutil.copyfileobj(f_in, f_out)
 
-                # Extend image, to avoid that NetBSD thinks the partition
-                # inside the image is larger than device size itself
-                f_out.seek(0, 2)
-                f_out.seek(64 * 1024 * 1024, 1)
-                f_out.write(bytearray([0x00]))
-
         self.vm.set_console()
         self.vm.add_args('-nic', 'user',
                          '-drive', image_drive_args,
-- 
2.21.3


