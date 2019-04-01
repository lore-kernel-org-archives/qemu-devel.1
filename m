Received: from eggs.gnu.org ([209.51.188.92]:56134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hAu8A-00025F-GR
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hAu89-0003mY-CA
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:25:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hAu89-0003jp-1I
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:25:29 -0400
Date: Mon, 1 Apr 2019 18:25:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190401102515.GD8853@xz-x1>
References: <20190324221319-mutt-send-email-mst@kernel.org>
	<AM6PR05MB66166ED74E2718150F0CBF62BD5F0@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190326085309-mutt-send-email-mst@kernel.org>
	<AM6PR05MB661611FE4DD494AF9EFB6B8ABD5F0@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190327064143.GP9149@xz-x1>
	<060498b58287775ce6bd7dd704f13b6d6e185f91.camel@oracle.com>
	<20190327084255.GR9149@xz-x1>
	<AM6PR05MB6616E9FDE038EA2B0665DD9CBD540@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190401024710.GB8853@xz-x1>
	<AM6PR05MB6616E9F5EE3B3B531266B73DBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR05MB6616E9F5EE3B3B531266B73DBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
Subject: Re: [Qemu-devel] QEMU and vIOMMU support for emulated VF
 passthrough to nested (L2) VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Elijah Shakkour <elijahsh@mellanox.com>
Cc: Knut Omang <knut.omang@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, Apr 01, 2019 at 09:12:38AM +0000, Elijah Shakkour wrote:
> 
> 
> > -----Original Message-----
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Monday, April 1, 2019 5:47 AM
> > To: Elijah Shakkour <elijahsh@mellanox.com>
> > Cc: Knut Omang <knut.omang@oracle.com>; Michael S. Tsirkin
> > <mst@redhat.com>; Alex Williamson <alex.williamson@redhat.com>;
> > Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Stefan Hajnoczi
> > <stefanha@gmail.com>; qemu-devel@nongnu.org
> > Subject: Re: QEMU and vIOMMU support for emulated VF passthrough to
> > nested (L2) VM
> > 
> > On Sun, Mar 31, 2019 at 11:15:00AM +0000, Elijah Shakkour wrote:
> > 
> > [...]
> > 
> > > I didn't have DMA nor MMIO read/write working with my old command
> > line.
> > > But, when I removed all CPU flags and only provided "-cpu host", I see that
> > MMIO works.
> > > Still, DMA read/write from emulated device doesn't work for VF. For
> > example:
> > > Driver provides me a buffer pointer through MMIO write, this address
> > (pointer) is GPA of L2, and when I try to call pci_dma_read() with this address
> > I get:
> > > "
> > > Unassigned mem read 0000000000000000
> > > "
> > 
> > I don't know where this error log was dumped but if it's during DMA then I
> > agree it can probably be related to vIOMMU.
> > 
> 
> This log is dumped from:
> memory.c: unassigned_mem_read()
> 
> > > As I said, my problem now is in translation of L2 GPA provided by driver,
> > when I call DMA read/write for this address from VF.
> > > Any insights?
> > 
> > I just noticed that you were using QEMU 2.12 [1].  If that's the case, please
> > rebase to the latest QEMU, at least >=3.0 because there's major refactor of
> > the shadow logic during 3.0 devel cycle AFAICT.
> > 
> 
> Rebased to QEMU 3.1
> Now I see the address I'm trying to read from in log but still same error:
> "
> Unassigned mem read 00000000f0481000
> "
> What do you suggest?

Would you please answer the questions that Knut asked?  Is it working
for L1 guest?  How about PF?

You can also try to enable VT-d device log by appending:

  -trace enable="vtd_*"

In case it dumps anything useful for you.

-- 
Peter Xu
