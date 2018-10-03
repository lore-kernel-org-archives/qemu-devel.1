Received: from eggs.gnu.org ([2001:4830:134:3::10]:38871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7kzm-00070i-CO
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7kzk-00026w-Vs
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:31:34 -0400
References: <20181003170228.95973-1-vsementsov@virtuozzo.com>
	<20181003170228.95973-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <75bd09f2-2e18-9c82-d918-0fc99d5279f5@redhat.com>
Date: Wed, 3 Oct 2018 12:31:11 -0500
MIME-Version: 1.0
In-Reply-To: <20181003170228.95973-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-nbd: drop old-style negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@virtuozzo.com, rjones@redhat.com, berrange@redhat.com

On 10/3/18 12:02 PM, Vladimir Sementsov-Ogievskiy wrote:
> Use new-style negotiation always, with default "" (empty) export name
> if it is not specified with '-x' option.

If we like this approach (over mine of keeping oldstyle, but via an 
explicit -O option), then this commit message should add the following:

qemu as client can manage either style since 2.6.0, commit 69b49502d8

For comparison:

nbdkit 1.3 switched its default to newstyle (Jan 2018):
https://github.com/libguestfs/nbdkit/commit/b2a8aecc
https://github.com/libguestfs/nbdkit/commit/8158e773

nbd 3.10 dropped oldstyle long ago (Mar 2015):
https://github.com/NetworkBlockDevice/nbd/commit/36940193

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qemu-nbd.c | 25 ++++++-------------------
>   1 file changed, 6 insertions(+), 19 deletions(-)
> 

If we like your patch over mine,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
