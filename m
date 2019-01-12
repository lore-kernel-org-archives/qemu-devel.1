Received: from eggs.gnu.org ([209.51.188.92]:40997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=90839a9a6=Alistair.Francis@wdc.com>)
	id 1gi7vW-0002UW-1A
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 20:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=90839a9a6=Alistair.Francis@wdc.com>)
	id 1gi7vV-00080H-62
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 20:17:30 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 12 Jan 2019 01:17:09 +0000
Message-ID: <d2ae859d3d73ec1897d78131e05a6cf6ba6c94b0.1547255794.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 1/1] riscv: Ensure the kernel start address
 is correctly cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "agraf@suse.de" <agraf@suse.de>

Cast the kernel start address to the target bit length.

This ensures that we calculate the initrd offset to a valid address for
the architecture.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Suggested-by: Alexander Graf <agraf@suse.de>
Reported-by: Alexander Graf <agraf@suse.de>
---
v2:
 - Remove old comment
 hw/riscv/sifive_e.c | 2 +-
 hw/riscv/sifive_u.c | 2 +-
 hw/riscv/spike.c    | 2 +-
 hw/riscv/virt.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 5d9d65ff29..e5d7fc548e 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -74,7 +74,7 @@ static const struct MemmapEntry {
     [SIFIVE_E_DTIM] =3D     { 0x80000000,     0x4000 }
 };
=20
-static uint64_t load_kernel(const char *kernel_filename)
+static target_ulong load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
=20
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3bd3b67507..3b3acec377 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -65,7 +65,7 @@ static const struct MemmapEntry {
=20
 #define GEM_REVISION        0x10070109
=20
-static uint64_t load_kernel(const char *kernel_filename)
+static target_ulong load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
=20
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 268df04c3c..79cb4c1282 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -53,7 +53,7 @@ static const struct MemmapEntry {
     [SPIKE_DRAM] =3D     { 0x80000000,        0x0 },
 };
=20
-static uint64_t load_kernel(const char *kernel_filename)
+static target_ulong load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
=20
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e7f0716fb6..648462b18c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -62,7 +62,7 @@ static const struct MemmapEntry {
     [VIRT_PCIE_ECAM] =3D   { 0x30000000,    0x10000000 },
 };
=20
-static uint64_t load_kernel(const char *kernel_filename)
+static target_ulong load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
=20
--=20
2.19.1
