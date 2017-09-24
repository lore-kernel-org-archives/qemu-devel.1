Received: from eggs.gnu.org ([2001:4830:134:3::10]:57534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwFbE-0002pL-0E
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwFbA-00083N-R2
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:42:08 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:49 +0300
Message-Id: <97fb016a2aae686098f01d1c2dc194ed0f8e1c36.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/31] hw/isa/pc87312: Mark the device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <thuth@redhat.com>

QEMU currently aborts if you try to use the device at the command
line:

$ ppc64-softmmu/qemu-system-ppc64 -S -machine prep -device pc87312
Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
qemu-system-ppc64: -device pc87312: Device 'parallel0' is in use
Aborted (core dumped)

It uses parallel_hds in its realize function, so I can not be
instantiated by the user again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/isa/pc87312.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 5ce9f0a062..48b29e3c3c 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -386,6 +386,8 @@ static void pc87312_class_init(ObjectClass *klass, vo=
id *data)
     dc->reset =3D pc87312_reset;
     dc->vmsd =3D &vmstate_pc87312;
     dc->props =3D pc87312_properties;
+    /* Reason: Uses parallel_hds[0] in realize(), so it can't be used tw=
ice */
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo pc87312_type_info =3D {
--=20
2.11.0
