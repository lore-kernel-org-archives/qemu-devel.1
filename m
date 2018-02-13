Received: from eggs.gnu.org ([2001:4830:134:3::10]:33899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eld3r-0005kP-3u
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eld3o-0004VJ-FK
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:04:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eld3o-0004V8-9C
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:04:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE98F7D67E
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 16:03:59 +0000 (UTC)
References: <20180213142102.14450-1-stefanha@redhat.com>
	<20180213142102.14450-3-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49797c75-1e96-10fe-4be5-58cd2b0ebd7f@redhat.com>
Date: Tue, 13 Feb 2018 10:03:55 -0600
MIME-Version: 1.0
In-Reply-To: <20180213142102.14450-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] block: add BlockBackend->in_flight
 counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On 02/13/2018 08:21 AM, Stefan Hajnoczi wrote:
> BlockBackend currently relies on BlockDriverState->in_flight to track
> requests for blk_drain().  There is a corner case where
> BlockDriverState->in_flight cannot be used though: blk->root can be NULL
> when there is no medium.  This results in a segfault when the NULL
> pointer is dereferenced.
> 
> Introduce a BlockBackend->in_flight counter for aio requests so it works
> even when blk->root == NULL.
> 
> Based on a patch by Kevin Wolf <kwolf@redhat.com>.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   block.c               |  2 +-
>   block/block-backend.c | 60 +++++++++++++++++++++++++++++++++++++++++++++------
>   2 files changed, 54 insertions(+), 8 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
