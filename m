Received: from eggs.gnu.org ([2001:4830:134:3::10]:51238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPagP-0005vQ-0w
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPagL-0004B9-Eo
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPagH-0003vU-Mr
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:11 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:35 +0400
Message-Id: <20181121220647.18844-19-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 18/30] slirp: no need to make
 DPRINTF conditional on DEBUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

DEBUG_CALL is already handled conditionally.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/bootp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/slirp/bootp.c b/slirp/bootp.c
index 5ab6692038..4c9a77eb98 100644
--- a/slirp/bootp.c
+++ b/slirp/bootp.c
@@ -36,11 +36,7 @@
=20
 static const uint8_t rfc1533_cookie[] =3D { RFC1533_COOKIE };
=20
-#ifdef DEBUG
 #define DPRINTF(fmt, ...) DEBUG_CALL(fmt, ##__VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...) do{}while(0)
-#endif
=20
 static BOOTPClient *get_new_addr(Slirp *slirp, struct in_addr *paddr,
                                  const uint8_t *macaddr)
@@ -166,8 +162,9 @@ static void bootp_reply(Slirp *slirp, const struct bo=
otp_t *bp)
     DPRINTF("bootp packet op=3D%d msgtype=3D%d", bp->bp_op, dhcp_msg_typ=
e);
     if (preq_addr.s_addr !=3D htonl(0L))
         DPRINTF(" req_addr=3D%08" PRIx32 "\n", ntohl(preq_addr.s_addr));
-    else
+    else {
         DPRINTF("\n");
+    }
=20
     if (dhcp_msg_type =3D=3D 0)
         dhcp_msg_type =3D DHCPREQUEST; /* Force reply for old BOOTP clie=
nts */
--=20
2.20.0.rc1
