Received: from eggs.gnu.org ([208.118.235.92]:49515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtk9-0003nj-As
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtk6-0006Ma-2q
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:01 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:41887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtk5-0006La-TV
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:55:58 -0500
Received: by mail-pl1-x629.google.com with SMTP id u6so6800669plm.8
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:55:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:54:49 +1100
Message-Id: <20181225205529.10874-3-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 02/42] linux-user: Add host dependency for
 RISC-V 32-bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Michael Clark <mjc@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <76f8f9383a766dbcade883e897dec8cfef669799.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/host/riscv32/hostdep.h | 11 +++++++++++
 MAINTAINERS                       |  1 +
 2 files changed, 12 insertions(+)
 create mode 100644 linux-user/host/riscv32/hostdep.h

diff --git a/linux-user/host/riscv32/hostdep.h b/linux-user/host/riscv32/hostdep.h
new file mode 100644
index 0000000000..adf9edbf2d
--- /dev/null
+++ b/linux-user/host/riscv32/hostdep.h
@@ -0,0 +1,11 @@
+/*
+ * hostdep.h : things which are dependent on the host architecture
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef RISCV32_HOSTDEP_H
+#define RISCV32_HOSTDEP_H
+
+#endif
diff --git a/MAINTAINERS b/MAINTAINERS
index 180695f5d3..067629b10e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -266,6 +266,7 @@ S: Maintained
 F: target/riscv/
 F: hw/riscv/
 F: include/hw/riscv/
+F: linux-user/host/riscv32/
 F: disas/riscv.c
 
 S390
-- 
2.17.2
