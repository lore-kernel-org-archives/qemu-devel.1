Received: from eggs.gnu.org ([2001:4830:134:3::10]:39375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsHFQ-0004Kh-Bt
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsHFP-0007AN-F8
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:39:12 -0400
References: <20170912203119.24166-1-eblake@redhat.com>
	<20170912203119.24166-7-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e22c68ed-b258-1159-a9eb-bf0f19e383bb@redhat.com>
Date: Wed, 13 Sep 2017 19:39:00 -0400
MIME-Version: 1.0
In-Reply-To: <20170912203119.24166-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 06/20] dirty-bitmap: Change
 bdrv_dirty_bitmap_size() to report bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 09/12/2017 04:31 PM, Eric Blake wrote:
> We're already reporting bytes for bdrv_dirty_bitmap_granularity();
> mixing bytes and sectors in our return values is a recipe for
> confusion.  A later cleanup will convert dirty bitmap internals
> to be entirely byte-based, but in the meantime, we should report
> the bitmap size in bytes.
> 
> The only external caller in qcow2-bitmap.c is temporarily more verbose
> (because it is still using sector-based math), but will later be
> switched to track progress by bytes instead of sectors.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: John Snow <jsnow@redhat.com>
