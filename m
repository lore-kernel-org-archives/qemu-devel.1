Received: from eggs.gnu.org ([2001:4830:134:3::10]:54412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyZ-0005Pq-K7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyW-0004ny-Eq
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gyW-0004nd-8m
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:40 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:44 +0200
Message-Id: <20171009225623.29232-4-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/42] tpm: make tpm_get_backend_driver() static
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

No need to export the function.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm_backend.h | 1 -
 tpm.c                        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 2c798a1eb4..c6e5637f68 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -215,7 +215,6 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
=20
 TPMBackend *qemu_find_tpm(const char *id);
=20
-const TPMDriverOps *tpm_get_backend_driver(const char *type);
 void tpm_register_model(enum TpmModel model);
 void tpm_register_driver(const TPMDriverOps *tdo);
=20
diff --git a/tpm.c b/tpm.c
index 3122227156..bc7d7470a8 100644
--- a/tpm.c
+++ b/tpm.c
@@ -31,7 +31,7 @@ void tpm_register_model(enum TpmModel model)
     tpm_models[model] =3D true;
 }
=20
-const TPMDriverOps *tpm_get_backend_driver(const char *type)
+static const TPMDriverOps *tpm_get_backend_driver(const char *type)
 {
     int i =3D qapi_enum_parse(&TpmType_lookup, type, -1, NULL);
=20
--=20
2.14.1.146.gd35faa819
