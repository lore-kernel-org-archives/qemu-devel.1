Received: from eggs.gnu.org ([2001:4830:134:3::10]:39345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKoSZ-0005cj-0O
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKoSU-00059u-1F
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:46:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKoST-000585-SG
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:46:37 -0500
Date: Fri, 1 Dec 2017 17:37:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171201093717.GF2712@xz-mi>
References: <20171108060130.3772-1-peterx@redhat.com>
	<20171108060130.3772-17-peterx@redhat.com>
	<20171130172147.GF3952@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171130172147.GF3952@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4 16/32] migration: new message
 MIG_RP_MSG_RECV_BITMAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Nov 30, 2017 at 05:21:48PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Introducing new return path message MIG_RP_MSG_RECV_BITMAP to send
> > received bitmap of ramblock back to source.
> > 
> > This is the reply message of MIG_CMD_RECV_BITMAP, it contains not only
> > the header (including the ramblock name), and it was appended with the
> > whole ramblock received bitmap on the destination side.
> > 
> > When the source receives such a reply message (MIG_RP_MSG_RECV_BITMAP),
> > it parses it, convert it to the dirty bitmap by inverting the bits.
> > 
> > One thing to mention is that, when we send the recv bitmap, we are doing
> > these things in extra:
> > 
> > - converting the bitmap to little endian, to support when hosts are
> >   using different endianess on src/dst.
> > 
> > - do proper alignment for 8 bytes, to support when hosts are using
> >   different word size (32/64 bits) on src/dst.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> (The comment on the receive side 'Add addings' is a bit odd!
> The send side is much better); other than that:
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Ouch.  It was meant to be "Add paddings". :)

I'll keep the r-b, though, with the fix.  Thanks,

> > +    /* Add addings */
> > +    le_bitmap = bitmap_new(nbits + BITS_PER_LONG);

-- 
Peter Xu
