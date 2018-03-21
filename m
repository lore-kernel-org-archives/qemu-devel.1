Received: from eggs.gnu.org ([2001:4830:134:3::10]:54720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyhKq-0002CQ-Jq
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyhKk-0000Ll-S6
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:15:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eyhKk-0000LO-NN
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:15:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6378B40704AD
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 17:15:30 +0000 (UTC)
Date: Wed, 21 Mar 2018 17:15:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180321171526.GG3465@work-vm>
References: <20180312183628.394722-1-eblake@redhat.com>
	<20180312183628.394722-32-eblake@redhat.com>
	<c1197340-adb8-4caa-d101-65722797e7eb@redhat.com>
	<cb901b49-e496-713d-c0a8-696fa52894fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb901b49-e496-713d-c0a8-696fa52894fe@redhat.com>
Subject: Re: [Qemu-devel] [PULL 31/36] monitor: enable IO thread for (qmp &
 !mux) typed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Eric Blake (eblake@redhat.com) wrote:
> On 03/21/2018 07:37 AM, Max Reitz wrote:
> > On 2018-03-12 19:36, Eric Blake wrote:
> > > From: Peter Xu <peterx@redhat.com>
> > > 
> > > Start to use dedicate IO thread for QMP monitors that are not using
> > > MUXed chardev.
> > > 
> > > Reviewed-by: Fam Zheng <famz@redhat.com>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > Message-Id: <20180309090006.10018-21-peterx@redhat.com>
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > ---
> > >   monitor.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > It seems the iotests aren't quite ready for this change (breakage in
> > 040, 041, 051, 060, 085, 087, 093, 095, 109, 124, 127, 132, 136, 144,
> > 148, 152, 182, 183, 185, 186; and 030 hangs).
> 
> Serves me right for not testing iotests on my qapi tree as rigoursly as I do
> on my NBD tree.  Fixing this during freeze is acceptable, although I'd like
> it if Peter Xu can take a look instead of just me.
> 
> (And still a bummer that iotests aren't being run by 'make check' or CLI to
> have caught it earlier?)

I'm guessing from those that 030 is the easiest to try and debug because
it hangs and you get a nice backtrace.  The others are a bit mysterious
(I think it's 042 which just has an f in one place in the output rather
than a .)

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
