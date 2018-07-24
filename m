Received: from eggs.gnu.org ([2001:4830:134:3::10]:47599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhver-0007b8-GY
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhven-0001yK-Jf
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:39:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fhven-0001yD-Ea
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:39:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFB9A77888
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 11:39:08 +0000 (UTC)
Date: Tue, 24 Jul 2018 19:39:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180724113904.GC2479@xz-mi>
References: <20180723123305.24792-1-peterx@redhat.com>
	<20180723123305.24792-3-peterx@redhat.com>
	<877ellgf9w.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877ellgf9w.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH for-3.0 2/4] migration: disallow recovery
 for release-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jul 24, 2018 at 11:21:47AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > Postcopy recovery won't work well with release-ram capability since
> > release-ram will drop the page buffer as long as the page is put into
> > the send buffer.  So if there is a network failure happened, any page
> > buffers that have not yet reached the destination VM but have already
> > been sent from the source VM will be lost forever.  Let's refuse the
> > client from resuming such a postcopy migration.  Luckily release-ram was
> > designed to only be used when src and destination VMs are on the same
> > host, so it should be fine.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks.

> 
> I wonder if we should have a FAQ somewhere and point an URL to there.

Yeah we possibly should.  I have plan to write up a postcopy recovery
wiki page, maybe an addon to the old postcopy wiki page, but I haven't
yet started (especially after knowing that libvirt developers know
well about how to use it already, hence I put that a lower
priority...).

Regards,

-- 
Peter Xu
