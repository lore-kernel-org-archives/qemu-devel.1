Received: from eggs.gnu.org ([2001:4830:134:3::10]:40701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR9-0000Lj-Gm
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR8-00050a-9o
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:03 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOR7-0004Pz-Qg
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:02 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:19 +0100
Message-Id: <20181218230442.27887-42-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 41/64] slirp: replace ARRAY_SIZE with
 G_N_ELEMENTS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Do not require QEMU macro.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
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
index 735b57aa55..a9ba1480db 100644
--- a/slirp/tftp.c
+++ b/slirp/tftp.c
@@ -359,7 +359,7 @@ static void tftp_handle_rrq(Slirp *slirp, struct sock=
addr_storage *srcsas,
       return;
   }
=20
-  while (k < pktlen && nb_options < ARRAY_SIZE(option_name)) {
+  while (k < pktlen && nb_options < G_N_ELEMENTS(option_name)) {
       const char *key, *value;
=20
       key =3D &tp->x.tp_buf[k];
@@ -403,7 +403,7 @@ static void tftp_handle_rrq(Slirp *slirp, struct sock=
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
2.19.2
