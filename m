Received: from eggs.gnu.org ([2001:4830:134:3::10]:46120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ymankad@redhat.com>) id 1d7kKX-0002jI-Rb
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ymankad@redhat.com>) id 1d7kKT-0008Bk-Nf
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:12:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ymankad@redhat.com>) id 1d7kKT-0008BX-Gk
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:12:05 -0400
References: <20170505032340.26467-1-famz@redhat.com>
	<20170505032340.26467-6-famz@redhat.com>
From: Yash Mankad <ymankad@redhat.com>
Message-ID: <822278f4-c684-3738-4c16-c1169c913970@redhat.com>
Date: Mon, 8 May 2017 11:11:56 -0400
MIME-Version: 1.0
In-Reply-To: <20170505032340.26467-6-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>


On 05/04/2017 11:23 PM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   tests/docker/test-block | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>   create mode 100755 tests/docker/test-block
>
> diff --git a/tests/docker/test-block b/tests/docker/test-block
> new file mode 100755
> index 0000000..20ef705
> --- /dev/null
> +++ b/tests/docker/test-block
> @@ -0,0 +1,21 @@
> +#!/bin/bash -e
> +#
> +# Run block test cases
> +#
> +# Copyright (c) 2017 Red Hat Inc.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2
> +# or (at your option) any later version. See the COPYING file in
> +# the top-level directory.
> +
> +. common.rc
> +
> +cd "$BUILD_DIR"
> +
> +build_qemu --target-list=x86_64-softmmu
> +cd tests/qemu-iotests
> +./check -raw
> +./check -qcow2

Could you also consider running -nbd tests ?

Yash
