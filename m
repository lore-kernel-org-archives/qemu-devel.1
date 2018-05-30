Received: from eggs.gnu.org ([2001:4830:134:3::10]:43186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fO7f2-00043h-7P
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fO7f1-0006af-4E
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:25:32 -0400
References: <20180530112424.204835-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cb0dbf30-c957-2038-3e31-dd3f2d16934d@redhat.com>
Date: Wed, 30 May 2018 16:25:23 -0400
MIME-Version: 1.0
In-Reply-To: <20180530112424.204835-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration/block-dirty-bitmap: fix
 dirty_bitmap_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-stable@nongnu.org, stefanha@redhat.com, den@openvz.org



On 05/30/2018 07:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> dirty_bitmap_load_header return code is obtained but not handled. Fix
> this.
> 
> Bug was introduced in b35ebdf076d697bc
> "migration: add postcopy migration of dirty bitmaps" with the whole
> function.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: John Snow <jsnow@redhat.com>
