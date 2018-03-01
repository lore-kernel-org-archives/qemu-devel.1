Received: from eggs.gnu.org ([2001:4830:134:3::10]:45542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erMzG-0002yt-1n
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erMzB-0007sW-Nd
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:07:02 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<20180226165723.17818-1-eblake@redhat.com>
	<20180226165723.17818-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6dabd4a4-105c-5539-c959-b25e4670c6ec@virtuozzo.com>
Date: Thu, 1 Mar 2018 15:06:43 +0300
MIME-Version: 1.0
In-Reply-To: <20180226165723.17818-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/2] nbd: BLOCK_STATUS constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

26.02.2018 19:57, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Expose the new constants and structs that will be used by both
> server and client implementations of NBD_CMD_BLOCK_STATUS (the
> command is currently experimental at
> https://github.com/NetworkBlockDevice/nbd/blob/extension-blockstatus/doc/proto.md
> but will hopefully be stabilized soon).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Message-Id: <1518702707-7077-4-git-send-email-vsementsov@virtuozzo.com>
> [eblake: split from larger patch on server implementation]
> Signed-off-by: Eric Blake <eblake@redhat.com>

ok, with NBD_REPLY_TYPE_BLOCK_STATUS switched back to 5, as it was decided.


-- 
Best regards,
Vladimir
