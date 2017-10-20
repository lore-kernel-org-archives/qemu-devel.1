Received: from eggs.gnu.org ([2001:4830:134:3::10]:39335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e5SEG-0007Rk-NK
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 04:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e5SE6-0001wj-S1
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 04:00:28 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cc260e41-674d-d443-ea09-abfbcc35fac3@virtuozzo.com>
Date: Fri, 20 Oct 2017 11:00:12 +0300
MIME-Version: 1.0
In-Reply-To: <20171019222637.17890-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 03/11] nbd: Expose constants and structs
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
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

20.10.2017 01:26, Eric Blake wrote:
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
>
> Based on patches from Vladimir Sementsov-Ogievskiy.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

you forgot
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir
