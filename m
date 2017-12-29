Received: from eggs.gnu.org ([2001:4830:134:3::10]:46028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUl4Z-0002hJ-CL
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 22:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUl4Y-0004vR-EX
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 22:11:03 -0500
Date: Fri, 29 Dec 2017 11:10:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171229031054.GO13004@lemon>
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207203036.14993-17-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 16/20] vdi: Switch to
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>

On Thu, 12/07 14:30, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the vdi driver accordingly.  Note that the
> TODO is already covered (the block layer guarantees bounds of its
> requests), and that we can remove the now-unused s->block_sectors.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
