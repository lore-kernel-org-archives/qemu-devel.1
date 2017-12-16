Received: from eggs.gnu.org ([2001:4830:134:3::10]:46068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTx-0006Fm-NT
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTt-0000FS-Rh
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTt-0000Ep-Ij
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:37 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHfZSn039327
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:36 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ew0vstjff-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:36 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:35 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:40 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-24-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 23/32] tpm-tis: remove redundant 'tpm_tis:'
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
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The reported error message is already prefixed with the -device
name & arguments.

Before:
qemu-system-x86_64: -device tpm-tis,id=3Dfoo,tpmdev=3Dfoo,irq=3D21: tpm_t=
is: IRQ 21 is outside valid range of 0 to 15

After:
qemu-system-x86_64: -device tpm-tis,id=3Dfoo,tpmdev=3Dfoo,irq=3D21: IRQ 2=
1 is outside valid range of 0 to 15

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 06b30c4..0a23203 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1063,8 +1063,8 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
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
@@ -1073,8 +1073,8 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
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
2.5.5
