Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2F8C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B533206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egGKumQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B533206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx2M-000663-AS
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLj-0004Zt-GL; Thu, 03 Sep 2020 17:00:52 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLh-0007mL-LT; Thu, 03 Sep 2020 17:00:51 -0400
Received: by mail-oi1-x241.google.com with SMTP id r64so4523234oib.6;
 Thu, 03 Sep 2020 14:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4/widhycmlff/G5xPs8XzJrOIKkwzYT0jr445QWuLTo=;
 b=egGKumQMv/pwMM8PYIs9wKNjFEWrcsQ22M2UjU6ql1giFI0ifC3FasfBnzkaiGuh7J
 yj57uT21Zyg/HMXDkcgE0TJqjMgTh4F4eDwuvVYlFlq82RXtLv+b0OXXDO1vMeRo+98O
 lJnjuDoWahtvrK7R79Yawq6fyPgcvmhQ4e6Uou6fy2iqsVBuVhQBYiQDoSNG/RL+VSob
 gCBoMQKfJWSQ2uC+dHtPOAwS12MUTViNAjX7ILl0eB49jmfB9D93te7lfT51asnuNbHu
 SNNzAln1y4JuDQq+QtUIjqS9d/BLTBLHAH6eWlAxo93dtdqDKVgnH0YSCiBxRpYopgFs
 84og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4/widhycmlff/G5xPs8XzJrOIKkwzYT0jr445QWuLTo=;
 b=JgYzj2fS5nzPlIbRhi2liazGYrYljiyTY2P+9UxmYCuSxLjzvZoslXqVy0pm3i06gt
 6GQ/4zvCcNKUtApPKPrYc55o6mUNJLNSlqGiwIT61LN8Ct7X/d8GdXSJcLShaQbNBP4x
 ajd+297YMgmaKS5M+RHcTZQcn2uKFiE6raHQm4nXuJNzPqRdQ0fhuOQg7qw5xtGQRFLE
 Vm/0NPdU+rjZ8hqE964OJQVZXPw+JlM2LEtdJv2jxBm8uPNtq9ZbNRZHA0IQCkzunvyn
 j5iZQhDw+tQjMC5Jj2sU5R38pjqGKp2uigF51s2Q47smRmD1ttmzu86yA41uDuR8lSLV
 O5EA==
X-Gm-Message-State: AOAM531gwcwcWBj7Ik0BktTL8BSXPGmqVy5eTf6tGc8hNyztof9yEgrv
 47T5VgHWTntwAUtSObUSwdF3O7flmbTtSg==
X-Google-Smtp-Source: ABdhPJzSOzyd3+UKrbITiyHPC4b0UoL3XNgzbNmUvfZJltpixxPNepSVJgsz/dj5l848S7pOarLXTg==
X-Received: by 2002:aca:bb07:: with SMTP id l7mr3406165oif.98.1599166847684;
 Thu, 03 Sep 2020 14:00:47 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id f12sm822017ooi.42.2020.09.03.14.00.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:47 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 50/77] tests/acceptance/boot_linux: Expand SD card image to
 power of 2
Date: Thu,  3 Sep 2020 15:59:08 -0500
Message-Id: <20200903205935.27832-51-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

In few commits we won't allow SD card images with invalid size
(not aligned to a power of 2). Prepare the tests: add the
pow2ceil() and image_pow2ceil_expand() methods and resize the
images (expanding) of the tests using SD cards.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200713183209.26308-5-f4bug@amsat.org>
(cherry picked from commit 6a289a5ba3383e17fb47029720425bef42e424d7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/acceptance/boot_linux_console.py | 31 ++++++++++++++++++--------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index e4204d8f09..db901c1348 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -28,6 +28,22 @@ try:
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
 
@@ -600,6 +616,7 @@ class BootLinuxConsole(LinuxKernelTest):
         rootfs_path_xz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
         rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
         archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
+        image_pow2ceil_expand(rootfs_path)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -637,7 +654,7 @@ class BootLinuxConsole(LinuxKernelTest):
         :avocado: tags=device:sd
         """
 
-        # This test download a 196MB compressed image and expand it to 932MB...
+        # This test download a 196MB compressed image and expand it to 1GB
         image_url = ('https://dl.armbian.com/orangepipc/archive/'
                      'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z')
         image_hash = '196a8ffb72b0123d92cea4a070894813d305c71e'
@@ -645,6 +662,7 @@ class BootLinuxConsole(LinuxKernelTest):
         image_name = 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
         image_path = os.path.join(self.workdir, image_name)
         process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
+        image_pow2ceil_expand(image_path)
 
         self.vm.set_console()
         self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
@@ -678,7 +696,7 @@ class BootLinuxConsole(LinuxKernelTest):
         :avocado: tags=machine:orangepi-pc
         :avocado: tags=device:sd
         """
-        # This test download a 304MB compressed image and expand it to 1.3GB...
+        # This test download a 304MB compressed image and expand it to 2GB
         deb_url = ('http://snapshot.debian.org/archive/debian/'
                    '20200108T145233Z/pool/main/u/u-boot/'
                    'u-boot-sunxi_2020.01%2Bdfsg-1_armhf.deb')
@@ -695,8 +713,9 @@ class BootLinuxConsole(LinuxKernelTest):
         image_hash = '2babb29d36d8360adcb39c09e31060945259917a'
         image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash)
         image_path = os.path.join(self.workdir, 'armv7.img')
-        image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
         archive.gzip_uncompress(image_path_gz, image_path)
+        image_pow2ceil_expand(image_path)
+        image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
 
         # dd if=u-boot-sunxi-with-spl.bin of=armv7.img bs=1K seek=8 conv=notrunc
         with open(uboot_path, 'rb') as f_in:
@@ -704,12 +723,6 @@ class BootLinuxConsole(LinuxKernelTest):
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
2.17.1


