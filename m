Received: from eggs.gnu.org ([2001:4830:134:3::10]:39842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkB5P-0007fd-9g
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkB5L-0004qn-RN
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:31:55 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49997 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkB5L-0004qI-Jl
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:31:51 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:12:39 +0200
Message-Id: <1532967169-22265-67-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 66/76] linux-user: Add target_fcntl.h header
 for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Add fcntl-related constants and structures for nanoMIPS.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/nanomips/target_fcntl.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 linux-user/nanomips/target_fcntl.h

diff --git a/linux-user/nanomips/target_fcntl.h b/linux-user/nanomips/target_fcntl.h
new file mode 100644
index 0000000..4203825
--- /dev/null
+++ b/linux-user/nanomips/target_fcntl.h
@@ -0,0 +1,38 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef NANOMIPS_TARGET_FCNTL_H
+#define NANOMIPS_TARGET_FCNTL_H
+
+#define TARGET_O_APPEND         0x000400
+#define TARGET_O_DSYNC          0x001000
+#define TARGET_O_NONBLOCK       0x000800
+#define TARGET_O_CREAT          0x000040
+#define TARGET_O_TRUNC          0x000200
+#define TARGET_O_EXCL           0x000080
+#define TARGET_O_NOCTTY         0x000100
+#define TARGET_FASYNC           0x002000
+#define TARGET_O_LARGEFILE      0x008000
+#define TARGET___O_SYNC         0x101000
+#define TARGET_O_DIRECT         0x004000
+#define TARGET_O_CLOEXEC        0x080000
+
+#define TARGET_F_GETLK         5
+#define TARGET_F_SETLK         6
+#define TARGET_F_SETLKW        7
+#define TARGET_F_SETOWN        8       /*  for sockets. */
+#define TARGET_F_GETOWN        9       /*  for sockets. */
+
+#define TARGET_ARCH_FLOCK_PAD abi_long pad[4];
+#define TARGET_ARCH_FLOCK64_PAD
+
+#define TARGET_F_GETLK64       12      /*  using 'struct flock64' */
+#define TARGET_F_SETLK64       13
+#define TARGET_F_SETLKW64      14
+
+#include "../generic/fcntl.h"
+#endif
-- 
2.7.4
