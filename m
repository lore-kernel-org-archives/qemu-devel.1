Received: from eggs.gnu.org ([2001:4830:134:3::10]:46899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhvcn-0006I8-W6
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhvci-0001FC-4j
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:37:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48262 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fhvch-0001Ez-QN
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:36:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 109AC81A4EA7
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 11:36:59 +0000 (UTC)
Date: Tue, 24 Jul 2018 19:36:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180724113654.GB2479@xz-mi>
References: <20180723123305.24792-1-peterx@redhat.com>
	<20180723123305.24792-5-peterx@redhat.com>
	<87y3e1f0jf.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y3e1f0jf.fsf@secure.mitica>
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
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jul 24, 2018 at 11:25:24AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > The release-ram capability will run some extra code for postcopy to
> > release used ram right away, let's just turn that on for the postcopy
> > unix test always to torture that code path too to make sure release-ram
> > feature won't break again.  The recovery test needs to turn that off
> > since release-ram cannot coop with that.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks.

> 
> But I think that the proper thing to do here is to have two tests.  One
> for postcopy and another for postcopy + release-ram.

Yeah I thought about it too, but I am not sure whether it'll worth it
to have a separate test for the release-ram feature (basically that's
some extra seconds for every unit test, even on relatively fast CPUs).
I did it this way since IMHO release-ram is mostly adding extra code
path to the postcopy logic, hence we should not miss much (or any) of
the old test path.  Ideally we should still cover all the postcopy
code path that we want to test.

Regards,

-- 
Peter Xu
