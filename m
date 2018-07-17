Received: from eggs.gnu.org ([2001:4830:134:3::10]:55058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffGnf-00040f-8l
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 23:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffGna-00083F-KD
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 23:37:19 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:41406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffGna-000839-F8
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 23:37:14 -0400
Received: by mail-vk0-x243.google.com with SMTP id j11-v6so22825211vke.8
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 20:37:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4bb9edb6-0c3d-93ce-fffa-6366449532aa@amsat.org>
Date: Tue, 17 Jul 2018 00:37:06 -0300
MIME-Version: 1.0
In-Reply-To: <20180713121741.19262-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 10/16] docker: add test-unit
 runner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 07/13/2018 09:17 AM, Alex Bennée wrote:
> This test doesn't even build QEMU, it just builds and runs all the
> unit tests. Intended to make checking unit tests on all docker images
> easier.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> ---
> v2
>   - make script -e to error out on failure
>   - add comment as to why the configure step is run
> ---
>  tests/docker/test-unit | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100755 tests/docker/test-unit
> 
> diff --git a/tests/docker/test-unit b/tests/docker/test-unit
> new file mode 100755
> index 0000000000..8905d01150
> --- /dev/null
> +++ b/tests/docker/test-unit
> @@ -0,0 +1,21 @@
> +#!/bin/bash -e
> +#
> +# Build and run the unit tests
> +#
> +# Copyright (c) 2018 Linaro Ltd.
> +#
> +# Authors:
> +#  Alex Bennée <alex.bennee@linaro.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2
> +# or (at your option) any later version. See the COPYING file in
> +# the top-level directory.
> +
> +. common.rc
> +
> +cd "$BUILD_DIR"
> +
> +# although we are not building QEMU itself we still need a configured
> +# build for the unit tests to be built and run
> +configure_qemu
> +check_qemu check-unit
> 
