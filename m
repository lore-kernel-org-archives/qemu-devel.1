Received: from eggs.gnu.org ([209.51.188.92]:58119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ggVoB-0008JW-Kk
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ggVo6-0006GO-3q
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:23:13 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181218075707.12006-5-anton.nefedov@virtuozzo.com>
References: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
	<20181218075707.12006-5-anton.nefedov@virtuozzo.com>
Date: Mon, 07 Jan 2019 15:22:50 +0100
Message-ID: <w51ef9oy2bp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 04/10] block: introduce
 BDRV_REQ_ALLOCATE flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Tue 18 Dec 2018 08:57:36 AM CET, Anton Nefedov wrote:
> The flag is supposed to indicate that the region of the disk image has
> to be sufficiently allocated so it reads as zeroes.
>
> The call with the flag set must return -ENOTSUP if allocation cannot
> be done efficiently.
> This has to be made sure of by both
>   - the drivers that support the flag
>   - and the common block layer (so it will not fall back to any slowpath
>     (like writing zero buffers) in case the driver does not support
>     the flag).
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
