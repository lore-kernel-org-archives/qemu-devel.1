Received: from eggs.gnu.org ([209.51.188.92]:42784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr5Tg-0005fT-1C
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr5Te-00063Z-5B
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:29:47 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:34934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gr5Tb-0005j1-LQ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:29:44 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Tue,  5 Feb 2019 20:28:39 +0200
Message-Id: <20190205182848.29887-24-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190205182848.29887-1-samuel.thibault@ens-lyon.org>
References: <20190205182848.29887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULLv3 23/32] slirp: replace QEMU_BUILD_BUG_ON with
 G_STATIC_ASSERT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Stefano Garzarella <sgarzare@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

to remove another dependency on qemu.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 slirp/ip.h       |  4 ++--
 slirp/ip6.h      |  4 ++--
 slirp/ip6_icmp.h | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/slirp/ip.h b/slirp/ip.h
index 2baeeb9a3a..73a4d2a3d2 100644
--- a/slirp/ip.h
+++ b/slirp/ip.h
@@ -229,8 +229,8 @@ struct	ipasfrag {
 	struct ip ipf_ip;
 };
=20
-QEMU_BUILD_BUG_ON(offsetof(struct ipq, frag_link) !=3D
-                  offsetof(struct ipasfrag, ipf_link));
+G_STATIC_ASSERT(offsetof(struct ipq, frag_link) =3D=3D
+                offsetof(struct ipasfrag, ipf_link));
=20
 #define ipf_off      ipf_ip.ip_off
 #define ipf_tos      ipf_ip.ip_tos
diff --git a/slirp/ip6.h b/slirp/ip6.h
index 4e7c366505..5361bd7449 100644
--- a/slirp/ip6.h
+++ b/slirp/ip6.h
@@ -152,7 +152,7 @@ struct ip6_pseudohdr {
  * If we marked the struct as packed then we would be unable to take
  * the address of any of the fields in it.
  */
-QEMU_BUILD_BUG_ON(sizeof(struct ip6) !=3D 40);
-QEMU_BUILD_BUG_ON(sizeof(struct ip6_pseudohdr) !=3D 40);
+G_STATIC_ASSERT(sizeof(struct ip6) =3D=3D 40);
+G_STATIC_ASSERT(sizeof(struct ip6_pseudohdr) =3D=3D 40);
=20
 #endif
diff --git a/slirp/ip6_icmp.h b/slirp/ip6_icmp.h
index 3f44ed2f49..e8ed753db5 100644
--- a/slirp/ip6_icmp.h
+++ b/slirp/ip6_icmp.h
@@ -50,14 +50,14 @@ struct ndp_ra {     /* Router Advertisement Message *=
/
     uint32_t retrans_time;  /* Retrans Timer */
 };
=20
-QEMU_BUILD_BUG_ON(sizeof(struct ndp_ra) !=3D 12);
+G_STATIC_ASSERT(sizeof(struct ndp_ra) =3D=3D 12);
=20
 struct ndp_ns {     /* Neighbor Solicitation Message */
     uint32_t reserved;
     struct in6_addr target; /* Target Address */
 };
=20
-QEMU_BUILD_BUG_ON(sizeof(struct ndp_ns) !=3D 20);
+G_STATIC_ASSERT(sizeof(struct ndp_ns) =3D=3D 20);
=20
 struct ndp_na {     /* Neighbor Advertisement Message */
 #if G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
@@ -78,7 +78,7 @@ struct ndp_na {     /* Neighbor Advertisement Message *=
/
     struct in6_addr target; /* Target Address */
 };
=20
-QEMU_BUILD_BUG_ON(sizeof(struct ndp_na) !=3D 20);
+G_STATIC_ASSERT(sizeof(struct ndp_na) =3D=3D 20);
=20
 struct ndp_redirect {
     uint32_t reserved;
@@ -86,7 +86,7 @@ struct ndp_redirect {
     struct in6_addr dest;   /* Destination Address */
 };
=20
-QEMU_BUILD_BUG_ON(sizeof(struct ndp_redirect) !=3D 36);
+G_STATIC_ASSERT(sizeof(struct ndp_redirect) =3D=3D 36);
=20
 /*
  * Structure of an icmpv6 header.
@@ -113,7 +113,7 @@ struct icmp6 {
 #define icmp6_redirect icmp6_body.ndp_redirect
 };
=20
-QEMU_BUILD_BUG_ON(sizeof(struct icmp6) !=3D 40);
+G_STATIC_ASSERT(sizeof(struct icmp6) =3D=3D 40);
=20
 #define ICMP6_MINLEN    4
 #define ICMP6_ERROR_MINLEN  8
--=20
2.20.1
