Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5450C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E6720679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E6720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxXCk-0000sE-R6
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34507)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxXBV-00071b-OW
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxXBU-00060N-F8
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:49:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxXBU-000609-7a
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:49:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 88EBB8E591;
 Tue, 13 Aug 2019 13:49:55 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78CC510013A1;
 Tue, 13 Aug 2019 13:49:45 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 15:49:21 +0200
Message-Id: <20190813134921.30602-4-philmd@redhat.com>
In-Reply-To: <20190813134921.30602-1-philmd@redhat.com>
References: <20190813134921.30602-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 13 Aug 2019 13:49:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH v3 3/3] tests/acceptance: Run commands
 sending VNC keys
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Proof of concept to interract with a framebuffer via VNC.

This test send 'mem' and 'help' to the firmware prompt
within the single X terminal opened.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
This test is limited because the '-vnc' option only allow
to bind TCP port. To allow parallel testing, I should try
to bind within a range instead of ':0'.
---
 tests/acceptance/machine_m68k_nextcube.py | 49 +++++++++++++++++++++++
 tests/requirements.txt                    |  1 +
 2 files changed, 50 insertions(+)

diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance=
/machine_m68k_nextcube.py
index e09cab9f20..f4f853dfa1 100644
--- a/tests/acceptance/machine_m68k_nextcube.py
+++ b/tests/acceptance/machine_m68k_nextcube.py
@@ -13,6 +13,7 @@ import distutils.spawn
=20
 from avocado_qemu import Test
 from avocado import skipUnless
+from vncdotool import api as vnc
 from avocado.utils import process
 from avocado.utils.path import find_command, CmdNotFoundError
=20
@@ -119,3 +120,51 @@ class NextCubeMachine(Test):
         self.assertIn('System test failed. Error code 51', text)
         self.assertIn('Boot command', text)
         self.assertIn('Next>', text)
+
+
+    @staticmethod
+    def vnc_send_string(client, string, eol=3DTrue):
+        for key in string:
+            client.keyPress(key)
+            time.sleep(0.02)
+        if eol:
+            client.keyPress('enter')
+            time.sleep(0.02)
+
+    @skipUnless(tesseract_available(3), 'tesseract v3 OCR tool not avail=
able')
+    def test_bootrom_via_vnc_with_tesseract_v3(self):
+        """
+        :avocado: tags=3Darch:m68k
+        :avocado: tags=3Dmachine:next_cube
+        :avocado: tags=3Ddevice:framebuffer
+        """
+        screenshot_path =3D os.path.join(self.workdir, "dump.png")
+
+        rom_url =3D ('http://www.nextcomputers.org/NeXTfiles/Software/RO=
M_Files/'
+                   '68040_Non-Turbo_Chipset/Rev_2.5_v66.BIN')
+        rom_hash =3D 'b3534796abae238a0111299fc406a9349f7fee24'
+        rom_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
+
+        self.vm.set_machine('next-cube')
+        self.vm.add_args('-bios', rom_path,
+                         '-vnc', ':0') # XXX do not use static TCP port.=
..
+        self.vm.launch()
+
+        self.log.info('VM launched, waiting for display')
+        # TODO: Use avocado.utils.wait.wait_for to catch the
+        #       'displaysurface_create 1120x832' trace-event.
+        time.sleep(2)
+
+        with vnc.connect('127.0.0.1') as client:
+            self.vnc_send_string(client, 'help')
+            self.vnc_send_string(client, 'mem')
+            client.captureScreen(screenshot_path)
+            client.disconnect()
+
+        console_logger =3D logging.getLogger('console')
+        text =3D process.run("tesseract %s stdout" % screenshot_path).st=
dout_text
+        for line in text.split('\n'):
+            if len(line):
+                console_logger.debug(line)
+        self.assertIn('address space', text)
+        self.assertIn('System', text)
diff --git a/tests/requirements.txt b/tests/requirements.txt
index 3ae0e29ad7..f7467287a1 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -3,3 +3,4 @@
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
 avocado-framework=3D=3D68.0
 paramiko
+vncdotool
--=20
2.20.1


