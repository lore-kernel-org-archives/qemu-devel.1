Received: from eggs.gnu.org ([2001:4830:134:3::10]:37566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUQcx-00020A-31
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUQcw-0003Ct-Db
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:21:11 -0500
Date: Thu, 28 Dec 2017 13:20:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171228052056.GB9192@lemon>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220154945.88410-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v9 02/13] block/dirty-bitmap: fix locking
 in bdrv_reclaim_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, quintela@redhat.com, jsnow@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

On Wed, 12/20 18:49, Vladimir Sementsov-Ogievskiy wrote:
> Like other setters here these functions should take a lock.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
