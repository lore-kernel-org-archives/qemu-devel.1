Received: from eggs.gnu.org ([2001:4830:134:3::10]:50570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dGhRZ-00008l-Uo
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dGhRY-0001Ne-BS
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:56:26 -0400
Received: from [59.151.112.132] (port=40007 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dGhRW-0001MR-Ss
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:56:24 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 2 Jun 2017 15:54:40 +0800
Message-ID: <f7d08efd369f89e0bf6362606e4e595c03f45b36.1496387804.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1496387804.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1496387804.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 4/6] net/eepro100: Fixed code style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, armbru@redhat.com

It reports a code style problem(ERROR: "foo * bar" should be "foo *bar")
when running checkpatch.pl. So fix it to conform to the coding standards.

Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/net/eepro100.c | 62 +++++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index da36816..62e989c 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -405,7 +405,7 @@ enum scb_stat_ack {
     stat_ack_tx = (stat_ack_cu_idle | stat_ack_cu_cmd_done),
 };
 
-static void disable_interrupt(EEPRO100State * s)
+static void disable_interrupt(EEPRO100State *s)
 {
     if (s->int_stat) {
         TRACE(INT, logout("interrupt disabled\n"));
@@ -414,7 +414,7 @@ static void disable_interrupt(EEPRO100State * s)
     }
 }
 
-static void enable_interrupt(EEPRO100State * s)
+static void enable_interrupt(EEPRO100State *s)
 {
     if (!s->int_stat) {
         TRACE(INT, logout("interrupt enabled\n"));
@@ -423,7 +423,7 @@ static void enable_interrupt(EEPRO100State * s)
     }
 }
 
-static void eepro100_acknowledge(EEPRO100State * s)
+static void eepro100_acknowledge(EEPRO100State *s)
 {
     s->scb_stat &= ~s->mem[SCBAck];
     s->mem[SCBAck] = s->scb_stat;
@@ -432,7 +432,7 @@ static void eepro100_acknowledge(EEPRO100State * s)
     }
 }
 
-static void eepro100_interrupt(EEPRO100State * s, uint8_t status)
+static void eepro100_interrupt(EEPRO100State *s, uint8_t status)
 {
     uint8_t mask = ~s->mem[SCBIntmask];
     s->mem[SCBAck] |= status;
@@ -449,52 +449,52 @@ static void eepro100_interrupt(EEPRO100State * s, uint8_t status)
     }
 }
 
-static void eepro100_cx_interrupt(EEPRO100State * s)
+static void eepro100_cx_interrupt(EEPRO100State *s)
 {
     /* CU completed action command. */
     /* Transmit not ok (82557 only, not in emulation). */
     eepro100_interrupt(s, 0x80);
 }
 
-static void eepro100_cna_interrupt(EEPRO100State * s)
+static void eepro100_cna_interrupt(EEPRO100State *s)
 {
     /* CU left the active state. */
     eepro100_interrupt(s, 0x20);
 }
 
-static void eepro100_fr_interrupt(EEPRO100State * s)
+static void eepro100_fr_interrupt(EEPRO100State *s)
 {
     /* RU received a complete frame. */
     eepro100_interrupt(s, 0x40);
 }
 
-static void eepro100_rnr_interrupt(EEPRO100State * s)
+static void eepro100_rnr_interrupt(EEPRO100State *s)
 {
     /* RU is not ready. */
     eepro100_interrupt(s, 0x10);
 }
 
-static void eepro100_mdi_interrupt(EEPRO100State * s)
+static void eepro100_mdi_interrupt(EEPRO100State *s)
 {
     /* MDI completed read or write cycle. */
     eepro100_interrupt(s, 0x08);
 }
 
-static void eepro100_swi_interrupt(EEPRO100State * s)
+static void eepro100_swi_interrupt(EEPRO100State *s)
 {
     /* Software has requested an interrupt. */
     eepro100_interrupt(s, 0x04);
 }
 
 #if 0
-static void eepro100_fcp_interrupt(EEPRO100State * s)
+static void eepro100_fcp_interrupt(EEPRO100State *s)
 {
     /* Flow control pause interrupt (82558 and later). */
     eepro100_interrupt(s, 0x01);
 }
 #endif
 
-static void e100_pci_reset(EEPRO100State * s)
+static void e100_pci_reset(EEPRO100State *s)
 {
     E100PCIDeviceInfo *info = eepro100_get_class(s);
     uint32_t device = s->device;
@@ -598,7 +598,7 @@ static void e100_pci_reset(EEPRO100State * s)
 #endif /* EEPROM_SIZE > 0 */
 }
 
-static void nic_selective_reset(EEPRO100State * s)
+static void nic_selective_reset(EEPRO100State *s)
 {
     size_t i;
     uint16_t *eeprom_contents = eeprom93xx_data(s->eeprom);
@@ -669,7 +669,7 @@ static char *regname(uint32_t addr)
  ****************************************************************************/
 
 #if 0
-static uint16_t eepro100_read_command(EEPRO100State * s)
+static uint16_t eepro100_read_command(EEPRO100State *s)
 {
     uint16_t val = 0xffff;
     TRACE(OTHER, logout("val=0x%04x\n", val));
@@ -694,27 +694,27 @@ enum commands {
     CmdTxFlex = 0x0008,         /* Use "Flexible mode" for CmdTx command. */
 };
 
-static cu_state_t get_cu_state(EEPRO100State * s)
+static cu_state_t get_cu_state(EEPRO100State *s)
 {
     return ((s->mem[SCBStatus] & BITS(7, 6)) >> 6);
 }
 
-static void set_cu_state(EEPRO100State * s, cu_state_t state)
+static void set_cu_state(EEPRO100State *s, cu_state_t state)
 {
     s->mem[SCBStatus] = (s->mem[SCBStatus] & ~BITS(7, 6)) + (state << 6);
 }
 
-static ru_state_t get_ru_state(EEPRO100State * s)
+static ru_state_t get_ru_state(EEPRO100State *s)
 {
     return ((s->mem[SCBStatus] & BITS(5, 2)) >> 2);
 }
 
-static void set_ru_state(EEPRO100State * s, ru_state_t state)
+static void set_ru_state(EEPRO100State *s, ru_state_t state)
 {
     s->mem[SCBStatus] = (s->mem[SCBStatus] & ~BITS(5, 2)) + (state << 2);
 }
 
-static void dump_statistics(EEPRO100State * s)
+static void dump_statistics(EEPRO100State *s)
 {
     /* Dump statistical data. Most data is never changed by the emulation
      * and always 0, so we first just copy the whole block and then those
@@ -962,7 +962,7 @@ static void action_command(EEPRO100State *s)
     /* List is empty. Now CU is idle or suspended. */
 }
 
-static void eepro100_cu_command(EEPRO100State * s, uint8_t val)
+static void eepro100_cu_command(EEPRO100State *s, uint8_t val)
 {
     cu_state_t cu_state;
     switch (val) {
@@ -1036,7 +1036,7 @@ static void eepro100_cu_command(EEPRO100State * s, uint8_t val)
     }
 }
 
-static void eepro100_ru_command(EEPRO100State * s, uint8_t val)
+static void eepro100_ru_command(EEPRO100State *s, uint8_t val)
 {
     switch (val) {
     case RU_NOP:
@@ -1084,7 +1084,7 @@ static void eepro100_ru_command(EEPRO100State * s, uint8_t val)
     }
 }
 
-static void eepro100_write_command(EEPRO100State * s, uint8_t val)
+static void eepro100_write_command(EEPRO100State *s, uint8_t val)
 {
     eepro100_ru_command(s, val & 0x0f);
     eepro100_cu_command(s, val & 0xf0);
@@ -1106,7 +1106,7 @@ static void eepro100_write_command(EEPRO100State * s, uint8_t val)
 #define EEPROM_DI       0x04
 #define EEPROM_DO       0x08
 
-static uint16_t eepro100_read_eeprom(EEPRO100State * s)
+static uint16_t eepro100_read_eeprom(EEPRO100State *s)
 {
     uint16_t val = e100_read_reg2(s, SCBeeprom);
     if (eeprom93xx_read(s->eeprom)) {
@@ -1170,7 +1170,7 @@ static const char *reg2name(uint8_t reg)
 }
 #endif                          /* DEBUG_EEPRO100 */
 
-static uint32_t eepro100_read_mdi(EEPRO100State * s)
+static uint32_t eepro100_read_mdi(EEPRO100State *s)
 {
     uint32_t val = e100_read_reg4(s, SCBCtrlMDI);
 
@@ -1302,7 +1302,7 @@ typedef struct {
     uint32_t st_result;         /* Self Test Results */
 } eepro100_selftest_t;
 
-static uint32_t eepro100_read_port(EEPRO100State * s)
+static uint32_t eepro100_read_port(EEPRO100State *s)
 {
     return 0;
 }
@@ -1340,7 +1340,7 @@ static void eepro100_write_port(EEPRO100State *s)
  *
  ****************************************************************************/
 
-static uint8_t eepro100_read1(EEPRO100State * s, uint32_t addr)
+static uint8_t eepro100_read1(EEPRO100State *s, uint32_t addr)
 {
     uint8_t val = 0;
     if (addr <= sizeof(s->mem) - sizeof(val)) {
@@ -1393,7 +1393,7 @@ static uint8_t eepro100_read1(EEPRO100State * s, uint32_t addr)
     return val;
 }
 
-static uint16_t eepro100_read2(EEPRO100State * s, uint32_t addr)
+static uint16_t eepro100_read2(EEPRO100State *s, uint32_t addr)
 {
     uint16_t val = 0;
     if (addr <= sizeof(s->mem) - sizeof(val)) {
@@ -1421,7 +1421,7 @@ static uint16_t eepro100_read2(EEPRO100State * s, uint32_t addr)
     return val;
 }
 
-static uint32_t eepro100_read4(EEPRO100State * s, uint32_t addr)
+static uint32_t eepro100_read4(EEPRO100State *s, uint32_t addr)
 {
     uint32_t val = 0;
     if (addr <= sizeof(s->mem) - sizeof(val)) {
@@ -1453,7 +1453,7 @@ static uint32_t eepro100_read4(EEPRO100State * s, uint32_t addr)
     return val;
 }
 
-static void eepro100_write1(EEPRO100State * s, uint32_t addr, uint8_t val)
+static void eepro100_write1(EEPRO100State *s, uint32_t addr, uint8_t val)
 {
     /* SCBStatus is readonly. */
     if (addr > SCBStatus && addr <= sizeof(s->mem) - sizeof(val)) {
@@ -1519,7 +1519,7 @@ static void eepro100_write1(EEPRO100State * s, uint32_t addr, uint8_t val)
     }
 }
 
-static void eepro100_write2(EEPRO100State * s, uint32_t addr, uint16_t val)
+static void eepro100_write2(EEPRO100State *s, uint32_t addr, uint16_t val)
 {
     /* SCBStatus is readonly. */
     if (addr > SCBStatus && addr <= sizeof(s->mem) - sizeof(val)) {
@@ -1565,7 +1565,7 @@ static void eepro100_write2(EEPRO100State * s, uint32_t addr, uint16_t val)
     }
 }
 
-static void eepro100_write4(EEPRO100State * s, uint32_t addr, uint32_t val)
+static void eepro100_write4(EEPRO100State *s, uint32_t addr, uint32_t val)
 {
     if (addr <= sizeof(s->mem) - sizeof(val)) {
         e100_write_reg4(s, addr, val);
-- 
2.9.3
