Received: from eggs.gnu.org ([2001:4830:134:3::10]:46877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dVxnK-0006oV-FN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dVxnG-0004y0-Fm
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:25:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dVxnG-0004x0-8W
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:25:54 -0400
References: <1499809473-28481-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<6d3baced-070b-908a-95b0-7784e2f0ca4e@ilande.co.uk>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <2f0d3ed6-5aa3-851e-3e9f-c08532ca1120@redhat.com>
Date: Fri, 14 Jul 2017 13:25:46 +0300
MIME-Version: 1.0
In-Reply-To: <6d3baced-070b-908a-95b0-7784e2f0ca4e@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 0/2] pci: allow PCI bus slots to be
 marked as reserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com

On 14/07/2017 12:59, Mark Cave-Ayland wrote:
> On 11/07/17 22:44, Mark Cave-Ayland wrote:
> 
>> For some machines it is impossible to plug devices into a particular PCI bus
>> slot, e.g. for a real Ultra 5 there are 2 PCI bridges attached to the root
>> bus behind which all devices must be plugged. Ignoring this rule will cause
>> problems with interrupt routing since the interrupt numbers are calculated
>> based upon PCI bridge id and secondary PCI bus slot id.
>>
>> This patchset adds a new slot_reserved_mask property to PCIBus which is a
>> bitmask used to indicate whether PCI bus slots are reserved, i.e. they cannot
>> be used for hot or cold plugging on a particular PCI bus.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>
>> v2:
>> - Rename dev_reserved_mask to slot_reserved_mask as suggested by Marcel
>> - Squash patches 2 and 3 together
>>
>>
>> Mark Cave-Ayland (2):
>>    pci: move check for existing devfn into new pci_bus_devfn_available()
>>      helper
>>    pci: add reserved slot check to do_pci_register_device()
>>
>>   hw/pci/pci.c             |   34 ++++++++++++++++++++++++++++++----
>>   include/hw/pci/pci_bus.h |    1 +
>>   2 files changed, 31 insertions(+), 4 deletions(-)
> 
> Ping? Any further feedback on the v2 version? My latest set of sun4u
> patches is dependent upon this patchset and it's freeze coming up next week!
> 

Hi,

As in prev version, other than the minor comment
on replacing "if (...) return true; else return false"
with the actual value, I am OK with it.

I believe Michael asked to see the series using this feature,
can you add a link to it, or post it with the dependency on this one?

Thanks,
Marcel

> 
> ATB,
> 
> Mark.
> 
