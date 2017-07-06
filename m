Received: from eggs.gnu.org ([2001:4830:134:3::10]:32769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTGRJ-00009k-BL
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTGRI-0003mm-JH
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:44:05 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-5-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c9ed6265-d0d4-49cf-8f0f-c859a1f02171@redhat.com>
Date: Thu, 6 Jul 2017 19:43:54 -0400
MIME-Version: 1.0
In-Reply-To: <20170703151051.31327-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 04/17] dirty-bitmap: Drop unused
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



On 07/03/2017 11:10 AM, Eric Blake wrote:
> We had several functions that no one is currently using, and which
> use sector-based interfaces.  I'm trying to convert towards byte-based
> interfaces, so it's easier to just drop the unused functions:
> 
> bdrv_dirty_bitmap_get_meta
> bdrv_dirty_bitmap_get_meta_locked
> bdrv_dirty_bitmap_reset_meta
> bdrv_dirty_bitmap_meta_granularity
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Admittedly I forget entirely why some of these are here, or to be more
precise I forget entirely why they are unused as I remember exactly why
we needed them -- but I forget why we merged them without a caller.

Oh well. If they're unused, they're unused, and can be re-added,
especially if we're changing the underpinnings.

I bet my last review on this email used nearly identical wordings.

I'm CCing Vladimir so he has a chance to see that we're removing
functions that he may have wanted to use for his migration series.

Reviewed-by: John Snow <jsnow@redhat.com>
