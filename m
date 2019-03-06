Received: from eggs.gnu.org ([209.51.188.92]:45625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h1V66-0005ZP-9d
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:52:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h1V65-0003hS-IO
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:52:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h1V64-0003g2-HG
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:52:28 -0500
Date: Wed, 6 Mar 2019 19:44:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190306114420.GC32434@xz-x1>
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190306101958.GK22159@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306101958.GK22159@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/4] iothread: create gcontext
 unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Mar 06, 2019 at 10:19:59AM +0000, Stefan Hajnoczi wrote:
> On Fri, Feb 22, 2019 at 11:14:09AM +0800, Peter Xu wrote:
> > Comments welcomed.  Thanks,
> > 
> > Peter Xu (4):
> >   iothread: replace init_done_cond with a semaphore
> >   iothread: create the gcontext onconditionally
> >   iothread: create main loop unconditionally
> >   iothread: push gcontext earlier in the thread_fn
> 
> What is the status of this series?  Will you send another revision?

I'll add some comment to patch 4 and repost, probably with another
patch to document why we can't drop aio_poll in iothread_run.

Regards,

-- 
Peter Xu
