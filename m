Received: from eggs.gnu.org ([2001:4830:134:3::10]:41221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORc-0000jh-FB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORZ-0005Ku-Pr
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:32 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZORZ-0004yH-5s
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:29 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:34 +0100
Message-Id: <20181218230442.27887-57-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 56/64] slirp: use %p for pointers format
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

This fixes some compilation warnings on mingw64.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip6_icmp.c   | 2 +-
 slirp/ip6_input.c  | 2 +-
 slirp/ip6_output.c | 4 ++--
 slirp/udp6.c       | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 595a62c8d4..bce075913c 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -390,7 +390,7 @@ void icmp6_input(struct mbuf *m)
     int hlen =3D sizeof(struct ip6);
=20
     DEBUG_CALL("icmp6_input");
-    DEBUG_ARG("m =3D %lx", (long) m);
+    DEBUG_ARG("m =3D %p", m);
     DEBUG_ARG("m_len =3D %d", m->m_len);
=20
     if (ntohs(ip->ip_pl) < ICMP6_MINLEN) {
diff --git a/slirp/ip6_input.c b/slirp/ip6_input.c
index ac2e3ea882..ab656a0a9d 100644
--- a/slirp/ip6_input.c
+++ b/slirp/ip6_input.c
@@ -31,7 +31,7 @@ void ip6_input(struct mbuf *m)
     }
=20
     DEBUG_CALL("ip6_input");
-    DEBUG_ARG("m =3D %lx", (long)m);
+    DEBUG_ARG("m =3D %p", m);
     DEBUG_ARG("m_len =3D %d", m->m_len);
=20
     if (m->m_len < sizeof(struct ip6)) {
diff --git a/slirp/ip6_output.c b/slirp/ip6_output.c
index 762cbfe89c..52c88ad691 100644
--- a/slirp/ip6_output.c
+++ b/slirp/ip6_output.c
@@ -19,8 +19,8 @@ int ip6_output(struct socket *so, struct mbuf *m, int f=
ast)
     struct ip6 *ip =3D mtod(m, struct ip6 *);
=20
     DEBUG_CALL("ip6_output");
-    DEBUG_ARG("so =3D %lx", (long)so);
-    DEBUG_ARG("m =3D %lx", (long)m);
+    DEBUG_ARG("so =3D %p", so);
+    DEBUG_ARG("m =3D %p", m);
=20
     /* Fill IPv6 header */
     ip->ip_v =3D IP6VERSION;
diff --git a/slirp/udp6.c b/slirp/udp6.c
index 473ba1586e..8cdb1892e2 100644
--- a/slirp/udp6.c
+++ b/slirp/udp6.c
@@ -20,7 +20,7 @@ void udp6_input(struct mbuf *m)
     struct sockaddr_in6 lhost;
=20
     DEBUG_CALL("udp6_input");
-    DEBUG_ARG("m =3D %lx", (long)m);
+    DEBUG_ARG("m =3D %p", m);
=20
     if (slirp->restricted) {
         goto bad;
@@ -144,8 +144,8 @@ int udp6_output(struct socket *so, struct mbuf *m,
     struct udphdr *uh;
=20
     DEBUG_CALL("udp6_output");
-    DEBUG_ARG("so =3D %lx", (long)so);
-    DEBUG_ARG("m =3D %lx", (long)m);
+    DEBUG_ARG("so =3D %p", so);
+    DEBUG_ARG("m =3D %p", m);
=20
     /* adjust for header */
     m->m_data -=3D sizeof(struct udphdr);
--=20
2.19.2
