Received: from eggs.gnu.org ([2001:4830:134:3::10]:60087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df13m-00063b-8J
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df13j-0000Ir-Ls
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:44:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1df13j-0000I7-Fe
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:44:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 816555D68D
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 09:44:16 +0000 (UTC)
Date: Tue, 8 Aug 2017 10:44:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170808094410.GB2081@work-vm>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-6-quintela@redhat.com>
	<20170719160030.GF3500@work-vm> <87fud2bg6g.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fud2bg6g.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v5 05/17] migration: Create
 x-multifd-threads parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> Indicates the number of threads that we would create.  By default we
> >> create 2 threads.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> > Also needs updating DEFINE_PROP stuff - and if Markus' qapi patch lands.
> 
> Done.
> 
> >>  #
> >>  # @return-path: If enabled, migration will use the return path even
> >>  #               for precopy. (since 2.10)
> >> +#
> >>  # @x-multifd: Use more than one fd for migration (since 2.10)
> >>  #
> >>  # Since: 1.2
> >> @@ -910,6 +911,7 @@
> >>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> >>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
> >>             'block', 'return-path', 'x-multifd'] }
> >> +
> >
> > Escapee from previous patch.
> 
> Done.
> 
> >
> >>  ##
> >>  # @MigrationCapabilityStatus:
> >>  #
> >> @@ -1026,13 +1028,19 @@
> >>  # 	migrated and the destination must already have access to the
> >>  # 	same backing chain as was used on the source.  (since 2.10)
> >>  #
> >> +# @x-multifd-threads: Number of threads used to migrate data in
> >> +#                     parallel. This is the same number that the
> >> +#                     number of sockets used for migration.
> >> +#                     The default value is 2 (since 2.10)
> >> +#
> >
> > That did make me think for a moment; I guess '2' makes sense once you've
> > set the x-multifd capability on.  The other possibility would be to
> > remove the capability and just rely on the threads > 1
> 
> I think this is the same that xbzrle cache size.  It has a default
> value.  But we only used it when we set the capability.
> 
> I think that it makes the code more ortogonal with the others, no?

I don't have a strong view either way; it's more orthogonal vs one less
parameter.  Your choice.

Dave

> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
