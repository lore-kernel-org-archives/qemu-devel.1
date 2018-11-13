Received: from eggs.gnu.org ([2001:4830:134:3::10]:51418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gMiSv-0003T6-6P
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gMiSr-0006aY-5k
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:51:28 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:44479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gMiSp-0006Xe-8h
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:51:24 -0500
Received: by mail-pf1-x435.google.com with SMTP id b81-v6so6389062pfe.11
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 15:51:19 -0800 (PST)
Date: Tue, 13 Nov 2018 15:50:42 -0800
Message-Id: <20181113235045.14155-2-palmer@sifive.com>
In-Reply-To: <20181113235045.14155-1-palmer@sifive.com>
References: <20181113235045.14155-1-palmer@sifive.com>
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
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

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
