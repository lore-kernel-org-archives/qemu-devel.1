Received: from eggs.gnu.org ([209.51.188.92]:51097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipk3-0002v9-Ag
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipk1-0006KH-Ty
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:35 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:60200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipk1-0006Fj-M1
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:33 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 01:02:28 +0100
Message-Id: <20190114000326.29847-8-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/65] slirp: move internal function declarations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Clarify that those functions are internal to slirp.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/libslirp.h | 3 ---
 slirp/slirp.h    | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 3e88dbaa01..a4f390ee89 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -7,9 +7,6 @@ typedef struct Slirp Slirp;
=20
 typedef void (*slirp_output)(void *opaque, const uint8_t *pkt, int pkt_l=
en);
=20
-int get_dns_addr(struct in_addr *pdns_addr);
-int get_dns6_addr(struct in6_addr *pdns6_addr, uint32_t *scope_id);
-
 Slirp *slirp_init(int restricted, bool in_enabled, struct in_addr vnetwo=
rk,
                   struct in_addr vnetmask, struct in_addr vhost,
                   bool in6_enabled,
diff --git a/slirp/slirp.h b/slirp/slirp.h
index e3d65d68ec..de299aa36c 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -232,6 +232,9 @@ extern Slirp *slirp_instance;
=20
 void if_start(Slirp *);
=20
+int get_dns_addr(struct in_addr *pdns_addr);
+int get_dns6_addr(struct in6_addr *pdns6_addr, uint32_t *scope_id);
+
 /* ncsi.c */
 void ncsi_input(Slirp *slirp, const uint8_t *pkt, int pkt_len);
=20
--=20
2.20.1
