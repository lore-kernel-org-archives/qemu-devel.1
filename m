Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54709C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22976206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUE4NAkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22976206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3IG-0007OH-Bm
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FU-00023Z-SE; Mon, 13 Jul 2020 14:32:20 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e]:40918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FT-0004Gb-0Y; Mon, 13 Jul 2020 14:32:20 -0400
Received: by mail-ej1-x62e.google.com with SMTP id o18so18423579eje.7;
 Mon, 13 Jul 2020 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nhs5ynfW5eDBEuVG49jlv4iF3aFNW3dwv+4Ev+duU34=;
 b=WUE4NAkmAlOifZiMBxX5My0GMHicjoD8ZRZ8sqc+PRKD/069odhAiCx+ay2wA/ft+J
 rA2OgepZapgR9blqpIwT3UP2M0AbEJzkpKvFgtzvUI1dIh5DwrS3ewvKFGlA/5UciIpv
 5OA+CQqEp05Y2tF7B2HttpzdtwZB4ecxv0QRoiGubkLiRuWWXOOOm+vsph6Y1uOMizez
 0MJrcoBBOcQ/+48NXuQzt4Mm482f1OuJ2SNjZtcyPfS0ZWyd4cYa/BYZaNAQsX9wJtlR
 1TmDyZgESg4pc3rwoS8sbcCi9IZOX5ci8w68/G+AXMgomkhVcbO73rExLWpPJso3+ZYj
 IOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nhs5ynfW5eDBEuVG49jlv4iF3aFNW3dwv+4Ev+duU34=;
 b=oA+mfF+dS2s9ZpoPGIMNO8MFfKemopi6u174j/iuV3bpwTuN2JVesn05rAgQcNnITs
 WHJxEjnmneWlhL+l2RSijfN+pXkCaumX/f8mte06ljHy5LvcTjDFc+Y5H7d0HEv90rMY
 CzfxtKnoaO9NXY5TfwV8zO+Qf0ocpeYbAUvadpTK9X5FfKiLEmp2pWVPL5V5MA04Cks9
 AtM7ZklhIDmxd2/21B+iEFfs7FtOOeZaw1JEFVUquMjZA/i/MRJ130XiikKjZZioypXg
 KkYECFhlhFTlVNKtq1du5lTzt6qe4sa/TlnqSL6niVgiVex5U4jVquPU192VtOhxErFn
 EZ0w==
X-Gm-Message-State: AOAM533lXU1wL/VVc4/6oHkGNE74WQJBhNqZ34eUv1w0MYs/gLLzD4IL
 kJBrwpWMAx/on1IBoD/I6Y98AxTl3Xs=
X-Google-Smtp-Source: ABdhPJxydMgwoAoprxteI6j0mm8uut16kwy5azGZOq1xng4INmyxdQxNqE4GT2cJ/lbgxmpc+RpbmQ==
X-Received: by 2002:a17:906:c56:: with SMTP id
 t22mr1090312ejf.50.1594665137027; 
 Mon, 13 Jul 2020 11:32:17 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id ce12sm4353148edb.4.2020.07.13.11.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 11:32:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/9] tests/acceptance/boot_linux: Expand SD card image to
 power of 2
Date: Mon, 13 Jul 2020 20:32:04 +0200
Message-Id: <20200713183209.26308-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200713183209.26308-1-f4bug@amsat.org>
References: <20200713183209.26308-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62e.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In few commits we won't allow SD card images with invalid size
(not aligned to a power of 2). Prepare the tests: add the
pow2ceil() and image_pow2ceil_expand() methods and resize the
images (expanding) of the tests using SD cards.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v1: Addressed review comments
- truncate -> expand reword (Alistair Francis)
- expand after uncompress (Niek Linnenbank)
---
 tests/acceptance/boot_linux_console.py | 27 +++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index b7e8858c2d..8f2a6aa8a4 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -28,6 +28,18 @@
 except CmdNotFoundError:
     P7ZIP_AVAILABLE = False
 
+# round up to next power of 2
+def pow2ceil(x):
+    return 1 if x == 0 else 2**(x - 1).bit_length()
+
+# expand file size to next power of 2
+def image_pow2ceil_expand(path):
+        size = os.path.getsize(path)
+        size_aligned = pow2ceil(size)
+        if size != size_aligned:
+            with open(path, 'ab+') as fd:
+                fd.truncate(size_aligned)
+
 class LinuxKernelTest(Test):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
@@ -636,6 +648,7 @@ def test_arm_orangepi_sd(self):
         rootfs_path_xz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
         rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
         archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
+        image_pow2ceil_expand(rootfs_path)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -673,7 +686,7 @@ def test_arm_orangepi_bionic(self):
         :avocado: tags=device:sd
         """
 
-        # This test download a 196MB compressed image and expand it to 932MB...
+        # This test download a 196MB compressed image and expand it to 1GB
         image_url = ('https://dl.armbian.com/orangepipc/archive/'
                      'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z')
         image_hash = '196a8ffb72b0123d92cea4a070894813d305c71e'
@@ -681,6 +694,7 @@ def test_arm_orangepi_bionic(self):
         image_name = 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
         image_path = os.path.join(self.workdir, image_name)
         process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
+        image_pow2ceil_expand(image_path)
 
         self.vm.set_console()
         self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
@@ -714,7 +728,7 @@ def test_arm_orangepi_uboot_netbsd9(self):
         :avocado: tags=machine:orangepi-pc
         :avocado: tags=device:sd
         """
-        # This test download a 304MB compressed image and expand it to 1.3GB...
+        # This test download a 304MB compressed image and expand it to 2GB
         deb_url = ('http://snapshot.debian.org/archive/debian/'
                    '20200108T145233Z/pool/main/u/u-boot/'
                    'u-boot-sunxi_2020.01%2Bdfsg-1_armhf.deb')
@@ -731,8 +745,9 @@ def test_arm_orangepi_uboot_netbsd9(self):
         image_hash = '2babb29d36d8360adcb39c09e31060945259917a'
         image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash)
         image_path = os.path.join(self.workdir, 'armv7.img')
-        image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
         archive.gzip_uncompress(image_path_gz, image_path)
+        image_pow2ceil_expand(image_path)
+        image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
 
         # dd if=u-boot-sunxi-with-spl.bin of=armv7.img bs=1K seek=8 conv=notrunc
         with open(uboot_path, 'rb') as f_in:
@@ -740,12 +755,6 @@ def test_arm_orangepi_uboot_netbsd9(self):
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


