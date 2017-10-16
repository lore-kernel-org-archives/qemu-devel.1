Received: from eggs.gnu.org ([2001:4830:134:3::10]:50562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e43Zt-00026W-7n
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e43Zq-0001dl-2x
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:29:01 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-8-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d9917adb-6b99-2daf-c4ae-736810a5ba8b@virtuozzo.com>
Date: Mon, 16 Oct 2017 14:28:54 +0300
MIME-Version: 1.0
In-Reply-To: <20171015010131.12172-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 7/8] nbd/client: prepare
 nbd_receive_reply for structured reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

15.10.2017 04:01, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> In following patch nbd_receive_reply will be used both for simple
> and structured reply header receiving.
> NBDReply is altered into union of simple reply header and structured
> reply chunk header, simple error translation moved to block/nbd-client
> to be consistent with further structured reply error translation.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

looks ok.



-- 
Best regards,
Vladimir
