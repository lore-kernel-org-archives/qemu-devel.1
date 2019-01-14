Received: from eggs.gnu.org ([209.51.188.92]:51841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipkj-0003X9-9P
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipki-0006ua-FQ
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:17 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:60562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipki-0006im-8Z
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:16 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 01:03:25 +0100
Message-Id: <20190114000326.29847-65-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 64/65] slirp: Mark debugging calls as unlikely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
2.20.1
