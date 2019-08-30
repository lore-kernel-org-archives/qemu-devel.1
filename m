Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AC3C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F056923428
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F056923428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3lqN-0006Bm-2b
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 14:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3lpH-0005Eo-Et
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3lpF-0007Xv-58
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:40:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3lpE-0007XU-Tr
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:40:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 708F0300CB2B;
 Fri, 30 Aug 2019 18:40:43 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3312A214;
 Fri, 30 Aug 2019 18:40:36 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Aug 2019 20:40:33 +0200
Message-Id: <20190830184033.7630-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 30 Aug 2019 18:40:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] tests/acceptance: Do not install paramiko
 module by default
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The paramiko Python module has many dependencies. Some of them
are not pure Python, such cryptography module which requires to
be built and linked with OpenSSL.

When native libraries and header are missing on the host, the
error reported is not very helpful:

  $ make check-venv
  VENV    tests/venv
  PIP     tests/requirements.txt
  Command "tests/venv/bin/python -u -c "import setuptools, tokenize;__fil=
e__=3D'/tmp/pip-build-la4el5r5/cryptography/setup.py';f=3Dgetattr(tokeniz=
e, 'open', open)(__file__);code=3Df.read().replace('\r\n', '\n');f.close(=
);exec(compile(code, __file__, 'exec'))" install --record /tmp/pip-1efs22=
iz-record/install-record.txt --single-version-externally-managed --compil=
e --install-headers tests/venv/include/site/python3.6/cryptography" faile=
d with error code 1 in /tmp/pip-build-la4el5r5/cryptography/

Since currently the tests depending on paramiko are targetting
very specific uses, we can avoid the strong dependency on the
paramiko module, to let systems where it does not build properly
work the rest of the tests.
If paramiko is manually installed, the tests using it will be
automatically run.

Fixes: c47c336e870
Reported-by: David Gibson <david@gibson.dropbear.id.au>
Suggested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/linux_ssh_mips_malta.py | 13 +++++++++++--
 tests/requirements.txt                   |  1 -
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
index aafb0c39f6..dbcdc03a80 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -9,14 +9,19 @@ import os
 import re
 import base64
 import logging
-import paramiko
 import time
=20
-from avocado import skipIf
+from avocado import skipIf, skipUnless
 from avocado_qemu import Test
 from avocado.utils import process
 from avocado.utils import archive
=20
+PARAMIKO_AVAILABLE =3D True
+try:
+    import paramiko
+except ImportError:
+    PARAMIKO_AVAILABLE =3D False
+
=20
 class LinuxSSH(Test):
=20
@@ -171,6 +176,7 @@ class LinuxSSH(Test):
         self.run_common_commands()
         self.shutdown_via_ssh()
=20
+    @skipUnless(PARAMIKO_AVAILABLE, "paramiko module not available")
     @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     def test_mips_malta32eb_kernel3_2_0(self):
         """
@@ -186,6 +192,7 @@ class LinuxSSH(Test):
=20
         self.do_test_mips_malta('be', kernel_path, 'mips')
=20
+    @skipUnless(PARAMIKO_AVAILABLE, "paramiko module not available")
     @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     def test_mips_malta32el_kernel3_2_0(self):
         """
@@ -201,6 +208,7 @@ class LinuxSSH(Test):
=20
         self.do_test_mips_malta('le', kernel_path, 'mips')
=20
+    @skipUnless(PARAMIKO_AVAILABLE, "paramiko module not available")
     @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     def test_mips_malta64eb_kernel3_2_0(self):
         """
@@ -215,6 +223,7 @@ class LinuxSSH(Test):
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
         self.do_test_mips_malta('be', kernel_path, 'mips64')
=20
+    @skipUnless(PARAMIKO_AVAILABLE, "paramiko module not available")
     @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     def test_mips_malta64el_kernel3_2_0(self):
         """
diff --git a/tests/requirements.txt b/tests/requirements.txt
index 3ae0e29ad7..002ded6a22 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -2,4 +2,3 @@
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
 avocado-framework=3D=3D68.0
-paramiko
--=20
2.20.1


