Received: from eggs.gnu.org ([2001:4830:134:3::10]:57114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG8-0002ns-3D
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG7-0002ov-7G
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35306 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKG7-0002oY-19
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:19 -0400
Date: Thu, 3 May 2018 22:51:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-40-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 39/67] target: replace command line flags with
 preprocessor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

Each target is currently built with a different set of include
directories, this is what makes it possible to pull in a separate copy
of header files depending on the target.

Replace with per-target ifdefs which are easier to understand.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/target-dir.h | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 include/target-dir.h

diff --git a/include/target-dir.h b/include/target-dir.h
new file mode 100644
index 0000000..3044236
--- /dev/null
+++ b/include/target-dir.h
@@ -0,0 +1,63 @@
+/*
+ * QEMU target-specific directory macros
+ *
+ * Copyright (C) 2018 Red Hat, Inc.
+ * Author: Michael S. Tsirkin <mst@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef QEMU_TARGET_DIR_H
+#define QEMU_TARGET_DIR_H
+
+#if defined(TARGET_ALPHA)
+#define TARGET_DIR_PREFIX ../target/alpha
+#elif defined(TARGET_ARM)
+#define TARGET_DIR_PREFIX ../target/arm
+#elif defined(TARGET_CRIS)
+#define TARGET_DIR_PREFIX ../target/cris
+#elif defined(TARGET_HPPA)
+#define TARGET_DIR_PREFIX ../target/hppa
+#elif defined(TARGET_I386)
+#define TARGET_DIR_PREFIX ../target/i386
+#elif defined(TARGET_LM32)
+#define TARGET_DIR_PREFIX ../target/lm32
+#elif defined(TARGET_M68K)
+#define TARGET_DIR_PREFIX ../target/m68k
+#elif defined(TARGET_MICROBLAZE)
+#define TARGET_DIR_PREFIX ../target/microblaze
+#elif defined(TARGET_MIPS)
+#define TARGET_DIR_PREFIX ../target/mips
+#elif defined(TARGET_MOXIE)
+#define TARGET_DIR_PREFIX ../target/moxie
+#elif defined(TARGET_NIOS2)
+#define TARGET_DIR_PREFIX ../target/nios2
+#elif defined(TARGET_OPENRISC)
+#define TARGET_DIR_PREFIX ../target/openrisc
+#elif defined(TARGET_PPC)
+#define TARGET_DIR_PREFIX ../target/ppc
+#elif defined(TARGET_RISCV)
+#define TARGET_DIR_PREFIX ../target/riscv
+#elif defined(TARGET_S390X)
+#define TARGET_DIR_PREFIX ../target/s390x
+#elif defined(TARGET_SH4)
+#define TARGET_DIR_PREFIX ../target/sh4
+#elif defined(TARGET_SPARC)
+#define TARGET_DIR_PREFIX ../target/sparc
+#elif defined(TARGET_UNICORE32)
+#define TARGET_DIR_PREFIX ../target/unicore32
+#elif defined(TARGET_TILEGX)
+#define TARGET_DIR_PREFIX ../target/tilegx
+#elif defined(TARGET_TRICORE)
+#define TARGET_DIR_PREFIX ../target/tricore
+#elif defined(TARGET_XTENSA)
+#define TARGET_DIR_PREFIX ../target/xtensa
+#else
+#error "Target-specific directory include missing"
+#endif
+
+#define TARGET_DIR_HASH(file) #file
+#define TARGET_DIR_STRING(file) TARGET_DIR_HASH(file)
+#define TARGET_DIR(file) TARGET_DIR_STRING(TARGET_DIR_PREFIX/file)
+
+#endif
-- 
MST
