Received: from eggs.gnu.org ([2001:4830:134:3::10]:47358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQDd-0005Xo-Rn
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQDY-0003YI-Cx
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:34:35 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 15 Nov 2018 22:34:19 +0000
Message-ID: <0f62035eb86da24f03b9980f086d6df268105986.1542321076.git.alistair.francis@wdc.com>
References: <cover.1542321076.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1542321076.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v1 03/23] linux-user: Add host dependency for
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 linux-user/host/riscv64/hostdep.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 linux-user/host/riscv64/hostdep.h

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
