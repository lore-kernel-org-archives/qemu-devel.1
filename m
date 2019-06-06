Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78608C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CFC320684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFC320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ1UD-0000yi-IJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 19:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40066)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZ1Ru-0007N1-Rz
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZ1IO-00071g-Cz
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 18:55:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61593)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hZ1IM-0006rf-Qi; Thu, 06 Jun 2019 18:55:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 215C7811A9;
 Thu,  6 Jun 2019 22:55:37 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-32.brq.redhat.com [10.40.204.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA5C7473C3;
 Thu,  6 Jun 2019 22:55:33 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  7 Jun 2019 00:55:21 +0200
Message-Id: <20190606225521.9187-3-philmd@redhat.com>
In-Reply-To: <20190606225521.9187-1-philmd@redhat.com>
References: <20190606225521.9187-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 06 Jun 2019 22:55:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/2] BootLinuxConsoleTest: Test the
 SmartFusion2 board
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Similar to the x86_64/pc test, it boots a Linux kernel on an
Emcraft board and verify the serial is working.

If ARM is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:arm" tags.

Alternatively, this test can be run using:

  $ avocado run -t arch:arm tests/acceptance
  $ avocado run -t machine:emcraft-sf2 tests/acceptance

Based on the recommended test setup from Subbaraya Sundeep:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03810.html

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
---
v2: (Cleber)
- drop 'kernel_command_line'
- do no concat string, use format
- replace '-' by '_' in Avocado tags
---
 tests/acceptance/boot_linux_console.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index f593f3858e..34527d4b38 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -178,6 +178,32 @@ class BootLinuxConsole(Test):
         console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
         self.wait_for_console_pattern(console_pattern)
=20
+    def test_arm_emcraft_sf2(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:emcraft_sf2
+        :avocado: tags=3Dendian:little
+        """
+        uboot_url =3D ('https://raw.githubusercontent.com/'
+                     'Subbaraya-Sundeep/qemu-test-binaries/'
+                     'fa030bd77a014a0b8e360d3b7011df89283a2f0b/u-boot')
+        uboot_hash =3D 'abba5d9c24cdd2d49cdc2a8aa92976cf20737eff'
+        uboot_path =3D self.fetch_asset(uboot_url, asset_hash=3Duboot_ha=
sh)
+        spi_url =3D ('https://raw.githubusercontent.com/'
+                   'Subbaraya-Sundeep/qemu-test-binaries/'
+                   'fa030bd77a014a0b8e360d3b7011df89283a2f0b/spi.bin')
+        spi_hash =3D '85f698329d38de63aea6e884a86fbde70890a78a'
+        spi_path =3D self.fetch_asset(spi_url, asset_hash=3Dspi_hash)
+
+        self.vm.set_machine('emcraft-sf2')
+        self.vm.set_console()
+        self.vm.add_args('-kernel', uboot_path,
+                         '-append', self.KERNEL_COMMON_COMMAND_LINE,
+                         '-drive', 'file=3D%s,if=3Dmtd,format=3Draw' % s=
pi_path,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('init started: BusyBox')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=3Darch:s390x
--=20
2.20.1


