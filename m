Received: from eggs.gnu.org ([209.51.188.92]:51254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gqeC9-0000pe-FB
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gqdyI-0008Vc-0o
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:07:37 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gqdyB-00088J-BL
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:07:27 -0500
Received: by mail-wr1-x442.google.com with SMTP id t27so14294288wra.6
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 05:07:25 -0800 (PST)
References: <1549268743-18502-1-git-send-email-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1549268743-18502-1-git-send-email-thuth@redhat.com>
Date: Mon, 04 Feb 2019 13:07:22 +0000
Message-ID: <87o97r4s8l.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/docker/test-mingw and docs: Remove
 --with-sdlabi=2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org, Philippe =?utf-8?Q?Mathieu-?= =?utf-8?Q?Daud=C3=A9?= <philmd@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?= =?utf-8?Q?=C3=A9?= <berrange@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> Patchew currently reports failures with the mingw docker test - this
> is due to --with-sdlabi=3D2.0 configure flag which does not exist anymore.
> Remove this remainder from the docker test and the docs now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I'm happy for this to be applied directly by Peter.

> ---
>  docs/multiseat.txt      | 2 +-
>  tests/docker/test-mingw | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/docs/multiseat.txt b/docs/multiseat.txt
> index 8dde36c..11850c9 100644
> --- a/docs/multiseat.txt
> +++ b/docs/multiseat.txt
> @@ -9,7 +9,7 @@ First you must compile qemu with a user interface support=
ing
>  multihead/multiseat and input event routing.  Right now this
>  list includes sdl2, gtk (both 2+3) and vnc:
>
> -  ./configure --enable-sdl --with-sdlabi=3D2.0
> +  ./configure --enable-sdl
>
>  or
>
> diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
> index b078f22..4b84cfe 100755
> --- a/tests/docker/test-mingw
> +++ b/tests/docker/test-mingw
> @@ -27,8 +27,7 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
>          --enable-curl \
>          --enable-vnc \
>          --enable-bzip2 \
> -        --enable-guest-agent \
> -        --with-sdlabi=3D2.0
> +        --enable-guest-agent
>      install_qemu
>      make clean


--
Alex Benn=C3=A9e
