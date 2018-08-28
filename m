Received: from eggs.gnu.org ([2001:4830:134:3::10]:43212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fuhcQ-0002Tw-Ti
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 13:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fuhcK-0004EQ-5y
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 13:17:28 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fuhcJ-0004Cg-L7
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 13:17:23 -0400
Received: by mail-wm0-x243.google.com with SMTP id 207-v6so2768481wme.5
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 10:17:23 -0700 (PDT)
References: <1533793434-7614-1-git-send-email-whois.zihan.yang@gmail.com>
	<ece2a3ff-678d-00b6-3fd6-660972c5beca@gmail.com>
	<20180827070406.t525gr43qpu7wpsj@sirius.home.kraxel.org>
	<CAKwiv-gyGoqEpmpicxo_a3cQBsb0-XoT9cqkJu5WOtkUtAx0eQ@mail.gmail.com>
	<5f5dc082-7053-d6b9-b01f-fffba1847ba5@gmail.com>
	<20180828060752.mmsd7x7uobqm2gsr@sirius.home.kraxel.org>
	<8b232ca6-4643-24c7-d93d-589a452d0785@gmail.com>
	<20180828101458.pnsldezdzp6tdulp@sirius.home.kraxel.org>
	<20180828170203.GA1018@morn.lan>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <ab62fe25-77f4-23d7-74d9-accda67e7a30@gmail.com>
Date: Tue, 28 Aug 2018 20:17:19 +0300
MIME-Version: 1.0
In-Reply-To: <20180828170203.GA1018@morn.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC v2 0/3] Support multiple pci
 domains in pci_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>
Cc: seabios@seabios.org, qemu-devel@nongnu.org, Zihan Yang <whois.zihan.yang@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi Kevin,

On 08/28/2018 08:02 PM, Kevin O'Connor wrote:
> On Tue, Aug 28, 2018 at 12:14:58PM +0200, Gerd Hoffmann wrote:
>>    Hi,
>>
>>>> Where is the pxb-pcie device?  0000:$somewhere?  Or $domain:00:00.0?
>>>   0000:$somewhere (On PCI domain 0)
>> Cool, so we don't have an chicken-and-egg issue.
>>
>>>> If we can access pxb-pcie registers before configuring MMCFG then yes,
>>>> we should use pxb-pcie registers for that.
>>> Yes, we can.
>> Ok, so we can configure mmcfg as hidden pci bar, simliar to the q35
>> mmcfg.  Any configuration hints can be passed as pci vendor capability
>> (simliar to the bridge window size hints), if needed.
> Just so I understand, the proposal is to have SeaBIOS search for
> pxb-pcie devices on the main PCI bus and allocate address space for
> each.  (These devices would not be considered pci buses in the
> traditional sense.)  Then SeaBIOS will traverse that address space
> (MMCFG) and allocate BARs (both address space and io space) for the
> PCI devices found in that address space.  Finally, QEMU will take all
> those allocations and use it when generating the ACPI tables.
>
> Did I get that right?

Yes, the pxb-pcie exposes a new PCI root bus, but we want it
in a different PCI domain. This is done in order to remove the
256 PCI Express devices limitation on a PCI Express machine.

Does the plan sounds sane?

Thanks,
Marcel

>
> -Kevin
