Received: from eggs.gnu.org ([2001:4830:134:3::10]:34679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBfwu-0003FK-B6
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBfwq-0005K5-69
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:24:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBfwq-0005Jh-0z
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:24:28 -0400
Date: Thu, 26 Apr 2018 13:24:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180426122413.GC2631@work-vm>
References: <20180425200326.72337-1-dgilbert@redhat.com>
	<20180425200326.72337-2-dgilbert@redhat.com>
	<5ac3b2f4-fff5-f9bc-1f90-289638f8e94f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ac3b2f4-fff5-f9bc-1f90-289638f8e94f@redhat.com>
Subject: Re: [Qemu-devel] [PULL 01/16] migration: introduce
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, a.perevalov@samsung.com, xiaoguangrong@tencent.com

* Eric Blake (eblake@redhat.com) wrote:
> On 04/25/2018 03:03 PM, Dr. David Alan Gilbert (git) wrote:
> > From: Alexey Perevalov <a.perevalov@samsung.com>
> > 
> > Right now it could be used on destination side to
> > enable vCPU blocktime calculation for postcopy live migration.
> > vCPU blocktime - it's time since vCPU thread was put into
> > interruptible sleep, till memory page was copied and thread awake.
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > Message-Id: <1521742647-25550-2-git-send-email-a.perevalov@samsung.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> 
> > +++ b/qapi/migration.json
> > @@ -354,16 +354,20 @@
> >  #
> >  # @x-multifd: Use more than one fd for migration (since 2.11)
> >  #
> > +#
> >  # @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
> 
> Why is the extra blank line added here?  Doesn't hold up the pull
> request, but might be worth a trivial followup patch.

I think it's just a merge artifact; this patch has been around for a few
versions so has been bumped down that list a few times.

OK, I'll do that.

Dave

> >  #                 (since 2.12)
> >  #
> > +# @postcopy-blocktime: Calculate downtime for postcopy live migration
> > +#                     (since 2.13)
> > +#
> >  # Since: 1.2
> >  ##
> >  { 'enum': 'MigrationCapability',
> >    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> >             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
> >             'block', 'return-path', 'pause-before-switchover', 'x-multifd',
> > -           'dirty-bitmaps' ] }
> > +           'dirty-bitmaps', 'postcopy-blocktime' ] }
> >  
> >  ##
> >  # @MigrationCapabilityStatus:
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
