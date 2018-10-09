Received: from eggs.gnu.org ([2001:4830:134:3::10]:35941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OW-0003N0-GQ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OV-0000ne-Ib
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gA1OS-0000kr-3M
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:24 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Tue,  9 Oct 2018 19:26:03 -0400
Message-Id: <20181009232607.15521-4-crosa@redhat.com>
In-Reply-To: <20181009232607.15521-1-crosa@redhat.com>
References: <20181009232607.15521-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/7] scripts/qemu.py: add method and private
 attribute for arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Because some sane defaults may require the knowledge of the arch,
let's give the QEMUMachine the opportunity to hold that information.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/qemu.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index f099ce7278..d9e24a0c1a 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -113,6 +113,7 @@ class QEMUMachine(object):
         self._test_dir =3D test_dir
         self._temp_dir =3D None
         self._launched =3D False
+        self._arch =3D None
         self._machine =3D None
         self._console_device_type =3D None
         self._console_address =3D None
@@ -406,6 +407,12 @@ class QEMUMachine(object):
         '''
         self._args.extend(args)
=20
+    def set_arch(self, arch):
+        """
+        Sets the architecture of this machine
+        """
+        self._arch =3D arch
+
     def set_machine(self, machine_type):
         '''
         Sets the machine type
--=20
2.17.1
