Received: from eggs.gnu.org ([2001:4830:134:3::10]:35866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMDw-0005AU-TR
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMDv-000654-V9
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:31:04 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:52277)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMDv-00064n-NL
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:31:03 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 15 Jul 2017 14:30:54 +0200
Message-Id: <20170715123057.8529-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170715123057.8529-1-samuel.thibault@ens-lyon.org>
References: <20170715123057.8529-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] slirp: use DIV_ROUND_UP
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

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip6.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/slirp/ip6.h b/slirp/ip6.h
index 0908855f0f..b1bea43b3c 100644
--- a/slirp/ip6.h
+++ b/slirp/ip6.h
@@ -57,9 +57,9 @@ static inline bool in6_equal_mach(const struct in6_addr=
 *a,
                                   const struct in6_addr *b,
                                   int prefix_len)
 {
-    if (memcmp(&(a->s6_addr[(prefix_len + 7) / 8]),
-               &(b->s6_addr[(prefix_len + 7) / 8]),
-               16 - (prefix_len + 7) / 8) !=3D 0) {
+    if (memcmp(&(a->s6_addr[DIV_ROUND_UP(prefix_len, 8)]),
+               &(b->s6_addr[DIV_ROUND_UP(prefix_len, 8)]),
+               16 - DIV_ROUND_UP(prefix_len, 8)) !=3D 0) {
         return 0;
     }
=20
--=20
2.13.2
