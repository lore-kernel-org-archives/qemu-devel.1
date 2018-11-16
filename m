Received: from eggs.gnu.org ([2001:4830:134:3::10]:59598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gNlhd-0000Ge-7O
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gNlha-0001f3-7S
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:31:01 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:40583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gNlha-0001ej-1f
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:30:58 -0500
Received: by mail-pl1-x62e.google.com with SMTP id b22-v6so6273515pls.7
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 13:30:57 -0800 (PST)
Date: Fri, 16 Nov 2018 13:30:41 -0800
Message-Id: <20181116213045.19825-2-palmer@sifive.com>
In-Reply-To: <20181116213045.19825-1-palmer@sifive.com>
References: <20181116213045.19825-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 1/4] hw/riscv/virt: Free the test device tree
 node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4a137a503c8a..2b38f890702c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -240,6 +240,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[VIRT_TEST].base,
         0x0, memmap[VIRT_TEST].size);
+    g_free(nodename);
 
     nodename = g_strdup_printf("/uart@%lx",
         (long)memmap[VIRT_UART0].base);
-- 
2.18.1
