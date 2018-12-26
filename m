Received: from eggs.gnu.org ([208.118.235.92]:47805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrB-00040l-F0
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrA-0007nh-JC
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:33 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833]:36336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gcCr2-0007hJ-FN
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:27 -0500
Received: by mail-qt1-x833.google.com with SMTP id t13so17843971qtn.3
	for <qemu-devel@nongnu.org>; Wed, 26 Dec 2018 09:20:21 -0800 (PST)
Date: Wed, 26 Dec 2018 09:19:55 -0800
Message-Id: <20181226172005.26990-5-palmer@sifive.com>
In-Reply-To: <20181226172005.26990-1-palmer@sifive.com>
References: <20181226172005.26990-1-palmer@sifive.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

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
