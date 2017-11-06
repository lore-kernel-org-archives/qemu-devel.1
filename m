Received: from eggs.gnu.org ([2001:4830:134:3::10]:39878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKJ-0007Kr-SA
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKJ-000509-11
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:65088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmKI-0004zJ-R0
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:50 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:14 +0100
Message-Id: <20171106183925.16747-18-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 17/28] tpm: rename qemu_find_tpm() ->
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
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

find_tpm() will be introduced to lookup the TPM device.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/sysemu/tpm_backend.h | 2 +-
 hw/tpm/tpm_tis.c             | 2 +-
 tpm.c                        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 1ad27ec374..c42d83aaef 100644
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
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 254f8bd6cb..1e846f1201 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1056,7 +1056,7 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
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
diff --git a/tpm.c b/tpm.c
index 520f449234..4661dfc46e 100644
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
2.15.0.rc0.40.gaefcc5f6f
