Received: from eggs.gnu.org ([2001:4830:134:3::10]:54932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dnJN0-0008Qt-Gl
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dnJMx-0003YT-Dk
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:54:30 -0400
Received: from chuckie.co.uk ([82.165.15.123]:59199
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dnJMx-0003Xy-6M
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:54:27 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <1500236854-28271-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Message-ID: <be3aee2e-bfa0-b18c-f14f-eff2224b7d03@ilande.co.uk>
Date: Thu, 31 Aug 2017 07:54:16 +0100
MIME-Version: 1.0
In-Reply-To: <1500236854-28271-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv3 0/2] pci: allow PCI bus slots to be
 marked as reserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com, marcel@redhat.com

On 16/07/17 21:27, Mark Cave-Ayland wrote:

> For some machines it is impossible to plug devices into a particular PCI bus
> slot, e.g. for a real Ultra 5 there are 2 PCI bridges attached to the root
> bus behind which all devices must be plugged. Ignoring this rule will cause
> problems with interrupt routing since the interrupt numbers are calculated
> based upon PCI bridge id and secondary PCI bus slot id.
> 
> This patchset adds a new slot_reserved_mask property to PCIBus which is a
> bitmask used to indicate whether PCI bus slots are reserved, i.e. they cannot
> be used for hot or cold plugging on a particular PCI bus.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> v3:
> - Rebase onto master
> - Simplify pci_bus_devfn_available() as suggested by Marcel
> - Also simplify pci_bus_devfn_reserved() in a similar manner
> 
> v2:
> - Rename dev_reserved_mask to slot_reserved_mask as suggested by Marcel
> - Squash patches 2 and 3 together
> 
> 
> Mark Cave-Ayland (2):
>   pci: move check for existing devfn into new pci_bus_devfn_available()
>     helper
>   pci: add reserved slot check to do_pci_register_device()
> 
>  hw/pci/pci.c             |   26 ++++++++++++++++++++++----
>  include/hw/pci/pci_bus.h |    1 +
>  2 files changed, 23 insertions(+), 4 deletions(-)

Ping? Is there any chance to get this in soon, as I ended up having to
drop a couple of sun4u patch series for 2.10 that were dependent upon
this :(

I have R-B tags from Marcel, however my understanding is that this patch
still needs review from Michael?

Here is the link to the patch that depends upon this:
https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg03041.html


Many thanks,

Mark.
