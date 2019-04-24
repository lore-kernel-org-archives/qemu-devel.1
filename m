Received: from eggs.gnu.org ([209.51.188.92]:55612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJJiT-0002Ho-IY
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 11:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJJiI-0001ui-2Z
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 11:21:34 -0400
References: <20190413165343.9018-1-mreitz@redhat.com>
	<20190413165343.9018-7-mreitz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0529aa5a-3de4-204b-0d3d-608c4dbc5f9a@redhat.com>
Date: Wed, 24 Apr 2019 17:21:28 +0200
MIME-Version: 1.0
In-Reply-To: <20190413165343.9018-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/7] iotests: Test qemu-img convert
 --salvage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, "Denis V . Lunev" <den@openvz.org>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

On 13/04/2019 18.53, Max Reitz wrote:
> This test converts a simple image to another, but blkdebug injects
> block_status and read faults at some offsets.  The resulting image
> should be the same as the input image, except that sectors that could
> not be read have to be 0.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/249     | 163 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/249.out |  43 ++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 207 insertions(+)
>  create mode 100755 tests/qemu-iotests/249
>  create mode 100644 tests/qemu-iotests/249.out
> 
> diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
> new file mode 100755
> index 0000000000..d3883d75f3
> --- /dev/null
> +++ b/tests/qemu-iotests/249
> @@ -0,0 +1,163 @@
> +#!/bin/bash

Please use "#!/usr/bin/env bash" instead.

 Thanks,
  Thomas
