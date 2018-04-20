Received: from eggs.gnu.org ([2001:4830:134:3::10]:38158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9afD-0005cg-T5
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9af8-0000CO-Ui
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9af8-00009H-Oc
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:34 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:35 -0300
Message-Id: <20180420181951.7252-9-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 08/24] avocado_qemu: Provide defaults for user
 and pass
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

For conveniency let's set default user to root and password to 123456 to
avoid the need to always input those. This password is inspired by the
default password of JeOS available from avocado-vt.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/avocado_qemu/test.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_q=
emu/test.py
index 6bf7825e55..9dc6c1ef91 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -344,8 +344,8 @@ class QemuTest(Test):
                                        job=3Djob, runner_queue=3Drunner_=
queue)
         self.vm =3D _VM(qemu_bin=3Dself.params.get('qemu_bin'),
                       arch=3Dself.params.get('arch'),
-                      username=3Dself.params.get('image_user'),
-                      password=3Dself.params.get('image_pass'),
+                      username=3Dself.params.get('image_user', default=3D=
"root"),
+                      password=3Dself.params.get('image_pass', default=3D=
"123456"),
                       qemu_dst_bin=3Dself.params.get('qemu_dst_bin'))
=20
         self.vm.image =3D self.params.get('image_path')
--=20
2.14.3
