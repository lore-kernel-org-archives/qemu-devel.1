Received: from eggs.gnu.org ([2001:4830:134:3::10]:37832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dfn73-0003Uq-9P
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dfn6x-0003d1-Np
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:02:57 -0400
Date: Thu, 10 Aug 2017 15:02:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170810130240.GC3650@localhost.localdomain>
References: <20170809203808.31725-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170809203808.31725-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 0/5] More bdrv_getlength() fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com

Am 09.08.2017 um 22:38 hat Eric Blake geschrieben:
> We already have a lot of bdrv_getlength() fixes in -rc2; so I think
> this is still okay for -rc3.
> 
> v1 was here (with a typo'd subject line):
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01226.html
> 
> Since v1:
> - patch 1: fix error message capitalization (Kevin, R-b kept)
> - fix locking bug in original patch 2 (Kevin)
> - split original patch 2 into two parts: signature update, and
> added error checking (Kevin)
> - check for unlikely integer overflow before bdrv_truncate (Jeff)
> 
> 001/5:[0002] [FC] 'vpc: Check failure of bdrv_getlength()'
> 002/5:[down] 'qcow: Change signature of get_cluster_offset()'
> 003/5:[0048] [FC] 'qcow: Check failure of bdrv_getlength() and bdrv_truncate()'
> 004/5:[----] [--] 'qcow2: Drop debugging dump_refcounts()'
> 005/5:[----] [--] 'qcow2: Check failure of bdrv_getlength()'

Looks good to me, but as the bug is far from being critical, I'd rather
apply the more complex qcow1 patches only to block-next. The vpc and
qcow2 parts seems a lot less risky, so 2.10 should be okay for them.

What do you think?

Kevin
