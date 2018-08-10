Received: from eggs.gnu.org ([2001:4830:134:3::10]:59005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fo3k5-0003HP-IZ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fo3k2-0004VK-E3
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:29:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fo3k2-0004UZ-8t
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:29:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AD0D8197038
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 09:29:52 +0000 (UTC)
Date: Fri, 10 Aug 2018 12:29:50 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180810122918-mutt-send-email-mst@kernel.org>
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-10-quintela@redhat.com>
	<20180809190303.GF2618@work-vm>
	<20180810015411-mutt-send-email-mst@kernel.org>
	<87d0uqwu7r.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0uqwu7r.fsf@trasno.org>
Subject: Re: [Qemu-devel] [PATCH v2 09/22] virtio: Remove unneeded includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

On Fri, Aug 10, 2018 at 09:34:32AM +0200, Juan Quintela wrote:
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Aug 09, 2018 at 08:03:03PM +0100, Dr. David Alan Gilbert wrote:
> >> * Juan Quintela (quintela@redhat.com) wrote:
> >> > They are all already included in virtio_pci.h.
> >
> > All I see in virtio_pci.h is:
> >
> > #include "standard-headers/linux/types.h"
> >
> > Weird.
> >
> > BTW what's the point of this patch?  Generally it's best not to depend
> > on headers including each other, it makes refactoring harder.
> 
> If you see the following patches, we remove blk, net, serial, scsi,
> balloon and input bits from that file, so I was removing includes patch
> by patch.
> 
> And at the end, I found that we only need that ones.
> 
> "virtio-pci.h" does too many things here, I could have split it also,
> because the mayority of the bits are only used now inside their own
> virtio-foo-pci.c.  But then, there are things that share bits,
> virtio-bus-pci is used for lots of stuff, virtio-input-pci bits are used
> in virtio-input-host-pci.c, etc,   So I decided to only do the direct
> split.
> 
> And about including directly all the files that you use, and including
> only the files that are extrictly needed, the normal argument is that
> the less includes, the faster compiler times.
> 
> Later, Juan.

That's reverse of the direction we have been going.
Pls move includes when you split up the files.

-- 
MST
