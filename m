Received: from eggs.gnu.org ([2001:4830:134:3::10]:39495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2bTK-0004y2-UR
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2bTG-0006xE-6Y
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:16:14 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:16695 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2bTF-0006vg-Qb
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:16:10 -0400
References: <150780535623.288.12272299760364683981@b58463cdfd5f>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <da4434ac-e912-172e-7d04-af09e11f813a@virtuozzo.com>
Date: Thu, 12 Oct 2017 14:15:52 +0300
MIME-Version: 1.0
In-Reply-To: <150780535623.288.12272299760364683981@b58463cdfd5f>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 00/13] nbd minimal structured read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com

This is a code movement, no changes.

12.10.2017 13:49, no-reply@patchew.org wrote:
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Type: series
> Message-id: 20171012095319.136610-1-vsementsov@virtuozzo.com
> Subject: [Qemu-devel] [PATCH v3 00/13] nbd minimal structured read
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
>   t [tag update]            patchew/20171005151313.32015-1-cohuck@redhat.com -> patchew/20171005151313.32015-1-cohuck@redhat.com
> Switched to a new branch 'test'
> 803c96aeca nbd: Minimal structured read for client
> 55b2692ff6 nbd/client: prepare nbd_receive_reply for structured reply
> 3155f99d3a nbd: share some nbd entities to be reused in block/nbd-client.c
> cf17e2f26c nbd/client: refactor nbd_receive_starttls
> 7934ecd6e3 nbd: Minimal structured read for server
> abfc671d5e nbd: header constants indenting
> 1c2944d9d1 nbd-server: simplify reply transmission
> fe87c0f68c nbd/server: refactor nbd_co_send_simple_reply parameters
> a9de77d411 nbd/server: do not use NBDReply structure
> 691f470797 nbd/server: structurize simple reply header sending
> 7f1652db0f nbd: rename some simple-request related objects to be _simple_
> ab2e6ba2f6 block/nbd-client: refactor nbd_co_receive_reply
> c5baea9e86 block/nbd-client: assert qiov len once in nbd_co_request
>
> === OUTPUT BEGIN ===
> Checking PATCH 1/13: block/nbd-client: assert qiov len once in nbd_co_request...
> Checking PATCH 2/13: block/nbd-client: refactor nbd_co_receive_reply...
> Checking PATCH 3/13: nbd: rename some simple-request related objects to be _simple_...
> Checking PATCH 4/13: nbd/server: structurize simple reply header sending...
> Checking PATCH 5/13: nbd/server: do not use NBDReply structure...
> Checking PATCH 6/13: nbd/server: refactor nbd_co_send_simple_reply parameters...
> Checking PATCH 7/13: nbd-server: simplify reply transmission...
> Checking PATCH 8/13: nbd: header constants indenting...
> Checking PATCH 9/13: nbd: Minimal structured read for server...
> Checking PATCH 10/13: nbd/client: refactor nbd_receive_starttls...
> Checking PATCH 11/13: nbd: share some nbd entities to be reused in block/nbd-client.c...
> ERROR: return of an errno should typically be -ve (return -EPERM)
> #46: FILE: include/block/nbd.h:206:
> +        return EPERM;
>
> ERROR: return of an errno should typically be -ve (return -EIO)
> #48: FILE: include/block/nbd.h:208:
> +        return EIO;
>
> ERROR: return of an errno should typically be -ve (return -ENOMEM)
> #50: FILE: include/block/nbd.h:210:
> +        return ENOMEM;
>
> ERROR: return of an errno should typically be -ve (return -ENOSPC)
> #52: FILE: include/block/nbd.h:212:
> +        return ENOSPC;
>
> ERROR: return of an errno should typically be -ve (return -ESHUTDOWN)
> #54: FILE: include/block/nbd.h:214:
> +        return ESHUTDOWN;
>
> ERROR: return of an errno should typically be -ve (return -EINVAL)
> #56: FILE: include/block/nbd.h:216:
> +        return EINVAL;
>
> ERROR: return of an errno should typically be -ve (return -EINVAL)
> #59: FILE: include/block/nbd.h:219:
> +    return EINVAL;
>
> total: 7 errors, 0 warnings, 149 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> Checking PATCH 12/13: nbd/client: prepare nbd_receive_reply for structured reply...
> Checking PATCH 13/13: nbd: Minimal structured read for client...
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
