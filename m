Received: from eggs.gnu.org ([209.51.188.92]:47375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1gR5-000385-Or
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1gR5-0003ky-5l
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:58:55 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:43702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h1gR4-0003kU-UZ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:58:55 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  7 Mar 2019 00:58:42 +0100
Message-Id: <20190306235850.30110-5-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
References: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/12] slirp: fix big/little endian conversion
 in ident protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

---
Based-on: <1551476756-25749-1-git-send-email-will@wbowling.info>
---
 slirp/tcp_subr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index ef9d99c154..1d7e72dca7 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -660,10 +660,12 @@ tcp_emu(struct socket *so, struct mbuf *m)
 						    tmpso->so_fport =3D=3D n1) {
 							if (getsockname(tmpso->s,
 								(struct sockaddr *)&addr, &addrlen) =3D=3D 0)
-							   n2 =3D ntohs(addr.sin_port);
+							   n2 =3D addr.sin_port;
 							break;
 						}
 					}
+					NTOHS(n1);
+					NTOHS(n2);
 					so_rcv->sb_cc =3D snprintf(so_rcv->sb_data,
 								 so_rcv->sb_datalen,
 								 "%d,%d\r\n", n1, n2);
--=20
2.20.1
