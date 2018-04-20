Received: from eggs.gnu.org ([2001:4830:134:3::10]:37775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9aek-0005E7-5y
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9aej-0007Ec-7K
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9aej-0007CC-2Q
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:09 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:33 -0300
Message-Id: <20180420181951.7252-7-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 06/24] avocado_qemu: Add " " after the default
 prompt regexp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

From: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

The prompt regexp is quite basic one (# or $), let's require at least
one additional space afterwards, which is the case in most modern
systems and decreases the probability of false-positives.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/avocado_qemu/test.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_q=
emu/test.py
index e99c7e9e8d..eeb759ec65 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -270,7 +270,7 @@ class _VM(qemu.QEMUMachine):
         self.password =3D password
         super(_VM, self).__init__(qemu_bin, name=3Dself.name, arch=3Darc=
h)
=20
-    def get_console(self, console_address=3DNone, prompt=3D"[\#\$]"):
+    def get_console(self, console_address=3DNone, prompt=3Dr"[\#\$] "):
         """
         :param address: Socket address, can be either a unix socket path
                         (string) or a tuple in the form (address, port)
@@ -297,7 +297,7 @@ class _VM(qemu.QEMUMachine):
         console =3D aexpect.ShellSession(nc_cmd)
         try:
             logging.info('Console: Waiting login prompt...')
-            _handle_prompts(console, self.username, self.password, "[\#\=
$]")
+            _handle_prompts(console, self.username, self.password, promp=
t)
             logging.info('Console: Ready!')
         except:
             console.close()
--=20
2.14.3
