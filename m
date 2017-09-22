Received: from eggs.gnu.org ([2001:4830:134:3::10]:53821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dvOXz-0006wH-IH
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dvOXt-0001PH-Nc
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:03:15 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dvOXt-0001Oi-Ig
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:03:09 -0400
Received: by mail-pf0-x243.google.com with SMTP id e69so499384pfg.4
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 07:03:09 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Fri, 22 Sep 2017 07:02:36 -0700
Message-Id: <20170922140237.10869-6-carenas@gmail.com>
In-Reply-To: <20170922140237.10869-1-carenas@gmail.com>
References: <20170922140237.10869-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 5/6] linux-user: fix 64bit versions of sparc and
 mips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, laurent@vivier.eu, riku.voipio@iki.fi, =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 linux-user/mips64/sockbits.h  | 1 +
 linux-user/socket.h           | 4 ++--
 linux-user/sparc64/sockbits.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 linux-user/mips64/sockbits.h
 create mode 100644 linux-user/sparc64/sockbits.h

diff --git a/linux-user/mips64/sockbits.h b/linux-user/mips64/sockbits.h
new file mode 100644
index 0000000000..e6b6d31ac9
--- /dev/null
+++ b/linux-user/mips64/sockbits.h
@@ -0,0 +1 @@
+#include "../mips/sockbits.h"
diff --git a/linux-user/socket.h b/linux-user/socket.h
index dfa692286b..6fd486c6b1 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -1,10 +1,10 @@
-#if defined(TARGET_MIPS)
+#if defined(TARGET_MIPS) || defined(TARGET_MIPS64)
 #include "mips/sockbits.h"
 #elif defined(TARGET_ALPHA)
 #include "alpha/sockbits.h"
 #elif defined(TARGET_HPPA)
 #include "hppa/sockbits.h"
-#elif defined(TARGET_SPARC)
+#elif defined(TARGET_SPARC) || defined(TARGET_SPARC64)
 #include "sparc/sockbits.h"
 #else
 
diff --git a/linux-user/sparc64/sockbits.h b/linux-user/sparc64/sockbits.h
new file mode 100644
index 0000000000..658899e4d3
--- /dev/null
+++ b/linux-user/sparc64/sockbits.h
@@ -0,0 +1 @@
+#include "../sparc/sockbits.h"
-- 
2.14.1
