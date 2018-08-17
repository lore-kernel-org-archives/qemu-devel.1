Received: from eggs.gnu.org ([2001:4830:134:3::10]:52837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMe-0004nF-Fm
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMY-0007bO-3e
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:31 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45268 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqfMX-0007Xx-JW
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:25 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 17 Aug 2018 16:03:42 +0200
Message-Id: <1534514633-13725-55-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v10 54/65] linux-user: Add target_elf.h header
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Dimitrije Nikolic <dnikolic@wavecomp.com>

This header includes common elf header, and adds cpu_get_model()
function.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/nanomips/target_elf.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 linux-user/nanomips/target_elf.h

diff --git a/linux-user/nanomips/target_elf.h b/linux-user/nanomips/target_elf.h
new file mode 100644
index 0000000..ca68dab
--- /dev/null
+++ b/linux-user/nanomips/target_elf.h
@@ -0,0 +1,14 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef NANOMIPS_TARGET_ELF_H
+#define NANOMIPS_TARGET_ELF_H
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    return "I7200";
+}
+#endif
-- 
2.7.4
