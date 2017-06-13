Received: from eggs.gnu.org ([2001:4830:134:3::10]:40355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gi-oh.kim@profitbricks.com>) id 1dKj5w-0005mw-76
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gi-oh.kim@profitbricks.com>) id 1dKj5v-0000ha-1n
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:30:44 -0400
Received: from mail-yb0-x22e.google.com ([2607:f8b0:4002:c09::22e]:35193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gi-oh.kim@profitbricks.com>)
	id 1dKj5u-0000hR-R6
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:30:42 -0400
Received: by mail-yb0-x22e.google.com with SMTP id f192so34311600yba.2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 03:30:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149734914886.12819.8513153919786826492@84b42461e25a>
References: <1497346256-10073-1-git-send-email-gi-oh.kim@profitbricks.com>
	<149734914886.12819.8513153919786826492@84b42461e25a>
From: Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Date: Tue, 13 Jun 2017 12:30:00 +0200
Message-ID: <CAJX1Ytb_rucnrN7=H2AQh_vNNJtb-j04ZY=fvJNgOnnLVZVk5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: drain block before cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com

On Tue, Jun 13, 2017 at 12:19 PM,  <no-reply@patchew.org> wrote:
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Type: series
> Subject: [Qemu-devel] [PATCH] virtio-blk: drain block before cleanup
> Message-id: 1497346256-10073-1-git-send-email-gi-oh.kim@profitbricks.com
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
>  * [new tag]         patchew/1497346593-8791-1-git-send-email-a.perevalov@samsung.com -> patchew/1497346593-8791-1-git-send-email-a.perevalov@samsung.com
>  * [new tag]         patchew/1497348515-6391-1-git-send-email-sbates@raithlin.com -> patchew/1497348515-6391-1-git-send-email-sbates@raithlin.com
> Switched to a new branch 'test'
> 4b981d6 virtio-blk: drain block before cleanup
>
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: virtio-blk: drain block before cleanup...
> ERROR: braces {} are necessary for all arms of this statement
> #157: FILE: hw/block/virtio-blk.c:976:
> +    if (blk_bs(s->blk) && bdrv_requests_pending((blk_bs(s->blk))))
> [...]
>
> total: 1 errors, 0 warnings, 8 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> === OUTPUT END ===
>

Yes, it has a problem.
I'll send 2nd patch after fixing it.

-- 
Best regards,
Gi-Oh Kim
TEL: 0176 2697 8962
