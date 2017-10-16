Received: from eggs.gnu.org ([2001:4830:134:3::10]:51608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e43ck-0002zH-P0
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e43ch-0003S0-Jk
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:31:58 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-9-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2483b0a0-65da-d08b-9d8e-a53cf6916d05@virtuozzo.com>
Date: Mon, 16 Oct 2017 14:31:53 +0300
MIME-Version: 1.0
In-Reply-To: <20171015010131.12172-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 8/8] nbd: Move nbd_read() to common
 header
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
> An upcoming change to block/nbd-client.c will want to read the
> tail of a structured reply chunk directly from the wire.  Move
> this function to make it easier.
>
> Based on a patch from Vladimir Sementsov-Ogievskiy.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
