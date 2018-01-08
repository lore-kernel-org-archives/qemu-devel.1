Received: from eggs.gnu.org ([2001:4830:134:3::10]:39481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYSQt-0002KU-VK
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYSQt-00025V-07
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:05:23 -0500
Date: Mon, 8 Jan 2018 16:05:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180108080507.GC5443@lemon.usersys.redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
	<20180105225753.30509-10-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105225753.30509-10-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 09/20] parallels: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, jcody@redhat.com, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Fri, 01/05 16:57, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the parallels driver accordingly.  Note that
> the internal function block_status() is still sector-based, because
> it is still in use by other sector-based functions; but that's okay
> because request_alignment is 512 as a result of those functions.
> For now, no optimizations are added based on the mapping hint.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
