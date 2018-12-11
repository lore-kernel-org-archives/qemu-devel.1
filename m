Received: from eggs.gnu.org ([2001:4830:134:3::10]:35717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87679fe4f=Alistair.Francis@wdc.com>)
	id 1gWqek-0005pG-St
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87679fe4f=Alistair.Francis@wdc.com>)
	id 1gWqeg-0006Nq-TS
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:37:34 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 11 Dec 2018 22:37:26 +0000
Message-ID: <8064f094368f233fe0fbdda772a33b7c07114613.1544567709.git.alistair.francis@wdc.com>
References: <cover.1544567709.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544567709.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v8 2/4] hw/riscv/virt: Adjust memory layout
 spacing
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Andrea Bolognani <abologna@redhat.com>
---
 hw/riscv/virt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2b38f89070..6b6fa39aaa 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -47,14 +47,14 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } virt_memmap[] =3D {
-    [VIRT_DEBUG] =3D    {        0x0,      0x100 },
-    [VIRT_MROM] =3D     {     0x1000,    0x11000 },
-    [VIRT_TEST] =3D     {   0x100000,     0x1000 },
-    [VIRT_CLINT] =3D    {  0x2000000,    0x10000 },
-    [VIRT_PLIC] =3D     {  0xc000000,  0x4000000 },
-    [VIRT_UART0] =3D    { 0x10000000,      0x100 },
-    [VIRT_VIRTIO] =3D   { 0x10001000,     0x1000 },
-    [VIRT_DRAM] =3D     { 0x80000000,        0x0 },
+    [VIRT_DEBUG] =3D       {        0x0,         0x100 },
+    [VIRT_MROM] =3D        {     0x1000,       0x11000 },
+    [VIRT_TEST] =3D        {   0x100000,        0x1000 },
+    [VIRT_CLINT] =3D       {  0x2000000,       0x10000 },
+    [VIRT_PLIC] =3D        {  0xc000000,     0x4000000 },
+    [VIRT_UART0] =3D       { 0x10000000,         0x100 },
+    [VIRT_VIRTIO] =3D      { 0x10001000,        0x1000 },
+    [VIRT_DRAM] =3D        { 0x80000000,           0x0 },
 };
=20
 static uint64_t load_kernel(const char *kernel_filename)
--=20
2.19.1
