Received: from eggs.gnu.org ([2001:4830:134:3::10]:33652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epHpb-00069q-Fr
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epHpa-0002Hw-Ih
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:12:27 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:46006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epHpa-0002HW-BL
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:12:26 -0500
Received: by mail-pg0-x244.google.com with SMTP id e11so3641170pgq.12
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:12:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223154613.2096-6-alex.bennee@linaro.org>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
	<20180223154613.2096-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 18:12:04 +0000
Message-ID: <CAFEAcA-R3CCvm_O=D8AprQc-8mnyjARrtdmH1146cSKCarFyyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 5/8] contrib/run_risu.sh: allow
 appending of QEMU_FLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 23 February 2018 at 15:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Useful if you want to disable a feature for your run. For example:
>
>   set -x QEMU_FLAGS "-cpu fp16=3Doff"
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  contrib/run_risu.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/run_risu.sh b/contrib/run_risu.sh
> index 439cd36..63649dd 100755
> --- a/contrib/run_risu.sh
> +++ b/contrib/run_risu.sh
> @@ -13,6 +13,7 @@
>  #
>  # Usage:
>  #   (optional) export QEMU=3D/path/to/qemu
> +#   (optional) export QEMU_FLAGS=3D"-cpu any,fp16=3Doff"
>  #   (optional) export RISU=3D/path/to/risu
>  #   ./run_risu.sh  ./testcases.aarch64/*.bin
>
> @@ -29,9 +30,10 @@ fi
>
>  for f in $@; do
>      t=3D"$f.trace"
> -    echo "Running $f against $t"
> +    CMD=3D"${QEMU} ${QEMU_FLAGS} ${RISU} $f -t $t"
> +    echo "Running: ${CMD}"
>      if [ -e $t ]; then
> -        ${QEMU} ${RISU} $f -t $t
> +        ${CMD}

Well, you used to be able to do this by setting
QEMU=3D"path/to/qemu -cpu whatever", but now you can't :-)

thanks
-- PMM
