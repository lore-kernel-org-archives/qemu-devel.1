Received: from eggs.gnu.org ([2001:4830:134:3::10]:56303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gS1HN-0000Lo-LC
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gS1HJ-0003nm-6w
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:57:29 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gS1HI-0003nJ-VD
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:57:25 -0500
Received: by mail-wr1-x443.google.com with SMTP id j10so26613732wru.4
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 06:57:24 -0800 (PST)
References: <20181123230206.12629-1-cota@braap.org>
	<20181123230206.12629-2-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123230206.12629-2-cota@braap.org>
Date: Wed, 28 Nov 2018 14:57:22 +0000
Message-ID: <877egx45d9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] qht-bench: document -p flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Which we forgot to do in bd224fce60 ("qht-bench: add -p flag
> to precompute hash values", 2018-09-26).
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/qht-bench.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/qht-bench.c b/tests/qht-bench.c
> index 2089e2bed1..636750d39f 100644
> --- a/tests/qht-bench.c
> +++ b/tests/qht-bench.c
> @@ -72,6 +72,7 @@ static const char commands_string[] =3D
>      " -n =3D number of threads\n"
>      "\n"
>      " -o =3D offset at which keys start\n"
> +    " -p =3D precompute hashes\n"
>      "\n"
>      " -g =3D set -s,-k,-K,-l,-r to the same value\n"
>      " -s =3D initial size hint\n"


--
Alex Benn=C3=A9e
