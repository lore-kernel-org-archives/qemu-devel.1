Received: from eggs.gnu.org ([2001:4830:134:3::10]:43011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fJFct-0005NN-S8
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fJFct-0004me-71
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:55:11 -0400
References: <20180507154458.73945-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0fac4939-20d0-b158-7279-fac31ff7baae@virtuozzo.com>
Date: Thu, 17 May 2018 12:54:59 +0300
MIME-Version: 1.0
In-Reply-To: <20180507154458.73945-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/5] NBD reconnect: preliminary refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org

What about patches 1-4?

07.05.2018 18:44, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>
> Here are some preliminary refactoring patches, before NBD reconnect
> series.
>
> Vladimir Sementsov-Ogievskiy (5):
>    block/nbd-client: split channel errors from export errors
>    block/nbd: move connection code from block/nbd to block/nbd-client
>    block/nbd-client: split connection from initialization
>    block/nbd-client: fix nbd_reply_chunk_iter_receive
>    block/nbd-client: don't check ioc
>
>   block/nbd-client.h |   2 +-
>   block/nbd-client.c | 163 ++++++++++++++++++++++++++++++++++-------------------
>   block/nbd.c        |  41 +-------------
>   3 files changed, 107 insertions(+), 99 deletions(-)
>


-- 
Best regards,
Vladimir
