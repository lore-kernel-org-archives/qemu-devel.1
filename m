Received: from eggs.gnu.org ([209.51.188.92]:35800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtb2Z-0005UT-6l
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtasU-0000vv-9l
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtasU-0000mD-0r
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:46 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 12 Feb 2019 17:25:24 +0100
Message-Id: <20190212162524.31504-8-marcandre.lureau@redhat.com>
In-Reply-To: <20190212162524.31504-1-marcandre.lureau@redhat.com>
References: <20190212162524.31504-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/7] slirp: remove QEMU Makefile.objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, peter.maydell@linaro.org

QEMU no longer includes it, and treats slirp/ as a separate project.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/Makefile.objs | 36 ------------------------------------
 1 file changed, 36 deletions(-)
 delete mode 100644 slirp/Makefile.objs

diff --git a/slirp/Makefile.objs b/slirp/Makefile.objs
deleted file mode 100644
index 0250229dfa..0000000000
--- a/slirp/Makefile.objs
+++ /dev/null
@@ -1,36 +0,0 @@
-slirp-obj-y =3D slirp.mo
-
-slirp.mo-objs =3D \
-	src/arp_table.o \
-	src/bootp.o \
-	src/cksum.o \
-	src/dhcpv6.o \
-	src/dnssearch.o \
-	src/if.o \
-	src/ip6_icmp.o \
-	src/ip6_input.o \
-	src/ip6_output.o \
-	src/ip_icmp.o \
-	src/ip_input.o \
-	src/ip_output.o \
-	src/mbuf.o \
-	src/misc.o \
-	src/ncsi.o \
-	src/ndp_table.o \
-	src/sbuf.o \
-	src/slirp.o \
-	src/socket.o \
-	src/state.o \
-	src/stream.o \
-	src/tcp_input.o \
-	src/tcp_output.o \
-	src/tcp_subr.o \
-	src/tcp_timer.o \
-	src/tftp.o \
-	src/udp.o \
-	src/udp6.o \
-	src/util.o \
-	src/vmstate.o \
-	$(NULL)
-
-slirp.mo-cflags =3D -DG_LOG_DOMAIN=3D\"Slirp\"
--=20
2.21.0.rc0.1.g036caf7885
