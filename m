Received: from eggs.gnu.org ([209.51.188.92]:48847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ggWgt-0002Ic-Qy
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ggWgs-0008SM-GW
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:19:47 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181218075707.12006-6-anton.nefedov@virtuozzo.com>
References: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
	<20181218075707.12006-6-anton.nefedov@virtuozzo.com>
Date: Mon, 07 Jan 2019 16:19:43 +0100
Message-ID: <w51bm4sxzow.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 05/10] block: treat BDRV_REQ_ALLOCATE
 as serialising
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

On Tue 18 Dec 2018 08:57:38 AM CET, Anton Nefedov wrote:
> The idea is that ALLOCATE requests may overlap with other requests.
> Reuse the existing block layer infrastructure for serialising requests.
> Use the following approach:
>   - mark ALLOCATE also SERIALISING, so subsequent requests to the area wait
>   - ALLOCATE request itself must never wait if another request is in flight
>     already. Return EAGAIN, let the caller reconsider.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
