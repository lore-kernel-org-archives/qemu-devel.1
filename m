Received: from eggs.gnu.org ([2001:4830:134:3::10]:58449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKk67-0006Sm-O5
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKjsn-0007t4-IF
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:58:02 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gKjsn-0007kx-6p
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:58:01 -0500
Received: by mail-wr1-x444.google.com with SMTP id k15-v6so18167044wre.12
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 04:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20181108125256.30986-1-peter.maydell@linaro.org>
In-Reply-To: <20181108125256.30986-1-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Nov 2018 16:57:47 +0400
Message-ID: <CAJ+F1CLW93jHocJMG+=sXkMzTyyHdh2-XdJbc0sGdK5XboUtyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg/tcg-op.h: Add multiple include guard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On Thu, Nov 8, 2018 at 4:53 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> The tcg-op.h header was missing the usual guard against multiple
> inclusion; add it.
>
> (Spotted by lgtm.com's static analyzer.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tcg/tcg-op.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index 7513c1eb7c5..db4e9188f42 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -22,6 +22,9 @@
>   * THE SOFTWARE.
>   */
>
> +#ifndef TCG_TCG_OP_H
> +#define TCG_TCG_OP_H
> +
>  #include "tcg.h"
>  #include "exec/helper-proto.h"
>  #include "exec/helper-gen.h"
> @@ -1267,3 +1270,5 @@ static inline void tcg_gen_trunc_ptr_i32(TCGv_i32 r=
, TCGv_ptr a)
>
>  #undef PTR
>  #undef NAT
> +
> +#endif /* TCG_TCG_OP_H */
> --
> 2.19.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
