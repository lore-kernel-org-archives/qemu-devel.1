Received: from eggs.gnu.org ([2001:4830:134:3::10]:59748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctfT8-0004bC-I1
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctfT5-0005ie-63
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:10:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctfT4-0005hm-WF
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:10:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E24007E9CE
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 19:10:45 +0000 (UTC)
Date: Thu, 30 Mar 2017 20:10:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170330191042.GN2800@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-43-quintela@redhat.com>
	<20170330090705.GC2800@work-vm> <87tw6bm1u9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tw6bm1u9.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH 42/51] ram: Pass RAMBlock to bitmap_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> We change the meaning of start to be the offset from the beggining of
> >> the block.
> >
> > s/beggining/beginning/
> >
> > Why do this?
> > We have:
> >    migration_bitmap_sync (all blocks)
> >    migration_bitmap_sync_range - called per block
> >    cpu_physical_memory_sync_dirty_bitmap
> >
> > Why keep migration_bitmap_sync_range having start/length as well as the block
> > if you could just rename it to migration_bitmap_sync_block and just give it the rb?
> > And since cpu_physical_memory_clear_dirty_range is lower level, why give it
> > the rb?
> 
> I did it on the previous series, then I remembered that I was not going
> to be able to sync only part of the range, as I will want in the future.
> 
> If you preffer as an intermediate meassure to just move to blocks, I can
> do, but change is really small and not sure if it makes sense.

OK then, but just comment it to say you want to.
I'm still not sure if cpu_physical_memory_clear_dirty_range should have the RB;
it feels that it's lower level, kvm stuff rather than things that know about RAMBlocks.

Dave

> 
> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
