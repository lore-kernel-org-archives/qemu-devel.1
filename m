Received: from eggs.gnu.org ([2001:4830:134:3::10]:58414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV3Fh-0007zp-Ip
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 18:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV3Fe-00019i-Eh
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 18:03:29 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35163
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV3Fe-00019Y-7o
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 18:03:26 -0400
References: <1499413442-5053-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170711182954-mutt-send-email-mst@kernel.org>
	<1fc46dca-4fc5-a7cd-986e-1e11a64642f3@redhat.com>
	<20170711185430-mutt-send-email-mst@kernel.org>
	<ccfb0a73-d094-11a5-c89e-cee1689fe19e@ilande.co.uk>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <cb04a803-9f9d-67df-5131-4b33c59afd9d@ilande.co.uk>
Date: Tue, 11 Jul 2017 23:03:17 +0100
MIME-Version: 1.0
In-Reply-To: <ccfb0a73-d094-11a5-c89e-cee1689fe19e@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] pci: allow PCI bus slots to be marked
 as reserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On 11/07/17 18:59, Mark Cave-Ayland wrote:

> On 11/07/17 16:57, Michael S. Tsirkin wrote:
> 
>> On Tue, Jul 11, 2017 at 06:51:50PM +0300, Marcel Apfelbaum wrote:
>>> On 11/07/2017 18:31, Michael S. Tsirkin wrote:
>>>> On Fri, Jul 07, 2017 at 08:43:59AM +0100, Mark Cave-Ayland wrote:
>>>>> For some machines it is impossible to plug devices into a particular PCI bus
>>>>> slot, e.g. for a real Ultra 5 there are 2 PCI bridges attached to the root
>>>>> bus behind which all devices must be plugged. Ignoring this rule will cause
>>>>> problems with interrupt routing since the interrupt numbers are calculated
>>>>> based upon PCI bridge id and secondary PCI bus slot id.
>>>>>
>>>>> This patchset adds a new dev_reserved_mask property to PCIBus which is a
>>>>> bitmask used to indicate whether PCI bus slots are reserved, i.e. they cannot
>>>>> be used for hot or cold plugging on a particular PCI bus.
>>>>>
>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>
>>>
>>> Hi Michael,
>>>
>>>> Could you please point me at series making use of this
>>>> functionality?
>>>
>>> There is a discussion upstream, I am not aware of patches yet.
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00771.html
>>>
>>> Thanks,
>>> Marcel
>>
>> It is probably a good idea to defer merging this patchset
>> until there's an agreement on how it will be used.
> 
> I have a local patchset that uses it, but it has been held up by the
> on-going issues with the fw_cfg patchset upon which it is also dependent.
> 
> I will try and find some time this evening to rebase the patchset and
> send it out as I am aware that freeze is coming up soon.

You can see the use of this feature in patch 8 of my sun4u patchset
here:
https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg03041.html.


ATB,

Mark.
