Received: from eggs.gnu.org ([2001:4830:134:3::10]:34365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1e0dGt-0006d6-S0
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1e0dGq-0002Sb-QH
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:47:15 -0400
Content-Type: text/plain;
	charset=gb2312
Mime-Version: 1.0 (1.0)
From: xiaoqiang zhao <zxq_yx_007@163.com>
In-Reply-To: <20171006235023.11952-52-f4bug@amsat.org>
Date: Sat, 7 Oct 2017 08:46:50 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <2F978D95-3433-4ABB-8421-B43017497006@163.com>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-52-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 51/88] hw/timer: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?GB2312?Q?Philippe_Mathieu-Daud=A8=A6?= <f4bug@amsat.org>
Cc: =?GB2312?Q?Marc-Andr=A8=A6_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Kevin Wolf <kwolf@redhat.com>, =?GB2312?Q?Marc-Andr=A8=A6_Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org


> =D4=DA 2017=C4=EA10=D4=C27=C8=D5=A3=AC=C9=CF=CE=E77:49=A3=ACPhilippe Mathi=
eu-Daud=A8=A6 <f4bug@amsat.org> =D0=B4=B5=C0=A3=BA
>=20
> From: Marc-Andr=A8=A6 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=A8=A6 Lureau <marcandre.lureau@redhat.com>
> ---
> hw/timer/slavio_timer.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
> index a8cc9c0148..6d0282a788 100644
> --- a/hw/timer/slavio_timer.c
> +++ b/hw/timer/slavio_timer.c
> @@ -385,7 +385,7 @@ static void slavio_timer_init(Object *obj)
>       uint64_t size;
>       char timer_name[20];
>=20
> -        tc =3D g_malloc0(sizeof(TimerContext));
> +        tc =3D g_new0(TimerContext, 1);
>       tc->s =3D s;
>       tc->timer_index =3D i;
>=20
> --=20
> 2.14.2

Reviewed-by: xiaoqiang zhao <zxq_yx_007@163.com>=
