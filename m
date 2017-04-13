Received: from eggs.gnu.org ([2001:4830:134:3::10]:44280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cySC7-0007N6-9z
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 20:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cySC6-0007Mp-1y
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 20:01:03 -0400
Date: Thu, 13 Apr 2017 08:00:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170413000053.GC8607@lemon>
References: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
	<149204110903.10500.17384665286927706715@6c512846dbc7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149204110903.10500.17384665286927706715@6c512846dbc7>
Subject: Re: [Qemu-devel] [PULL 00/10] Block layer fixes for 2.9.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

On Wed, 04/12 16:51, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 1491572865-8549-1-git-send-email-kwolf@redhat.com
> Subject: [Qemu-devel] [PULL 00/10] Block layer fixes for 2.9.0-rc4
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> 
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
> 
> # Useful git options
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> 
> commits="$(git log --format=%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>         failed=1
>         echo
>     fi
>     n=$((n+1))
> done
> 
> exit $failed
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 4a9e7db mirror: Fix aio context of mirror_top_bs
> 79767f5 block: Assert attached child node has right aio context
> dfad3a5 block: Fix unpaired aio_disable_external in external snapshot
> 99be1dc block: Don't check permissions for copy on read
> 0e5e935 qemu-img: img_create does not support image-opts, fix docs
> 3afb9fa iotests: Add mirror tests for orphaned source
> 5ccc43d block/mirror: Fix use-after-free
> e65d767 commit: Set commit_top_bs->total_sectors
> 2dddcd2 commit: Set commit_top_bs->aio_context
> 5770f38 block: Ignore guest dev permissions during incoming migration
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/10: block: Ignore guest dev permissions during incoming migration...
> Checking PATCH 2/10: commit: Set commit_top_bs->aio_context...
> Checking PATCH 3/10: commit: Set commit_top_bs->total_sectors...
> Checking PATCH 4/10: block/mirror: Fix use-after-free...
> Checking PATCH 5/10: iotests: Add mirror tests for orphaned source...
> Checking PATCH 6/10: qemu-img: img_create does not support image-opts, fix docs...
> Checking PATCH 7/10: block: Don't check permissions for copy on read...
> ERROR: do not use C99 // comments
> #32: FILE: block/io.c:955:
> +    // assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
> 
> total: 1 errors, 0 warnings, 15 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 8/10: block: Fix unpaired aio_disable_external in external snapshot...
> Checking PATCH 9/10: block: Assert attached child node has right aio context...
> Checking PATCH 10/10: mirror: Fix aio context of mirror_top_bs...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

Hmm, patchew has stalled and a long queue of series is now being processed. I'm
going to disable email notifications for now until it catches up.

Fam
