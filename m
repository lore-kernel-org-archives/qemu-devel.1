Received: from eggs.gnu.org ([209.51.188.92]:53025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hDeTk-0003kg-J0
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 20:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hDeTj-0003se-Ko
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 20:19:08 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hDeTj-0003rj-AC
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 20:19:07 -0400
Received: by mail-oi1-x242.google.com with SMTP id j132so12078042oib.2
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 17:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
In-Reply-To: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 9 Apr 2019 08:18:29 +0800
Message-ID: <CAKXe6SLnou3TMsdorK0Ck-c+D6ECzWg10rBdQ_v3kLPb4FY7-A@mail.gmail.com>
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Darren Kenny <darren.kenny@oracle.com>, f4bug@amsat.org

Lidong Chen <lidong.chen@oracle.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=883:51=E5=86=99=E9=81=93=EF=BC=9A

> Due to an off-by-one error, the assert statements allow an
> out-of-bounds array access.
>
> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/sd/sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index aaab15f..818f86c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates
> state)
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
>
