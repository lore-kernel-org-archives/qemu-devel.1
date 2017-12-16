Received: from eggs.gnu.org ([2001:4830:134:3::10]:45964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTn-00065E-63
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTj-00008Z-98
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTi-000071-Vy
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:27 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdWbZ135158
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:26 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ew0hhb46w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:25 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:25 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:34 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-18-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 17/32] tpm: rename qemu_find_tpm() ->
 qemu_find_tpm_be()
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

find_tpm() will be introduced to lookup the TPM device.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c             | 2 +-
 include/sysemu/tpm_backend.h | 2 +-
 tpm.c                        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 81b23b7..fd1511b 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1060,7 +1060,7 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
or **errp)
 {
     TPMState *s =3D TPM(dev);
=20
-    s->be_driver =3D qemu_find_tpm(s->backend);
+    s->be_driver =3D qemu_find_tpm_be(s->backend);
     if (!s->be_driver) {
         error_setg(errp, "tpm_tis: backend driver with id %s could not b=
e "
                    "found", s->backend);
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 1ad27ec..c42d83a 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -192,7 +192,7 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)=
;
  */
 TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
=20
-TPMBackend *qemu_find_tpm(const char *id);
+TPMBackend *qemu_find_tpm_be(const char *id);
=20
 void tpm_register_model(enum TpmModel model);
=20
diff --git a/tpm.c b/tpm.c
index 520f449..4661dfc 100644
--- a/tpm.c
+++ b/tpm.c
@@ -69,7 +69,7 @@ static void tpm_display_backend_drivers(void)
 /*
  * Find the TPM with the given Id
  */
-TPMBackend *qemu_find_tpm(const char *id)
+TPMBackend *qemu_find_tpm_be(const char *id)
 {
     TPMBackend *drv;
=20
--=20
2.5.5
