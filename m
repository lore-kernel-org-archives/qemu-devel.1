Received: from eggs.gnu.org ([2001:4830:134:3::10]:35790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87679fe4f=Alistair.Francis@wdc.com>)
	id 1gWqf4-0006Hn-M6
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87679fe4f=Alistair.Francis@wdc.com>)
	id 1gWqf1-0006cS-Dc
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:37:54 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 11 Dec 2018 22:37:46 +0000
Message-ID: <d537d6d4bbe59fcb36fcab3280fdad4fbff7aa15.1544567709.git.alistair.francis@wdc.com>
References: <cover.1544567709.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544567709.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v8 4/4] riscv: Enable VGA and PCIE_VGA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "stephen@eideticom.com" <stephen@eideticom.com>, "palmer@sifive.com" <palmer@sifive.com>

Enable compile support for VGA devices. This allows the user to conenct
a display by adding '-device bochs-display -display sdl' to their
command line argument.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Andrea Bolognani <abologna@redhat.com>
---
 default-configs/riscv32-softmmu.mak | 3 +++
 default-configs/riscv64-softmmu.mak | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-=
softmmu.mak
index c5ea36cba5..dbc9398284 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -8,3 +8,6 @@ CONFIG_VIRTIO_MMIO=3Dy
 CONFIG_CADENCE=3Dy
=20
 CONFIG_PCI_GENERIC=3Dy
+
+CONFIG_VGA=3Dy
+CONFIG_VGA_PCI=3Dy
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-=
softmmu.mak
index c5ea36cba5..dbc9398284 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -8,3 +8,6 @@ CONFIG_VIRTIO_MMIO=3Dy
 CONFIG_CADENCE=3Dy
=20
 CONFIG_PCI_GENERIC=3Dy
+
+CONFIG_VGA=3Dy
+CONFIG_VGA_PCI=3Dy
--=20
2.19.1
