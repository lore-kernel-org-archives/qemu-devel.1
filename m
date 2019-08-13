Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1C7C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE1F20679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE1F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52547 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxXBw-0007eN-9S
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34477)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxXBH-0006PV-PQ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxXBG-0005uc-5E
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:49:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxXBF-0005uK-Tq
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:49:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D0A6C0035C2;
 Tue, 13 Aug 2019 13:49:41 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F2231001281;
 Tue, 13 Aug 2019 13:49:35 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 15:49:19 +0200
Message-Id: <20190813134921.30602-2-philmd@redhat.com>
In-Reply-To: <20190813134921.30602-1-philmd@redhat.com>
References: <20190813134921.30602-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 13 Aug 2019 13:49:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/3] tests/acceptance: Add test of NeXTcube
 framebuffer using OCR
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Add a test of the NeXTcube framebuffer using the Tesseract OCR
engine on a screenshot of the framebuffer device.

The test is very quick:

  $ avocado --show=3Dapp,console run tests/acceptance/machine_m68k_nextcu=
be.py
  JOB ID     : 78844a92424cc495bd068c3874d542d1e20f24bc
  JOB LOG    : /home/phil/avocado/job-results/job-2019-08-13T13.16-78844a=
9/job.log
   (1/3) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_b=
ootrom_framebuffer_size: PASS (2.16 s)
   (2/3) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_b=
ootrom_framebuffer_ocr_with_tesseract_v3: -
  ue r pun Honl'=EF=AC=82x ; 5=E2=80=98 55=E2=80=98
  avg ncaaaaa 25 MHZ, memary jag m
  Backplane slat =C2=ABa
  Ethernet address a a r a r3 2
  Memgry sackets aea canflqured far 16MB Darlly page made stMs but have 1=
6MB page made stMs )nstalled
  Memgry sackets a and 1 canflqured far 16MB Darlly page made stMs but ha=
ve 16MB page made stMs )nstalled
  [...]
  Yestlnq the rpu, 5::
  system test raneg Errar egge 51
  Egg: cammand
  Default pggc devlce nut fauna
  NEXY>I
  PASS (2.64 s)
   (3/3) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_b=
ootrom_framebuffer_ocr_with_tesseract_v4: SKIP: tesseract v4 OCR tool not=
 available
  RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 1 | WARN 0 | INTERRUPT 0 =
| CANCEL 0
  JOB TIME   : 5.35 s

Documentation on how to install tesseract:
  https://github.com/tesseract-ocr/tesseract/wiki#installation

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v2:
- test fb sizes
- handle 2 versions of teseract
v3:
- sort imports
- use of ALL_CAPS variables if they are at the module level (PIL_AVAILABL=
E)
- use find_command from avocado.utils.path
- check tesseract version using regex to avoid exceptions
- do not use '-' in avocado tags
- use use os.path.join()
- add few comments
---
 tests/acceptance/machine_m68k_nextcube.py | 121 ++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 tests/acceptance/machine_m68k_nextcube.py

diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance=
/machine_m68k_nextcube.py
new file mode 100644
index 0000000000..e09cab9f20
--- /dev/null
+++ b/tests/acceptance/machine_m68k_nextcube.py
@@ -0,0 +1,121 @@
+# Functional test that boots a VM and run OCR on the framebuffer
+#
+# Copyright (c) Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+import re
+import time
+import logging
+import distutils.spawn
+
+from avocado_qemu import Test
+from avocado import skipUnless
+from avocado.utils import process
+from avocado.utils.path import find_command, CmdNotFoundError
+
+PIL_AVAILABLE =3D True
+try:
+    from PIL import Image
+except ImportError:
+    PIL_AVAILABLE =3D False
+
+
+def tesseract_available(expected_version):
+    try:
+        find_command('tesseract')
+    except CmdNotFoundError:
+        return False
+    res =3D process.run('tesseract --version')
+    try:
+        version =3D res.stdout_text.split()[1]
+    except IndexError:
+        version =3D res.stderr_text.split()[1]
+    return int(version.split('.')[0]) =3D=3D expected_version
+
+    match =3D re.match(r'tesseract\s(\d)', res)
+    if match is None:
+        return False
+    # now this is guaranteed to be a digit
+    return int(match.groups()[0]) =3D=3D expected_version
+
+
+class NextCubeMachine(Test):
+
+    timeout =3D 15
+
+    def check_bootrom_framebuffer(self, screenshot_path):
+        rom_url =3D ('http://www.nextcomputers.org/NeXTfiles/Software/RO=
M_Files/'
+                   '68040_Non-Turbo_Chipset/Rev_2.5_v66.BIN')
+        rom_hash =3D 'b3534796abae238a0111299fc406a9349f7fee24'
+        rom_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
+
+        self.vm.set_machine('next-cube')
+        self.vm.add_args('-bios', rom_path)
+        self.vm.launch()
+
+        self.log.info('VM launched, waiting for display')
+        # TODO: Use avocado.utils.wait.wait_for to catch the
+        #       'displaysurface_create 1120x832' trace-event.
+        time.sleep(2)
+
+        self.vm.command('human-monitor-command',
+                        command_line=3D'screendump %s' % screenshot_path=
)
+
+    @skipUnless(PIL_AVAILABLE, 'Python PIL not installed')
+    def test_bootrom_framebuffer_size(self):
+        """
+        :avocado: tags=3Darch:m68k
+        :avocado: tags=3Dmachine:next_cube
+        :avocado: tags=3Ddevice:framebuffer
+        """
+        screenshot_path =3D os.path.join(self.workdir, "dump.png")
+        self.check_bootrom_framebuffer(screenshot_path)
+
+        width, height =3D Image.open(screenshot_path).size
+        self.assertEqual(width, 1120)
+        self.assertEqual(height, 832)
+
+    @skipUnless(tesseract_available(3), 'tesseract v3 OCR tool not avail=
able')
+    def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
+        """
+        :avocado: tags=3Darch:m68k
+        :avocado: tags=3Dmachine:next_cube
+        :avocado: tags=3Ddevice:framebuffer
+        """
+        screenshot_path =3D os.path.join(self.workdir, "dump.png")
+        self.check_bootrom_framebuffer(screenshot_path)
+
+        console_logger =3D logging.getLogger('console')
+        text =3D process.run("tesseract %s stdout" % screenshot_path).st=
dout_text
+        for line in text.split('\n'):
+            if len(line):
+                console_logger.debug(line)
+        self.assertIn('Backplane', text)
+        self.assertIn('Ethernet address', text)
+
+    # Tesseract 4 adds a new OCR engine based on LSTM neural networks. T=
he
+    # new version is faster and more accurate than version 3. The drawba=
ck is
+    # that it is still alpha-level software.
+    @skipUnless(tesseract_available(4), 'tesseract v4 OCR tool not avail=
able')
+    def test_bootrom_framebuffer_ocr_with_tesseract_v4(self):
+        """
+        :avocado: tags=3Darch:m68k
+        :avocado: tags=3Dmachine:next_cube
+        :avocado: tags=3Ddevice:framebuffer
+        """
+        screenshot_path =3D os.path.join(self.workdir, "dump.png")
+        self.check_bootrom_framebuffer(screenshot_path)
+
+        console_logger =3D logging.getLogger('console')
+        proc =3D process.run("tesseract --oem 1 %s stdout" % screenshot_=
path)
+        text =3D proc.stdout_text
+        for line in text.split('\n'):
+            if len(line):
+                console_logger.debug(line)
+        self.assertIn('Testing the FPU, SCC', text)
+        self.assertIn('System test failed. Error code 51', text)
+        self.assertIn('Boot command', text)
+        self.assertIn('Next>', text)
--=20
2.20.1


