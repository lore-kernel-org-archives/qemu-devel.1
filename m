Received: from eggs.gnu.org ([2001:4830:134:3::10]:32920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gVFF1-0003El-Jx
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gVFEx-0003VK-98
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:28:23 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181205144700.26563-2-vsementsov@virtuozzo.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
	<20181205144700.26563-2-vsementsov@virtuozzo.com>
Date: Fri, 07 Dec 2018 13:27:35 +0100
Message-ID: <w511s6twmh4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/5] crypto/block-luks: fix
 memory leak in qcrypto_block_luks_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, berrange@redhat.com, mreitz@redhat.com

On Wed 05 Dec 2018 03:46:56 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> Free block->cipher and block->ivgen on error path.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
