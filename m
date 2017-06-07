Received: from eggs.gnu.org ([2001:4830:134:3::10]:60452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dIQxg-00034E-2J
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 22:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dIQxb-0005Hd-QD
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 22:44:44 -0400
Received: from [59.151.112.132] (port=15037 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dIQxa-0005Eq-SA
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 22:44:39 -0400
References: <cover.1496746390.git.maozy.fnst@cn.fujitsu.com>
	<8533d2df3734029324eec5b3edc546bd148dc3ef.1496746391.git.maozy.fnst@cn.fujitsu.com>
	<20170606183013-mutt-send-email-mst@kernel.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <2b29b7a1-4c8f-853b-ab85-6aa1eae1914e@cn.fujitsu.com>
Date: Wed, 7 Jun 2017 10:43:14 +0800
MIME-Version: 1.0
In-Reply-To: <20170606183013-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/7] net/eepro100: Fix code style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, armbru@redhat.com

Hi, Michael

On 06/06/2017 11:31 PM, Michael S. Tsirkin wrote:
> On Tue, Jun 06, 2017 at 07:26:29PM +0800, Mao Zhongyi wrote:
>> It reports a code style problem(ERROR: "foo * bar" should be "foo *bar")
>> when running checkpatch.pl. So fix it to conform to the coding standards.
>>
>> Cc: jasowang@redhat.com
>> Cc: armbru@redhat.com
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>
> We don't generally do this kind of drive-by coding cleanups.
> Wait until you actually make some changes to this file.
> I'm also not merging this through the pci tree, pls split this out.
>

The e100_pci_reset() in this file will be modified in the patch5. it will
reports a code style problem such as 'ERROR: "foo * bar" should be "foo *bar"'
when executing the checkpatch.pl for patch5.

Of course, I could simply modify the e100_pci_reset() to avoid this error,
but I think it's not a good idea. Since fix, all the same error should be
fixed absolutely.

So I make a separate patch to fix it, meanwhile prepare for patch5.

Thanks
Mao

>> ---
>>  hw/net/eepro100.c | 62 +++++++++++++++++++++++++++----------------------------
>>  1 file changed, 31 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
>> index da36816..62e989c 100644
>> --- a/hw/net/eepro100.c
>> +++ b/hw/net/eepro100.c
>> @@ -405,7 +405,7 @@ enum scb_stat_ack {
>>      stat_ack_tx = (stat_ack_cu_idle | stat_ack_cu_cmd_done),
>>  };
>>
>> -static void disable_interrupt(EEPRO100State * s)
>> +static void disable_interrupt(EEPRO100State *s)
>>  {
>>      if (s->int_stat) {
>>          TRACE(INT, logout("interrupt disabled\n"));
>> @@ -414,7 +414,7 @@ static void disable_interrupt(EEPRO100State * s)
>>      }
>>  }
>>
>> -static void enable_interrupt(EEPRO100State * s)
>> +static void enable_interrupt(EEPRO100State *s)
>>  {
>>      if (!s->int_stat) {
>>          TRACE(INT, logout("interrupt enabled\n"));
>> @@ -423,7 +423,7 @@ static void enable_interrupt(EEPRO100State * s)
>>      }
>>  }
>>
>> -static void eepro100_acknowledge(EEPRO100State * s)
>> +static void eepro100_acknowledge(EEPRO100State *s)
>>  {
>>      s->scb_stat &= ~s->mem[SCBAck];
>>      s->mem[SCBAck] = s->scb_stat;
>> @@ -432,7 +432,7 @@ static void eepro100_acknowledge(EEPRO100State * s)
>>      }
>>  }
>>
>> -static void eepro100_interrupt(EEPRO100State * s, uint8_t status)
>> +static void eepro100_interrupt(EEPRO100State *s, uint8_t status)
>>  {
>>      uint8_t mask = ~s->mem[SCBIntmask];
>>      s->mem[SCBAck] |= status;
>> @@ -449,52 +449,52 @@ static void eepro100_interrupt(EEPRO100State * s, uint8_t status)
>>      }
>>  }
>>
>> -static void eepro100_cx_interrupt(EEPRO100State * s)
>> +static void eepro100_cx_interrupt(EEPRO100State *s)
>>  {
>>      /* CU completed action command. */
>>      /* Transmit not ok (82557 only, not in emulation). */
>>      eepro100_interrupt(s, 0x80);
>>  }
>>
>> -static void eepro100_cna_interrupt(EEPRO100State * s)
>> +static void eepro100_cna_interrupt(EEPRO100State *s)
>>  {
>>      /* CU left the active state. */
>>      eepro100_interrupt(s, 0x20);
>>  }
>>
>> -static void eepro100_fr_interrupt(EEPRO100State * s)
>> +static void eepro100_fr_interrupt(EEPRO100State *s)
>>  {
>>      /* RU received a complete frame. */
>>      eepro100_interrupt(s, 0x40);
>>  }
>>
>> -static void eepro100_rnr_interrupt(EEPRO100State * s)
>> +static void eepro100_rnr_interrupt(EEPRO100State *s)
>>  {
>>      /* RU is not ready. */
>>      eepro100_interrupt(s, 0x10);
>>  }
>>
>> -static void eepro100_mdi_interrupt(EEPRO100State * s)
>> +static void eepro100_mdi_interrupt(EEPRO100State *s)
>>  {
>>      /* MDI completed read or write cycle. */
>>      eepro100_interrupt(s, 0x08);
>>  }
>>
>> -static void eepro100_swi_interrupt(EEPRO100State * s)
>> +static void eepro100_swi_interrupt(EEPRO100State *s)
>>  {
>>      /* Software has requested an interrupt. */
>>      eepro100_interrupt(s, 0x04);
>>  }
>>
>>  #if 0
>> -static void eepro100_fcp_interrupt(EEPRO100State * s)
>> +static void eepro100_fcp_interrupt(EEPRO100State *s)
>>  {
>>      /* Flow control pause interrupt (82558 and later). */
>>      eepro100_interrupt(s, 0x01);
>>  }
>>  #endif
>>
>> -static void e100_pci_reset(EEPRO100State * s)
>> +static void e100_pci_reset(EEPRO100State *s)
>>  {
>>      E100PCIDeviceInfo *info = eepro100_get_class(s);
>>      uint32_t device = s->device;
>> @@ -598,7 +598,7 @@ static void e100_pci_reset(EEPRO100State * s)
>>  #endif /* EEPROM_SIZE > 0 */
>>  }
>>
>> -static void nic_selective_reset(EEPRO100State * s)
>> +static void nic_selective_reset(EEPRO100State *s)
>>  {
>>      size_t i;
>>      uint16_t *eeprom_contents = eeprom93xx_data(s->eeprom);
>> @@ -669,7 +669,7 @@ static char *regname(uint32_t addr)
>>   ****************************************************************************/
>>
>>  #if 0
>> -static uint16_t eepro100_read_command(EEPRO100State * s)
>> +static uint16_t eepro100_read_command(EEPRO100State *s)
>>  {
>>      uint16_t val = 0xffff;
>>      TRACE(OTHER, logout("val=0x%04x\n", val));
>> @@ -694,27 +694,27 @@ enum commands {
>>      CmdTxFlex = 0x0008,         /* Use "Flexible mode" for CmdTx command. */
>>  };
>>
>> -static cu_state_t get_cu_state(EEPRO100State * s)
>> +static cu_state_t get_cu_state(EEPRO100State *s)
>>  {
>>      return ((s->mem[SCBStatus] & BITS(7, 6)) >> 6);
>>  }
>>
>> -static void set_cu_state(EEPRO100State * s, cu_state_t state)
>> +static void set_cu_state(EEPRO100State *s, cu_state_t state)
>>  {
>>      s->mem[SCBStatus] = (s->mem[SCBStatus] & ~BITS(7, 6)) + (state << 6);
>>  }
>>
>> -static ru_state_t get_ru_state(EEPRO100State * s)
>> +static ru_state_t get_ru_state(EEPRO100State *s)
>>  {
>>      return ((s->mem[SCBStatus] & BITS(5, 2)) >> 2);
>>  }
>>
>> -static void set_ru_state(EEPRO100State * s, ru_state_t state)
>> +static void set_ru_state(EEPRO100State *s, ru_state_t state)
>>  {
>>      s->mem[SCBStatus] = (s->mem[SCBStatus] & ~BITS(5, 2)) + (state << 2);
>>  }
>>
>> -static void dump_statistics(EEPRO100State * s)
>> +static void dump_statistics(EEPRO100State *s)
>>  {
>>      /* Dump statistical data. Most data is never changed by the emulation
>>       * and always 0, so we first just copy the whole block and then those
>> @@ -962,7 +962,7 @@ static void action_command(EEPRO100State *s)
>>      /* List is empty. Now CU is idle or suspended. */
>>  }
>>
>> -static void eepro100_cu_command(EEPRO100State * s, uint8_t val)
>> +static void eepro100_cu_command(EEPRO100State *s, uint8_t val)
>>  {
>>      cu_state_t cu_state;
>>      switch (val) {
>> @@ -1036,7 +1036,7 @@ static void eepro100_cu_command(EEPRO100State * s, uint8_t val)
>>      }
>>  }
>>
>> -static void eepro100_ru_command(EEPRO100State * s, uint8_t val)
>> +static void eepro100_ru_command(EEPRO100State *s, uint8_t val)
>>  {
>>      switch (val) {
>>      case RU_NOP:
>> @@ -1084,7 +1084,7 @@ static void eepro100_ru_command(EEPRO100State * s, uint8_t val)
>>      }
>>  }
>>
>> -static void eepro100_write_command(EEPRO100State * s, uint8_t val)
>> +static void eepro100_write_command(EEPRO100State *s, uint8_t val)
>>  {
>>      eepro100_ru_command(s, val & 0x0f);
>>      eepro100_cu_command(s, val & 0xf0);
>> @@ -1106,7 +1106,7 @@ static void eepro100_write_command(EEPRO100State * s, uint8_t val)
>>  #define EEPROM_DI       0x04
>>  #define EEPROM_DO       0x08
>>
>> -static uint16_t eepro100_read_eeprom(EEPRO100State * s)
>> +static uint16_t eepro100_read_eeprom(EEPRO100State *s)
>>  {
>>      uint16_t val = e100_read_reg2(s, SCBeeprom);
>>      if (eeprom93xx_read(s->eeprom)) {
>> @@ -1170,7 +1170,7 @@ static const char *reg2name(uint8_t reg)
>>  }
>>  #endif                          /* DEBUG_EEPRO100 */
>>
>> -static uint32_t eepro100_read_mdi(EEPRO100State * s)
>> +static uint32_t eepro100_read_mdi(EEPRO100State *s)
>>  {
>>      uint32_t val = e100_read_reg4(s, SCBCtrlMDI);
>>
>> @@ -1302,7 +1302,7 @@ typedef struct {
>>      uint32_t st_result;         /* Self Test Results */
>>  } eepro100_selftest_t;
>>
>> -static uint32_t eepro100_read_port(EEPRO100State * s)
>> +static uint32_t eepro100_read_port(EEPRO100State *s)
>>  {
>>      return 0;
>>  }
>> @@ -1340,7 +1340,7 @@ static void eepro100_write_port(EEPRO100State *s)
>>   *
>>   ****************************************************************************/
>>
>> -static uint8_t eepro100_read1(EEPRO100State * s, uint32_t addr)
>> +static uint8_t eepro100_read1(EEPRO100State *s, uint32_t addr)
>>  {
>>      uint8_t val = 0;
>>      if (addr <= sizeof(s->mem) - sizeof(val)) {
>> @@ -1393,7 +1393,7 @@ static uint8_t eepro100_read1(EEPRO100State * s, uint32_t addr)
>>      return val;
>>  }
>>
>> -static uint16_t eepro100_read2(EEPRO100State * s, uint32_t addr)
>> +static uint16_t eepro100_read2(EEPRO100State *s, uint32_t addr)
>>  {
>>      uint16_t val = 0;
>>      if (addr <= sizeof(s->mem) - sizeof(val)) {
>> @@ -1421,7 +1421,7 @@ static uint16_t eepro100_read2(EEPRO100State * s, uint32_t addr)
>>      return val;
>>  }
>>
>> -static uint32_t eepro100_read4(EEPRO100State * s, uint32_t addr)
>> +static uint32_t eepro100_read4(EEPRO100State *s, uint32_t addr)
>>  {
>>      uint32_t val = 0;
>>      if (addr <= sizeof(s->mem) - sizeof(val)) {
>> @@ -1453,7 +1453,7 @@ static uint32_t eepro100_read4(EEPRO100State * s, uint32_t addr)
>>      return val;
>>  }
>>
>> -static void eepro100_write1(EEPRO100State * s, uint32_t addr, uint8_t val)
>> +static void eepro100_write1(EEPRO100State *s, uint32_t addr, uint8_t val)
>>  {
>>      /* SCBStatus is readonly. */
>>      if (addr > SCBStatus && addr <= sizeof(s->mem) - sizeof(val)) {
>> @@ -1519,7 +1519,7 @@ static void eepro100_write1(EEPRO100State * s, uint32_t addr, uint8_t val)
>>      }
>>  }
>>
>> -static void eepro100_write2(EEPRO100State * s, uint32_t addr, uint16_t val)
>> +static void eepro100_write2(EEPRO100State *s, uint32_t addr, uint16_t val)
>>  {
>>      /* SCBStatus is readonly. */
>>      if (addr > SCBStatus && addr <= sizeof(s->mem) - sizeof(val)) {
>> @@ -1565,7 +1565,7 @@ static void eepro100_write2(EEPRO100State * s, uint32_t addr, uint16_t val)
>>      }
>>  }
>>
>> -static void eepro100_write4(EEPRO100State * s, uint32_t addr, uint32_t val)
>> +static void eepro100_write4(EEPRO100State *s, uint32_t addr, uint32_t val)
>>  {
>>      if (addr <= sizeof(s->mem) - sizeof(val)) {
>>          e100_write_reg4(s, addr, val);
>> --
>> 2.9.3
>>
>>
>>
>
>
>
