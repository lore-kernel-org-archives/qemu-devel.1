Received: from eggs.gnu.org ([2001:4830:134:3::10]:48856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cw9iZ-00044r-R1
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cw9iV-0008RK-TN
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:53:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cw9iV-0008R5-N0
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:52:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E1E2C059751
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 15:52:58 +0000 (UTC)
Date: Thu, 6 Apr 2017 16:52:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170406155253.GB18315@work-vm>
References: <20170406154107.9178-1-dgilbert@redhat.com>
	<48d5bb0d-25a9-365c-04fa-e3dad7ecf6e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48d5bb0d-25a9-365c-04fa-e3dad7ecf6e8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/check-qdict: Fix missing brackets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

* Eric Blake (eblake@redhat.com) wrote:
> On 04/06/2017 10:41 AM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Gcc 7 (on Fedora 26) spotted odd use of integers instead of a
> > boolean; it's got a point.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  tests/check-qdict.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/check-qdict.c b/tests/check-qdict.c
> > index 81162ee572..6f3fbcf9c1 100644
> > --- a/tests/check-qdict.c
> > +++ b/tests/check-qdict.c
> > @@ -559,7 +559,7 @@ static void qdict_join_test(void)
> >          g_assert(qdict_size(dict1) == 2);
> >          g_assert(qdict_size(dict2) == !overwrite);
> >  
> > -        g_assert(qdict_get_int(dict1, "foo") == overwrite ? 84 : 42);
> > +        g_assert(qdict_get_int(dict1, "foo") == (overwrite ? 84 : 42));
> 
> How is the test passing pre-patch, and why does it not change the test
> post-patch?  Does that mean that overwrite is not doing what we expected?

Pre-patch it passes because either 84 or 42  are valid 'true' values into g_assert.
Post patch it ends up as either:
    qdict_get_int(dict1, "foo") == 42
or
    qdict_get_int(dict1, "foo") == 84

which is what's intended.

Dave

> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
