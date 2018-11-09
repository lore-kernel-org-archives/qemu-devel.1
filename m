Received: from eggs.gnu.org ([2001:4830:134:3::10]:38820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL5wp-00029P-PN
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 07:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL5wa-0007a4-Np
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 07:31:34 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gL5wY-0007XF-0m
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 07:31:22 -0500
Received: by mail-wm1-x341.google.com with SMTP id f1-v6so3677336wmg.1
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 04:31:15 -0800 (PST)
References: <20181108160115.20747-1-philmd@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181108160115.20747-1-philmd@redhat.com>
Date: Fri, 09 Nov 2018 12:31:13 +0000
Message-ID: <87k1lm5t66.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] travis: Split the OSX job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> The current OSX job often reach the 50min Travis-CI time limit.
>
> Split it in two jobs, which as of this commit took:
> - system: ~39min
> - user:    ~9min
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

I suggested a different split in:

  https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01695.html

Does a user build actually build anything we can run?

> ---
>  .travis.yml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index aa49c7b114..827f2252b6 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -107,7 +107,11 @@ matrix:
>      - env: CONFIG=3D"--disable-tcg"
>             TEST_CMD=3D""
>        compiler: gcc
> -    - env: CONFIG=3D""
> +    # OSX builds
> +    - env: CONFIG=3D"--disable-user"
> +      os: osx
> +      compiler: clang
> +    - env: CONFIG=3D"--disable-system --disable-tools --disable-docs --d=
isable-guest-agent"
>        os: osx
>        compiler: clang
>      # Python builds


--
Alex Benn=C3=A9e
