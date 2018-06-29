Received: from eggs.gnu.org ([2001:4830:134:3::10]:42072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYnMg-0007iU-My
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYnMb-0006xO-R2
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:58:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39760 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fYnMb-0006ro-Ma
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:58:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8CD640122D6
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 06:58:30 +0000 (UTC)
Date: Fri, 29 Jun 2018 14:58:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180629065825.GD2455@xz-mi>
References: <20180627105112.31401-1-peterx@redhat.com>
	<20180627105112.31401-4-peterx@redhat.com>
	<20180627122544.GG2423@work-vm> <20180627130319.GF2516@xz-mi>
	<20180627141303.GH2423@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180627141303.GH2423@work-vm>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] migration: do explicit incoming
 setup for rdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On Wed, Jun 27, 2018 at 03:13:04PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Wed, Jun 27, 2018 at 01:25:45PM +0100, Dr. David Alan Gilbert wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > RDMA does not support postcopy recovery, so no need to go into such
> > > > logic.  Instead of calling migration_fd_process_incoming(), let's call
> > > > the two functions that setup the incoming migration.  There should have
> > > > no functional change at all.
> > > 
> > > Can you explain why we need to though?  The reason I ask is that there
> > > is Lidong Chen's work that gets postcopy partially working with RDMA, so
> > > then the next question is bound to be recovery.
> > 
> > Ah if so this patch needs to change.  Could you paste me the message
> > id of the work?  Or link?
> > 
> > After all I'll need to keep this bit, but I am just curious about what
> > is "partially" mean here. :)
> 
> https://patchwork.ozlabs.org/cover/925525/
> 
> It enables postcopy with RDMA, but once it switches into postcopy mode
> it doesn't use the fast features of RDMA, it still shuffles the data
> as a stream (using some more basic RDMA features).

Ah so it's not really partial but relatively complete, though it seems
that there can be further performance work on top.  That's an
interesting work, thanks for the pointer.

-- 
Peter Xu
