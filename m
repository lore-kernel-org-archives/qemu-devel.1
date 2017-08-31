Received: from eggs.gnu.org ([2001:4830:134:3::10]:48737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnSB5-0004lX-HV
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnSB0-0008B1-PT
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:18:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnSB0-0008Ak-J7
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:18:42 -0400
Date: Thu, 31 Aug 2017 17:18:35 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170831161835.GQ17315@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170831112210.19921-1-famz@redhat.com>
	<20170831112210.19921-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170831112210.19921-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Thu, Aug 31, 2017 at 07:22:10PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/test-block | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100755 tests/docker/test-block
> 
> diff --git a/tests/docker/test-block b/tests/docker/test-block
> new file mode 100755
> index 0000000000..20ef70538f
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

Could you add  'check -luks' - it should be passing already with git
master.  Ideally it wants password-less sudo enabled, but will skip
the appropriate test if that's not there.

'qcow' (v1) was also passing last time I checked, though it is
waaaaaay slow to run compared to qcow2, so I'd understand if you
were reluctant to turn that on due to speed

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
