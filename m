Received: from eggs.gnu.org ([2001:4830:134:3::10]:38008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9af1-0005Ts-55
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9aex-0007wn-6S
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9aex-0007tb-0k
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:34 -0300
Message-Id: <20180420181951.7252-8-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 07/24] avocado_qemu: Store "arch" in VM
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

The "arch" is quite important info regarding the current VM, let's store
it so tests can query for it.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/avocado_qemu/test.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_q=
emu/test.py
index eeb759ec65..6bf7825e55 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -258,6 +258,7 @@ class _VM(qemu.QEMUMachine):
                  qemu_dst_bin=3DNone):
         if arch is None:
             arch =3D os.uname()[4]
+        self.arch =3D arch
         self.ports =3D _PortTracker()
         self.name =3D "qemu-%s" % str(uuid.uuid4())[:8]
         if qemu_bin is None:
--=20
2.14.3
