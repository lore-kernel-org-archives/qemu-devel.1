Received: from eggs.gnu.org ([2001:4830:134:3::10]:50542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYA6d-0007D8-Vi
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYA6Y-0000hB-Bj
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:03:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fYA6Y-0000gT-6W
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:03:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B401B406E974
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:03:25 +0000 (UTC)
Date: Wed, 27 Jun 2018 21:03:19 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180627130319.GF2516@xz-mi>
References: <20180627105112.31401-1-peterx@redhat.com>
	<20180627105112.31401-4-peterx@redhat.com>
	<20180627122544.GG2423@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180627122544.GG2423@work-vm>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] migration: do explicit incoming
 setup for rdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On Wed, Jun 27, 2018 at 01:25:45PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > RDMA does not support postcopy recovery, so no need to go into such
> > logic.  Instead of calling migration_fd_process_incoming(), let's call
> > the two functions that setup the incoming migration.  There should have
> > no functional change at all.
> 
> Can you explain why we need to though?  The reason I ask is that there
> is Lidong Chen's work that gets postcopy partially working with RDMA, so
> then the next question is bound to be recovery.

Ah if so this patch needs to change.  Could you paste me the message
id of the work?  Or link?

After all I'll need to keep this bit, but I am just curious about what
is "partially" mean here. :)

Thanks,

-- 
Peter Xu
