Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E949C47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 15:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392A52133F
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 15:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzj4FmPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392A52133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGmNO-0005bl-EM
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 11:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iGmHs-0008LC-E4
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 11:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iGmHp-00080U-Nt
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 11:48:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iGmHp-0007zj-BQ; Sat, 05 Oct 2019 11:48:01 -0400
Received: by mail-wm1-x343.google.com with SMTP id r17so11681578wme.0;
 Sat, 05 Oct 2019 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hXjDLUOk17jtBgjZt49xK2ZebEtJ7ImDjgQZ+Uu6f2U=;
 b=Tzj4FmPu/HaKqj1qTdbL/WkHveMBafQ4JPLjObEOxEwfEYGnhONmkYv9im6jjsMyFj
 /AEyEsRFCK9AXKWYkLdacrE2/U2I1ko2Hr/5RsX1qg40ki5u1K7IJyu3t3rzx535fCqT
 3BGp+fcMUcuU7CJ5SKLNFe30tSJyv3ipcSTvvPz8W+NhIhnGZoPmRmkNn03Em2rDyeoP
 x3csxmMkvDIIbRkBeIyJQwKbD/zPSxZdJIDL0CI7dFhJvkk+b9pUYa2x/hd5C7/6k76f
 hUKf4us1EBTj/7suHuPkaJKhJCUXgyu/+vX/cu2tkDTS0zozu3C0ebiqJc6pTqHelKxb
 Yg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hXjDLUOk17jtBgjZt49xK2ZebEtJ7ImDjgQZ+Uu6f2U=;
 b=G5mxH3D/lzVHYtALZUOqnNC6UM19zBwYn1a2mNVu21r1DalFb5yLH+BwCz62kwhxQG
 OJIktzHnqRrJ+DAm/+hK/jL9tXTPvnG91hp1HSGcoy85LRqaoCAtGkSlEpyr2ho8tjBg
 B3ayqnV5ka0y6viB2BW7qsYZJ6Lv6qyN1EIqC98FnGzaeTciCDLH145Hhp9k9CfrUbma
 j3NbOZFfNiMvEbdkejDhRIkU6bKKUh1nUaKEWfhxZJtIC04GaFgJtU1zDUaEDJCps7oT
 SUJ/RMXywNrTHouotXHkTR+k2oFe+3bIZMKecuXsk84kNw72MzayJwQ4Ub9wVTTByKnL
 UPXQ==
X-Gm-Message-State: APjAAAVEMZT/Qo1UEMEQY3MMbzoaQFlxKu2h8zxpHjXVwy9EjuQXFj0y
 bMGNkRFpj31NALcIP6yHIczEydTdy4U=
X-Google-Smtp-Source: APXvYqzXnigEyEQXruScyjwRCXZTJ6NIQEAVqNa1tLooPc+pS6Ui3yHk+9z27HXny3gEIia/zptGCQ==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr11950366wmb.62.1570290479745; 
 Sat, 05 Oct 2019 08:47:59 -0700 (PDT)
Received: from localhost.localdomain (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id o22sm24542294wra.96.2019.10.05.08.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 08:47:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] tests/boot_linux_console: Add sdcard test for the
 Exynos4210
Date: Sat,  5 Oct 2019 17:47:48 +0200
Message-Id: <20191005154748.21718-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191005154748.21718-1-f4bug@amsat.org>
References: <20191005154748.21718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Basse?= <contact@fredericb.info>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Cleber Rosa <crosa@redhat.com>,
 Maksim Kozlov <m.kozlov@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test boots a Linux kernel on a smdkc210 board and verify
the serial output is working.

The cpio image used comes from the linux-build-test project:
https://github.com/groeck/linux-build-test

Since this test is not reliable due to clock timing issues,
it is disabled with the 'skip' property.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 197358a69c..2d0d82b013 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -14,6 +14,7 @@ import lzma
 import gzip
 import shutil
 
+from avocado import skip
 from avocado_qemu import Test
 from avocado.utils import process
 from avocado.utils import archive
@@ -359,6 +360,52 @@ class BootLinuxConsole(Test):
         self.wait_for_console_pattern('Boot successful.')
         # TODO user command, for now the uart is stuck
 
+    @skip("unstable clock timings")
+    def test_arm_exynos4210_sdcard(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:smdkc210
+        """
+        deb_url = ('https://snapshot.debian.org/archive/debian/'
+                   '20190928T224601Z/pool/main/l/linux/'
+                   'linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb')
+        deb_hash = 'fa9df4a0d38936cb50084838f2cb933f570d7d82'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-4.19.0-6-armmp')
+        dtb_path = '/usr/lib/linux-image-4.19.0-6-armmp/exynos4210-smdkv310.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+
+        rootfs_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
+                      'arm/rootfs-armv5.ext2.gz')
+        rootfs_hash = '093e89d2b4d982234bf528bc9fb2f2f17a9d1f93'
+        rootfs_path_gz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
+        rootfs_path = os.path.join(self.workdir, 'rootfs.ext2')
+        gunzip(rootfs_path_gz, rootfs_path)
+
+        self.vm.set_machine('smdkc210')
+        self.vm.set_console(console_id=1)
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=exynos4210,0x13810000 earlyprintk ' +
+                               'console=ttySAC1,115200n8 ' +
+                               'random.trust_cpu=off cryptomgr.notests ' +
+                               'root=/dev/mmcblk0 rootwait rw ' +
+                               'cpuidle.off=1 panic=-1 noreboot')
+
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line,
+                         # The external MMC is on the 3rd slot
+                         '-drive', 'if=sd,driver=null-co',
+                         '-drive', 'if=sd,driver=null-co',
+                         '-drive', 'if=sd,file=' + rootfs_path + ',format=raw',
+                         '-no-reboot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Boot successful.')
+        # TODO user command, for now the uart is stuck
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.20.1


