Received: from eggs.gnu.org ([2001:4830:134:3::10]:40204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQI-00081U-L5
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQE-0004Ey-Tu
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:08 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQD-00044D-49
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:06 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:45 +0100
Message-Id: <20181218230442.27887-8-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/64] slirp: move internal function declarations
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
2.19.2
