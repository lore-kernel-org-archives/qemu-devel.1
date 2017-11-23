Received: from eggs.gnu.org ([2001:4830:134:3::10]:56587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHvOn-0001qb-Gd
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHvOk-0002WP-Mx
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:34:53 -0500
Date: Thu, 23 Nov 2017 18:34:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171123173442.GE4375@localhost.localdomain>
References: <c4532ef7-6e05-d14a-21de-1b8381aa2112@redhat.com>
	<1511456107-7081-1-git-send-email-deepa.srinivasan@oracle.com>
	<3DFDA265-8685-4601-B981-1BB0007C44B4@oracle.com>
	<20171123172927.GD4375@localhost.localdomain>
	<b9092b47-2cb0-283f-afb5-a9a447f11012@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9092b47-2cb0-283f-afb5-a9a447f11012@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Fix qemu crash when using scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Deepa Srinivasan <deepa.srinivasan@oracle.com>, stefanha@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mark.kanda@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Am 23.11.2017 um 18:31 hat Paolo Bonzini geschrieben:
> On 23/11/2017 18:29, Kevin Wolf wrote:
> >> Note that a similar issue exists in
> >> blk_ioctl()/blk_ioctl_entry()/blk_prw() where blk_prw() always creates
> >> the QEMUIOVector even if blk_ioctl()/blk_ioctl_entry() does not need a
> >> QEMUIOVector. This will need to be fixed separately to keep it
> >> consistent with the AIO path.
> > 
> > I don't think there is an actual problem in the blk_ioctl() path because
> > the iov on the stack stays valid as long as the coroutine runs. AIO is
> > different because it returns before the coroutine has terminated.
> 
> I agree, it's just code that is slightly ugly.

Slightly. Neither void pointers nor code duplication make it less ugly,
though. So in this case, I'd say: If it ain't broke, don't fix it.

Kevin
