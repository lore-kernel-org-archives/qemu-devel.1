Received: from eggs.gnu.org ([2001:4830:134:3::10]:60611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz6af-0001DY-0o
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz6aa-0000bM-Ma
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:41:21 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz6aa-0000aa-GK
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:41:16 -0400
Received: by mail-qk0-x244.google.com with SMTP id z12so1380573qkb.0
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 12:41:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506037164.git.alistair.francis@xilinx.com>
	<CAKmqyKOo_TJ=9GbYMdCAuEW6kKh8_5bjz9_8f3Ggc85OwWpd+A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1aef9623-b4ee-867b-e495-4a3ebdd4064a@amsat.org>
Date: Mon, 2 Oct 2017 16:41:11 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOo_TJ=9GbYMdCAuEW6kKh8_5bjz9_8f3Ggc85OwWpd+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 0/2] Add a valid_cpu_types property
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Hi Alistair,

On 10/02/2017 03:42 PM, Alistair Francis wrote:
> On Thu, Sep 21, 2017 at 4:41 PM, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> There are numorous QEMU machines that only have a single or a handful of
>> valid CPU options. To simplyfy the management of specificying which CPU
>> is/isn't valid let's create a property that can be set in the machine
>> init. We can then check to see if the user supplied CPU is in that list
>> or not.
>>
>> Here is what specifying the CPUs looks like now:
>>
>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m3" -S
>> QEMU 2.10.50 monitor - type 'help' for more information
>> (qemu) info cpus
>> * CPU #0: thread_id=24175
>> (qemu) q
>>
>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m4" -S
>> QEMU 2.10.50 monitor - type 'help' for more information
>> (qemu) q
>>
>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m5" -S
>> qemu-system-aarch64: unable to find CPU model 'cortex-m5'
>>
>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-a9" -S
>> qemu-system-aarch64: Invalid CPU: cortex-a9-arm-cpu
>> The valid options are: cortex-m3-arm-cpu, cortex-m4-arm-cpu
>>
> 
> Any comments on this?

No negative comment, so far so good!

> 
> Otherwise I'll prepare a patch series and start adding support for
> more machines.

Yes please, I'm waiting your work get merged to continue some SoC 
cleanups/improvements.

> 
> Thanks,
> Alistair
> 
>> RFC v2:
>>   - Rebase on Igor's work
>>   - Use more QEMUisms inside the code
>>   - List the supported machines in a NULL terminated array
>>
>> Alistair Francis (2):
>>    machine: Add a valid_cpu_types property
>>    netduino2: Specify the valid CPUs
>>
>>   hw/arm/netduino2.c  | 10 +++++++++-
>>   hw/core/machine.c   | 35 +++++++++++++++++++++++++++++++++++
>>   include/hw/boards.h |  1 +
>>   3 files changed, 45 insertions(+), 1 deletion(-)
>>
>> --
>> 2.11.0
>>
> 
