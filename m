Received: from eggs.gnu.org ([2001:4830:134:3::10]:38036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gTola-0003TL-Cq
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gTolW-0005Rz-7E
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:00:06 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181203101429.88735-9-anton.nefedov@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
	<20181203101429.88735-9-anton.nefedov@virtuozzo.com>
Date: Mon, 03 Dec 2018 14:59:21 +0100
Message-ID: <w51y3963e4m.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 8/9] qcow2: skip writing zero buffers
 to empty COW areas
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

On Mon 03 Dec 2018 11:14:59 AM CET, Anton Nefedov wrote:
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3004,6 +3004,8 @@
>  #
>  # @cor_write: a write due to copy-on-read (since 2.11)
>  #
> +# @cluster_alloc_space: an allocation of file space for a cluster (since 4.0)

Since 4.0 ??

Berto
