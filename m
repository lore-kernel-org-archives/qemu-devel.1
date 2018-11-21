Received: from eggs.gnu.org ([2001:4830:134:3::10]:51545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPah6-0006Ug-Kz
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:10:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPah0-00051H-B1
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPagw-0004cT-Aj
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:09:52 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:38 +0400
Message-Id: <20181121220647.18844-22-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 21/30] slirp: use %p for pointers
 format
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

This fixes some compilation warnings on mingw64.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/ip6_icmp.c   | 2 +-
 slirp/ip6_input.c  | 2 +-
 slirp/ip6_output.c | 4 ++--
 slirp/udp6.c       | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 0acdcc26a2..95f8fddacc 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -388,7 +388,7 @@ void icmp6_input(struct mbuf *m)
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
2.20.0.rc1
