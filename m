Received: from eggs.gnu.org ([2001:4830:134:3::10]:37755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1drH6l-00064t-Lr
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 01:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1drH6i-0008JN-GC
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 01:18:07 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:43556
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1drH6i-0008Io-9h
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 01:18:04 -0400
References: <20170911022839.23231-1-f4bug@amsat.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <caaf9ae8-e320-4a49-dab4-2d0b79b3f60e@weilnetz.de>
Date: Mon, 11 Sep 2017 07:18:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170911022839.23231-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: do not use ldst label (never
 implemented)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Am 11.09.2017 um 04:28 schrieb Philippe Mathieu-Daud=C3=A9:
> changed in 659ef5cbb893, this fixes building with --enable-tcg-interpre=
ter:
>=20
> /home/travis/build/qemu/qemu/tcg/tcg.c:116:14: error: =E2=80=98tcg_out_=
ldst_finalize=E2=80=99 used but never defined [-Werror]
>  static bool tcg_out_ldst_finalize(TCGContext *s);
>               ^
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> see https://travis-ci.org/qemu/qemu/jobs/273351287
>=20
>  tcg/tci/tcg-target.h | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
> index 5d692e1f4b..26140d78cb 100644
> --- a/tcg/tci/tcg-target.h
> +++ b/tcg/tci/tcg-target.h
> @@ -206,8 +206,4 @@ static inline void tb_target_set_jmp_target(uintptr=
_t tc_ptr,
>      /* no need to flush icache explicitly */
>  }
> =20
> -#ifdef CONFIG_SOFTMMU
> -#define TCG_TARGET_NEED_LDST_LABELS
> -#endif
> -
>  #endif /* TCG_TARGET_H */
>=20

Reviewed-by: Stefan Weil <sw@weilnetz.de>

Thank you.

Stefan
