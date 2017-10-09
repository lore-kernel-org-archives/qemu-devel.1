Received: from eggs.gnu.org ([2001:4830:134:3::10]:54706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gz2-0005qA-4f
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyz-00052F-4S
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gyy-00050v-Ur
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:09 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:53 +0200
Message-Id: <20171009225623.29232-13-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/42] tpm: remove needless cast
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
 hw/tpm/tpm_passthrough.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 5cd988e8a4..fed3d69799 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -96,7 +96,7 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthruStat=
e *tpm_pt,
=20
     is_selftest =3D tpm_util_is_selftest(in, in_len);
=20
-    ret =3D qemu_write_full(tpm_pt->tpm_fd, (const void *)in, (size_t)in=
_len);
+    ret =3D qemu_write_full(tpm_pt->tpm_fd, in, in_len);
     if (ret !=3D in_len) {
         if (!tpm_pt->tpm_op_canceled || errno !=3D ECANCELED) {
             error_report("tpm_passthrough: error while transmitting data=
 "
--=20
2.14.1.146.gd35faa819
