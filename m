Received: from eggs.gnu.org ([2001:4830:134:3::10]:37480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eJpHB-0003Xx-Tq
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eJpHA-0005ss-VF
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:26:53 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eJpHA-0005sN-Oq
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:26:52 -0500
Received: by mail-wr0-x243.google.com with SMTP id z18so1702118wrb.8
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 15:26:52 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAKmqyKMettqnEmxr2w5Z6o0Dn3gU5Pun8CbQm4VPj_0qXeO33w@mail.gmail.com>
References: <cover.1508279421.git.alistair.francis@xilinx.com>
	<CAKmqyKM4CsbVvfT5roqQOi+oVLCV=kN7mFxKeTSkiD_tBNA5Ng@mail.gmail.com>
	<CAKmqyKMettqnEmxr2w5Z6o0Dn3gU5Pun8CbQm4VPj_0qXeO33w@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 28 Nov 2017 15:26:20 -0800
Message-ID: <CAKmqyKNVxfGFLiR6iuMdSkY-bN1eJyTaN1Mw3FO9+h9ObMa_tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Tue, Nov 7, 2017 at 3:30 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Mon, Oct 23, 2017 at 12:26 AM, Alistair Francis <alistair23@gmail.com> wrote:
>> On Wed, Oct 18, 2017 at 12:31 AM, Alistair Francis
>> <alistair.francis@xilinx.com> wrote:
>>> There are numorous QEMU machines that only have a single or a handful of
>>> valid CPU options. To simplyfy the management of specificying which CPU
>>> is/isn't valid let's create a property that can be set in the machine
>>> init. We can then check to see if the user supplied CPU is in that list
>>> or not.
>>>
>>> I have added the valid_cpu_types for some ARM machines only at the
>>> moment.
>>>
>>> Here is what specifying the CPUs looks like now:
>>>
>>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m3" -S
>>> QEMU 2.10.50 monitor - type 'help' for more information
>>> (qemu) info cpus
>>> * CPU #0: thread_id=24175
>>> (qemu) q
>>>
>>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m4" -S
>>> QEMU 2.10.50 monitor - type 'help' for more information
>>> (qemu) q
>>>
>>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-m5" -S
>>> qemu-system-aarch64: unable to find CPU model 'cortex-m5'
>>>
>>> $ aarch64-softmmu/qemu-system-aarch64 -M netduino2 -kernel ./u-boot.elf -nographic -cpu "cortex-a9" -S
>>> qemu-system-aarch64: Invalid CPU type: cortex-a9-arm-cpu
>>> The valid types are: cortex-m3-arm-cpu, cortex-m4-arm-cpu
>>
>> It looks like all the patches have been reviewed now. Can this go
>> through your tree Peter?
>
> Ping!

Ping^2

Can this go through target-arm.next for 2.12?

Alistair

>
> I'm happy to send a pull request if that helps. I have a slick signed key now :)
>
> Alistair
>
>>
>> Thanks,
>> Alistair
>>
>>>
>>> V3:
>>>  - Make the varialbes static
>>> V2:
>>>  - Rebase
>>>  - Reorder patches
>>>  - Add a Raspberry Pi 2 CPU fix
>>> V1:
>>>  - Small fixes to prepare a series instead of RFC
>>>  - Add commit messages for the commits
>>>  - Expand the machine support to ARM machines
>>> RFC v2:
>>>  - Rebase on Igor's work
>>>  - Use more QEMUisms inside the code
>>>  - List the supported machines in a NULL terminated array
>>>
>>> Alistair Francis (5):
>>>   netduino2: Specify the valid CPUs
>>>   bcm2836: Use the Cortex-A7 instead of Cortex-A15
>>>   raspi: Specify the valid CPUs
>>>   xlnx-zcu102: Specify the valid CPUs
>>>   xilinx_zynq: Specify the valid CPUs
>>>
>>>  hw/arm/bcm2836.c     |  2 +-
>>>  hw/arm/netduino2.c   | 10 +++++++++-
>>>  hw/arm/raspi.c       |  7 +++++++
>>>  hw/arm/xilinx_zynq.c |  6 ++++++
>>>  hw/arm/xlnx-zcu102.c | 17 +++++++++++++++++
>>>  5 files changed, 40 insertions(+), 2 deletions(-)
>>>
>>> --
>>> 2.11.0
>>>
