Received: from eggs.gnu.org ([2001:4830:134:3::10]:59768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fbMPA-00021b-3M
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fbMP7-0002AE-1E
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:47:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fbMP6-00027c-TV
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:47:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74A3C4071188
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 08:47:48 +0000 (UTC)
Date: Fri, 6 Jul 2018 09:47:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180706084745.GA7949@work-vm>
References: <20180627132246.5576-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627132246.5576-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] migation: unbreak postcopy recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

Queued

* Peter Xu (peterx@redhat.com) wrote:
> v3:
> - keep the recovery logic even for RDMA by dropping the 3rd patch and
>   touch up the original 4th patch (current 3rd patch) to suite that [Dave]
> 
> v2:
> - break the first patch into several
> - fix a QEMUFile leak
> 
> Please review.  Thanks,
> 
> Peter Xu (4):
>   migration: delay postcopy paused state
>   migration: move income process out of multifd
>   migration: unbreak postcopy recovery
>   migration: unify incoming processing
> 
>  migration/ram.h       |  2 +-
>  migration/exec.c      |  3 ---
>  migration/fd.c        |  3 ---
>  migration/migration.c | 44 ++++++++++++++++++++++++++++++++++++-------
>  migration/ram.c       | 11 +++++------
>  migration/savevm.c    |  6 +++---
>  migration/socket.c    |  5 -----
>  7 files changed, 46 insertions(+), 28 deletions(-)
> 
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
