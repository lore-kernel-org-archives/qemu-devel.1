Received: from eggs.gnu.org ([2001:4830:134:3::10]:48724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ebnqe-0005Hr-7Y
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ebnqd-0005Wl-Es
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:33:48 -0500
Date: Wed, 17 Jan 2018 14:33:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180117133336.GC3860@localhost.localdomain>
References: <1516188312-29612-1-git-send-email-pbonzini@redhat.com>
	<20180117125937.GB3860@localhost.localdomain>
	<4eea3f98-4da1-5334-690d-b92f7f1b06fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eea3f98-4da1-5334-690d-b92f7f1b06fc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Call check and invalidate_cache
 from coroutine context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 17.01.2018 um 14:15 hat Paolo Bonzini geschrieben:
> On 17/01/2018 13:59, Kevin Wolf wrote:
> > Am 17.01.2018 um 12:25 hat Paolo Bonzini geschrieben:
> >> Check and invalidate_cache share some parts of the implementation
> >> with the regular I/O path.  This is sometimes complicated because the
> >> I/O path wants to use a CoMutex but that is not possible outside coroutine
> >> context.  By moving things to coroutine context, we can remove special
> >> cases.  In fact, invalidate_cache is already called from coroutine context
> >> because incoming migration is placed in a coroutine.
> >>
> >> While at it, I'm including two patches from Stefan to rename the
> >> bdrv_create callback to bdrv_co_create, because it is already called
> >> from coroutine context.
> > I'm using .bdrv_co_create for the QAPI type based function that will be
> > used from QMP blockdev-create, so it would be good if we leave the
> > legacy function with its old name or at least choose a different new
> > name for it.
> 
> .bdrv_co_create_opts since it takes QemuOpts*?

Sounds good enough to me.

Kevin
