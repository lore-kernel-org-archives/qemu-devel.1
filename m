Received: from eggs.gnu.org ([2001:4830:134:3::10]:51204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIEpl-00048l-Sl
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIEpf-0008W1-V6
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:47:45 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIEpf-0008Vt-PF
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:47:39 -0400
Received: by mail-wm0-x231.google.com with SMTP id n195so101116742wmg.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 06:47:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170602160848.4913-10-alex.bennee@linaro.org>
References: <20170602160848.4913-1-alex.bennee@linaro.org>
	<20170602160848.4913-10-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 14:47:17 +0100
Message-ID: <CAFEAcA81E8LTdQjMHypTZwEueoytJ2n1_C9ofwJmZ=esU++c+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v4 09/10] new: record_traces.sh helper
 script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 June 2017 at 17:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> A simple script to run through a bunch of binaries and generate their
> trace files.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v3
>   - allow overriding of RISU binary
> ---
>  record_traces.sh | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100755 record_traces.sh
>
> diff --git a/record_traces.sh b/record_traces.sh
> new file mode 100755
> index 0000000..78ce47f
> --- /dev/null
> +++ b/record_traces.sh
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +#
> +# Record traces
> +#
> +# A risu helper script to batch process a bunch of binaries and record t=
heir outputs
> +#

Can we have a license statement, copyright line and a
usage summary, please? (Ditto patch 10). I'm not sure if
these scripts are intended for testing purposes or as
something that risu users might want to use -- if the
latter then also documenting them in README would be
a good idea.

> +set -e
> +
> +if test -z "$RISU"; then
> +    script_dir=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd -P)
> +    RISU=3D${script_dir}/risu
> +fi
> +
> +for f in $@; do
> +    echo "Running risu against $f"
> +    t=3D"$f.trace"
> +    ${RISU} --master $f -t $t
> +    echo "Checking trace file OK"
> +    ${RISU} $f -t $t
> +done
> --
> 2.13.0

thanks
-- PMM
