Received: from eggs.gnu.org ([2001:4830:134:3::10]:46861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ct7WH-0006Tq-Cd
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 02:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ct7WD-0005QD-71
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 02:55:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ct7WD-0005Pz-1W
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 02:55:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2CB34E326
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 06:55:43 +0000 (UTC)
Date: Wed, 29 Mar 2017 14:55:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170329065533.GD3152@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-6-quintela@redhat.com>
	<20170327073407.GB11497@pxdev.xzpeter.org>
	<87wpb9r7p5.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wpb9r7p5.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH 05/51] ram: Move bitmap_sync_count into
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

On Tue, Mar 28, 2017 at 12:56:06PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Thu, Mar 23, 2017 at 09:44:58PM +0100, Juan Quintela wrote:
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >
> > (I see that we have MigrationStats.dirty_pages_rate which looks
> >  similar to this one. Maybe one day we can merge these two?)
> 
> no, this one is how many times we have synchronized the dirty bitmap
> with kvm/rest of qemu.
> dirty_pages_rame is the pages we have dirtied in some <period>.
> 
> Period is not clear, it tries to be around one second, but that part is
> not specially well done.

Oh, sorry... I was trying to mean MigrationStats.dirty_sync_count, not
MigrationStats.dirty_pages_rate. I think it was introduced in:

    commit 58570ed894631904bcdbcd1e8b34479cebe2aae9
    Author: ChenLiang <chenliang88@huawei.com>
    Date:   Fri Apr 4 17:57:55 2014 +0800

    migration: expose the bitmap_sync_count to the end

And these two variables are synchronized every time in
migration_bitmap_sync(), so looks the same. Thanks,

-- peterx
