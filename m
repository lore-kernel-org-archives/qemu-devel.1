Received: from eggs.gnu.org ([2001:4830:134:3::10]:43726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gPbCs-0002og-0A
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gPbCm-0004pE-RL
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:42:49 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:33032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gPbCl-0004MU-1j
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:42:44 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 21 Nov 2018 23:42:20 +0100
Message-Id: <20181121224220.10595-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] slirp: Mark debugging calls as unlikely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, marcandre.lureau@redhat.com, zhangckid@gmail.com, lizhijian@cn.fujitsu.com, jasowang@redhat.com, jan.kiszka@siemens.com

to get them out of the hot path.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/debug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/slirp/debug.h b/slirp/debug.h
index ff920f0b87..ad4e07aa01 100644
--- a/slirp/debug.h
+++ b/slirp/debug.h
@@ -17,7 +17,7 @@
 extern int slirp_debug;
=20
 #define DEBUG_CALL(fmt, ...) do {               \
-    if (slirp_debug & DBG_CALL) {               \
+    if (unlikely(slirp_debug & DBG_CALL)) {     \
         fprintf(dfd, fmt, ##__VA_ARGS__);       \
         fprintf(dfd, "...\n");                  \
         fflush(dfd);                            \
@@ -25,7 +25,7 @@ extern int slirp_debug;
 } while (0)
=20
 #define DEBUG_ARG(fmt, ...) do {                \
-    if (slirp_debug & DBG_CALL) {               \
+    if (unlikely(slirp_debug & DBG_CALL)) {     \
         fputc(' ', dfd);                        \
         fprintf(dfd, fmt, ##__VA_ARGS__);       \
         fputc('\n', dfd);                       \
@@ -36,14 +36,14 @@ extern int slirp_debug;
 #define DEBUG_ARGS(fmt, ...) DEBUG_ARG(fmt, ##__VA_ARGS__)
=20
 #define DEBUG_MISC(fmt, ...) do {               \
-    if (slirp_debug & DBG_MISC) {               \
+    if (unlikely(slirp_debug & DBG_MISC)) {     \
         fprintf(dfd, fmt, ##__VA_ARGS__);       \
         fflush(dfd);                            \
     }                                           \
 } while (0)
=20
 #define DEBUG_ERROR(fmt, ...) do {              \
-    if (slirp_debug & DBG_ERROR) {              \
+    if (unlikely(slirp_debug & DBG_ERROR)) {    \
         fprintf(dfd, fmt, ##__VA_ARGS__);       \
         fflush(dfd);                            \
     }                                           \
--=20
2.19.1
