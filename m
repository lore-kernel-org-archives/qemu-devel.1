Received: from eggs.gnu.org ([2001:4830:134:3::10]:60459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuWE-0004vI-Km
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuWC-0004TE-PF
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:43:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuWA-0004Rh-V9
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:43:39 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:39 +0400
Message-Id: <20181114123643.24091-38-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 37/41] slirp: replace ARRAY_SIZE with
 G_N_ELEMENTS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Do not require QEMU macro.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/ncsi.c | 2 +-
 slirp/tftp.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/slirp/ncsi.c b/slirp/ncsi.c
index 10decfb5ef..8594382270 100644
--- a/slirp/ncsi.c
+++ b/slirp/ncsi.c
@@ -128,7 +128,7 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, int=
 pkt_len)
     memset(reh->h_source, 0xff, ETH_ALEN);
     reh->h_proto =3D htons(ETH_P_NCSI);
=20
-    for (i =3D 0; i < ARRAY_SIZE(ncsi_rsp_handlers); i++) {
+    for (i =3D 0; i < G_N_ELEMENTS(ncsi_rsp_handlers); i++) {
         if (ncsi_rsp_handlers[i].type =3D=3D nh->type + 0x80) {
             handler =3D &ncsi_rsp_handlers[i];
             break;
diff --git a/slirp/tftp.c b/slirp/tftp.c
index dddb614b8a..ef8d0352b4 100644
--- a/slirp/tftp.c
+++ b/slirp/tftp.c
@@ -360,7 +360,7 @@ static void tftp_handle_rrq(Slirp *slirp, struct sock=
addr_storage *srcsas,
       return;
   }
=20
-  while (k < pktlen && nb_options < ARRAY_SIZE(option_name)) {
+  while (k < pktlen && nb_options < G_N_ELEMENTS(option_name)) {
       const char *key, *value;
=20
       key =3D &tp->x.tp_buf[k];
@@ -404,7 +404,7 @@ static void tftp_handle_rrq(Slirp *slirp, struct sock=
addr_storage *srcsas,
   }
=20
   if (nb_options > 0) {
-      assert(nb_options <=3D ARRAY_SIZE(option_name));
+      assert(nb_options <=3D G_N_ELEMENTS(option_name));
       tftp_send_oack(spt, option_name, option_value, nb_options, tp);
       return;
   }
--=20
2.19.1.708.g4ede3d42df
