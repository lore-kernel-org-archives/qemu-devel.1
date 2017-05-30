Received: from eggs.gnu.org ([2001:4830:134:3::10]:40683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dFfIo-0007nP-Mr
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dFfIk-0006i7-M2
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:27:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dFfIk-0006hj-FW
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:27:02 -0400
Date: Tue, 30 May 2017 12:26:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170530112655.GH2120@work-vm>
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512133146eucas1p2ba4841cabf508b66410fae6784952eaa@eucas1p2.samsung.com>
	<1494595886-30912-6-git-send-email-a.perevalov@samsung.com>
	<43617b5a-0fcc-d171-aa19-4a24a4007e35@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43617b5a-0fcc-d171-aa19-4a24a4007e35@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5 5/9] migration: introduce
 postcopy-blocktime capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com

* Eric Blake (eblake@redhat.com) wrote:
> On 05/12/2017 08:31 AM, Alexey Perevalov wrote:
> > Right now it could be used on destination side to
> > enable vCPU blocktime calculation for postcopy live migration.
> > vCPU blocktime - it's time since vCPU thread was put into
> > interruptible sleep, till memory page was copied and thread awake.
> > 
> > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > ---
> >  include/migration/migration.h | 1 +
> >  migration/migration.c         | 9 +++++++++
> >  qapi-schema.json              | 5 ++++-
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> > 
> 
> > +++ b/qapi-schema.json
> > @@ -894,11 +894,14 @@
> >  # @release-ram: if enabled, qemu will free the migrated ram pages on the source
> >  #        during postcopy-ram migration. (since 2.9)
> >  #
> > +# @postcopy-blocktime: Calculate downtime for postcopy live migration (since 2.10)
> > +#
> >  # Since: 1.2
> >  ##
> >  { 'enum': 'MigrationCapability',
> >    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> > -           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'] }
> > +           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
> > +           'postcopy-blocktime'] }
> 
> Why does this need to be a capability that we have to turn on, and not
> something that is collected unconditionally? Is there a drawback to
> having the stat collection always enabled without a capability?

Yes, there was a reasonable CPU/memory overhead.
(Although it might be lower now).

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
