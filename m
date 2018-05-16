Received: from eggs.gnu.org ([2001:4830:134:3::10]:52656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJ3TU-0000FF-Py
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJ3TR-00045n-Mt
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:57635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fJ3TR-00044a-DC
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:37 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 16 May 2018 22:55:39 +0200
Message-Id: <20180516205543.29305-5-laurent@vivier.eu>
In-Reply-To: <20180516205543.29305-1-laurent@vivier.eu>
References: <20180516205543.29305-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 4/8] linux-user: move socket.h generic
 definitions to generic/sockbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

and include the file from architectures without specific definitions

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/sockbits.h    |  1 +
 linux-user/arm/sockbits.h        |  1 +
 linux-user/cris/sockbits.h       |  1 +
 linux-user/generic/sockbits.h    | 67 ++++++++++++++++++++++++++++++++++++++++
 linux-user/i386/sockbits.h       |  1 +
 linux-user/m68k/sockbits.h       |  1 +
 linux-user/microblaze/sockbits.h |  1 +
 linux-user/nios2/sockbits.h      |  1 +
 linux-user/openrisc/sockbits.h   |  1 +
 linux-user/ppc/sockbits.h        |  1 +
 linux-user/riscv/sockbits.h      |  1 +
 linux-user/s390x/sockbits.h      |  1 +
 linux-user/sh4/sockbits.h        |  1 +
 linux-user/socket.h              | 61 ------------------------------------
 linux-user/tilegx/sockbits.h     |  1 +
 linux-user/x86_64/sockbits.h     |  1 +
 linux-user/xtensa/sockbits.h     |  1 +
 17 files changed, 82 insertions(+), 61 deletions(-)
 create mode 100644 linux-user/aarch64/sockbits.h
 create mode 100644 linux-user/arm/sockbits.h
 create mode 100644 linux-user/cris/sockbits.h
 create mode 100644 linux-user/generic/sockbits.h
 create mode 100644 linux-user/i386/sockbits.h
 create mode 100644 linux-user/m68k/sockbits.h
 create mode 100644 linux-user/microblaze/sockbits.h
 create mode 100644 linux-user/nios2/sockbits.h
 create mode 100644 linux-user/openrisc/sockbits.h
 create mode 100644 linux-user/ppc/sockbits.h
 create mode 100644 linux-user/riscv/sockbits.h
 create mode 100644 linux-user/s390x/sockbits.h
 create mode 100644 linux-user/sh4/sockbits.h
 create mode 100644 linux-user/tilegx/sockbits.h
 create mode 100644 linux-user/x86_64/sockbits.h
 create mode 100644 linux-user/xtensa/sockbits.h

diff --git a/linux-user/aarch64/sockbits.h b/linux-user/aarch64/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/aarch64/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/arm/sockbits.h b/linux-user/arm/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/arm/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/cris/sockbits.h b/linux-user/cris/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/cris/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h
new file mode 100644
index 0000000000..093faf0a48
--- /dev/null
+++ b/linux-user/generic/sockbits.h
@@ -0,0 +1,67 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef GENERIC_SOCKBITS_H
+#define GENERIC_SOCKBITS_H
+
+#define TARGET_SO_PASSSEC        34
+
+/* For setsockopt(2) */
+#define TARGET_SOL_SOCKET      1
+
+#define TARGET_SO_DEBUG        1
+#define TARGET_SO_REUSEADDR    2
+#define TARGET_SO_TYPE         3
+#define TARGET_SO_ERROR        4
+#define TARGET_SO_DONTROUTE    5
+#define TARGET_SO_BROADCAST    6
+#define TARGET_SO_SNDBUF       7
+#define TARGET_SO_RCVBUF       8
+#define TARGET_SO_SNDBUFFORCE  32
+#define TARGET_SO_RCVBUFFORCE  33
+#define TARGET_SO_KEEPALIVE    9
+#define TARGET_SO_OOBINLINE    10
+#define TARGET_SO_NO_CHECK     11
+#define TARGET_SO_PRIORITY     12
+#define TARGET_SO_LINGER       13
+#define TARGET_SO_BSDCOMPAT    14
+/* To add :#define TARGET_SO_REUSEPORT 15 */
+#if defined(TARGET_PPC)
+#define TARGET_SO_RCVLOWAT     16
+#define TARGET_SO_SNDLOWAT     17
+#define TARGET_SO_RCVTIMEO     18
+#define TARGET_SO_SNDTIMEO     19
+#define TARGET_SO_PASSCRED     20
+#define TARGET_SO_PEERCRED     21
+#else
+#define TARGET_SO_PASSCRED     16
+#define TARGET_SO_PEERCRED     17
+#define TARGET_SO_RCVLOWAT     18
+#define TARGET_SO_SNDLOWAT     19
+#define TARGET_SO_RCVTIMEO     20
+#define TARGET_SO_SNDTIMEO     21
+#endif
+
+/* Security levels - as per NRL IPv6 - don't actually do anything */
+#define TARGET_SO_SECURITY_AUTHENTICATION              22
+#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        23
+#define TARGET_SO_SECURITY_ENCRYPTION_NETWORK          24
+
+#define TARGET_SO_BINDTODEVICE 25
+
+/* Socket filtering */
+#define TARGET_SO_ATTACH_FILTER        26
+#define TARGET_SO_DETACH_FILTER        27
+
+#define TARGET_SO_PEERNAME             28
+#define TARGET_SO_TIMESTAMP            29
+#define TARGET_SCM_TIMESTAMP           TARGET_SO_TIMESTAMP
+
+#define TARGET_SO_ACCEPTCONN           30
+
+#define TARGET_SO_PEERSEC              31
+#endif
diff --git a/linux-user/i386/sockbits.h b/linux-user/i386/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/i386/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/m68k/sockbits.h b/linux-user/m68k/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/m68k/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/microblaze/sockbits.h b/linux-user/microblaze/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/microblaze/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/nios2/sockbits.h b/linux-user/nios2/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/nios2/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/openrisc/sockbits.h b/linux-user/openrisc/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/openrisc/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/ppc/sockbits.h b/linux-user/ppc/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/ppc/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/riscv/sockbits.h b/linux-user/riscv/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/riscv/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/s390x/sockbits.h b/linux-user/s390x/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/s390x/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/sh4/sockbits.h b/linux-user/sh4/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/sh4/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/socket.h b/linux-user/socket.h
index 8eb62ea3f2..135f438bdf 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -1,66 +1,5 @@
 
-#if defined(TARGET_MIPS) || defined(TARGET_HPPA) || defined(TARGET_ALPHA) || \
-    defined(TARGET_SPARC)
 #include "sockbits.h"
-#else
-    #define TARGET_SO_PASSSEC        34
-
-    /* For setsockopt(2) */
-    #define TARGET_SOL_SOCKET      1
-
-    #define TARGET_SO_DEBUG        1
-    #define TARGET_SO_REUSEADDR    2
-    #define TARGET_SO_TYPE         3
-    #define TARGET_SO_ERROR        4
-    #define TARGET_SO_DONTROUTE    5
-    #define TARGET_SO_BROADCAST    6
-    #define TARGET_SO_SNDBUF       7
-    #define TARGET_SO_RCVBUF       8
-    #define TARGET_SO_SNDBUFFORCE  32
-    #define TARGET_SO_RCVBUFFORCE  33
-    #define TARGET_SO_KEEPALIVE    9
-    #define TARGET_SO_OOBINLINE    10
-    #define TARGET_SO_NO_CHECK     11
-    #define TARGET_SO_PRIORITY     12
-    #define TARGET_SO_LINGER       13
-    #define TARGET_SO_BSDCOMPAT    14
-    /* To add :#define TARGET_SO_REUSEPORT 15 */
-#if defined(TARGET_PPC)
-    #define TARGET_SO_RCVLOWAT     16
-    #define TARGET_SO_SNDLOWAT     17
-    #define TARGET_SO_RCVTIMEO     18
-    #define TARGET_SO_SNDTIMEO     19
-    #define TARGET_SO_PASSCRED     20
-    #define TARGET_SO_PEERCRED     21
-#else
-    #define TARGET_SO_PASSCRED     16
-    #define TARGET_SO_PEERCRED     17
-    #define TARGET_SO_RCVLOWAT     18
-    #define TARGET_SO_SNDLOWAT     19
-    #define TARGET_SO_RCVTIMEO     20
-    #define TARGET_SO_SNDTIMEO     21
-#endif
-
-    /* Security levels - as per NRL IPv6 - don't actually do anything */
-    #define TARGET_SO_SECURITY_AUTHENTICATION              22
-    #define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        23
-    #define TARGET_SO_SECURITY_ENCRYPTION_NETWORK          24
-
-    #define TARGET_SO_BINDTODEVICE 25
-
-    /* Socket filtering */
-    #define TARGET_SO_ATTACH_FILTER        26
-    #define TARGET_SO_DETACH_FILTER        27
-
-    #define TARGET_SO_PEERNAME             28
-    #define TARGET_SO_TIMESTAMP            29
-    #define TARGET_SCM_TIMESTAMP           TARGET_SO_TIMESTAMP
-
-    #define TARGET_SO_ACCEPTCONN           30
-
-    #define TARGET_SO_PEERSEC              31
-
-#endif
 
 #ifndef ARCH_HAS_SOCKET_TYPES
     /** sock_type - Socket types - default values
diff --git a/linux-user/tilegx/sockbits.h b/linux-user/tilegx/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/tilegx/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/x86_64/sockbits.h b/linux-user/x86_64/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/x86_64/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
diff --git a/linux-user/xtensa/sockbits.h b/linux-user/xtensa/sockbits.h
new file mode 100644
index 0000000000..0e4c8f012d
--- /dev/null
+++ b/linux-user/xtensa/sockbits.h
@@ -0,0 +1 @@
+#include "../generic/sockbits.h"
-- 
2.14.3
