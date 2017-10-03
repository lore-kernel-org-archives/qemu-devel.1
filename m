Received: from eggs.gnu.org ([2001:4830:134:3::10]:42617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dzUsN-00064w-BS
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 17:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dzUsM-00027g-CV
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 17:37:15 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dzUsM-00026u-5p
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 17:37:14 -0400
Received: by mail-wr0-x241.google.com with SMTP id f12so907240wra.5
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 14:37:13 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171003203956.GE4760@localhost.localdomain>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<a418ab36b8beecb9df9886b283c6bbedaf94bb68.1507059418.git.alistair.francis@xilinx.com>
	<20171003203956.GE4760@localhost.localdomain>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 3 Oct 2017 14:36:42 -0700
Message-ID: <CAKmqyKN-ABwyryZvHpWHpS9Kuaqy2ZSvdDoXSku2eBskLc8EBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 5/5] raspi: : Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Tue, Oct 3, 2017 at 1:39 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Tue, Oct 03, 2017 at 01:05:18PM -0700, Alistair Francis wrote:
>> List all possible valid CPU options.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  hw/arm/raspi.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>> index 5941c9f751..555db0f258 100644
>> --- a/hw/arm/raspi.c
>> +++ b/hw/arm/raspi.c
>> @@ -158,6 +158,10 @@ static void raspi2_init(MachineState *machine)
>>      setup_boot(machine, 2, machine->ram_size - vcram_size);
>>  }
>>
>> +const char *raspi2_valid_cpus[] = { ARM_CPU_TYPE_NAME("cortex-a7"),
>> +                                    NULL
>> +                                  };
>> +
>>  static void raspi2_machine_init(MachineClass *mc)
>>  {
>>      mc->desc = "Raspberry Pi 2";
>> @@ -169,5 +173,7 @@ static void raspi2_machine_init(MachineClass *mc)
>>      mc->max_cpus = BCM2836_NCPUS;
>>      mc->default_ram_size = 1024 * 1024 * 1024;
>>      mc->ignore_memory_transaction_failures = true;
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
>> +    mc->valid_cpu_types = raspi2_valid_cpus;
>
> I'm confused: bcm2836_init() is hardcoded to cortex-a15, not
> cortex-a7.

Odd. I just looked up the Raspberry Pi 2 and it says a Cortex-A7:
https://www.raspberrypi.org/products/raspberry-pi-2-model-b/

Thanks,
Alistair

>
>>  };
>>  DEFINE_MACHINE("raspi2", raspi2_machine_init)
>> --
>> 2.11.0
>>
>
> --
> Eduardo
