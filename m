Received: from eggs.gnu.org ([2001:4830:134:3::10]:40479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ebqPs-00011I-69
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:18:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ebqPo-000587-0o
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:18:20 -0500
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-10-andrew.smirnov@gmail.com>
	<CAFEAcA-hEgWp58nte89Vs6nZnp4wA6_f8-Vaovm2hiJe9SWwHQ@mail.gmail.com>
	<b9661e65-5fb2-46b5-b082-6e768afff7bc@zoho.com>
	<CAHQ1cqFknfW0NmiD-3GFJRedgVE-9bacKhm-pYx0ycviRsmucQ@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <d060a7d9-b87e-df81-d601-f4cd538a0a88@redhat.com>
Date: Wed, 17 Jan 2018 18:17:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqFknfW0NmiD-3GFJRedgVE-9bacKhm-pYx0ycviRsmucQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/14] pci: Add support for Designware
 IP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 17/01/2018 18:12, Andrey Smirnov wrote:
> On Wed, Jan 17, 2018 at 7:23 AM, Marcel Apfelbaum
> <marcel.apfelbaum@zoho.com> wrote:
>>
>> Hi Peter,
>>
>>
>> On 16/01/2018 16:34, Peter Maydell wrote:
>>>
>>> On 16 January 2018 at 01:37, Andrey Smirnov <andrew.smirnov@gmail.com=
>
>>> wrote:
>>>>
>>>> Add code needed to get a functional PCI subsytem when using in
>>>> conjunction with upstream Linux guest (4.13+). Tested to work agains=
t
>>>> "e1000e" (network adapter, using MSI interrupts) as well as
>>>> "usb-ehci" (USB controller, using legacy PCI interrupts).
>>>>
>>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> Cc: qemu-devel@nongnu.org
>>>> Cc: qemu-arm@nongnu.org
>>>> Cc: yurovsky@gmail.com
>>>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>>>> ---
>>>>    default-configs/arm-softmmu.mak  |   2 +
>>>>    hw/pci-host/Makefile.objs        |   2 +
>>>>    hw/pci-host/designware.c         | 618
>>>> +++++++++++++++++++++++++++++++++++++++
>>>>    include/hw/pci-host/designware.h |  93 ++++++
>>>>    include/hw/pci/pci_ids.h         |   2 +
>>>>    5 files changed, 717 insertions(+)
>>>>    create mode 100644 hw/pci-host/designware.c
>>>>    create mode 100644 include/hw/pci-host/designware.h
>>>
>>> I'm not familiar enough with our PCI code to be able to review
>>> this, I'm afraid. MST and Marcel are our PCI subsystem maintainers --
>>> could one of you have a look at whether this seems to be a correct
>>> implementation of a pcie host controller ?
>>
>>
>> Sadly PCI Host bridges do not have a standard, each HW vendor
>> can do pretty much what they want.
>>
>> That being said, if Andrey can point me to the PCI spec for the Design=
ware
>> PCI host bridge and what parts they implemented for it I can have a lo=
ok,
>> sure.
>> (I will not be available for a week or so, but right after)
>>
>=20
> Just in case you still want this:
>=20
> To the best of my knowledge, Synposys does not provide specification
> for their PCIe IP to general public and I am in no way affiliated with
> them, so I don't have any backchannels to get it any other way.
>=20
> The next best thing to an actual spec, that I found to be pretty
> useful, is PCIe chapter of i.MX6Q Reference Manual
> (https://www.nxp.com/docs/en/reference-manual/IMX6DQRM.pdf   page
> 4049), which is what I used to implement the code in question.
>=20

Appreciated.

> Last, and probably the most important, "source of truth" was actual
> Linux PCIe driver for i.MX/Designware which I used as a sort of
> inverse reference implementation.
>=20

We did the same for our PVRDMA device implementation :)


Thanks,
Marcel

> Thanks,
> Andrey Smirnov
>=20
