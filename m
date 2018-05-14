Received: from eggs.gnu.org ([2001:4830:134:3::10]:55709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fIDE4-0002qz-FI
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fIDE0-0007hY-Dy
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:09:16 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1525791496-125188-9-git-send-email-anton.nefedov@virtuozzo.com>
References: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1525791496-125188-9-git-send-email-anton.nefedov@virtuozzo.com>
Date: Mon, 14 May 2018 15:09:08 +0200
Message-ID: <w51sh6ucrkb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 8/9] qcow2: skip writing zero buffers to
 empty COW areas
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

On Tue 08 May 2018 04:58:15 PM CEST, Anton Nefedov wrote:
> If COW areas of the newly allocated clusters are zeroes on the backing image,
> efficient bdrv_write_zeroes(flags=BDRV_REQ_ALLOCATE) can be used on the whole
> cluster instead of writing explicit zero buffers later in perform_cow().
>
> iotest 060:
> write to the discarded cluster does not trigger COW anymore.
> Use a backing image instead.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
