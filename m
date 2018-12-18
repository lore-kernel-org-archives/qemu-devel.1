Received: from eggs.gnu.org ([2001:4830:134:3::10]:41114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORa-0000jY-J5
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORY-0005J5-TM
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:30 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZORY-00053s-Eo
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:28 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:42 +0100
Message-Id: <20181218230442.27887-65-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 64/64] slirp: Mark debugging calls as unlikely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

to get them out of the hot path.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/debug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/slirp/debug.h b/slirp/debug.h
index 25a5d59439..269d97d807 100644
--- a/slirp/debug.h
+++ b/slirp/debug.h
@@ -15,25 +15,25 @@
 extern int slirp_debug;
=20
 #define DEBUG_CALL(fmt, ...) do {               \
-    if (slirp_debug & DBG_CALL) {               \
+    if (G_UNLIKELY(slirp_debug & DBG_CALL)) {   \
         g_debug(fmt "...", ##__VA_ARGS__);      \
     }                                           \
 } while (0)
=20
 #define DEBUG_ARG(fmt, ...) do {                \
-    if (slirp_debug & DBG_CALL) {               \
+    if (G_UNLIKELY(slirp_debug & DBG_CALL)) {   \
         g_debug(" " fmt, ##__VA_ARGS__);        \
     }                                           \
 } while (0)
=20
 #define DEBUG_MISC(fmt, ...) do {               \
-    if (slirp_debug & DBG_MISC) {               \
+    if (G_UNLIKELY(slirp_debug & DBG_MISC)) {   \
         g_debug(fmt, ##__VA_ARGS__);            \
     }                                           \
 } while (0)
=20
 #define DEBUG_ERROR(fmt, ...) do {              \
-    if (slirp_debug & DBG_ERROR) {              \
+    if (G_UNLIKELY(slirp_debug & DBG_ERROR)) {  \
         g_debug(fmt, ##__VA_ARGS__);            \
     }                                           \
 } while (0)
--=20
2.19.2
