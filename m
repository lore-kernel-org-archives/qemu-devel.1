Received: from eggs.gnu.org ([2001:4830:134:3::10]:33451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eSHNG-00060o-Cz
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eSHNA-0006BO-HB
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:04:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:32713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eSHNA-0006Ar-4q
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:04:00 -0500
Date: Fri, 22 Dec 2017 14:47:28 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20171222064728.GA20627@sky-dev>
References: <1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
	<20171113082845.GA10932@xz-mi>
	<20171114005934.GD32308@umbus.fritz.box>
	<20171116085709.GA5072@sky-dev>
	<20171218061442.GW7753@umbus.fritz.box>
	<20171218091735.GA6002@sky-dev>
	<20171218112218.GB4786@umbus.fritz.box>
	<20171220063242.GA7070@sky-dev>
	<20171220110110.GF5981@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220110110.GF5981@umbus.fritz.box>
Subject: Re: [Qemu-devel] [RESEND PATCH 2/6] memory: introduce
 AddressSpaceOps and IOMMUObject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, alex.williamson@redhat.com, pbonzini@redhat.com

On Wed, Dec 20, 2017 at 10:01:10PM +1100, David Gibson wrote:
> On Wed, Dec 20, 2017 at 02:32:42PM +0800, Liu, Yi L wrote:
> > On Mon, Dec 18, 2017 at 10:22:18PM +1100, David Gibson wrote:
> > > On Mon, Dec 18, 2017 at 05:17:35PM +0800, Liu, Yi L wrote:
> > > > On Mon, Dec 18, 2017 at 05:14:42PM +1100, David Gibson wrote:
> > > > > On Thu, Nov 16, 2017 at 04:57:09PM +0800, Liu, Yi L wrote:
[snip]
> > > Partly.  Each PE has an address space which all devices in the PE see.
> > > Only some of that address space is mapped to system memory though,
> > > other parts are occupied by devices, others are unmapped.
> > > 
> > > Only the parts mapped by the IOMMU vary between PEs - the other parts
> > > of the address space will be identical for all PEs on the host
> > 
> > Thx, this comment addressed me well. This is different from what we have
> > on VT-d.
> 
> Really?  That's hard to believe.  I'm pretty sure the VT-d IOMMU must
> have a range < 2^64, and anything on the bus outside that range I
> expect would be common between all domains.  In particular I'd expect
> the BARs for other devices not to be remapped by the IOMMU (though
> they may be inaccessible on PCI-E due peer to peer transactions being
> blocked).  As well as things above the IOMMU's range, I'd expect the
> region for 32-bit BARs to be common between all domains.

Sorry I misunderstood you. In each IOVA space, there is reserved range
, it is the BARs MMIO range. Such reservation is to avoid un-expected
Peer-To-Peer transaction. So regards to the IOVA space, all vendors should
be similar. So you are right~

Thanks,
Yi L 
