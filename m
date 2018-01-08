Received: from eggs.gnu.org ([2001:4830:134:3::10]:33709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEm-0008AM-Bc
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEl-0000B1-KC
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:28 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEl-0000Aa-FL
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:27 -0500
Received: by mail-qt0-x241.google.com with SMTP id r39so14514502qtr.13
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:29:27 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 14:28:57 -0300
Message-Id: <20180108172904.8772-6-f4bug@amsat.org>
In-Reply-To: <20180108172904.8772-1-f4bug@amsat.org>
References: <20180108172904.8772-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/12] slirp: poison IN6_*_ADDR_*() macros to
 avoid them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 slirp/ip6.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/slirp/ip6.h b/slirp/ip6.h
index 6c5d4eeaa3..c6493a0856 100644
--- a/slirp/ip6.h
+++ b/slirp/ip6.h
@@ -8,6 +8,25 @@
 
 #include "net/eth.h"
 
+#ifdef __GNUC__
+# undef IN6_IS_ADDR_UNSPECIFIED
+# pragma GCC poison IN6_IS_ADDR_UNSPECIFIED
+# undef IN6_IS_ADDR_LOOPBACK
+# pragma GCC poison IN6_IS_ADDR_LOOPBACK
+# undef IN6_IS_ADDR_LINKLOCAL
+# pragma GCC poison IN6_IS_ADDR_LINKLOCAL
+# undef IN6_IS_ADDR_SITELOCAL
+# pragma GCC poison IN6_IS_ADDR_SITELOCAL
+# undef IN6_IS_ADDR_V4MAPPED
+# pragma GCC poison IN6_IS_ADDR_V4MAPPED
+# undef IN6_IS_ADDR_V4COMPAT
+# pragma GCC poison IN6_IS_ADDR_V4COMPAT
+# undef IN6_ARE_ADDR_EQUAL
+# pragma GCC poison IN6_ARE_ADDR_EQUAL
+# undef IN6_IS_ADDR_MULTICAST
+# pragma GCC poison IN6_IS_ADDR_MULTICAST
+#endif
+
 #define ALLNODES_MULTICAST  { .s6_addr = \
                             { 0xff, 0x02, 0x00, 0x00,\
                             0x00, 0x00, 0x00, 0x00,\
-- 
2.15.1
