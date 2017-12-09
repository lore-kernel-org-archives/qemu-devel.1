Received: from eggs.gnu.org ([2001:4830:134:3::10]:35846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eNf6m-00066f-G1
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 08:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eNf6l-0005bF-Ks
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 08:24:00 -0500
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-21-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <61c85ec7-a3a0-1657-52d1-5d08b89f7c4e@virtuozzo.com>
Date: Sat, 9 Dec 2017 16:23:40 +0300
MIME-Version: 1.0
In-Reply-To: <20171207203036.14993-21-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 20/20] block: Drop unused
 .bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

07.12.2017 23:30, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Now that all drivers have been updated to provide the
> byte-based .bdrv_co_block_status(), we can delete the sector-based
> interface.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
