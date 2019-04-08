Received: from eggs.gnu.org ([209.51.188.92]:48015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hDaKw-0006qr-Gt
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hDaKv-0001IE-M3
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:53:46 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hDaKv-0001HP-9g
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:53:45 -0400
Received: by mail-wr1-x433.google.com with SMTP id k11so17886432wro.5
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 12:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
In-Reply-To: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 8 Apr 2019 21:53:30 +0200
Message-ID: <CAJ+F1C+c=+p__B=cZg5cOH-StcyMFLv3cB07LDFybk_Em8CpUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <lidong.chen@oracle.com>
Cc: QEMU <qemu-devel@nongnu.org>, darren.kenny@oracle.com, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Mon, Apr 8, 2019 at 9:51 PM Lidong Chen <lidong.chen@oracle.com> wrote:
>
> Due to an off-by-one error, the assert statements allow an
> out-of-bounds array access.
>
> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/sd/sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index aaab15f..818f86c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates st=
ate)
>      if (state =3D=3D sd_inactive_state) {
>          return "inactive";
>      }
> -    assert(state <=3D ARRAY_SIZE(state_name));
> +    assert(state < ARRAY_SIZE(state_name));
>      return state_name[state];
>  }
>
> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp=
)
>      if (rsp =3D=3D sd_r1b) {
>          rsp =3D sd_r1;
>      }
> -    assert(rsp <=3D ARRAY_SIZE(response_name));
> +    assert(rsp < ARRAY_SIZE(response_name));
>      return response_name[rsp];
>  }
>
> --
> 1.8.3.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
