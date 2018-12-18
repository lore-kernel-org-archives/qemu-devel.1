Received: from eggs.gnu.org ([2001:4830:134:3::10]:40202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQI-00081T-KC
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQE-0004ED-AB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:07 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQD-00044o-2Q
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:05 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:49 +0100
Message-Id: <20181218230442.27887-12-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/64] slirp: remove dead declarations
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

An overdue cleanup. Remaining declarations could probably be moved in
other headers, such as slirp.h.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/main.h | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/slirp/main.h b/slirp/main.h
index 90053ce5ec..e04677944f 100644
--- a/slirp/main.h
+++ b/slirp/main.h
@@ -12,38 +12,9 @@
 #include <sys/select.h>
 #endif
=20
-#define TOWRITEMAX 512
-
-extern int slirp_socket;
-extern int slirp_socket_unit;
-extern int slirp_socket_port;
-extern uint32_t slirp_socket_addr;
-extern char *slirp_socket_passwd;
-extern int ctty_closed;
-
-/*
- * Get the difference in 2 times from updtim()
- * Allow for wraparound times, "just in case"
- * x is the greater of the 2 (current time) and y is
- * what it's being compared against.
- */
-#define TIME_DIFF(x,y) (x)-(y) < 0 ? ~0-(y)+(x) : (x)-(y)
-
-extern char *slirp_tty;
-extern char *exec_shell;
 extern u_int curtime;
 extern struct in_addr loopback_addr;
 extern unsigned long loopback_mask;
-extern char *username;
-extern char *socket_path;
-extern int towrite_max;
-extern int ppp_exit;
-extern int tcp_keepintvl;
-
-#define PROTO_SLIP 0x1
-#ifdef USE_PPP
-#define PROTO_PPP 0x2
-#endif
=20
 int if_encap(Slirp *slirp, struct mbuf *ifm);
 ssize_t slirp_send(struct socket *so, const void *buf, size_t len, int f=
lags);
--=20
2.19.2
