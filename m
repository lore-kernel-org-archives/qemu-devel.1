Received: from eggs.gnu.org ([2001:4830:134:3::10]:37508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6IhQ-0007Zc-Gb
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6IhP-0000sf-Pj
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:34:20 -0400
References: <20180411122606.367301-1-vsementsov@virtuozzo.com>
	<20180411122606.367301-2-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f053af10-6c4a-496e-77d9-e01d65eb2eac@redhat.com>
Date: Wed, 11 Apr 2018 18:33:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180411122606.367301-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qcow2: try load bitmaps only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com

On 2018-04-11 14:26, Vladimir Sementsov-Ogievskiy wrote:
> Checking reopen by existence of some bitmaps is wrong, as it may be
> some other bitmaps, or on the other hand, user may remove bitmaps. This
> criteria is bad. To simplify things and make behavior more predictable
> let's just add a flag to remember, that we've already tried to load
> bitmaps on open and do not want do it again.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.h |  1 +
>  block/qcow2.c | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>
