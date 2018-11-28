Received: from eggs.gnu.org ([2001:4830:134:3::10]:35087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gS1TH-0003BD-Ff
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gS1TB-00008k-Pe
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:09:46 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gS1T8-0008L3-0e
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:09:41 -0500
Received: by mail-wr1-x441.google.com with SMTP id j2so26691787wrw.1
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 07:09:37 -0800 (PST)
References: <20181123230206.12629-1-cota@braap.org>
	<20181123230206.12629-5-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123230206.12629-5-cota@braap.org>
Date: Wed, 28 Nov 2018 15:09:34 +0000
Message-ID: <875zwh44sx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] xxhash: match output against the
 original xxhash32
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

> Change the order in which we extract a/b and c/d to
> match the output of the upstream xxhash32.
>
> Tested with:
>   https://github.com/cota/xxhash/tree/qemu
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qemu/xxhash.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/qemu/xxhash.h b/include/qemu/xxhash.h
> index fe35dde328..076f1f6054 100644
> --- a/include/qemu/xxhash.h
> +++ b/include/qemu/xxhash.h
> @@ -55,10 +55,10 @@ qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, ui=
nt32_t f, uint32_t g)
>      uint32_t v2 =3D QEMU_XXHASH_SEED + PRIME32_2;
>      uint32_t v3 =3D QEMU_XXHASH_SEED + 0;
>      uint32_t v4 =3D QEMU_XXHASH_SEED - PRIME32_1;
> -    uint32_t a =3D ab >> 32;
> -    uint32_t b =3D ab;
> -    uint32_t c =3D cd >> 32;
> -    uint32_t d =3D cd;
> +    uint32_t a =3D ab;
> +    uint32_t b =3D ab >> 32;
> +    uint32_t c =3D cd;
> +    uint32_t d =3D cd >> 32;
>      uint32_t h32;
>
>      v1 +=3D a * PRIME32_2;


--
Alex Benn=C3=A9e
