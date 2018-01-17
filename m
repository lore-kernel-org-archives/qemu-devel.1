Received: from eggs.gnu.org ([2001:4830:134:3::10]:44082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@zoho.com>) id 1ebpZe-00023d-0B
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@zoho.com>) id 1ebpZY-0006Rm-2d
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:24:22 -0500
Reply-To: marcel@redhat.com
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-10-andrew.smirnov@gmail.com>
	<CAFEAcA-hEgWp58nte89Vs6nZnp4wA6_f8-Vaovm2hiJe9SWwHQ@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@zoho.com>
Message-ID: <b9661e65-5fb2-46b5-b082-6e768afff7bc@zoho.com>
Date: Wed, 17 Jan 2018 17:23:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-hEgWp58nte89Vs6nZnp4wA6_f8-Vaovm2hiJe9SWwHQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Andrey Yurovsky <yurovsky@gmail.com>


Hi Peter,

On 16/01/2018 16:34, Peter Maydell wrote:
> On 16 January 2018 at 01:37, Andrey Smirnov <andrew.smirnov@gmail.com> =
wrote:
>> Add code needed to get a functional PCI subsytem when using in
>> conjunction with upstream Linux guest (4.13+). Tested to work against
>> "e1000e" (network adapter, using MSI interrupts) as well as
>> "usb-ehci" (USB controller, using legacy PCI interrupts).
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>   default-configs/arm-softmmu.mak  |   2 +
>>   hw/pci-host/Makefile.objs        |   2 +
>>   hw/pci-host/designware.c         | 618 +++++++++++++++++++++++++++++=
++++++++++
>>   include/hw/pci-host/designware.h |  93 ++++++
>>   include/hw/pci/pci_ids.h         |   2 +
>>   5 files changed, 717 insertions(+)
>>   create mode 100644 hw/pci-host/designware.c
>>   create mode 100644 include/hw/pci-host/designware.h
> I'm not familiar enough with our PCI code to be able to review
> this, I'm afraid. MST and Marcel are our PCI subsystem maintainers --
> could one of you have a look at whether this seems to be a correct
> implementation of a pcie host controller ?

Sadly PCI Host bridges do not have a standard, each HW vendor
can do pretty much what they want.

That being said, if Andrey can point me to the PCI spec for the Designwar=
e
PCI host bridge and what parts they implemented for it I can have a look,=
 sure.
(I will not be available for a week or so, but right after)

Thanks,
Marcel
> I did notice it seems to be missing device state save/load support.
>
> thanks
> -- PMM
>
