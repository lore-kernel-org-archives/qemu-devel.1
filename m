Received: from eggs.gnu.org ([2001:4830:134:3::10]:32826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duRbc-0004zS-C5
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 19:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duRbX-0000tI-Ag
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 19:07:04 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:35921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1duRbX-0000sC-5A
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 19:06:59 -0400
Received: by mail-it0-x243.google.com with SMTP id e134so576348ite.3
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 16:06:59 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Tue, 19 Sep 2017 16:06:41 -0700
Message-Id: <20170919230643.87425-1-carenas@gmail.com>
In-Reply-To: <d137f607-aa48-e388-02b2-1f1b104439e2@vivier.eu>
References: <d137f607-aa48-e388-02b2-1f1b104439e2@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/3] linux-user: fix TARGET_SO_LINGER for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, peter.maydell@linaro.org, gang.chen.5i5j@gmail.com, rth@twiddle.net, =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 linux-user/socket.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/socket.h b/linux-user/socket.h
index 7051cd2cf4..129f9b4713 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -246,8 +246,12 @@
     #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
     #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
 
+    #define TARGET_SO_LINGER         0x0080
+
     #define TARGET_SO_PASSSEC        31
 #else
+    #define TARGET_SO_LINGER         13
+
     #define TARGET_SO_PASSSEC        34
 #endif
 
@@ -268,7 +272,7 @@
     #define TARGET_SO_OOBINLINE    10
     #define TARGET_SO_NO_CHECK     11
     #define TARGET_SO_PRIORITY     12
-    #define TARGET_SO_LINGER       13
+
     #define TARGET_SO_BSDCOMPAT    14
     /* To add :#define TARGET_SO_REUSEPORT 15 */
 #if defined(TARGET_PPC)
-- 
2.14.1
