Received: from eggs.gnu.org ([209.51.188.92]:37970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDS9a-0000wA-K7
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDS9Z-0001mf-NM
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hDS9X-0001lK-Lk
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:29 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  8 Apr 2019 13:09:18 +0200
Message-Id: <20190408110920.30119-2-thuth@redhat.com>
In-Reply-To: <20190408110920.30119-1-thuth@redhat.com>
References: <20190408110920.30119-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] tests/libqos: fix usage of bool in pci-pc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jafar Abdi <cafer.abdi@gmail.com>, dgilbert@redhat.com

From: Jafar Abdi <cafer.abdi@gmail.com>

Clean up wrong usage of FALSE and TRUE in places that use "bool" from std=
bool.h.

FALSE and TRUE (with capital letters) are the constants defined by glib f=
or
being used with the "gboolean" type of glib. But some parts of the code a=
lso use
TRUE and FALSE for variables that are declared as "bool" (the type from <=
stdbool.h>).

Signed-off-by: Jafar Abdi <cafer.abdi@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1553351197-14581-3-git-send-email-cafer.abdi@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/pci-pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index 4ab16facf2..407d8aff78 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -125,7 +125,7 @@ void qpci_init_pc(QPCIBusPC *qpci, QTestState *qts, Q=
GuestAllocator *alloc)
     assert(qts);
=20
     /* tests can use pci-bus */
-    qpci->bus.has_buggy_msi =3D FALSE;
+    qpci->bus.has_buggy_msi =3D false;
=20
     qpci->bus.pio_readb =3D qpci_pc_pio_readb;
     qpci->bus.pio_readw =3D qpci_pc_pio_readw;
--=20
2.21.0
