Received: from eggs.gnu.org ([209.51.188.92]:58261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk68F-0007Fd-M7
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk68C-0006Hz-Pv
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk689-0006EZ-HW
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:41 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:59 +0400
Message-Id: <20190117114359.5164-28-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 27/27] slirp: API is extern C
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

Make it possible to use headers easily with C++ projects.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 9b13d8250c6..fccab425187 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -12,6 +12,10 @@
 #include <arpa/inet.h>
 #endif
=20
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 typedef struct Slirp Slirp;
=20
 enum {
@@ -96,5 +100,8 @@ void slirp_socket_recv(Slirp *slirp, struct in_addr gu=
est_addr,
                        int guest_port, const uint8_t *buf, int size);
 size_t slirp_socket_can_recv(Slirp *slirp, struct in_addr guest_addr,
                              int guest_port);
-
+#ifdef __cplusplus
+} /* extern "C" */
 #endif
+
+#endif /* LIBSLIRP_H */
--=20
2.20.1.98.gecbdaf0899
