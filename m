Received: from eggs.gnu.org ([209.51.188.92]:48363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmF43-0002PP-Rt
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmEsv-0001os-Gy
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:31:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmEsv-0001nd-BD
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:31:49 -0500
Date: Wed, 23 Jan 2019 09:31:37 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190123093137.GA2193@work-vm>
References: <20190122173111.29821-1-dgilbert@redhat.com>
	<20190123081351.GB18231@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123081351.GB18231@xz-x1>
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: unegister fd handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, jemmy858585@gmail.com, quintela@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Tue, Jan 22, 2019 at 05:31:11PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Unregister the fd handler before we destroy the channel,
> > otherwise we've got a race where we might land in the
> > fd handler just as we're closing the device.
> > 
> > (The race is quite data dependent, you just have to have
> > the right set of devices for it to trigger).
> > 
> > Corresponds to RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=1666601
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> (Could the crash happened because the same fd number is re-used after
>  the RDMA channel was destroyed?  Then when the fd has an event, it'll
>  be delivered to rdma_cm_poll_handler() while the fd is not really the
>  RDMA channel handle any more)

That's an interesting thought, I'd assumed it was just a race, but being
dependent on the fd numbering would explain why it was so delicate to
reproduce it.

> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

Dave

> Regards,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
