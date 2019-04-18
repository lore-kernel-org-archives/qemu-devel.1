Received: from eggs.gnu.org ([209.51.188.92]:56075)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<BATV+2af28a5d36b01af4518d+5716+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1hH9t2-000410-6y
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<BATV+2af28a5d36b01af4518d+5716+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1hH9kV-0005m0-0u
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:18:56 -0400
Received: from bombadil.infradead.org ([2607:7c80:54:e::133]:50434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<BATV+2af28a5d36b01af4518d+5716+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1hH9kT-0005fJ-T3
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:18:54 -0400
Date: Thu, 18 Apr 2019 09:18:34 -0700
From: Christoph Hellwig <hch@infradead.org>
Message-ID: <20190418161833.GA22970@infradead.org>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-2-pagupta@redhat.com>
	<CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
	<20190412083230.GA29850@quack2.suse.cz>
	<x494l73z7th.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/6] libnvdimm: nd_region flush callback
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, Jan Kara <jack@suse.cz>, Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, KVM list <kvm@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, Ross Zwisler <zwisler@kernel.org>, Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Matthew Wilcox <willy@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Christoph Hellwig <hch@infradead.org>, Len Brown <lenb@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, "Darrick J. Wong" <darrick.wong@oracle.com>, lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Rik van Riel <riel@surriel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, david <david@fromorbit.com>, cohuck@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, kilobyte@angband.pl, yuval shaia <yuval.shaia@oracle.com>

On Thu, Apr 18, 2019 at 09:05:05AM -0700, Dan Williams wrote:
> > > I'd either add a comment about avoiding retpoline overhead here or just
> > > make ->flush == NULL mean generic_nvdimm_flush(). Just so that people don't
> > > get confused by the code.
> >
> > Isn't this premature optimization?  I really don't like adding things
> > like this without some numbers to show it's worth it.
> 
> I don't think it's premature given this optimization technique is
> already being deployed elsewhere, see:
> 
> https://lwn.net/Articles/774347/

For one this one was backed by numbers, and second after feedback
from Linux we switched to the NULL pointer check instead.
