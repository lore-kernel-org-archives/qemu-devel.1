Received: from eggs.gnu.org ([2001:4830:134:3::10]:46949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gWr8p-00019f-By
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 18:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gWr8o-0004Ye-Eb
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 18:08:39 -0500
References: <154414128075.8206.639791884193945612@bb8f5089e434>
From: John Snow <jsnow@redhat.com>
Message-ID: <a5c017a1-8388-dd18-52cd-3eea7c21dfcf@redhat.com>
Date: Tue, 11 Dec 2018 18:08:29 -0500
MIME-Version: 1.0
In-Reply-To: <154414128075.8206.639791884193945612@bb8f5089e434>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] bitmaps: remove x- prefix from QMP api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, vsementov@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com



On 12/6/18 7:08 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20181206192544.3987-1-jsnow@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Subject: [Qemu-devel] [PATCH 0/3] bitmaps: remove x- prefix from QMP api
> Message-id: 20181206192544.3987-1-jsnow@redhat.com
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> 
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
> 
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
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
> c972673 block: remove 'x' prefix from experimental bitmap APIs
> ebd1e6c blockdev: n-ary bitmap merge
> 68d3c0c blockdev: abort transactions in reverse order
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/3: blockdev: abort transactions in reverse order...
> Checking PATCH 2/3: blockdev: n-ary bitmap merge...
> ERROR: externs should be avoided in .c files
> #23: FILE: blockdev.c:2125:
> +void do_block_dirty_bitmap_merge(const char *node, const char *target,
> 

Oh, I guess I'm missing `static` here for this forward declaration.

Also, we need to edit patchew to not CC famz@redhat.com anymore :(

> total: 1 errors, 0 warnings, 147 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 3/3: block: remove 'x' prefix from experimental bitmap APIs...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20181206192544.3987-1-jsnow@redhat.com/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 
