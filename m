Received: from eggs.gnu.org ([2001:4830:134:3::10]:37833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9Gcr-0002Bu-Rs
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9Gcr-0002j4-4X
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:57:53 -0400
References: <20180326104037.6894-1-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2d136a42-1896-2add-6614-abfd2cf4be41@redhat.com>
Date: Thu, 19 Apr 2018 16:57:47 -0400
MIME-Version: 1.0
In-Reply-To: <20180326104037.6894-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] block: simplify code
 around releasing bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org



On 03/26/2018 06:40 AM, Paolo Bonzini wrote:
> QLIST_REMOVE does not require walking the list, and once the "bitmap"
> argument is removed from bdrv_do_release_matching_dirty_bitmap_locked
> the code simplifies a lot and it is worth inlining everything in the
> callers of bdrv_do_release_matching_dirty_bitmap.
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
> 
> Notes:
>     v1->v2: improve locking comments [Vladimir]
> 


Thanks, applied to my bitmaps tree:

https://github.com/jnsnow/qemu/commits/bitmaps
https://github.com/jnsnow/qemu.git

--js
