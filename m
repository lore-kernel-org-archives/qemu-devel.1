Received: from eggs.gnu.org ([2001:4830:134:3::10]:44839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXYxX-0003J7-IB
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXYxW-0000gb-I9
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:23:39 -0400
References: <20180625165745.25259-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b021509d-71fe-2c16-6f66-1e6277940988@redhat.com>
Date: Mon, 25 Jun 2018 17:23:30 -0400
MIME-Version: 1.0
In-Reply-To: <20180625165745.25259-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] dirty bitmap fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org



On 06/25/2018 12:57 PM, Vladimir Sementsov-Ogievskiy wrote:
> Vladimir Sementsov-Ogievskiy (2):
>   block/dirty-bitmap: add bdrv_enable_dirty_bitmap_locked
>   dirty-bitmap: fix double lock on bitmap enabling
> 
>  include/block/dirty-bitmap.h   |  1 +
>  block/dirty-bitmap.c           | 12 +++++++++---
>  migration/block-dirty-bitmap.c |  4 ++--
>  3 files changed, 12 insertions(+), 5 deletions(-)
> 

ACK,

though it looks really odd that we've got enable/disable but only one
corresponding _locked version.

I have a patch somewhere in my local files to create a combined
_set_disabled() that would cut the number of functions we have by a
little bit.

I'll take this first though, as an iotest fix.

--js
