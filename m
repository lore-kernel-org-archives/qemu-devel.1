Received: from eggs.gnu.org ([2001:4830:134:3::10]:35801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dFy82-0005PV-KW
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dFy7z-0003j8-DN
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:33:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dFy7z-0003hy-7J
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:33:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 290D14E4D0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 07:33:10 +0000 (UTC)
Date: Wed, 31 May 2017 15:33:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170531073304.GG14845@pxdev.xzpeter.org>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-6-git-send-email-peterx@redhat.com>
	<87wp8ye3rb.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wp8ye3rb.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH RFC 5/6] migration: let MigrationState be
 an QObject
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

On Tue, May 30, 2017 at 05:57:44PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > Let the old man "MigrationState" join the object family. Direct benefit
> > is that we can start to use all the property features derived from
> > current QObject, like: HW_COMPAT_* bits, command line setup for
> > migration parameters (so will never need to set them up each time using
> > HMP/QMP, this is really, really attractive for test writters), etc.
> >
> > I see no reason to disallow this happen yet. So let's start from this
> > one, to see whether it would be anything good.
> >
> > No functional change at all.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> 
> Please, send this patch in toplevel.
> 
> Once there, as for following patch, could you incorporate as properties:
> - only_migratable: And we don't have to have the global variable in vl.c
> - global_state_set_optional()
> - savevm_skip_configuration()
> - savevm_skip_section_footers()
> 
> So we don't have to export functions from them?  they are just
> properties of this?

Okay. I'll try. :)

Thanks.

-- 
Peter Xu
