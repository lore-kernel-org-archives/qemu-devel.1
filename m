Received: from eggs.gnu.org ([2001:4830:134:3::10]:37611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQgo-0006Hp-8W
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQgn-0000BW-GK
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:29:18 -0400
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-22-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-22-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 04:29:13 -0700
Message-ID: <CAJ+F1CLPBCL5XQ+gmZLF_fjguYekQSpss7XNsd2AtPPJqRc7+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 21/29] qga: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu trival <qemu-trivial@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>

On Mon, Jul 17, 2017 at 11:09 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.=
cocci
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qga/commands-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index d8e412275e..2a5d5cb4ba 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -896,7 +896,7 @@ static void build_guest_fsinfo_for_real_device(char c=
onst *syspath,
>      if (p && sscanf(q, "%u", &host) =3D=3D 1) {
>          has_host =3D true;
>          nhosts =3D build_hosts(syspath, p, has_ata, hosts,
> -                             sizeof(hosts) / sizeof(hosts[0]), errp);
> +                             ARRAY_SIZE(hosts), errp);
>          if (nhosts < 0) {
>              goto cleanup;
>          }
> --
> 2.13.2
>
>



--=20
Marc-Andr=C3=A9 Lureau
