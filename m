Received: from eggs.gnu.org ([209.51.188.92]:55598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gtDUB-0006BQ-P6
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gtDUB-0003sw-1P
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:27:07 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190211144421.106232-9-vsementsov@virtuozzo.com>
References: <20190211144421.106232-1-vsementsov@virtuozzo.com>
	<20190211144421.106232-9-vsementsov@virtuozzo.com>
Date: Mon, 11 Feb 2019 16:27:00 +0100
Message-ID: <w51pnryuz0b.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 8/9] qcow2: bdrv_co_pwritev: move
 encryption code out of the lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, berrange@redhat.com

On Mon 11 Feb 2019 03:44:20 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> Encryption will be done in threads, to take benefit of it, we should
> move it out of the lock first.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
