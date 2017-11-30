Received: from eggs.gnu.org ([2001:4830:134:3::10]:41067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKHpp-0007Nu-KQ
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKHpm-0003K2-JE
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:56:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKHpm-0003IR-Bk
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:56:30 -0500
Date: Thu, 30 Nov 2017 13:56:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171130055618.GA22901@xz-mi>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-4-david@gibson.dropbear.id.au>
	<abaddfae-f0f0-cbe3-93b5-b2f102290725@redhat.com>
	<20171130040248.GU3023@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171130040248.GU3023@umbus.fritz.box>
Subject: Re: [Qemu-devel] [for-2.12 3/7] pci: Fold pci_bus.h into pci.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Thu, Nov 30, 2017 at 03:02:48PM +1100, David Gibson wrote:
> On Wed, Nov 29, 2017 at 12:38:00PM +0200, Marcel Apfelbaum wrote:
> > On 29/11/2017 10:46, David Gibson wrote:
> > > include/hw/pci/pci_bus.h is now very small and can only safely be included
> > > after hw/pci/pci.h.  So, just fold it into pci.h.
> > > 
> > 
> > I don't get the benefit from merging the header files.
> > I would go the other way around and find stuff specific
> > to pci_bus and add it there, like the pci_bus_new*
> > you touched in the prev patch.
> 
> Hrm.  Except the point of the earlier patch was that those are
> actually spoecific to root buses, so would really belong in say
> pci-host.h, rather than pci-bus.h.
> 
> A log of PCI stuff deals with interaction between the device and bus
> though, so it just seemed like more trouble than it was worth to go
> disentangling them properly.
> 
> > Maybe if *all* code files requiring pci.h would automatically
> > need pci_bus.h would make sense, but I didn't check that.
> 
> Yeah, I don't think every user of pci.h needs pci_bus.h, although a
> fair few do as you can see from the diff.  Well, I guess it's up to
> Michael.  I'll be tolerably content either way - I'd say this is the
> least important patch of the series.

I would tend to keep pci_bus.h too considering that it's a separate
header file already (though I see that Linux doesn't have that
specific pci_bus.h, but everything is in pci.h).

Or, if we really want to do that, IMHO we can also consider to include
pci_bus.h directly in pci.h to avoid movement within headers.  Thanks,

-- 
Peter Xu
