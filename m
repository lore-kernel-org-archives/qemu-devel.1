Received: from eggs.gnu.org ([2001:4830:134:3::10]:49064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcSsb-0006ZA-J2
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcSsW-0004D9-3N
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:50:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcSsV-0004BR-SQ
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:50:12 -0400
Date: Tue, 1 Aug 2017 09:50:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170801085001.GB2079@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-11-git-send-email-peterx@redhat.com>
	<20170731185224.GB3095@work-vm>
	<20170801031303.GE15697@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170801031303.GE15697@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC 10/29] migration: new property
 "x-postcopy-fast"
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
> On Mon, Jul 31, 2017 at 07:52:24PM +0100, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > This provides a way to start postcopy ASAP when migration starts. To do
> > > this, we need both:
> > > 
> > >   -global migration.x-postcopy-ram=on \
> > >   -global migration.x-postcopy-fast=on
> > 
> > Can you explain why this is necessary?  Both sides already know
> > they're doing a postcopy recovery don't they?
> 
> What I wanted to do here is to provide a way to start postcopy at the
> very beginning (actually it'll possibly start postcopy at the first
> loop in migration_thread), instead of start postcopy until we trigger
> it using "migrate_start_postcopy" command.
> 
> I used it for easier debugging (so I don't need to type
> "migrate_start_postcopy" every time when I trigger postcopy
> migration), meanwhile I think it can also be used when someone really
> want to start postcopy from the very beginning.
> 
> Would such a new parameter makes sense?

Other than debugging, I don't think there's a real use for it; the
slight delay between starting migration and triggering postcopy has
very little cost.

Dave

> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
