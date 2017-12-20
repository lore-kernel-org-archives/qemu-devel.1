Received: from eggs.gnu.org ([2001:4830:134:3::10]:55772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRf0e-0006e1-U0
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRf0d-0006e6-TO
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:06:12 -0500
References: <20171212160450.17510-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7d53138b-6ae5-c157-f98c-07026eea432b@virtuozzo.com>
Date: Wed, 20 Dec 2017 17:05:58 +0300
MIME-Version: 1.0
In-Reply-To: <20171212160450.17510-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/3] fix bitmaps migration through
 shared storage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, crosa@redhat.com, ehabkost@redhat.com, den@openvz.org, jsnow@redhat.com

Should qemu-stable be here?


12.12.2017 19:04, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
>
> This fixes bitmaps migration through shared storage. Look at 02 for
> details.
>
> The bug introduced in 2.10 with the whole qcow2 bitmaps feature, so
> qemu-stable in CC. However I doubt that someone really suffered from this.
>
> v2:
>     John, thank you for reviewing v1.
>     changes:
>      add John's r-bs, change s/timeout=10/timeout=10.0/ in last patch
>      and drop old 03 patch, related to this timeout fix.
>
> Vladimir Sementsov-Ogievskiy (3):
>    qcow2-bitmap: add qcow2_reopen_bitmaps_rw_hint()
>    qcow2: handle reopening bitmaps on bdrv_invalidate_cache
>    iotests: add dirty bitmap migration test
>
>   block/qcow2.h              |  2 ++
>   block/qcow2-bitmap.c       | 15 ++++++++-
>   block/qcow2.c              |  8 ++++-
>   tests/qemu-iotests/169     | 82 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/169.out |  5 +++
>   tests/qemu-iotests/group   |  1 +
>   6 files changed, 111 insertions(+), 2 deletions(-)
>   create mode 100755 tests/qemu-iotests/169
>   create mode 100644 tests/qemu-iotests/169.out
>


-- 
Best regards,
Vladimir
