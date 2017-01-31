Received: from eggs.gnu.org ([2001:4830:134:3::10]:45179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cYbAf-00077N-M9
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cYbAb-0000aV-L7
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:20:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cYbAb-0000aG-Ds
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:20:37 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69CF7C05681A
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 16:20:37 +0000 (UTC)
Date: Tue, 31 Jan 2017 16:20:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170131162032.GA30735@work-vm>
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-15-dgilbert@redhat.com>
	<87d1f3s6p1.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d1f3s6p1.fsf@emacs.mitica>
Subject: Re: [Qemu-devel] [PATCH 14/15] postcopy: Check for
 userfault+hugepage feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > We need extra Linux kernel support (~4.9) to support userfaults
> > on hugetlbfs; check for them.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> 
> >  migration/postcopy-ram.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 6b30b43..d12dd7f 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -81,6 +81,17 @@ static bool ufd_version_check(int ufd)
> >          return false;
> >      }
> >  
> > +    if (getpagesize() != ram_pagesize_summary()) {
> 
> I am pretty sure that I don't like ram_pagesize_summary() name.  I have
> already forgot what I mean O:-)

Suggested replacements welcome!

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
