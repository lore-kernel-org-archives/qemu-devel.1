Received: from eggs.gnu.org ([2001:4830:134:3::10]:57257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmhj-000071-Tv
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmhf-0005Pj-1j
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:04:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54616 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fcmhe-0005PM-Tc
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:04:50 -0400
Date: Tue, 10 Jul 2018 15:04:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180710070446.GM17581@lemon.usersys.redhat.com>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
	<20180709152117.21585-10-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180709152117.21585-10-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.0 09/10] docker: add test-unit runner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On Mon, 07/09 16:21, Alex Benn=E9e wrote:
> This test doesn't even build QEMU, it just runs all the unit tests.
> Intended to make checking unit tests on all docker images easier.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/test-unit | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100755 tests/docker/test-unit
>=20
> diff --git a/tests/docker/test-unit b/tests/docker/test-unit
> new file mode 100755
> index 0000000000..be0d90d748
> --- /dev/null
> +++ b/tests/docker/test-unit
> @@ -0,0 +1,19 @@
> +#!/bin/bash
> +#
> +# Build and run the unit tests
> +#
> +# Copyright (c) 2018 Linaro Ltd.
> +#
> +# Authors:
> +#  Alex Benn=E9e <alex.bennee@linaro.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2
> +# or (at your option) any later version. See the COPYING file in
> +# the top-level directory.
> +
> +. common.rc
> +
> +cd "$BUILD_DIR"
> +
> +configure_qemu

This reads a bit unusual and counter-intuitive: how could configure_qemu =
succeed
when the env cannot actually build it? Does configure_qemu fail but the s=
ide
effects needed to run build and run unit tests are done anyway?  Either w=
ay,
please add a comment explaining what is happening here.

Also, should we test the exit code of configure_qemu?

> +check_qemu check-unit
> --=20
> 2.17.1
>=20
