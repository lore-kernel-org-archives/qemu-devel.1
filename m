Received: from eggs.gnu.org ([2001:4830:134:3::10]:47491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dcsnQ-0006bA-Gr
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dcsnN-0004eK-5L
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:30:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dcsnM-0004dN-O7
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:30:36 -0400
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-6-git-send-email-zuban32s@gmail.com>
	<491f77fc-974c-33dd-3974-08ab61d2c078@redhat.com>
	<CAKSfGUCTom8YBs8wOHMX_MpzDF1efB8_USb4tuW+hcAdoG2xvw@mail.gmail.com>
	<20170802003910-mutt-send-email-mst@kernel.org>
	<17a71bfc-1933-f707-2504-c9c699534cea@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <d6e97af9-9761-e192-36a1-6d2073aaf763@redhat.com>
Date: Wed, 2 Aug 2017 15:30:04 +0300
MIME-Version: 1.0
In-Reply-To: <17a71bfc-1933-f707-2504-c9c699534cea@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] docs: update documentation
 considering PCIE-PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, seabios@seabios.org, Kevin OConnor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net

On 02/08/2017 1:23, Laszlo Ersek wrote:
> On 08/01/17 23:39, Michael S. Tsirkin wrote:
>> On Wed, Aug 02, 2017 at 12:33:12AM +0300, Alexander Bezzubikov wrote:
>>> 2017-08-01 23:31 GMT+03:00 Laszlo Ersek <lersek@redhat.com>:
>>>> (Whenever my comments conflict with Michael's or Marcel's, I defer to them.)
>>>>
>>>> On 07/29/17 01:37, Aleksandr Bezzubikov wrote:
>>>>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>>>>> ---
>>>>>   docs/pcie.txt            |  46 ++++++++++--------
>>>>>   docs/pcie_pci_bridge.txt | 121 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>>   2 files changed, 147 insertions(+), 20 deletions(-)
>>>>>   create mode 100644 docs/pcie_pci_bridge.txt
>>>>>
>>>>> diff --git a/docs/pcie.txt b/docs/pcie.txt
>>>>> index 5bada24..338b50e 100644
>>>>> --- a/docs/pcie.txt
>>>>> +++ b/docs/pcie.txt
>>>>> @@ -46,7 +46,7 @@ Place only the following kinds of devices directly on the Root Complex:
>>>>>       (2) PCI Express Root Ports (ioh3420), for starting exclusively PCI Express
>>>>>           hierarchies.
>>>>>
>>>>> -    (3) DMI-PCI Bridges (i82801b11-bridge), for starting legacy PCI
>>>>> +    (3) PCIE-PCI Bridge (pcie-pci-bridge), for starting legacy PCI
>>>>>           hierarchies.
>>>>>
>>>>>       (4) Extra Root Complexes (pxb-pcie), if multiple PCI Express Root Buses
>>>>
>>>> When reviewing previous patches modifying / adding this file, I
>>>> requested that we spell out "PCI Express" every single time. I'd like to
>>>> see the same in this patch, if possible.
>>>
>>> OK, I didn't know it.
>>>
>>>>
>>>>> @@ -55,18 +55,18 @@ Place only the following kinds of devices directly on the Root Complex:
>>>>>      pcie.0 bus
>>>>>      ----------------------------------------------------------------------------
>>>>>           |                |                    |                  |
>>>>> -   -----------   ------------------   ------------------   --------------
>>>>> -   | PCI Dev |   | PCIe Root Port |   | DMI-PCI Bridge |   |  pxb-pcie  |
>>>>> -   -----------   ------------------   ------------------   --------------
>>>>> +   -----------   ------------------   -------------------   --------------
>>>>> +   | PCI Dev |   | PCIe Root Port |   | PCIE-PCI Bridge |   |  pxb-pcie  |
>>>>> +   -----------   ------------------   -------------------   --------------
>>>>>
>>>>>   2.1.1 To plug a device into pcie.0 as a Root Complex Integrated Endpoint use:
>>>>>             -device <dev>[,bus=pcie.0]
>>>>>   2.1.2 To expose a new PCI Express Root Bus use:
>>>>>             -device pxb-pcie,id=pcie.1,bus_nr=x[,numa_node=y][,addr=z]
>>>>> -      Only PCI Express Root Ports and DMI-PCI bridges can be connected
>>>>> +      Only PCI Express Root Ports, PCIE-PCI bridges and DMI-PCI bridges can be connected
>>>>
>>>> It would be nice if we could keep the flowing text wrapped to 80 chars.
>>>>
>>>> Also, here you add the "PCI Express-PCI" bridge to the list of allowed
>>>> controllers (and you keep DMI-PCI as permitted), but above DMI was
>>>> replaced. I think these should be made consistent -- we should make up
>>>> our minds if we continue to recommend the DMI-PCI bridge or not. If not,
>>>> then we should eradicate all traces of it. If we want to keep it at
>>>> least for compatibility, then it should remain as fully documented as it
>>>> is now.
>>>
>>> Now I'm beginning to think that we shouldn't keep the DMI-PCI bridge
>>> even for compatibility and may want to use a new PCIE-PCI bridge
>>> everywhere (of course, except some cases when users are
>>> sure they need exactly DMI-PCI bridge for some reason)
>>
>> Can dmi-pci support shpc? why doesn't it? For compatibility?
> 
Yes, mainly because I as far as I know the Intel device hasn't
an SHPC controller. Is may be possible to make it work
with it, but now we don't have a reason since we have PCIe_PCI bridge.

> I don't know why, but the fact that it doesn't is the reason libvirt
> settled on auto-creating a dmi-pci bridge and a pci-pci bridge under
> that for Q35. 

And hotplug doesn't work even for this configuration!
(last time I checked)

Thanks,
Marcel

The reasoning was (IIRC Laine's words correctly) that the
> dmi-pci bridge cannot receive hotplugged devices, while the pci-pci
> bridge cannot be connected to the root complex. So both were needed.
> 
> Thanks
> Laszlo
> 
