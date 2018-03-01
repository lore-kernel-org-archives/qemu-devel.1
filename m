Received: from eggs.gnu.org ([2001:4830:134:3::10]:34628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQgS-0006vr-AQ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQgO-0006M8-BK
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:03:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53240 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1erQgO-0006Lx-75
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:03:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C97B480AD238
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 16:03:47 +0000 (UTC)
Date: Thu, 1 Mar 2018 16:03:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180301160344.GU14643@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301084438.13594-5-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/15] migration: let incoming side use
 thread context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Thu, Mar 01, 2018 at 04:44:27PM +0800, Peter Xu wrote:
> The old incoming migration is running in main thread and default
> gcontext.  With the new qio_channel_add_watch_full() we can now let it
> run in the thread's own gcontext (if there is one).
> 
> Currently this patch does nothing alone.  But when any of the incoming
> migration is run in another iothread (e.g., the upcoming migrate-recover
> command), this patch will bind the incoming logic to the iothread
> instead of the main thread (which may already get page faulted and
> hanged).
> 
> RDMA is not considered for now since it's not even using the QIO watch
> framework at all.
> 
> CC: Juan Quintela <quintela@redhat.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/exec.c   |  9 ++++-----
>  migration/fd.c     |  9 ++++-----
>  migration/socket.c | 10 +++++-----
>  3 files changed, 13 insertions(+), 15 deletions(-)

This should probably just be in a separate series, since it does nothing
on its own, and nothing following in this series touches migration at all.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
