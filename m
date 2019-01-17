Received: from eggs.gnu.org ([209.51.188.92]:57509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66n-0005yc-8b
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66m-000577-EP
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk66m-00052Q-72
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:16 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:45 +0400
Message-Id: <20190117114359.5164-14-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/27] slirp: do not include qemu headers in
 libslirp.h public API header
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 679a25422b9..02cbec9f8be 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -1,7 +1,17 @@
 #ifndef LIBSLIRP_H
 #define LIBSLIRP_H
=20
-#include "qemu-common.h"
+#include <glib.h>
+#include <stdint.h>
+#include <stdbool.h>
+
+#ifdef _WIN32
+#include <winsock2.h>
+#include <in6addr.h>
+#else
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#endif
=20
 typedef struct Slirp Slirp;
=20
--=20
2.20.1.98.gecbdaf0899
