Received: from eggs.gnu.org ([2001:4830:134:3::10]:38961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtj-0002Xy-M3
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmti-0007Yo-SX
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46980 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmti-0007YW-Nv
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:26 -0400
Date: Fri, 1 Jun 2018 19:27:25 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-28-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 27/31] arch_init: sort architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>, Helge Deller <deller@gmx.de>

Sort alphabetically. Will help us see if anything is missing (e.g. tile
is not there now).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 arch_init.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch_init.c b/arch_init.c
index 9597218ced..f4f3f610c8 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -52,14 +52,14 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_ARM
 #elif defined(TARGET_CRIS)
 #define QEMU_ARCH QEMU_ARCH_CRIS
-#elif defined(TARGET_I386)
-#define QEMU_ARCH QEMU_ARCH_I386
 #elif defined(TARGET_HPPA)
 #define QEMU_ARCH QEMU_ARCH_HPPA
-#elif defined(TARGET_M68K)
-#define QEMU_ARCH QEMU_ARCH_M68K
+#elif defined(TARGET_I386)
+#define QEMU_ARCH QEMU_ARCH_I386
 #elif defined(TARGET_LM32)
 #define QEMU_ARCH QEMU_ARCH_LM32
+#elif defined(TARGET_M68K)
+#define QEMU_ARCH QEMU_ARCH_M68K
 #elif defined(TARGET_MICROBLAZE)
 #define QEMU_ARCH QEMU_ARCH_MICROBLAZE
 #elif defined(TARGET_MIPS)
@@ -80,12 +80,12 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_SH4
 #elif defined(TARGET_SPARC)
 #define QEMU_ARCH QEMU_ARCH_SPARC
-#elif defined(TARGET_XTENSA)
-#define QEMU_ARCH QEMU_ARCH_XTENSA
-#elif defined(TARGET_UNICORE32)
-#define QEMU_ARCH QEMU_ARCH_UNICORE32
 #elif defined(TARGET_TRICORE)
 #define QEMU_ARCH QEMU_ARCH_TRICORE
+#elif defined(TARGET_UNICORE32)
+#define QEMU_ARCH QEMU_ARCH_UNICORE32
+#elif defined(TARGET_XTENSA)
+#define QEMU_ARCH QEMU_ARCH_XTENSA
 #endif
 
 const uint32_t arch_type = QEMU_ARCH;
-- 
MST
