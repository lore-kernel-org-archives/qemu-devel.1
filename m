Received: from eggs.gnu.org ([2001:4830:134:3::10]:54016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwdNC-00007D-P8
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 20:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwdNB-0002so-RU
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 20:05:14 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dwdNB-0002sU-EZ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 20:05:13 -0400
Received: by mail-wr0-x244.google.com with SMTP id b9so982010wra.0
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 17:05:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170925082913.22089-1-famz@redhat.com>
References: <20170925082913.22089-1-famz@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 25 Sep 2017 17:04:41 -0700
Message-ID: <CAKmqyKNZW=JBc4xTpg1wisqD2_eLEPJvqtVMMacCt9mrNgEY-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] docker: Fix test-mingw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Mon, Sep 25, 2017 at 1:29 AM, Fam Zheng <famz@redhat.com> wrote:
> Feature "dtc" is explicitly required by test-mingw, but is not detected
> by the run script since we switched to archive-source.sh in b7f404201e4.
> Since it isn't available in the Fedora image which runs this test on
> patchew, the way we get dtc is still from submodule.
>
> archive-source.sh takes care of bundling the submodule files already, so
> what we need to do is just checking if files are there. Makefile is
> chosen because it is one that is unlikely to get renamed in the future.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  tests/docker/run | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tests/docker/run b/tests/docker/run
> index c8f940de15..0fd2f358ce 100755
> --- a/tests/docker/run
> +++ b/tests/docker/run
> @@ -31,6 +31,9 @@ mkdir -p $TEST_DIR/{src,build,install}
>
>  # Extract the source tarballs
>  tar -C $TEST_DIR/src -xf $BASE/qemu.tar || prep_fail "Failed to untar source"
> +if test -f $TEST_DIR/src/Makefile; then
> +    export FEATURES="$FEATURES dtc"
> +fi
>
>  if test -n "$SHOW_ENV"; then
>      if test -f /packages.txt; then
> --
> 2.13.5
>
>
