Received: from eggs.gnu.org ([2001:4830:134:3::10]:36748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fLyyE-0006KM-IQ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fLyyD-0008To-IA
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:44:30 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fLyyD-0008TH-B4
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:44:29 -0400
Received: by mail-wm0-x242.google.com with SMTP id l1-v6so9579255wmb.2
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 15:44:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <058fbe8c-e23c-4c72-8a0c-684c01e62b94@amsat.org>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-19-git-send-email-mjc@sifive.com>
	<058fbe8c-e23c-4c72-8a0c-684c01e62b94@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 May 2018 15:43:57 -0700
Message-ID: <CAKmqyKOYhuFpsSVO0MUBuuOpnujOTOQPKxD+dFUNApDeA4Wv5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 18/30] RISC-V: Add missing free for
 plic_hart_config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Michael Clark <mjc@sifive.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, patches@groups.riscv.org

On Wed, May 23, 2018 at 5:40 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 05/22/2018 09:15 PM, Michael Clark wrote:
>> Cc: Palmer Dabbelt <palmer@sifive.com>
>> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
>> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> Cc: Alistair Francis <Alistair.Francis@wdc.com>
>> Signed-off-by: Michael Clark <mjc@sifive.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
>> ---
>>  hw/riscv/virt.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index ad03113e0f72..321fa6e8122a 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -385,6 +385,8 @@ static void riscv_virt_board_init(MachineState *mach=
ine)
>>      serial_mm_init(system_memory, memmap[VIRT_UART0].base,
>>          0, SIFIVE_PLIC(s->plic)->irqs[UART0_IRQ], 399193,
>>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
>> +
>> +    g_free(plic_hart_config);
>>  }
>>
>>  static void riscv_virt_board_machine_init(MachineClass *mc)
>>
>
