Received: from eggs.gnu.org ([2001:4830:134:3::10]:42701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e415A-00059e-5P
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e4156-0000Pb-9K
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:49:08 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bee8a445-1cb9-53f6-4828-bdbd9c745ccc@virtuozzo.com>
Date: Mon, 16 Oct 2017 11:49:00 +0300
MIME-Version: 1.0
In-Reply-To: <20171015010131.12172-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 3/8] nbd: Expose constants and structs
 for structured read
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
> Upcoming patches will implement the NBD structured reply
> extension [1] for both client and server roles.  Declare the
> constants, structs, and lookup routines that will be valuable
> whether the server or client code is backported in isolation.
>
> This includes moving one constant from an internal header to
> the public header, as part of the structured read processing
> will be done in block/nbd-client.c rather than nbd/client.c.
>
> [1]https://github.com/NetworkBlockDevice/nbd/blob/extension-structured-reply/doc/proto.md

this link may become dead in future, after merging extension spec into 
master...

>
> Based on patches from Vladimir Sementsov-Ogievskiy.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
