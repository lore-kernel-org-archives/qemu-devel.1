Received: from eggs.gnu.org ([2001:4830:134:3::10]:59338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG72M-0006ey-6v
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG72J-0006vD-0l
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:03:58 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:16660 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dG72I-0006ur-M9
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:03:54 -0400
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
	<20170531165541.47338-2-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3d5ae16d-4973-d45f-3e7b-9f45108e8841@virtuozzo.com>
Date: Wed, 31 May 2017 20:03:52 +0300
MIME-Version: 1.0
In-Reply-To: <20170531165541.47338-2-vsementsov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/12] nbd: rename read_sync and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, den@openvz.org

31.05.2017 19:55, Vladimir Sementsov-Ogievskiy wrote:
> Rename
>    nbd_wr_syncv -> nbd_rwv
>    read_sync -> nbd_read
>    read_sync_eof -> nbd_read_eof
>    write_sync -> nbd_write
>    drop_sync -> nbd_drop
>
> 1. nbd_ prefix
>     read_sync and write_sync are already shared, so it is good to have a
>     namespace prefix. drop_sync will be shared, and read_sync_eof is
>     related to read_sync, so let's rename them all.
>
> 2. _sync suffix
>     _sync is related to the fact, that nbd_wr_syncv doesn't return if
>     write to socket returns EAGAIN. In first implementation nbd_wr_syncv

not bad to add here the following note in parentheses. Please add it in 
flight, if no more updates required for the series.
(was wr_sync in 7a5ca8648b)

>     just loops while getting EAGAIN, current implementation yields in
>     this case.
>     Why to get rid of it:
>     - it is normal for r/w functions to be synchronous, so having
>       additional suffix for it looks redundant (contrariwise, we have
>       _aio suffix for async functions)
>     - _sync suffix in block layer is used when function does flush (so
>       using it for other thing is confusing a bit)
>     - keep function names short after adding nbd_ prefix
>
> 3. for nbd_wr_syncv let's use more common notation 'rw'
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

-- 
Best regards,
Vladimir
