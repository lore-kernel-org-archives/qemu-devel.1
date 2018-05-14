Received: from eggs.gnu.org ([2001:4830:134:3::10]:39203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fIAkZ-0003fz-8i
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fIAkT-0003St-BY
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:30:39 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1525791496-125188-5-git-send-email-anton.nefedov@virtuozzo.com>
References: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1525791496-125188-5-git-send-email-anton.nefedov@virtuozzo.com>
Date: Mon, 14 May 2018 12:29:55 +0200
Message-ID: <w51y3gmcyxo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 4/9] block: introduce BDRV_REQ_ALLOCATE
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com

On Tue 08 May 2018 04:58:11 PM CEST, Anton Nefedov wrote:
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
