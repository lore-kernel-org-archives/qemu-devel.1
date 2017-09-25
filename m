Received: from eggs.gnu.org ([2001:4830:134:3::10]:42895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwU1X-00053Z-Nr
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwU1T-0002lH-O2
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:06:15 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:8908 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dwU1T-0002kV-Bk
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:06:11 -0400
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <864fc90f-7add-1dbc-c741-c1ac37161486@virtuozzo.com>
Date: Mon, 25 Sep 2017 17:06:02 +0300
MIME-Version: 1.0
In-Reply-To: <20170925135801.144261-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/8] nbd minimal structured read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org

Add Max.

Max, sorry, I've mistaken in copy-pasting your email address..

25.09.2017 16:57, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. Here is minimal structured-read extension implementation for nbd.
> It is needed mostly to implement nbd block-status extension over it, so
> it is minimal.
>
> It's based on my three patches, currently on pull-request stage:
>        block/nbd-client: refactor nbd_co_receive_reply
>        block/nbd-client: simplify check in nbd_co_receive_reply
>        block/nbd-client: nbd_co_send_request: fix return code
>
> clone: tag up-nbd-minimal-structured-read-v1 from https://src.openvz.org/scm/~vsementsov/qemu.git
> online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=up-nbd-minimal-structured-read-v1
>
> Note: actually it's a continuation of a part of my series "nbd: BLOCK_STATUS",
> but it was sent about half a year ago, so let's consider it as new series.
>
> Vladimir Sementsov-Ogievskiy (8):
>    block/nbd-client: assert qiov len once in nbd_co_request
>    block/nbd-client: refactor nbd_co_receive_reply
>    nbd: rename NBD_REPLY_MAGIC to NBD_SIMPLE_REPLY_MAGIC
>    nbd-server: refactor simple reply sending
>    nbd: header constants indenting
>    nbd: Minimal structured read for server
>    nbd/client: refactor nbd_receive_starttls
>    nbd: Minimal structured read for client
>
>   block/nbd-client.h                       |   2 +
>   include/block/nbd.h                      |  67 +++++++--
>   nbd/nbd-internal.h                       |  44 +++---
>   block/nbd-client.c                       | 104 +++++++++++---
>   nbd/client.c                             | 233 ++++++++++++++++++++++++++-----
>   nbd/server.c                             | 189 +++++++++++++++++--------
>   nbd/trace-events                         |   7 +-
>   tests/qemu-iotests/nbd-fault-injector.py |   4 +-
>   8 files changed, 507 insertions(+), 143 deletions(-)
>


-- 
Best regards,
Vladimir
