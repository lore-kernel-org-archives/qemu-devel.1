Received: from eggs.gnu.org ([2001:4830:134:3::10]:38424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fG4hV-000213-5q
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fG4hS-000626-VT
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:38:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52352 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fG4hS-00061s-R7
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:38:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 517EDEB71C
	for <qemu-devel@nongnu.org>; Tue,  8 May 2018 15:38:46 +0000 (UTC)
Date: Tue, 8 May 2018 16:38:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180508153838.GQ2500@work-vm>
References: <20180425111940.1030-1-quintela@redhat.com>
	<20180425111940.1030-4-quintela@redhat.com>
	<20180503173154.GL2660@work-vm> <87sh726uvd.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sh726uvd.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v8 3/8] tests: Add migration xbzrle test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> >> +
> >> +    migrate_set_parameter(from, "xbzrle-cache-size", "33554432");
> >
> > I still worry about the cache size relative to the size of memory we're
> > actually changing in the test; I don't quite understand why it's turning
> > out to get lots of hits.
> 
> I planned this as a smorke test.  But what value do you have in mind?

Given the test code dirties 100MB of RAM, I suggest a cache of 110MB
say.  But it's interesting that the stats show we are getting a lot of
page hits; I'm not sure I understand why.

> > Also, xbzrle eats so much CPU we'll still have to watch out for the low
> > end CPUs.
> 
> Any concrete suggestion?
> 
> My plan would have been to push on my next pull request:
> 
> Add migration precopy test
> Add migration xbzrle test
> Migration ppc now inlines its program
> 
> And put the rest of the patches with fixes for another review.

Go with it and lets see; if we hit problems then we can just turn that
300ms downtime limit right up.

Dave

> 
> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
