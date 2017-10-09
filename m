Received: from eggs.gnu.org ([2001:4830:134:3::10]:54603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gys-0005hW-Vw
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gys-0004xL-04
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gyr-0004wv-Qj
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:01 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:51 +0200
Message-Id: <20171009225623.29232-11-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/42] tpm: remove configure_tpm() hop
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tpm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tpm.c b/tpm.c
index 4882501bd7..45520f555d 100644
--- a/tpm.c
+++ b/tpm.c
@@ -86,7 +86,7 @@ TPMBackend *qemu_find_tpm(const char *id)
     return NULL;
 }
=20
-static int configure_tpm(QemuOpts *opts)
+static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
 {
     const char *value;
     const char *id;
@@ -145,11 +145,6 @@ static int configure_tpm(QemuOpts *opts)
     return 0;
 }
=20
-static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
-{
-    return configure_tpm(opts);
-}
-
 /*
  * Walk the list of TPM backend drivers that are in use and call their
  * destroy function to have them cleaned up.
--=20
2.14.1.146.gd35faa819
