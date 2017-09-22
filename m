Received: from eggs.gnu.org ([2001:4830:134:3::10]:35203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dvK7A-0004Bk-24
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dvK6J-0001Bm-GI
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:19:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dvK6J-0001BG-86
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:18:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CD4A7E433
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:18:22 +0000 (UTC)
Date: Fri, 22 Sep 2017 17:18:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170922091815.GK30661@pxdev.xzpeter.org>
References: <1505975754-21555-1-git-send-email-peterx@redhat.com>
	<1505975754-21555-4-git-send-email-peterx@redhat.com>
	<f64bbc56-4f0d-7cc0-b62c-23045f33ad78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f64bbc56-4f0d-7cc0-b62c-23045f33ad78@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] chardev: use per-dev context for
 io_add_watch_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Sep 21, 2017 at 04:11:33PM +0200, Paolo Bonzini wrote:
> On 21/09/2017 08:35, Peter Xu wrote:
> > It was only passed in by chr_update_read_handlers().  However when
> > reconnect, we'll lose that context information.  So if a chardev was
> > running on another context (rather than the default context, the NULL
> > pointer), it'll switch back to the default context if reconnection
> > happens.  But, it should really stick to the old context.
> > 
> > Convert all the callers of io_add_watch_poll() to use the internally
> > cached gcontext.  Then the context should be able to survive even after
> > reconnections.
> 
> Why keep the argument then?

Yeah it's in next patch. I see that this series has been queued
already. Thanks!

-- 
Peter Xu
