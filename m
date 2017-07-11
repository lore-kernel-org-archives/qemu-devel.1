Received: from eggs.gnu.org ([2001:4830:134:3::10]:38200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dUxSN-0001u8-KO
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dUxSK-0005en-29
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:52:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dUxSJ-0005ef-SO
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:52:08 -0400
References: <1499413442-5053-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170711182954-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <1fc46dca-4fc5-a7cd-986e-1e11a64642f3@redhat.com>
Date: Tue, 11 Jul 2017 18:51:50 +0300
MIME-Version: 1.0
In-Reply-To: <20170711182954-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On 11/07/2017 18:31, Michael S. Tsirkin wrote:
> On Fri, Jul 07, 2017 at 08:43:59AM +0100, Mark Cave-Ayland wrote:
>> For some machines it is impossible to plug devices into a particular PCI bus
>> slot, e.g. for a real Ultra 5 there are 2 PCI bridges attached to the root
>> bus behind which all devices must be plugged. Ignoring this rule will cause
>> problems with interrupt routing since the interrupt numbers are calculated
>> based upon PCI bridge id and secondary PCI bus slot id.
>>
>> This patchset adds a new dev_reserved_mask property to PCIBus which is a
>> bitmask used to indicate whether PCI bus slots are reserved, i.e. they cannot
>> be used for hot or cold plugging on a particular PCI bus.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 

Hi Michael,

> Could you please point me at series making use of this
> functionality?

There is a discussion upstream, I am not aware of patches yet.

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00771.html

Thanks,
Marcel


> Thanks!
> 
>>
>> Mark Cave-Ayland (3):
>>    pci: move check for existing devfn into new pci_bus_devfn_available()
>>      helper
>>    pci: add dev_reserved_mask property to PCIBus
>>    pci: add reserved slot check to do_pci_register_device()
>>
>>   hw/pci/pci.c             |   34 ++++++++++++++++++++++++++++++----
>>   include/hw/pci/pci_bus.h |    1 +
>>   2 files changed, 31 insertions(+), 4 deletions(-)
>>
>> -- 
>> 1.7.10.4
