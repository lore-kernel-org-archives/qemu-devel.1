Received: from eggs.gnu.org ([209.51.188.92]:45657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gi1Ch-0008QO-Ib
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gi1Cg-0002gK-33
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:06:47 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:38342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gi1Cf-0002fL-Ps
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:06:45 -0500
Received: by mail-pf1-x42c.google.com with SMTP id q1so7304254pfi.5
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 10:06:45 -0800 (PST)
Date: Fri, 11 Jan 2019 10:06:30 -0800
Message-Id: <20190111180630.6433-5-palmer@sifive.com>
In-Reply-To: <20190111180630.6433-1-palmer@sifive.com>
References: <20190111180630.6433-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 4/4] default-configs: Enable USB support for
 RISC-V machines
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 default-configs/riscv32-softmmu.mak | 1 +
 default-configs/riscv64-softmmu.mak | 1 +
 2 files changed, 2 insertions(+)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index dbc93982848a..c9c59714093f 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -1,6 +1,7 @@
 # Default configuration for riscv-softmmu
 
 include pci.mak
+include usb.mak
 
 CONFIG_SERIAL=y
 CONFIG_VIRTIO_MMIO=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index dbc93982848a..c9c59714093f 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -1,6 +1,7 @@
 # Default configuration for riscv-softmmu
 
 include pci.mak
+include usb.mak
 
 CONFIG_SERIAL=y
 CONFIG_VIRTIO_MMIO=y
-- 
2.18.1
