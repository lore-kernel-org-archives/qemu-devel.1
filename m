Received: from eggs.gnu.org ([2001:4830:134:3::10]:39516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJv-0006ys-J0
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJs-0004c0-48
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmJr-0004aW-SY
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:23 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:08 +0100
Message-Id: <20171106183925.16747-12-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/28] tpm-passthrough: pass
 TPMPassthruState to handle_device_opts
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

It doesn't need TPMBackend. Also reorder arguments for consistency.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 048edb1a1a..9326cbfdc9 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -239,9 +239,9 @@ static int tpm_passthrough_open_sysfs_cancel(TPMPasst=
hruState *tpm_pt)
     return fd;
 }
=20
-static int tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBackend=
 *tb)
+static int
+tpm_passthrough_handle_device_opts(TPMPassthruState *tpm_pt, QemuOpts *o=
pts)
 {
-    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
     const char *value;
=20
     value =3D qemu_opt_get(opts, "cancel-path");
@@ -292,7 +292,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *o=
pts, const char *id)
=20
     tb->id =3D g_strdup(id);
=20
-    if (tpm_passthrough_handle_device_opts(opts, tb)) {
+    if (tpm_passthrough_handle_device_opts(tpm_pt, opts)) {
         goto err_exit;
     }
=20
--=20
2.15.0.rc0.40.gaefcc5f6f
