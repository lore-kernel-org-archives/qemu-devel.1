Received: from eggs.gnu.org ([208.118.235.92]:49533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtkD-0003s2-Rj
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtkD-0006Vc-4C
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:05 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:37247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtkC-0006Ut-VF
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:05 -0500
Received: by mail-pf1-x431.google.com with SMTP id y126so7080629pfb.4
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:56:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:54:50 +1100
Message-Id: <20181225205529.10874-4-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 03/42] linux-user: Add host dependency for
 RISC-V 64-bit
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
Message-Id: <9d777f619840a8dd8e4f3834dcfc3bd28e052ccd.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/host/riscv64/hostdep.h | 11 +++++++++++
 MAINTAINERS                       |  1 +
 2 files changed, 12 insertions(+)
 create mode 100644 linux-user/host/riscv64/hostdep.h

diff --git a/linux-user/host/riscv64/hostdep.h b/linux-user/host/riscv64/hostdep.h
new file mode 100644
index 0000000000..28467ba00b
--- /dev/null
+++ b/linux-user/host/riscv64/hostdep.h
@@ -0,0 +1,11 @@
+/*
+ * hostdep.h : things which are dependent on the host architecture
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef RISCV64_HOSTDEP_H
+#define RISCV64_HOSTDEP_H
+
+#endif
diff --git a/MAINTAINERS b/MAINTAINERS
index 067629b10e..7a4cf30a04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -267,6 +267,7 @@ F: target/riscv/
 F: hw/riscv/
 F: include/hw/riscv/
 F: linux-user/host/riscv32/
+F: linux-user/host/riscv64/
 F: disas/riscv.c
 
 S390
-- 
2.17.2
