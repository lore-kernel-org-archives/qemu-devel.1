Received: from eggs.gnu.org ([2001:4830:134:3::10]:41298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTxGO-0003ZI-FS
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTxGL-0000VI-39
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:55:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cTxGK-0000UQ-QW
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:55:21 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AB56C0467F1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 20:55:20 +0000 (UTC)
Date: Wed, 18 Jan 2017 22:55:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170118225452-mutt-send-email-mst@kernel.org>
References: <1484771412-28024-1-git-send-email-mst@redhat.com>
	<148477204953.214.4233575593065257938@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148477204953.214.4233575593065257938@790289a7ca88>
Subject: Re: [Qemu-devel] [PATCH 0/4] virtio: ARRAY_SIZE fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com

On Wed, Jan 18, 2017 at 12:40:50PM -0800, no-reply@patchew.org wrote:
> Hi,
> 
> Your series seems to have some coding style problems. See output below for
> more information:

Not sure we really do care as this matches existing code, but I'll fix
it up.


> Message-id: 1484771412-28024-1-git-send-email-mst@redhat.com
> Subject: [Qemu-devel] [PATCH 0/4] virtio: ARRAY_SIZE fixups
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
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/1484771412-28024-1-git-send-email-mst@redhat.com -> patchew/1484771412-28024-1-git-send-email-mst@redhat.com
> Switched to a new branch 'test'
> 38b031b ARRAY_SIZE: check that argument is an array
> 19ef003 compiler: expression version of QEMU_BUILD_BUG_ON
> 71870e6 compiler: drop ; after BUILD_BUG_ON
> c652d79 virtio: fix up max size checks
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/4: virtio: fix up max size checks...
> Checking PATCH 2/4: compiler: drop ; after BUILD_BUG_ON...
> WARNING: line over 80 characters
> #25: FILE: include/qemu/compiler.h:89:
> +    typedef char glue(qemu_build_bug_on__,__LINE__)[(x)?-1:1] __attribute__((unused))
> 
> ERROR: space required after that ',' (ctx:VxV)
> #25: FILE: include/qemu/compiler.h:89:
> +    typedef char glue(qemu_build_bug_on__,__LINE__)[(x)?-1:1] __attribute__((unused))
>                                           ^
> 
> ERROR: spaces required around that '?' (ctx:VxO)
> #25: FILE: include/qemu/compiler.h:89:
> +    typedef char glue(qemu_build_bug_on__,__LINE__)[(x)?-1:1] __attribute__((unused))
>                                                         ^
> 
> ERROR: space required before that '-' (ctx:OxV)
> #25: FILE: include/qemu/compiler.h:89:
> +    typedef char glue(qemu_build_bug_on__,__LINE__)[(x)?-1:1] __attribute__((unused))
>                                                          ^
> 
> ERROR: spaces required around that ':' (ctx:VxV)
> #25: FILE: include/qemu/compiler.h:89:
> +    typedef char glue(qemu_build_bug_on__,__LINE__)[(x)?-1:1] __attribute__((unused))
>                                                            ^
> 
> total: 4 errors, 1 warnings, 8 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 3/4: compiler: expression version of QEMU_BUILD_BUG_ON...
> ERROR: spaces required around that '?' (ctx:VxO)
> #23: FILE: include/qemu/compiler.h:91:
> +#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(int[(x)?-1:1]) - sizeof(int))
>                                                   ^
> 
> ERROR: space required before that '-' (ctx:OxV)
> #23: FILE: include/qemu/compiler.h:91:
> +#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(int[(x)?-1:1]) - sizeof(int))
>                                                    ^
> 
> ERROR: spaces required around that ':' (ctx:VxV)
> #23: FILE: include/qemu/compiler.h:91:
> +#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(int[(x)?-1:1]) - sizeof(int))
>                                                      ^
> 
> total: 3 errors, 0 warnings, 8 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 4/4: ARRAY_SIZE: check that argument is an array...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
