Received: from eggs.gnu.org ([2001:4830:134:3::10]:47668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGZO2-0000Rx-Vq
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGZO0-0003FU-Au
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:24:46 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGZO0-0003FM-5t
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:24:44 -0400
Received: by mail-qk0-x242.google.com with SMTP id b39-v6so287501qkb.5
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 17:24:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180509060104.4458-1-f4bug@amsat.org>
	<20180509060104.4458-2-f4bug@amsat.org>
	<CAKmqyKO8BsN2P9FCOyh0=nwx+4kcPf7nz=ym=ZF6hiwxKOdXaQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c4fdaf83-bf53-a1bb-72ad-6617da1280eb@amsat.org>
Date: Wed, 9 May 2018 21:24:40 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKO8BsN2P9FCOyh0=nwx+4kcPf7nz=ym=ZF6hiwxKOdXaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] sdcard: Update the SDState
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 05/09/2018 12:42 PM, Alistair Francis wrote:
> On Tue, May 8, 2018 at 11:01 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Add more descriptive comments to keep a clear separation
>> between static property vs runtime changeable.
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/sd/sd.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 235e0518d6..5fb4787671 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -90,12 +90,15 @@ struct SDState {
>>      uint32_t card_status;
>>      uint8_t sd_status[64];
>>
>> -    /* Configurable properties */
>> +    /* Static properties */
>> +
>>      BlockBackend *blk;
>>      bool spi;
>>
>> -    uint32_t mode;    /* current card mode, one of SDCardModes */
>> -    int32_t state;    /* current card state, one of SDCardStates */
>> +    /* Runtime changeables */
>> +
>> +    uint32_t mode;    /** current card mode, one of #SDCardModes */
>> +    int32_t state;    /** current card state, one of #SDCardStates */
>>      uint32_t vhs;
>>      bool wp_switch;
>>      unsigned long *wp_groups;
>> @@ -109,8 +112,9 @@ struct SDState {
>>      uint32_t pwd_len;
>>      uint8_t function_group[6];
>>      uint8_t current_cmd;
>> -    /* True if we will handle the next command as an ACMD. Note that this does
>> -     * *not* track the APP_CMD status bit!
>> +    /**
>> +     * #True if we will handle the next command as an ACMD.
> 
> Why do we need a # here?

I used the CPUState as a documentation example, but this might not be
the correct use...

  /**
   * CPUState:
   * @running: #true if CPU is currently running (lockless).
   ...

$ git grep -Ei '#(true|false)'
include/exec/memory.h:164:         * If present, and returns #false, the
transaction is not accepted
include/qom/cpu.h:280: * @running: #true if CPU is currently running
(lockless).
include/qom/cpu.h:281: * @has_waiter: #true if a CPU is currently
waiting for the cpu_exec_end;

MemoryRegionOps does not use the double '/**' style:

    bool unaligned;
    /*
     * If present, and returns #false, the transaction is not accepted
     * by the device (and results in machine dependent behaviour such
     * as a machine check exception).
     */

Peter if you take this, feel free to drop this '#'.

> 
> Otherwise:
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

> 
> Alistair
> 
> 
>> +     * Note that this does *not* track the APP_CMD status bit!
>>       */
>>      bool expecting_acmd;
>>      uint32_t blk_written;
>> --
>> 2.17.0
>>
>>
