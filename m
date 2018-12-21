Received: from eggs.gnu.org ([2001:4830:134:3::10]:52811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gaNH3-0001K4-Lo
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gaNH2-00044V-Ro
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:03:41 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835]:35673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gaNH2-00043v-Mr
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:03:40 -0500
Received: by mail-qt1-x835.google.com with SMTP id v11so6210490qtc.2
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 08:03:40 -0800 (PST)
Date: Fri, 21 Dec 2018 08:02:57 -0800
Message-Id: <20181221160307.14819-5-palmer@sifive.com>
In-Reply-To: <20181221160307.14819-1-palmer@sifive.com>
References: <20181221160307.14819-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 04/14] riscv: Enable VGA and PCIE_VGA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Enable compile support for VGA devices. This allows the user to conenct
a display by adding '-device bochs-display -display sdl' to their
command line argument.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 default-configs/riscv32-softmmu.mak | 3 +++
 default-configs/riscv64-softmmu.mak | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index c5ea36cba597..dbc93982848a 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -8,3 +8,6 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_CADENCE=y
 
 CONFIG_PCI_GENERIC=y
+
+CONFIG_VGA=y
+CONFIG_VGA_PCI=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index c5ea36cba597..dbc93982848a 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -8,3 +8,6 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_CADENCE=y
 
 CONFIG_PCI_GENERIC=y
+
+CONFIG_VGA=y
+CONFIG_VGA_PCI=y
-- 
2.18.1
