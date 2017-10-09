Received: from eggs.gnu.org ([2001:4830:134:3::10]:54605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyt-0005hX-04
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyp-0004wI-Vg
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gyp-0004vz-Ph
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:59 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:50 +0200
Message-Id: <20171009225623.29232-10-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/42] tpm: remove init() class method
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

No backend use it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm_backend.h | 2 --
 backends/tpm.c               | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index a4288df038..b08f985500 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -66,8 +66,6 @@ struct TPMBackendClass {
=20
     TPMBackend *(*create)(QemuOpts *opts, const char *id);
=20
-    /* initialize the backend */
-    int (*init)(TPMBackend *t);
     /* start up the TPM on the backend */
     int (*startup_tpm)(TPMBackend *t);
=20
diff --git a/backends/tpm.c b/backends/tpm.c
index ca3a78eea8..dc750d48c9 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -47,13 +47,11 @@ enum TpmType tpm_backend_get_type(TPMBackend *s)
 int tpm_backend_init(TPMBackend *s, TPMState *state,
                      TPMRecvDataCB *datacb)
 {
-    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
-
     s->tpm_state =3D state;
     s->recv_data_callback =3D datacb;
     s->had_startup_error =3D false;
=20
-    return k->init ? k->init(s) : 0;
+    return 0;
 }
=20
 int tpm_backend_startup_tpm(TPMBackend *s)
--=20
2.14.1.146.gd35faa819
