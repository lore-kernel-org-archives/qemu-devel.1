Received: from eggs.gnu.org ([2001:4830:134:3::10]:51704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUkYS-0005az-S8
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 21:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUkYP-0007gG-QE
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 21:37:52 -0500
Date: Fri, 29 Dec 2017 10:37:40 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171229023740.GC13004@lemon>
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207203036.14993-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 02/20] block: Switch passthrough drivers
 to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, 12/07 14:30, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the generic helpers, and all passthrough clients
> (blkdebug, commit, mirror, throttle) accordingly.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> ---
> v5: rebase to master

Reviewed-by: Fam Zheng <famz@redhat.com>
