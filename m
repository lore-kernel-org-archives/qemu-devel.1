Received: from eggs.gnu.org ([2001:4830:134:3::10]:60978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctYPM-0000YG-Pp
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctYPJ-0007ZC-MF
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:38:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ctYPJ-0007Yg-G3
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:38:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8CED3D978
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 11:38:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170330090705.GC2800@work-vm> (David Alan Gilbert's message of
	"Thu, 30 Mar 2017 10:07:06 +0100")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-43-quintela@redhat.com>
	<20170330090705.GC2800@work-vm>
Reply-To: quintela@redhat.com
Date: Thu, 30 Mar 2017 13:38:22 +0200
Message-ID: <87tw6bm1u9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 42/51] ram: Pass RAMBlock to bitmap_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We change the meaning of start to be the offset from the beggining of
>> the block.
>
> s/beggining/beginning/
>
> Why do this?
> We have:
>    migration_bitmap_sync (all blocks)
>    migration_bitmap_sync_range - called per block
>    cpu_physical_memory_sync_dirty_bitmap
>
> Why keep migration_bitmap_sync_range having start/length as well as the block
> if you could just rename it to migration_bitmap_sync_block and just give it the rb?
> And since cpu_physical_memory_clear_dirty_range is lower level, why give it
> the rb?

I did it on the previous series, then I remembered that I was not going
to be able to sync only part of the range, as I will want in the future.

If you preffer as an intermediate meassure to just move to blocks, I can
do, but change is really small and not sure if it makes sense.


Later, Juan.
