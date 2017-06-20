Received: from eggs.gnu.org ([2001:4830:134:3::10]:32890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dNQSa-0003Ki-OJ
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dNQSZ-0006vo-MU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:13:16 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:32955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dNQSZ-0006vQ-Fx
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:13:15 -0400
Received: by mail-wr0-x241.google.com with SMTP id x23so20768611wrb.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 14:13:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOxmtN_L5hCn7_pZ8nkPuOvv4aC2OmSvNZ4T28-gXdebw@mail.gmail.com>
References: <1497973886-26257-1-git-send-email-edgar.iglesias@gmail.com>
	<1497973886-26257-2-git-send-email-edgar.iglesias@gmail.com>
	<CAKmqyKOxmtN_L5hCn7_pZ8nkPuOvv4aC2OmSvNZ4T28-gXdebw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Jun 2017 14:12:43 -0700
Message-ID: <CAKmqyKNsteSgGe=GkYipMNp6ttis3Ky5ThyCXyVakSSUssQs9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/8] target-microblaze: Correct bit
 shift for the PVR0 version field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistai@xilinx.com>

On Tue, Jun 20, 2017 at 2:09 PM, Alistair Francis <alistair23@gmail.com> wrote:
> On Tue, Jun 20, 2017 at 8:51 AM, Edgar E. Iglesias
> <edgar.iglesias@gmail.com> wrote:
>> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>>
>> Correct bit shift for the PVR0 version field.
>>
>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> ---
>>  target/microblaze/cpu.c | 2 +-
>>  target/microblaze/cpu.h | 2 ++
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
>> index 3d58869..af70faa 100644
>> --- a/target/microblaze/cpu.c
>> +++ b/target/microblaze/cpu.c
>> @@ -182,7 +182,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>>                          (cpu->cfg.use_fpu ? PVR0_USE_FPU_MASK : 0) |
>>                          (cpu->cfg.use_mmu ? PVR0_USE_MMU_MASK : 0) |
>>                          (cpu->cfg.endi ? PVR0_ENDI_MASK : 0) |
>> -                        (version_code << 16) |
>> +                        (version_code << PVR0_VERSION_SHIFT) |
>>                          (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0);
>>
>>      env->pvr.regs[2] |= (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
>> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
>> index bf6963b..68c33e8 100644
>> --- a/target/microblaze/cpu.h
>> +++ b/target/microblaze/cpu.h
>> @@ -129,6 +129,8 @@ typedef struct CPUMBState CPUMBState;
>>  #define PVR0_USER1_MASK                 0x000000FF
>>  #define PVR0_SPROT_MASK                 0x00000001
>>
>> +#define PVR0_VERSION_SHIFT              8
>> +
>
> Hey Edgar,
>
> Where do you get 8 from?
>
> Looking at: https://www.xilinx.com/support/documentation/sw_manuals/xilinx2017_2/ug984-vivado-microblaze-ref.pdf
> (page 41) 16 is correct.

Woops, got my endianess muddled up there.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair


>
> Thanks,
> Alistair
>
>>  /* User 2 PVR mask */
>>  #define PVR1_USER2_MASK                 0xFFFFFFFF
>>
>> --
>> 2.7.4
>>
>>
