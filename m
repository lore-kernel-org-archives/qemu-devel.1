Received: from eggs.gnu.org ([2001:4830:134:3::10]:60835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ebadD-0004Hd-Bv
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ebadC-00025n-Eg
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:27:03 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 16 Jan 2018 15:22:20 -0800
Message-ID: <d1049a00a3c00d8310584f7732492a2064a982ae.1516144891.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1516144891.git.alistair.francis@xilinx.com>
References: <cover.1516144891.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 1/9] microblaze: boot.c: Don't try to find
 NULL pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, qemu-arm@nongnu.org

Previously if no device tree was passed to microblaze_load_kernel() then
qemu_find_file() would try to find a NULL pointer. To avoid this put a
check around qemu_find_file().

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
---

 hw/microblaze/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 457a08a2fe..35bfeda7aa 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -124,7 +124,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr =
ddr_base,
     kernel_cmdline =3D qemu_opt_get(machine_opts, "append");
     dtb_arg =3D qemu_opt_get(machine_opts, "dtb");
     /* default to pcbios dtb as passed by machine_init */
-    if (!dtb_arg) {
+    if (!dtb_arg && dtb_filename) {
         filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, dtb_filename);
     }

--
2.14.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
