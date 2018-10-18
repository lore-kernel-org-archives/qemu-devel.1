Received: from eggs.gnu.org ([2001:4830:134:3::10]:34880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gDAOH-0004bh-5R
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gDAOB-00016X-Ai
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:39:13 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gDAO7-00014M-J8
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:39:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id 143-v6so743203wmf.1
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 08:39:02 -0700 (PDT)
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net> <20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
	<87murdf73g.fsf_-_@dusky.pond.sub.org>
	<20181017155637.GC31060@habkost.net>
	<29ed5e33-18d5-7c86-d946-02e96b9bff68@gmail.com>
	<CAFEAcA_f1yAXLTgK6utBYG5H4woPw5UezgB8Co5aauNu2EA+wg@mail.gmail.com>
	<20181018143858.GG20424@redhat.com>
	<CAFEAcA-OyfXgU-NgcSXvUf_KEnAJQYDWAs9=FFLPt7son2W9Ag@mail.gmail.com>
	<6bdbd841-5922-c974-8232-4912a8fd9906@gmail.com>
	<CAFEAcA-bVOJGSquDd_ikSUMs41xfJuHvc_Pp++08sUq5x8O+Gg@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <8568c109-1def-101b-2056-844c97105666@gmail.com>
Date: Thu, 18 Oct 2018 18:39:54 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-bVOJGSquDd_ikSUMs41xfJuHvc_Pp++08sUq5x8O+Gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] No more chameleon devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>



On 10/18/18 5:48 PM, Peter Maydell wrote:
> On 18 October 2018 at 15:45, Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com> wrote:
>> PCIe machines support PCI devices while PCI machines do not support
>> PCIe devices.
>>
>> I think users of the PCI machines would benefit from having a clear list of
>> supported devices, rather than have to find out if their device
>>   1. Is a hybrid device - QEMU will 'make' it PCI/PCIe
>>   2. Is a PCIe device - would not work on a PCI machine
>>   3. Is a PCI device - all good
> Ah, I see. So, today, of all the devices labelled as "pci" which
> QEMU has, how many of them are in which of those categories?
> (I guess I'm mostly interested in whether what we have is
> mostly really-PCI devices with one or two PCIe devices, or
> if we're currently (mis-)modelling some PCIe devices as hybrid.)

Eduardo added 'marker' interfaces to all PCI/PCIe devices
making it easier to answer the question.

A 'hybrid' devices implements both:
    * INTERFACE_CONVENTIONAL_PCI_DEVICE
    * INTERFACE_PCIE_DEVICE
interfaces, please see the complete list:
     https://paste.fedoraproject.org/paste/vgOo7n7PKi3Wxij~5dZxQQ

The list is not complete as we cannot see devices of derived classes,
like virtio-*-pci, but is good enough.


Thanks,
Marcel

> thanks
> -- PMM
