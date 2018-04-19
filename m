Received: from eggs.gnu.org ([2001:4830:134:3::10]:42883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9IOG-0001mw-SN
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9IOG-0005lu-2v
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:50:56 -0400
References: <20180416114414.18406-1-vsementsov@virtuozzo.com>
	<20180416114414.18406-7-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <78e75070-0ba5-b181-dee8-2dccee8f47bf@redhat.com>
Date: Thu, 19 Apr 2018 18:50:49 -0400
MIME-Version: 1.0
In-Reply-To: <20180416114414.18406-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/7] block/dirty-bitmap:
 bdrv_clear_dirty_bitmap: drop unused parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org



On 04/16/2018 07:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> Drop parameter "HBitmap **out" which is unused now, all callers set
> it to NULL.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

And now this patch is in question too.
