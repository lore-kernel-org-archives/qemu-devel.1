Received: from eggs.gnu.org ([2001:4830:134:3::10]:43460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHck-0001XS-4K
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHch-0005KG-77
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:15:18 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:14:48 +0300
Message-Id: <787bbc306e2770c73f9fd9d3a209d26af191e352.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/22] misc,
 ide: remove use of HWADDR_PRIx in trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The trace events all use a uint64_t data type, so should be using the
corresponding PRIx64 format, not HWADDR_PRIx which is intended for use
with the 'hwaddr' type.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/ide/trace-events  | 4 ++--
 hw/misc/trace-events | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 0c39cabe72..5c0e59ec42 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -108,8 +108,8 @@ ahci_dma_prepare_buf_fail(void *s, int port) "ahci(%p=
)[%d]: sglist population fa
 ahci_dma_rw_buf(void *s, int port, int l) "ahci(%p)[%d] len=3D0x%x"
 ahci_cmd_done(void *s, int port) "ahci(%p)[%d]: cmd done"
 ahci_reset(void *s) "ahci(%p): HBA reset"
-allwinner_ahci_mem_read(void *s, void *a, uint64_t addr, uint64_t val, u=
nsigned size) "ahci(%p): read a=3D%p addr=3D0x%"HWADDR_PRIx" val=3D0x%"PR=
Ix64", size=3D%d"
-allwinner_ahci_mem_write(void *s, void *a, uint64_t addr, uint64_t val, =
unsigned size) "ahci(%p): write a=3D%p addr=3D0x%"HWADDR_PRIx" val=3D0x%"=
PRIx64", size=3D%d"
+allwinner_ahci_mem_read(void *s, void *a, uint64_t addr, uint64_t val, u=
nsigned size) "ahci(%p): read a=3D%p addr=3D0x%"PRIx64" val=3D0x%"PRIx64"=
, size=3D%d"
+allwinner_ahci_mem_write(void *s, void *a, uint64_t addr, uint64_t val, =
unsigned size) "ahci(%p): write a=3D%p addr=3D0x%"PRIx64" val=3D0x%"PRIx6=
4", size=3D%d"
=20
 # Warning: Verbose
 handle_reg_h2d_fis_dump(void *s, int port, const char *fis) "ahci(%p)[%d=
]: %s"
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 562d9ed005..ec5a9f0da1 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -69,13 +69,13 @@ mps2_fpgaio_reset(void) "MPS2 FPGAIO: reset"
 mps2_fpgaio_leds(char led1, char led0) "MPS2 FPGAIO LEDs: %c%c"
=20
 # hw/misc/msf2-sysreg.c
-msf2_sysreg_write(uint64_t offset, uint32_t val, uint32_t prev) "msf2-sy=
sreg write: addr 0x%08" HWADDR_PRIx " data 0x%" PRIx32 " prev 0x%" PRIx32
-msf2_sysreg_read(uint64_t offset, uint32_t val) "msf2-sysreg read: addr =
0x%08" HWADDR_PRIx " data 0x%08" PRIx32
+msf2_sysreg_write(uint64_t offset, uint32_t val, uint32_t prev) "msf2-sy=
sreg write: addr 0x%08" PRIx64 " data 0x%" PRIx32 " prev 0x%" PRIx32
+msf2_sysreg_read(uint64_t offset, uint32_t val) "msf2-sysreg read: addr =
0x%08" PRIx64 " data 0x%08" PRIx32
 msf2_sysreg_write_pll_status(void) "Invalid write to read only PLL statu=
s register"
=20
 #hw/misc/imx7_gpr.c
-imx7_gpr_read(uint64_t offset) "addr 0x%08" HWADDR_PRIx
-imx7_gpr_write(uint64_t offset, uint64_t value) "addr 0x%08" HWADDR_PRIx=
 "value 0x%08" HWADDR_PRIx
+imx7_gpr_read(uint64_t offset) "addr 0x%08" PRIx64
+imx7_gpr_write(uint64_t offset, uint64_t value) "addr 0x%08" PRIx64 "val=
ue 0x%08" PRIx64
=20
 # hw/misc/mos6522.c
 mos6522_set_counter(int index, unsigned int val) "T%d.counter=3D%d"
--=20
2.11.0
