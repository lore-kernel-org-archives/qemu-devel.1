Received: from eggs.gnu.org ([2001:4830:134:3::10]:55453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVhf3-0005FZ-Gw
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVhf0-0002ww-D7
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:12:21 -0400
Date: Thu, 13 Jul 2017 18:12:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170713171203.GH2121@work-vm>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-16-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170713163219.9024-16-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 15/29] monitor: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index fa3e3ac251..bcbf307b45 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1348,7 +1348,7 @@ static void memory_dump(Monitor *mon, int count, =
int format, int wsize,
> =20
>      switch(format) {
>      case 'o':
> -        max_digits =3D (wsize * 8 + 2) / 3;
> +        max_digits =3D DIV_ROUND_UP(wsize * 8, 3);
>          break;
>      default:
>      case 'x':
> @@ -1356,7 +1356,7 @@ static void memory_dump(Monitor *mon, int count, =
int format, int wsize,
>          break;
>      case 'u':
>      case 'd':
> -        max_digits =3D (wsize * 8 * 10 + 32) / 33;
> +        max_digits =3D DIV_ROUND_UP(wsize * 8 * 10, 33);
>          break;
>      case 'c':
>          wsize =3D 1;
> --=20
> 2.13.1.395.gf7b71de06
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
