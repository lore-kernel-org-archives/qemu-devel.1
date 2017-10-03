Received: from eggs.gnu.org ([2001:4830:134:3::10]:53744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzVWf-0001lb-Pl
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzVWc-0006kz-KW
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:18:53 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:51446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzVWc-0006kC-Ea
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:18:50 -0400
Received: by mail-qt0-x242.google.com with SMTP id q4so15890523qtq.8
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 15:18:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<a418ab36b8beecb9df9886b283c6bbedaf94bb68.1507059418.git.alistair.francis@xilinx.com>
	<20171003203956.GE4760@localhost.localdomain>
	<CAKmqyKN-ABwyryZvHpWHpS9Kuaqy2ZSvdDoXSku2eBskLc8EBA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a5ffa7ef-af03-7d63-5428-f78ad8a9339b@amsat.org>
Date: Tue, 3 Oct 2017 19:18:44 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKN-ABwyryZvHpWHpS9Kuaqy2ZSvdDoXSku2eBskLc8EBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 5/5] raspi: : Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 10/03/2017 06:36 PM, Alistair Francis wrote:
> On Tue, Oct 3, 2017 at 1:39 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> On Tue, Oct 03, 2017 at 01:05:18PM -0700, Alistair Francis wrote:
>>> List all possible valid CPU options.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>>> ---
>>>
>>>  hw/arm/raspi.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>>> index 5941c9f751..555db0f258 100644
>>> --- a/hw/arm/raspi.c
>>> +++ b/hw/arm/raspi.c
>>> @@ -158,6 +158,10 @@ static void raspi2_init(MachineState *machine)
>>>      setup_boot(machine, 2, machine->ram_size - vcram_size);
>>>  }
>>>
>>> +const char *raspi2_valid_cpus[] = { ARM_CPU_TYPE_NAME("cortex-a7"),
>>> +                                    NULL
>>> +                                  };
>>> +
>>>  static void raspi2_machine_init(MachineClass *mc)
>>>  {
>>>      mc->desc = "Raspberry Pi 2";
>>> @@ -169,5 +173,7 @@ static void raspi2_machine_init(MachineClass *mc)
>>>      mc->max_cpus = BCM2836_NCPUS;
>>>      mc->default_ram_size = 1024 * 1024 * 1024;
>>>      mc->ignore_memory_transaction_failures = true;
>>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
>>> +    mc->valid_cpu_types = raspi2_valid_cpus;
>>
>> I'm confused: bcm2836_init() is hardcoded to cortex-a15, not
>> cortex-a7.
> 
> Odd. I just looked up the Raspberry Pi 2 and it says a Cortex-A7:
> https://www.raspberrypi.org/products/raspberry-pi-2-model-b/

The BCM2836 SoC definitively is Cortex-A7.

git history says the A7 was added after (dcf578ed8cec) the raspi2 board
(bad5623690b1).

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Thanks,
> Alistair
> 
>>
>>>  };
>>>  DEFINE_MACHINE("raspi2", raspi2_machine_init)
>>> --
>>> 2.11.0
>>>
>>
>> --
>> Eduardo
