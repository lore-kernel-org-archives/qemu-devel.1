Received: from eggs.gnu.org ([2001:4830:134:3::10]:58096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fbOQE-0007aB-FP
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fbOQB-0002n0-BI
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:57:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40894 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fbOQB-0002la-5n
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:57:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53AB54078098
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:57:02 +0000 (UTC)
Date: Fri, 6 Jul 2018 11:56:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180706105658.GB2661@work-vm>
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180706091716.GA9761@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706091716.GA9761@work-vm>
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/9] migration: postcopy recovery
 unit test, bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Based-on: <20180627132246.5576-1-peterx@redhat.com>
> > 
> > Based on the series to unbreak postcopy:
> >   Subject: [PATCH v3 0/4] migation: unbreak postcopy recovery
> >   Message-Id: <20180627132246.5576-1-peterx@redhat.com>
> > 
> > This series introduce a new postcopy recovery test.  The new test
> > actually helped me to identify two bugs there so fix them as well
> > before 3.0 release.
> > 
> > Patch 1: a trivial cleanup for existing postcopy ram load, which I
> >          found a bit confusing during debugging the problem.
> > 
> > Patch 2-3: two bug fixes that address different issues.  Please see
> >            the commit log for more information.
> > 
> > Patch 4-9: add the postcopy recovery unit test.
> > 
> > Please review.  Thanks,
> 
> Queued

Hi Peter,
  There's a problem in there somewhere;  I'm getting
an intermittent failure of the test if I run a make check -j 8    on my
laptop.  Just running two copies of tests/migration-test in parallel
sometimes triggers it (but not if I turn on QTEST_LOG!).
But it's always failing with:

  ERROR:/home/dgilbert/git/migpull/tests/migration-test.c:373:migrate_recover: assertion failed: (qdict_haskey(rsp, "return"))

Dave

> > Peter Xu (9):
> >   migration: simplify check to use qemu file buffer
> >   migration: loosen recovery check when load vm
> >   migration: fix incorrect bitmap size calculation
> >   tests: introduce migrate_postcopy_* helpers
> >   tests: allow migrate() to take extra flags
> >   tests: introduce migrate_query*() helpers
> >   tests: introduce wait_for_migration_status()
> >   tests: add postcopy recovery test
> >   tests: hide stderr for postcopy recovery test
> > 
> >  migration/ram.c        |  21 +++--
> >  migration/savevm.c     |  16 ++--
> >  tests/migration-test.c | 198 ++++++++++++++++++++++++++++++++---------
> >  3 files changed, 176 insertions(+), 59 deletions(-)
> > 
> > -- 
> > 2.17.1
> > 
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
