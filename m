Received: from eggs.gnu.org ([209.51.188.92]:49815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ggWjf-00042k-NP
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:22:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ggWje-0003Ev-P4
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:22:39 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181218075707.12006-7-anton.nefedov@virtuozzo.com>
References: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
	<20181218075707.12006-7-anton.nefedov@virtuozzo.com>
Date: Mon, 07 Jan 2019 16:22:36 +0100
Message-ID: <w518szwxzk3.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 06/10] file-posix: reset
 fallocate-related flags without CONFIG_FALLOCATE*
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

On Tue 18 Dec 2018 08:57:40 AM CET, Anton Nefedov wrote:
> these flags currently affect nothing without CONFIG_FALLOCATE*, so it's
> not a bug. Fixing it makes possible to adjust supported zero flag
> BDRV_REQ_ALLOCATE regardless of configuration (in the following patch).
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
