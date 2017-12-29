Received: from eggs.gnu.org ([2001:4830:134:3::10]:56777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUlKR-0008JP-NV
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 22:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUlKO-0007gI-Hv
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 22:27:27 -0500
Date: Fri, 29 Dec 2017 11:27:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171229032717.GC27028@lemon>
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-21-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207203036.14993-21-eblake@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, 12/07 14:30, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Now that all drivers have been updated to provide the
> byte-based .bdrv_co_block_status(), we can delete the sector-based
> interface.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
