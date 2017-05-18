Received: from eggs.gnu.org ([2001:4830:134:3::10]:42586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBGUF-0002pE-Jx
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBGUA-00019e-JJ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:08:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dBGUA-00019Y-Dh
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:08:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66B4D7F4A5
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 08:08:37 +0000 (UTC)
Date: Thu, 18 May 2017 09:08:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170518080833.GA2079@work-vm>
References: <20170517165810.18164-1-dgilbert@redhat.com>
	<20170517165810.18164-3-dgilbert@redhat.com>
	<87bmqrb7ui.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmqrb7ui.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH 2/2] postcopy: Require RAMBlocks that are
 whole pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, lvivier@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > It turns out that it's legal to create a VM with RAMBlocks that aren't
> > a multiple of the pagesize in use; e.g. a 1025M main memory using
> > 2M host pages.  That breaks postcopy's atomic placement of pages,
> > so disallow it.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks

> >      }
> >  
> >      /* We don't support postcopy with shared RAM yet */
> > -    if (qemu_ram_foreach_block(test_range_shared, NULL)) {
> > +    if (qemu_ram_foreach_block(test_ramblock_postcopiable, NULL)) {
> 
> When I was looking at this code, I still don't know why
> qemu_ram_foreach_block() don't pass the block directly.  It needs it
> almost all callers.
> 
> When I saw it I was about to change it, but got sidetracked on other
> things :-p

I think originally it passed very little information at all, and
that RAMBlocks were these mystical things no one outside exec.c
was really supposed to know about.

Dave

> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
