Received: from eggs.gnu.org ([2001:4830:134:3::10]:39772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUkvp-0006eN-L5
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 22:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUkvo-0005XS-VL
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 22:02:01 -0500
Date: Fri, 29 Dec 2017 11:01:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171229030147.GJ13004@lemon>
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-12-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207203036.14993-12-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 11/20] qcow2: Switch to
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

On Thu, 12/07 14:30, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the qcow2 driver accordingly.
> 
> For now, we are ignoring the 'want_zero' hint.  However, it should
> be relatively straightforward to honor the hint as a way to return
> larger *pnum values when we have consecutive clusters with the same
> data/zero status but which differ only in having non-consecutive
> mappings.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
