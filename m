Received: from eggs.gnu.org ([2001:4830:134:3::10]:59030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzIaj-0006Q1-4U
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzIVy-0005yz-QC
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:29:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzIVy-0005yK-B7
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:29:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id s14-v6so12149290wrw.6
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 02:29:50 -0700 (PDT)
References: <20180908191735.22861-1-cota@braap.org>
	<20180908191735.22861-2-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180908191735.22861-2-cota@braap.org>
Date: Mon, 10 Sep 2018 10:29:47 +0100
Message-ID: <87bm95d7jo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] gitmodules: add berkeley's
 softfloat + testfloat version 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>


Emilio G. Cota <cota@braap.org> writes:

> These are BSD-licensed so we can add them as submodules.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  .gitmodules                   | 6 ++++++
>  tests/fp/berkeley-softfloat-3 | 1 +
>  tests/fp/berkeley-testfloat-3 | 1 +
>  3 files changed, 8 insertions(+)
>  create mode 160000 tests/fp/berkeley-softfloat-3
>  create mode 160000 tests/fp/berkeley-testfloat-3
>
> diff --git a/.gitmodules b/.gitmodules
> index d108478e0a..165c7c5286 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -43,3 +43,9 @@
>  [submodule "roms/u-boot-sam460ex"]
>  	path =3D roms/u-boot-sam460ex
>  	url =3D git://git.qemu.org/u-boot-sam460ex.git
> +[submodule "tests/fp/testfloat"]
> +	path =3D tests/fp/berkeley-testfloat-3
> +	url =3D git://github.com/ucb-bar/berkeley-testfloat-3
> +[submodule "tests/fp/berkeley-softfloat-3"]
> +	path =3D tests/fp/berkeley-softfloat-3
> +	url =3D git://github.com/ucb-bar/berkeley-softfloat-3

I think generally when we add submodules we setup a mirror at
git://git.qemu.org so we are only at the whims of our own
infrastructure. See https://wiki.qemu.org/AdminContacts

Nevertheless:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>




> diff --git a/tests/fp/berkeley-softfloat-3 b/tests/fp/berkeley-softfloat-3
> new file mode 160000
> index 0000000000..b64af41c32
> --- /dev/null
> +++ b/tests/fp/berkeley-softfloat-3
> @@ -0,0 +1 @@
> +Subproject commit b64af41c3276f97f0e181920400ee056b9c88037
> diff --git a/tests/fp/berkeley-testfloat-3 b/tests/fp/berkeley-testfloat-3
> new file mode 160000
> index 0000000000..06b20075dd
> --- /dev/null
> +++ b/tests/fp/berkeley-testfloat-3
> @@ -0,0 +1 @@
> +Subproject commit 06b20075dd3c1a5d0dd007a93643282832221612


--
Alex Benn=C3=A9e
