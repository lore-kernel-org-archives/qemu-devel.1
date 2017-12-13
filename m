Received: from eggs.gnu.org ([2001:4830:134:3::10]:54953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eOzRa-0000BV-WE
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 00:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eOzRZ-0004eI-Py
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 00:18:58 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 02:17:36 -0300
Message-Id: <20171213051736.17755-5-f4bug@amsat.org>
In-Reply-To: <20171213051736.17755-1-f4bug@amsat.org>
References: <20171213051736.17755-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/4] hw/registerfields: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

This allows to use this header in qtests.

This fixes:
    CC      tests/test.o
  include/hw/registerfields.h:32:41: error: implicit declaration of function ‘MAKE_64BIT_MASK’ [-Werror=implicit-function-declaration]
              MAKE_64BIT_MASK(shift, length)};
              ^
  include/hw/registerfields.h:39:5: error: implicit declaration of function ‘extract64’; [-Werror=implicit-function-declaration]
       extract64((storage), R_ ## reg ## _ ## field ## _SHIFT,
       ^

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/registerfields.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
index f59e7f47bd..44e0b94edf 100644
--- a/include/hw/registerfields.h
+++ b/include/hw/registerfields.h
@@ -11,6 +11,8 @@
 #ifndef REGISTERFIELDS_H
 #define REGISTERFIELDS_H
 
+#include <qemu/bitops.h>
+
 /* Define constants for a 32 bit register */
 
 /* This macro will define A_FOO, for the byte address of a register
-- 
2.15.1
