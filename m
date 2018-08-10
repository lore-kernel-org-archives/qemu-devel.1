Received: from eggs.gnu.org ([2001:4830:134:3::10]:60403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fo65y-0004rL-BL
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fo65u-0008NS-0U
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:00:42 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180810062647.23211-7-lbloch@janustech.com>
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-7-lbloch@janustech.com>
Date: Fri, 10 Aug 2018 14:00:33 +0200
Message-ID: <w5136vm8m8u.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 6/9] qcow2: Increase the default upper
 limit on the L2 cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri 10 Aug 2018 08:26:44 AM CEST, Leonid Bloch wrote:
> The upper limit on the L2 cache size is increased from 1 MB to 32 MB.
> This is done in order to allow default full coverage with the L2 cache
> for images of up to 256 GB in size (was 8 GB). Note, that only the
> needed amount to cover the full image is allocated. The value which is
> changed here is just the upper limit on the L2 cache size, beyond which
> it will not grow, even if the size of the image will require it to.
>
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

> -#define DEFAULT_L2_CACHE_MAX_SIZE (1 * MiB)
> +#define DEFAULT_L2_CACHE_MAX_SIZE (32 * MiB)

The patch looks perfect to me now and I'm fine with this change, but
this is quite an increase from the previous default value. If anyone
thinks that this is too aggressive (or too little :)) I'm all ears.

Berto
