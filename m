Received: from eggs.gnu.org ([2001:4830:134:3::10]:54099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6YaR-0008O6-Mu
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6YaQ-0000ae-Rr
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:27:39 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6YaQ-0000aM-La
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:27:38 -0400
Received: by mail-wr0-x22f.google.com with SMTP id z52so19670890wrc.2
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 01:27:38 -0700 (PDT)
References: <20170505032340.26467-1-famz@redhat.com>
	<20170505032340.26467-6-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170505032340.26467-6-famz@redhat.com>
Date: Fri, 05 May 2017 09:28:17 +0100
Message-ID: <87ziern1we.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/5] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/test-block | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100755 tests/docker/test-block
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

Shouldn't we allow for non-default targets like the other tests?

> +cd tests/qemu-iotests
> +./check -raw
> +./check -qcow2


--
Alex Bennée
