Received: from eggs.gnu.org ([2001:4830:134:3::10]:44526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqf0e-0002kI-Pc
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqf0e-0000nD-2X
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:41:48 -0400
References: <20180802144834.520904-1-eblake@redhat.com>
	<20180802144834.520904-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <49149b03-e63e-51e5-9b88-c1d1aecad4c5@virtuozzo.com>
Date: Fri, 17 Aug 2018 16:41:35 +0300
MIME-Version: 1.0
In-Reply-To: <20180802144834.520904-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/4] block: Add bdrv_get_request_alignment()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

02.08.2018 17:48, Eric Blake wrote:
> The next patch needs access to a device's minimum permitted
> alignment, since NBD wants to advertise this to clients. Add
> an accessor function, borrowing from blk_get_max_transfer()
> for accessing a backend's block limits.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
