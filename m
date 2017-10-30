Received: from eggs.gnu.org ([2001:4830:134:3::10]:36008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9EHK-0003HS-DT
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9EHJ-0002Iz-J3
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:55:14 -0400
References: <20171027104037.8319-1-eblake@redhat.com>
	<20171027104037.8319-13-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <60d6e8df-8544-90ad-b4f1-12a6a350fe48@virtuozzo.com>
Date: Mon, 30 Oct 2017 20:55:00 +0300
MIME-Version: 1.0
In-Reply-To: <20171027104037.8319-13-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 12/12] nbd: Minimal structured read for
 client
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

27.10.2017 13:40, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Minimal implementation: for structured error only error_report error
> message.
>
> Note that test 83 is now more verbose, because the implementation
> prints more warnings about unexpected communication errors; perhaps
> future patches should tone things down by using trace messages
> instead of traces, but the common case of successful communication
> is no noisier than before.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

ok for me, thank you!

>
> ---
> v6: tweak overflow check [Vladimir], fix reads to use absolute offset
> from server by tracking original offset, fix talking to old-style server,
> tweak iotest 83 output to account for new verbosity
> v5: fix payload_advance[32,64], return correct negative error on
> structured error, rearrange size checks to not be vulnerable to
> overflow, simplify payload to use g_new instead of qemu_memalign,
> don't set errp when returning 0, validate that error message
> length is sane
>

-- 
Best regards,
Vladimir
