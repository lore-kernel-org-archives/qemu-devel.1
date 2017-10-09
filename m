Received: from eggs.gnu.org ([2001:4830:134:3::10]:46990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e1gM5-00070U-Sp
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e1gM5-00017m-5H
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:16:57 -0400
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
	<20171002143919.207741-3-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d488c01b-e1ba-a79a-38f1-dd881dc26ba0@redhat.com>
Date: Mon, 9 Oct 2017 18:16:46 -0400
MIME-Version: 1.0
In-Reply-To: <20171002143919.207741-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] backup: move from done_bitmap to
 copy_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org



On 10/02/2017 10:39 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use HBitmap copy_bitmap instead of done_bitmap. This is needed to
> improve incremental backup in following patches and to unify backup
> loop for full/incremental modes in future patches.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Jeff Cody <jcody@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
