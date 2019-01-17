Received: from eggs.gnu.org ([209.51.188.92]:57003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk65o-00056Z-PW
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk65n-0004CS-Nx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk65n-0004Bs-1N
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:15 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:34 +0400
Message-Id: <20190117114359.5164-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/27] net/slirp: simplify checking for cmd:
 prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 net/slirp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/slirp.c b/net/slirp.c
index ec07f662c00..b91741b8fc1 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -773,7 +773,7 @@ static int slirp_guestfwd(SlirpState *s, const char *=
config_str, Error **errp)
=20
     snprintf(buf, sizeof(buf), "guestfwd.tcp.%d", port);
=20
-    if ((strlen(p) > 4) && !strncmp(p, "cmd:", 4)) {
+    if (g_str_has_prefix(p, "cmd:")) {
         if (slirp_add_exec(s->slirp, &p[4], &server, port) < 0) {
             error_setg(errp, "Conflicting/invalid host:port in guest "
                        "forwarding rule '%s'", config_str);
--=20
2.20.1.98.gecbdaf0899
