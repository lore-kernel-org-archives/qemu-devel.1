Received: from eggs.gnu.org ([2001:4830:134:3::10]:40129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKm-0007ju-7Z
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKk-0005TT-Bm
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmKk-0005T2-5b
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:18 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:20 +0100
Message-Id: <20171106183925.16747-24-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 23/28] tpm-tis: remove redundant 'tpm_tis:'
 in error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The reported error message is already prefixed with the -device
name & arguments.

Before:
qemu-system-x86_64: -device tpm-tis,id=3Dfoo,tpmdev=3Dfoo,irq=3D21: tpm_t=
is: IRQ 21 is outside valid range of 0 to 15

After:
qemu-system-x86_64: -device tpm-tis,id=3Dfoo,tpmdev=3Dfoo,irq=3D21: IRQ 2=
1 is outside valid range of 0 to 15

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index d313347144..175785b9c4 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1059,8 +1059,8 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
or **errp)
=20
     s->be_driver =3D qemu_find_tpm_be(s->backend);
     if (!s->be_driver) {
-        error_setg(errp, "tpm_tis: backend driver with id %s could not b=
e "
-                   "found", s->backend);
+        error_setg(errp, "backend driver with id %s could not be found",
+                   s->backend);
         return;
     }
=20
@@ -1069,8 +1069,8 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
or **errp)
     }
=20
     if (s->irq_num > 15) {
-        error_setg(errp, "tpm_tis: IRQ %d for TPM TIS is outside valid r=
ange "
-                   "of 0 to 15", s->irq_num);
+        error_setg(errp, "IRQ %d is outside valid range of 0 to 15",
+                   s->irq_num);
         return;
     }
=20
--=20
2.15.0.rc0.40.gaefcc5f6f
