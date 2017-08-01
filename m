Received: from eggs.gnu.org ([2001:4830:134:3::10]:46865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcSiz-0004bI-U5
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcSiw-0004N4-1G
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:40:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcSiv-0004Mb-RK
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:40:17 -0400
Date: Tue, 1 Aug 2017 09:40:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170801084009.GA2079@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-5-git-send-email-peterx@redhat.com>
	<20170731171155.GE2122@work-vm>
	<20170801024319.GC15697@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170801024319.GC15697@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC 04/29] bitmap: introduce bitmap_invert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Mon, Jul 31, 2017 at 06:11:56PM +0100, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > It is used to invert the whole bitmap.
> > 
> > Would it be easier to change bitmap_complement to use ^
> > in it's macro and slow_bitmap_complement, and then you could call it
> > with src==dst  to do the same thing with just that small change?
> 
> Or, I can directly use that and drop this patch. :-)

Yes, that's fine - note the only difference I see is what happens to the
bits in the last word after the end of the count; your code leaves them
as is, the complement code will zero them on the destination I think.

Dave

> (I didn't really notice that one before)
> 
> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
