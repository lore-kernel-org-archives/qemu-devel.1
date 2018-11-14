Received: from eggs.gnu.org ([2001:4830:134:3::10]:39012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMxmQ-00019Z-KP
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMxmL-0005oJ-NW
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:12:37 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMxmJ-0005lg-LW
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:12:33 -0500
Received: by mail-wm1-x343.google.com with SMTP id s11so5952134wmh.1
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 08:12:29 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-8-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-8-cota@braap.org>
Date: Wed, 14 Nov 2018 16:12:27 +0000
Message-ID: <87tvkjd4es.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 07/48] tcg: export TCGHelperInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>


Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg.h | 7 +++++++
>  tcg/tcg.c | 7 -------
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index f4efbaa680..9f9643b470 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -480,6 +480,13 @@ typedef TCGv_ptr TCGv_env;
>  /* Used to align parameters.  See the comment before tcgv_i32_temp.  */
>  #define TCG_CALL_DUMMY_ARG      ((TCGArg)0)
>
> +typedef struct TCGHelperInfo {
> +    void *func;
> +    const char *name;
> +    unsigned flags;
> +    unsigned sizemask;
> +} TCGHelperInfo;
> +
>  /* Conditions.  Note that these are laid out for easy manipulation by
>     the functions below:
>       bit 0 is used for inverting;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 65da3c5dbf..08b6926894 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -868,13 +868,6 @@ void tcg_pool_reset(TCGContext *s)
>      s->pool_current =3D NULL;
>  }
>
> -typedef struct TCGHelperInfo {
> -    void *func;
> -    const char *name;
> -    unsigned flags;
> -    unsigned sizemask;
> -} TCGHelperInfo;
> -
>  #include "exec/helper-proto.h"
>
>  static const TCGHelperInfo all_helpers[] =3D {


--
Alex Benn=C3=A9e
