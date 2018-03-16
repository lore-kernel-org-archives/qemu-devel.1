Received: from eggs.gnu.org ([2001:4830:134:3::10]:41447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ewtOq-0003k5-3B
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ewtOm-00033o-Vh
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:44:16 -0400
Received: from mail-eopbgr10110.outbound.protection.outlook.com
	([40.107.1.110]:44134
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ewtOm-00032B-C5
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:44:12 -0400
References: <152097696263.39.14937366547659300363@71c20359a636>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <388925e9-147e-1e02-8205-1c75c9cadbdb@virtuozzo.com>
Date: Fri, 16 Mar 2018 20:44:05 +0300
MIME-Version: 1.0
In-Reply-To: <152097696263.39.14937366547659300363@71c20359a636>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PULL 00/13] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, jsnow@redhat.com
Cc: peter.maydell@linaro.org, famz@redhat.com

Just note here too, that this relates to bug in checkpatch, work on 
fixing is in progress:
https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg04651.html

14.03.2018 00:36, no-reply@patchew.org wrote:
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Type: series
> Message-id: 20180313211441.5179-1-jsnow@redhat.com
> Subject: [Qemu-devel] [PULL 00/13] Bitmaps patches
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
>      echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>      if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>          failed=1
>          echo
>      fi
>      n=$((n+1))
> done
>
> exit $failed
> === TEST SCRIPT END ===
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>  From https://github.com/patchew-project/qemu
>   t [tag update]            patchew/20180312172124.56461-1-dgilbert@redhat.com -> patchew/20180312172124.56461-1-dgilbert@redhat.com
>   * [new tag]               patchew/20180313211441.5179-1-jsnow@redhat.com -> patchew/20180313211441.5179-1-jsnow@redhat.com
> Switched to a new branch 'test'
> 6dbaff4909 iotests: add dirty bitmap postcopy test
> 970272a769 iotests: add dirty bitmap migration test
> 0a4cfd0266 migration: add postcopy migration of dirty bitmaps
> 39fdbb0e78 migration: allow qmp command migrate-start-postcopy for any postcopy
> 95be37b4df migration: add is_active_iterate handler
> ebce5a11c9 migration/qemu-file: add qemu_put_counted_string()
> b2e3a3e0f7 migration: include migrate_dirty_bitmaps in migrate_postcopy
> d234483b40 qapi: add dirty-bitmaps migration capability
> 6b24eebd32 migration: introduce postcopy-only pending
> a8ca389528 dirty-bitmap: add locked state
> 48cfc1176c block/dirty-bitmap: add _locked version of bdrv_reclaim_dirty_bitmap
> 8bc9e17e62 block/dirty-bitmap: fix locking in bdrv_reclaim_dirty_bitmap
> ce2cf17b98 block/dirty-bitmap: add bdrv_dirty_bitmap_enable_successor()
>
> === OUTPUT BEGIN ===
> Checking PATCH 1/13: block/dirty-bitmap: add bdrv_dirty_bitmap_enable_successor()...
> Checking PATCH 2/13: block/dirty-bitmap: fix locking in bdrv_reclaim_dirty_bitmap...
> Checking PATCH 3/13: block/dirty-bitmap: add _locked version of bdrv_reclaim_dirty_bitmap...
> Checking PATCH 4/13: dirty-bitmap: add locked state...
> Checking PATCH 5/13: migration: introduce postcopy-only pending...
> Checking PATCH 6/13: qapi: add dirty-bitmaps migration capability...
> Checking PATCH 7/13: migration: include migrate_dirty_bitmaps in migrate_postcopy...
> Checking PATCH 8/13: migration/qemu-file: add qemu_put_counted_string()...
> Checking PATCH 9/13: migration: add is_active_iterate handler...
> Checking PATCH 10/13: migration: allow qmp command migrate-start-postcopy for any postcopy...
> Checking PATCH 11/13: migration: add postcopy migration of dirty bitmaps...
> ERROR: braces {} are necessary for all arms of this statement
> #740: FILE: migration/block-dirty-bitmap.c:690:
> +    } while (!(s.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
> [...]
>
> total: 1 errors, 0 warnings, 816 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> Checking PATCH 12/13: iotests: add dirty bitmap migration test...
> Checking PATCH 13/13: iotests: add dirty bitmap postcopy test...
> === OUTPUT END ===
>
> Test command exited with code: 1
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org


-- 
Best regards,
Vladimir
