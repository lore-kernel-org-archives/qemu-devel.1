Received: from eggs.gnu.org ([2001:4830:134:3::10]:59816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehyVy-00077v-Fj
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 09:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehyVt-0003uB-J8
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 09:09:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48650
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ehyVt-0003tu-Df
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 09:09:53 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w13E8qQf051156
	for <qemu-devel@nongnu.org>; Sat, 3 Feb 2018 09:09:52 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fw6w8m9ea-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 09:09:52 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 3 Feb 2018 09:09:51 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat,  3 Feb 2018 09:09:41 -0500
In-Reply-To: <1517666981-9339-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1517666981-9339-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1517666981-9339-5-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] tpm: tis: move one-line function into caller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, peter.maydell@linaro.org

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 08f41d2..f81168a 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -946,11 +946,6 @@ static const MemoryRegionOps tpm_tis_memory_ops =3D =
{
     },
 };
=20
-static int tpm_tis_do_startup_tpm(TPMState *s, size_t buffersize)
-{
-    return tpm_backend_startup_tpm(s->be_driver, buffersize);
-}
-
 /*
  * Get the TPMVersion of the backend device being used
  */
@@ -1005,7 +1000,7 @@ static void tpm_tis_reset(DeviceState *dev)
         s->rw_offset =3D 0;
     }
=20
-    tpm_tis_do_startup_tpm(s, s->be_buffer_size);
+    tpm_backend_startup_tpm(s->be_driver, s->be_buffer_size);
 }
=20
 static const VMStateDescription vmstate_tpm_tis =3D {
--=20
2.5.5
