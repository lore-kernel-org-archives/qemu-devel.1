Received: from eggs.gnu.org ([2001:4830:134:3::10]:58227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fuXsg-00041d-8F
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 02:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fuXsY-0002YR-Ez
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 02:53:37 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fuXsW-0002Wr-Ed
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 02:53:30 -0400
Received: by mail-wm0-x234.google.com with SMTP id n11-v6so721960wmc.2
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 23:53:28 -0700 (PDT)
References: <1533793434-7614-1-git-send-email-whois.zihan.yang@gmail.com>
	<ece2a3ff-678d-00b6-3fd6-660972c5beca@gmail.com>
	<20180827070406.t525gr43qpu7wpsj@sirius.home.kraxel.org>
	<CAKwiv-gyGoqEpmpicxo_a3cQBsb0-XoT9cqkJu5WOtkUtAx0eQ@mail.gmail.com>
	<5f5dc082-7053-d6b9-b01f-fffba1847ba5@gmail.com>
	<20180828060752.mmsd7x7uobqm2gsr@sirius.home.kraxel.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <8b232ca6-4643-24c7-d93d-589a452d0785@gmail.com>
Date: Tue, 28 Aug 2018 09:53:24 +0300
MIME-Version: 1.0
In-Reply-To: <20180828060752.mmsd7x7uobqm2gsr@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, seabios@seabios.org

Hi Gerd,

On 08/28/2018 09:07 AM, Gerd Hoffmann wrote:
>    Hi,
>
>> Since we will not use all 256 buses of an extra PCI domain,
>> I think this space will allow us to support more PCI domains.
> Depends on the use case I guess.  If you just need many pcie devices
> this probably doesn't help.  If you want them for numa support then yes,
> more domains with less devices each can be useful then.

We already support multiple NUMA nodes. We want more devices.
Still, having 4x number of devices we previously supported is
a good step forward.

>
>> How will the flow look like ?
>>
>> 1. QEMU passes to SeaBIOS information of how many extra
>>     PCI domains needs, and how many buses per domain.
>>     How it will pass this info? A vendor specific capability,
>>     some PCI registers or modifying extra-pci-roots fw_cfg file?
> Where is the pxb-pcie device?  0000:$somewhere?  Or $domain:00:00.0?

  0000:$somewhere (On PCI domain 0)



>> 2. SeaBIOS assigns the address for each PCI Domain

>>   and
>>      returns the information to QEMU.
>>      How it will do that? Some pxb-pcie registers? Or do we model
>>      the MMCFG like a PCI BAR?
> If we can access pxb-pcie registers before configuring MMCFG then yes,
> we should use pxb-pcie registers for that.

Yes, we can.

Thanks Gerd!
Marcel

>
> cheers,
>    Gerd
>
