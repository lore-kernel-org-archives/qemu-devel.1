Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54C4C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB3C206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP+OH8fC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB3C206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsnYG-00042v-S6
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 09:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsnXJ-0002Z7-4L; Tue, 07 Jul 2020 09:21:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsnXH-00015S-LQ; Tue, 07 Jul 2020 09:21:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id l2so45003847wmf.0;
 Tue, 07 Jul 2020 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2zrFZLYRo+c3ZEDBF+YAvDsuRX/hAG3O/q/kiT44KIQ=;
 b=HP+OH8fCdo1xHNMitcyLJwrCP7pk4poJoOrauXKoo/8kSE3XsuiKVem1jsFOY8Z+hp
 em3n/8EwKkx3KXpop720My7KATo8OpCvm2W0xOytfqCwh+iblEcHeSkzuGiaB0Ff4R2w
 Mwy5DPNqYI5wV+xOtGSKeGwE2SXGfye0s2L2yRHjuiyxo5KEQY1JwiljxFzRUlC19aGz
 1uUqTY6JNugpmRdbdevzVFSmyj5Xd1ydYfEiDBymKRRwb4nw/Ce3pHe2kxdsjY4rKGOG
 dEmFVtmIUrhQrFGJrEPvGUlHuBNkDtIHtfOeH5gkttGAXENoS2qTDhePzH+2lj9Tv0zr
 SSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2zrFZLYRo+c3ZEDBF+YAvDsuRX/hAG3O/q/kiT44KIQ=;
 b=juH36mqDz//7/i5YlrhcRM9vHZqhsmzxXQSCE6el+XhkWyYf9xx+MQOpBan5KNU+Fm
 aUkp2CAi0rOf1J/amAEC/gzDbnlAHLpduxzVKbBFbivNq47HkW7MiAzIpSdn5jIQcckJ
 aa9rYqOHWMGbjCZC1yHw/b53xDHobg1tohc3uZAP3FYhruZgqpeOCBYin343N3SAWwj8
 SBrMw6zHLH6tImkgOU4Rooo7hVFYd7b8DZ1HM0XqqdZO7Xo4oSVDo1CYxhhCJAKQFiw2
 JI5CHG8oPFoKpu09ZGrmyY/UP7KPuxaDTgRXvVE9aPuET+crIMNFp4GNlZlbT/AX2EP2
 epmA==
X-Gm-Message-State: AOAM533RIQX8SjCwKeVC7sAPChOtUu8UyYHMfsbHvF2xZzeA57+Ef2Hz
 p1cSXhf1Iul+auWCyLxd9s/eqbi4
X-Google-Smtp-Source: ABdhPJxRg2kunOFYun7g0X40mDt2oApYL0maIZjmI8n/zdci5QvOMJx9cBxtiVact0zZ1H5g7eopmw==
X-Received: by 2002:a05:600c:2154:: with SMTP id
 v20mr4491839wml.185.1594128081365; 
 Tue, 07 Jul 2020 06:21:21 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 1sm1040130wmf.0.2020.07.07.06.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 06:21:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tests/acceptance/boot_linux: Truncate SD card image to
 power of 2
Date: Tue,  7 Jul 2020 15:21:15 +0200
Message-Id: <20200707132116.26207-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707132116.26207-1-f4bug@amsat.org>
References: <20200707132116.26207-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the next commit we won't allow SD card images with invalid
size (not aligned to a power of 2). Prepare the tests: add the
pow2ceil() and image_pow2ceil_truncate() methods and truncate
the images of the tests using SD cards.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 3d02519660..f4d4e3635f 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -28,6 +28,18 @@
 except CmdNotFoundError:
     P7ZIP_AVAILABLE = False
 
+# round up to next power of 2
+def pow2ceil(x):
+    return 1 if x == 0 else 2**(x - 1).bit_length()
+
+# truncate file size to next power of 2
+def image_pow2ceil_truncate(path):
+        size = os.path.getsize(path)
+        size_aligned = pow2ceil(size)
+        if size != size_aligned:
+            with open(path, 'ab+') as fd:
+                fd.truncate(size_aligned)
+
 class LinuxKernelTest(Test):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
@@ -635,6 +647,7 @@ def test_arm_orangepi_sd(self):
         rootfs_path_xz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
         rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
         archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
+        image_pow2ceil_truncate(rootfs_path)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -679,6 +692,7 @@ def test_arm_orangepi_bionic(self):
         image_name = 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
         image_path = os.path.join(self.workdir, image_name)
         process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
+        image_pow2ceil_truncate(image_path)
 
         self.vm.set_console()
         self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
@@ -728,6 +742,7 @@ def test_arm_orangepi_uboot_netbsd9(self):
         image_hash = '2babb29d36d8360adcb39c09e31060945259917a'
         image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash)
         image_path = os.path.join(self.workdir, 'armv7.img')
+        image_pow2ceil_truncate(image_path)
         image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
         archive.gzip_uncompress(image_path_gz, image_path)
 
-- 
2.21.3


