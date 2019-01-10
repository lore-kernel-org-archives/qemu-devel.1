Received: from eggs.gnu.org ([209.51.188.92]:58514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=906996e92=Alistair.Francis@wdc.com>)
	id 1ghNn4-0006Pp-Eq
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 19:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=906996e92=Alistair.Francis@wdc.com>)
	id 1ghNn3-0000vQ-Nz
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 19:01:42 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 10 Jan 2019 00:01:34 +0000
Message-ID: <c162ffeb1bb1cbcdeb47ea62a829294168a0ebdf.1547078463.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 1/1] default-configs: Enable USB support for
 RISC-V machines
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
---
 default-configs/riscv32-softmmu.mak | 1 +
 default-configs/riscv64-softmmu.mak | 1 +
 2 files changed, 2 insertions(+)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-=
softmmu.mak
index dbc9398284..c9c5971409 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -1,6 +1,7 @@
 # Default configuration for riscv-softmmu
=20
 include pci.mak
+include usb.mak
=20
 CONFIG_SERIAL=3Dy
 CONFIG_VIRTIO_MMIO=3Dy
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-=
softmmu.mak
index dbc9398284..c9c5971409 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -1,6 +1,7 @@
 # Default configuration for riscv-softmmu
=20
 include pci.mak
+include usb.mak
=20
 CONFIG_SERIAL=3Dy
 CONFIG_VIRTIO_MMIO=3Dy
--=20
2.19.1
