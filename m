Received: from eggs.gnu.org ([209.51.188.92]:53443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gosi2-00043R-0U
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gosi1-0004Y5-7Z
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:27:29 -0500
Date: Wed, 30 Jan 2019 17:27:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190130172722.7ac3953e.cohuck@redhat.com>
In-Reply-To: <20190130155733.32742-1-david@redhat.com>
References: <20190130155733.32742-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/6] s390x/pci: remaining hot/un)plug
 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Pierre Morel <pmorel@linux.ibm.com>

On Wed, 30 Jan 2019 16:57:27 +0100
David Hildenbrand <david@redhat.com> wrote:

> These are all the patches that are not yet upstream (@Conny you might
> already picked some, including them for the full picture) and after

I usually keep s390-next up-to-date, so if the patches are not there, I
have not yet queued them.

> a good discussion yesterday, including a patch t get rid of the release
> timer. I ran a couple of sanity tests on this series.
> 
> #1 and #2 fix hotplugging of PCI bridges.
> #3 warns when "zpci=off"
> #4 refactors unplugging
> #5 get's rid of the release timer
> #6 processes all unplug requests on reboot
> 
> @Colin, can you review/ack? Especially Patch #4 is needed for qdev
> patches already on the list. ("[PATCH RFCv2 0/9] qdev: Hotplug handler
> chaining + virtio-pmem")
> 
> David Hildenbrand (6):
>   s390x/pci: Fix primary bus number for PCI bridges
>   s390x/pci: Fix hotplugging of PCI bridges
>   s390x/pci: Warn when adding PCI devices without the 'zpci' feature
>   s390x/pci: Introduce unplug requests and split unplug handler
>   s390x/pci: Drop release timer and replace it with a flag
>   s390x/pci: Unplug remaining requested devices on pcihost reset
> 
>  hw/s390x/s390-pci-bus.c | 233 ++++++++++++++++++++++++++--------------
>  hw/s390x/s390-pci-bus.h |   4 +-
>  2 files changed, 152 insertions(+), 85 deletions(-)
> 
