Received: from eggs.gnu.org ([2001:4830:134:3::10]:60152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddXCX-0001q4-2X
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddXCU-0003Xf-BO
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:39:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ddXCU-0003Vf-5b
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:39:14 -0400
Date: Fri, 4 Aug 2017 15:39:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170804073908.GL5561@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-26-git-send-email-peterx@redhat.com>
	<20170803113801.GG2076@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170803113801.GG2076@work-vm>
Subject: Re: [Qemu-devel] [RFC 25/29] migration: introduce
 SaveVMHandlers.resume_prepare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Aug 03, 2017 at 12:38:01PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > This is hook function to be called when a postcopy migration wants to
> > resume from a failure. For each module, it should provide its own
> > recovery logic before we switch to the postcopy-active state.
> 
> Would a change-state handler be able to do this,

We don't have such a change-state handler, do we?

> or perhaps
> the notifier chain I have in my shared memory world:
>  https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06459.html

The postcopy_notify() can do this as well. I just need a way to hook
up all the system modules for migration. In our case, it's only RAM,
but I think maybe one day we need block support. So as long as the
mechanism (either current SaveVMHandlers interface, or
postcopy_notify) can do the notification, IMHO it'll be fine.

-- 
Peter Xu
