Received: from eggs.gnu.org ([208.118.235.92]:47879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrD-00043c-H1
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrB-0007ow-Vy
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:34 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a]:34791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gcCrB-0007eo-MU
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:33 -0500
Received: by mail-qt1-x82a.google.com with SMTP id r14so17897162qtp.1
	for <qemu-devel@nongnu.org>; Wed, 26 Dec 2018 09:20:18 -0800 (PST)
Date: Wed, 26 Dec 2018 09:19:53 -0800
Message-Id: <20181226172005.26990-3-palmer@sifive.com>
In-Reply-To: <20181226172005.26990-1-palmer@sifive.com>
References: <20181226172005.26990-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 02/14] hw/riscv/virt: Adjust memory layout
 spacing
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/virt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2b38f890702c..6b6fa39aaa38 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -47,14 +47,14 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } virt_memmap[] = {
-    [VIRT_DEBUG] =    {        0x0,      0x100 },
-    [VIRT_MROM] =     {     0x1000,    0x11000 },
-    [VIRT_TEST] =     {   0x100000,     0x1000 },
-    [VIRT_CLINT] =    {  0x2000000,    0x10000 },
-    [VIRT_PLIC] =     {  0xc000000,  0x4000000 },
-    [VIRT_UART0] =    { 0x10000000,      0x100 },
-    [VIRT_VIRTIO] =   { 0x10001000,     0x1000 },
-    [VIRT_DRAM] =     { 0x80000000,        0x0 },
+    [VIRT_DEBUG] =       {        0x0,         0x100 },
+    [VIRT_MROM] =        {     0x1000,       0x11000 },
+    [VIRT_TEST] =        {   0x100000,        0x1000 },
+    [VIRT_CLINT] =       {  0x2000000,       0x10000 },
+    [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
+    [VIRT_UART0] =       { 0x10000000,         0x100 },
+    [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
+    [VIRT_DRAM] =        { 0x80000000,           0x0 },
 };
 
 static uint64_t load_kernel(const char *kernel_filename)
-- 
2.18.1
