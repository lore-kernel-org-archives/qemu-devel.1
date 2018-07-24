Received: from eggs.gnu.org ([2001:4830:134:3::10]:48246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fhvhn-00019I-Ap
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fhvhj-0003AK-Dm
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:42:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51532 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fhvhj-0003AC-7l
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:42:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E696401EF05
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 11:42:10 +0000 (UTC)
Date: Tue, 24 Jul 2018 12:42:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180724114205.GB2374@work-vm>
References: <20180723123305.24792-1-peterx@redhat.com>
	<20180723123305.24792-5-peterx@redhat.com>
	<87y3e1f0jf.fsf@secure.mitica> <20180724113654.GB2479@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724113654.GB2479@xz-mi>
Subject: Re: [Qemu-devel] [PATCH for-3.0 4/4] tests: torture release-ram in
 postcopy test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Peter Xu (peterx@redhat.com) wrote:
> On Tue, Jul 24, 2018 at 11:25:24AM +0200, Juan Quintela wrote:
> > Peter Xu <peterx@redhat.com> wrote:
> > > The release-ram capability will run some extra code for postcopy to
> > > release used ram right away, let's just turn that on for the postcopy
> > > unix test always to torture that code path too to make sure release-ram
> > > feature won't break again.  The recovery test needs to turn that off
> > > since release-ram cannot coop with that.
> > >
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > 
> > Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> Thanks.
> 
> > 
> > But I think that the proper thing to do here is to have two tests.  One
> > for postcopy and another for postcopy + release-ram.
> 
> Yeah I thought about it too, but I am not sure whether it'll worth it
> to have a separate test for the release-ram feature (basically that's
> some extra seconds for every unit test, even on relatively fast CPUs).
> I did it this way since IMHO release-ram is mostly adding extra code
> path to the postcopy logic, hence we should not miss much (or any) of
> the old test path.  Ideally we should still cover all the postcopy
> code path that we want to test.

It's worth being a bit careful, since I'm not sure if release-ram has
ever been tested on hosts with larger page size; my suspicion is you
might get a spew of errors on Power.

Dave

> Regards,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
