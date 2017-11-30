Received: from eggs.gnu.org ([2001:4830:134:3::10]:46877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKNxr-0003zi-6v
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKNxq-0005nX-CU
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:29:15 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-21-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b12fe301-d2b3-815c-1484-2cf84668cdc6@virtuozzo.com>
Date: Thu, 30 Nov 2017 15:29:02 +0300
MIME-Version: 1.0
In-Reply-To: <20171012185916.22776-21-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 20/20] block: Drop unused
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
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

12.10.2017 21:59, Eric Blake wrote:
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
