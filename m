Received: from eggs.gnu.org ([2001:4830:134:3::10]:45369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZaU7-0007uT-6t
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZaU6-0005cr-8o
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:21:07 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZaU6-0005bf-1z
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:21:06 -0400
Received: by mail-wm0-x22b.google.com with SMTP id c184so27528299wmd.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 03:21:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170721093416.17816-1-stefanha@redhat.com>
References: <20170721093416.17816-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 11:20:44 +0100
Message-ID: <CAFEAcA_+ffmyvExhFvm2JTmoipum6GeWiFPP5kuxRKb9+ezRzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add a "how to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, Qemu-block <qemu-block@nongnu.org>

On 21 July 2017 at 10:34, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> There is not much getting started documentation for qemu-iotests.  This
> patch explains how to create a new test and covers the overall testing
> approach.
>
> Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/README | 83 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/tests/qemu-iotests/README b/tests/qemu-iotests/README
> index 6079b40..8259b9f 100644
> --- a/tests/qemu-iotests/README
> +++ b/tests/qemu-iotests/README
> @@ -14,8 +14,91 @@ Just run ./check to run all tests for the raw image format, or ./check
>  -qcow2 to test the qcow2 image format.  The output of ./check -h explains
>  additional options to test further image formats or I/O methods.
>
> +* Testing approach
> +
> +Each test is an executable file (usually a bash script) that is run by the
> +./check test harness.  Standard out and standard error are captured to an
> +output file.  If the output file differs from the "golden master" output file
> +for the test then it fails.

Should ./check be run from the source tree, or the build tree? The
existing README text doesn't say and I don't think your additions
do either.

thanks
-- PMM
