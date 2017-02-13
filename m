Received: from eggs.gnu.org ([2001:4830:134:3::10]:33477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cdCAq-0008Cb-8J
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cdCAp-0000or-Cl
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:39:52 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170212014724.10618-1-mreitz@redhat.com>
References: <20170212014724.10618-1-mreitz@redhat.com>
Date: Mon, 13 Feb 2017 09:39:07 +0100
Message-ID: <w51lgtazdqs.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Swap request limit
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Sun 12 Feb 2017 02:47:24 AM CET, Max Reitz <mreitz@redhat.com> wrote:

> -#define BDRV_REQUEST_MAX_SECTORS MIN(SIZE_MAX >> BDRV_SECTOR_BITS, \
> -                                     INT_MAX >> BDRV_SECTOR_BITS)
> -#define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS)
> +#define BDRV_REQUEST_MAX_BYTES      MIN(SIZE_MAX, INT_MAX)
> +#define BDRV_REQUEST_MAX_SECTORS    (BDRV_REQUEST_MAX_BYTES >> BDRV_SECTOR_BITS)

I'm just pointing it out because I don't know if this can cause
problems, but this patch would make BDRV_REQUEST_MAX_BYTES not a
multiple of the sector size (INT_MAX is actually a prime number).

Berto
