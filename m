Received: from eggs.gnu.org ([2001:4830:134:3::10]:45482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKKSF-0001IS-7l
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKKSE-0006eN-Ge
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:44:23 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4cc1bece-19fe-4fc2-597c-da13202675e2@virtuozzo.com>
Date: Thu, 30 Nov 2017 11:44:05 +0300
MIME-Version: 1.0
In-Reply-To: <20171012185916.22776-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 04/20] gluster: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com

12.10.2017 21:59, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the gluster driver accordingly.
>
> In want_zero mode, we continue to report fine-grained hole
> information (the caller wants as much mapping detail as possible);
> but when not in that mode, the caller prefers larger *pnum and
> merely cares about what offsets are allocated at this layer, rather
> than where the holes live.  Since holes still read as zeroes at
> this layer (rather than deferring to a backing layer), we can take
> the shortcut of skipping find_allocation(), and merely state that
> all bytes are allocated.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
