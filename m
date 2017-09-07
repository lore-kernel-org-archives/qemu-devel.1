Received: from eggs.gnu.org ([2001:4830:134:3::10]:59795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpvfd-0006DE-3j
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpvfY-0001b7-4D
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:12:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpvfX-0001aZ-U3
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:12:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5554E5F7B2
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 12:12:26 +0000 (UTC)
Date: Thu, 7 Sep 2017 13:12:16 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170907121216.GL30609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170907084230.26493-1-famz@redhat.com>
	<20170907093731.GF2098@work-vm> <20170907113742.GC25123@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170907113742.GC25123@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH] buildsys: Move rdma libs to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

On Thu, Sep 07, 2017 at 07:37:42PM +0800, Fam Zheng wrote:
> On Thu, 09/07 10:37, Dr. David Alan Gilbert wrote:
> > * Fam Zheng (famz@redhat.com) wrote:
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > 
> > OK, I've not actually got a preference as to whether it's
> > per-object or not - I don't really see any advantage.
> 
> Thanks for the review.  You're right this probably doesn't make a difference
> except for a bit more consistency, until we want to make rdma a module (as in
> --enable-modules) like the ones in block layer. The -libs and -cflags variables
> were initially added just for that.
> 
> While we are talking about it, is there any reason why that will not be a good
> idea?  There are other libraries used by QEMU outside block layer that are
> overdue to be converted to modules, like ui (gtk, sdl, etc.), rdma seems to be a
> candidate too.

Since we have per-module flags, it makes sense to use them whereever it is
reasonable todo so. The global flags should only be needed for things which
are truely globally used, which is (almost) only glib2.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
