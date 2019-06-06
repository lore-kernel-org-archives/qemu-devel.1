Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01912C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 22:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFFB2083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 22:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFFB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ00k-0001iQ-Qk
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 17:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51595)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hYzu5-0005bg-GE
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hYziZ-00087g-Ic
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hYziZ-00086W-AC
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DF9F1330247;
 Thu,  6 Jun 2019 21:14:31 +0000 (UTC)
Received: from dhcp-17-47.bos.redhat.com (dhcp-17-47.bos.redhat.com
 [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBB9610ABD9F;
 Thu,  6 Jun 2019 21:14:30 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 17:14:14 -0400
Message-Id: <20190606211414.8681-8-crosa@redhat.com>
In-Reply-To: <20190606211414.8681-1-crosa@redhat.com>
References: <20190606211414.8681-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 06 Jun 2019 21:14:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 7/7] [RFC]: use Avocado data drainer for
 console logging
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This depends on a proposed feature to Avocado, a new module that
"drains" data and processes it.  In this case, a drainer for the
console socket file descriptor is used, and the data is sent to the
"console" logger.

This allows for a much better feedback of the test process, showing
boot data from the guest as it happens, without obstructing the test
code path.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux.py | 14 +++++++++++---
 tests/requirements.txt         |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux=
.py
index 9b54a0241f..f3507f519e 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -15,6 +15,7 @@ from avocado_qemu import Test, SRC_ROOT_DIR
 from avocado.utils import cloudinit
 from avocado.utils import network
 from avocado.utils import vmimage
+from avocado.utils import datadrainer
=20
=20
 class BootLinux(Test):
@@ -55,6 +56,13 @@ class BootLinux(Test):
                       phone_home_port=3Dself.phone_home_port)
         self.vm.add_args('-drive', 'file=3D%s,format=3Draw' % cloudinit_=
iso)
=20
+    def launch(self):
+        self.vm.set_console()
+        self.vm.launch()
+        console_drainer =3D datadrainer.LineLogger(self.vm.console_socke=
t.fileno(),
+                                                 logger=3Dself.log.getCh=
ild('console'))
+        console_drainer.start()
+
     def wait_for_boot_confirmation(self):
         self.log.info('VM launched, waiting for boot confirmation from g=
uest')
         cloudinit.wait_for_phone_home(('0.0.0.0', self.phone_home_port),=
 self.name)
@@ -70,7 +78,7 @@ class BootLinuxX8664(BootLinux):
         :avocado: tags=3Dmachine:pc
         """
         self.vm.set_machine('pc')
-        self.vm.launch()
+        self.launch()
         self.wait_for_boot_confirmation()
=20
     def test_q35(self):
@@ -79,7 +87,7 @@ class BootLinuxX8664(BootLinux):
         :avocado: tags=3Dmachine:q35
         """
         self.vm.set_machine('q35')
-        self.vm.launch()
+        self.launch()
         self.wait_for_boot_confirmation()
=20
=20
@@ -99,5 +107,5 @@ class BootLinuxAarch64(BootLinux):
                                       'edk2-aarch64-code.fd'))
         self.vm.add_args('-device', 'virtio-rng-pci,rng=3Drng0')
         self.vm.add_args('-object', 'rng-random,id=3Drng0,filename=3D/de=
v/urandom')
-        self.vm.launch()
+        self.launch()
         self.wait_for_boot_confirmation()
diff --git a/tests/requirements.txt b/tests/requirements.txt
index 9d2c79b146..28eaf7b61e 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,7 +1,7 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework=3D=3D68.0
+-e git+https://github.com/clebergnu/avocado@datadrainer#egg=3Davocado_fr=
amework
 paramiko
 pycdlib=3D=3D1.6.0
=20
--=20
2.21.0


