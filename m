Received: from eggs.gnu.org ([2001:4830:134:3::10]:39271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQld-00080j-D1
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQlZ-0000Qx-A3
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:46:49 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 8 Dec 2018 00:46:39 +0000
Message-ID: <6e77872f033be3d16c60161a260c75bb8b0368df.1544229872.git.alistair.francis@wdc.com>
References: <cover.1544229872.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544229872.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v3 03/24] linux-user: Add host dependency for
 RISC-V 64-bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                       |  1 +
 linux-user/host/riscv64/hostdep.h | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 linux-user/host/riscv64/hostdep.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 97071bcdf4..ddfeb32c6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -263,6 +263,7 @@ F: target/riscv/
 F: hw/riscv/
 F: include/hw/riscv/
 F: linux-user/host/riscv32/
+F: linux-user/host/riscv64/
 F: disas/riscv.c
=20
 S390
diff --git a/linux-user/host/riscv64/hostdep.h b/linux-user/host/riscv64/ho=
stdep.h
new file mode 100644
index 0000000000..28467ba00b
--- /dev/null
+++ b/linux-user/host/riscv64/hostdep.h
@@ -0,0 +1,11 @@
+/*
+ * hostdep.h : things which are dependent on the host architecture
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef RISCV64_HOSTDEP_H
+#define RISCV64_HOSTDEP_H
+
+#endif
--=20
2.19.1
