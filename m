Received: from eggs.gnu.org ([2001:4830:134:3::10]:55444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1h0I-0006xp-Lk
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1h0H-0005c1-Vp
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1h0H-0005bi-R7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:29 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:17 +0200
Message-Id: <20171009225623.29232-37-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 36/42] tpm: rename qemu_find_tpm() ->
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
---
 include/sysemu/tpm_backend.h | 2 +-
 hw/tpm/tpm_tis.c             | 2 +-
 tpm.c                        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 881be97ee3..d02067e631 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -193,7 +193,7 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)=
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
index e7e8b112e8..954b7b0e5d 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1055,7 +1055,7 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
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
index 37298f3f03..4d6c45a4f2 100644
--- a/tpm.c
+++ b/tpm.c
@@ -71,7 +71,7 @@ static void tpm_display_backend_drivers(void)
 /*
  * Find the TPM with the given Id
  */
-TPMBackend *qemu_find_tpm(const char *id)
+TPMBackend *qemu_find_tpm_be(const char *id)
 {
     TPMBackend *drv;
=20
--=20
2.14.1.146.gd35faa819
