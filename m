Received: from eggs.gnu.org ([2001:4830:134:3::10]:42611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d2xLA-0001qj-9g
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d2xL9-0003VR-DP
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:05:00 -0400
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOMyR+DH8F4OUgZjzeM-CmXVurwQwWKGKLOUj68jAuzqw@mail.gmail.com>
References: <1491736758-19540-1-git-send-email-sundeep.lkml@gmail.com>
	<1491736758-19540-5-git-send-email-sundeep.lkml@gmail.com>
	<CAKmqyKPAwL27-ina2X4DUJ-x_POTqRdf5HAr1mNUVYQBeUAjPQ@mail.gmail.com>
	<CALHRZuo3s-NRXPpJvfkkaf7FzNoyv2uSmox-nhycSz1x+r6fGg@mail.gmail.com>
	<CAKmqyKOMyR+DH8F4OUgZjzeM-CmXVurwQwWKGKLOUj68jAuzqw@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Tue, 25 Apr 2017 15:34:57 +0530
Message-ID: <CALHRZuqtGZDxEgBTs4NbgSed0OwPLO4ns8zC2oXwC-CFMrGj7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-devel RFC v2 4/4] msf2: Add Emcraft's
 Smartfusion2 SOM kit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Hi Alistair,

On Mon, Apr 24, 2017 at 11:23 PM, Alistair Francis <alistair23@gmail.com> wrote:
>>>
>>> Instead of calling all of these in the init function you should split
>>> it up over the machines init and realize function.
>>>
>>> Look at the stm32f205_soc or xlnx-zynqmp files for examples of how to do this.
>>>
>>> It also moves away from calling qdev_create() and qdev_init_nofail()
>>> and instead manually creates the objects.
>>>
>> I am still learning all these. Please correct me if am wrong.
>> I need to create a SoC file and a board file like stm32f205 and
>> xlnx-zynqmp now right?
>
> Hey Sundeep,
>
> I don't think you have to do it like that. I think for some
> SoCs/boards it makes sense. For example the ZynqMP SoCs are included
> on multiple different boards (EP108 and ZCU102) so it makes sense to
> have a SoC and a board separately defined. On the other hand if you
> had a SoC that is always on the same board it doesn't make as much
> sense.
>
> It is probably is a good idea to split it between a board and an SoC
> unless you have a good reason not to though.

There are multiples boards with the SoC. I will split into seperate files.

Thanks,
Sundeep
>
> Thanks,
>
> Alistair
>
>>
>>> Otherwise this patch looks pretty good.
>>
>> Thank you :)
>> Sundeep
>>
>>>
>>> Thanks,
>>>
>>> Alistair
>>>
>>>> +}
>>>> +
>>>> +static void msf2_machine_init(MachineClass *mc)
>>>> +{
>>>> +    mc->desc = "SmartFusion2 SOM kit from Emcraft";
>>>> +    mc->init = msf2_init;
>>>> +}
>>>> +
>>>> +DEFINE_MACHINE("smartfusion2-som", msf2_machine_init)
>>>> --
>>>> 2.5.0
>>>>
>>>>
