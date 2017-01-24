Received: from eggs.gnu.org ([2001:4830:134:3::10]:51531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW05v-0006sG-BE
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW05s-0005yJ-8N
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:21:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cW05s-0005xz-2M
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:21:00 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C9727FE94
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 12:21:00 +0000 (UTC)
Date: Tue, 24 Jan 2017 12:20:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170124122055.GG20224@work-vm>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-2-git-send-email-quintela@redhat.com>
	<f77369a0-8818-0115-ec1b-13dcd0c594f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f77369a0-8818-0115-ec1b-13dcd0c594f2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/17] migration: transform remained
 DPRINTF into trace_
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, amit.shah@redhat.com

* Eric Blake (eblake@redhat.com) wrote:
> On 01/23/2017 03:32 PM, Juan Quintela wrote:
> 
> In the subject: s/remained/remaining/
> 
> > So we can remove DPRINTF() macro
> > 
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  migration/ram.c        | 18 ++++--------------
> >  migration/trace-events |  4 ++++
> >  2 files changed, 8 insertions(+), 14 deletions(-)
> > 
> > diff --git a/migration/ram.c b/migration/ram.c
> > index a1c8089..ef8fadf 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -45,14 +45,6 @@
> >  #include "qemu/rcu_queue.h"
> >  #include "migration/colo.h"
> > 
> > -#ifdef DEBUG_MIGRATION_RAM
> > -#define DPRINTF(fmt, ...) \
> > -    do { fprintf(stdout, "migration_ram: " fmt, ## __VA_ARGS__); } while (0)
> > -#else
> > -#define DPRINTF(fmt, ...) \
> > -    do { } while (0)
> 
> Yay - you're getting rid of the bitrot pattern in this file!
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

This change doesn't need the rest of the series so,
queued.
(Fixed up 'remained')

Dave

> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
