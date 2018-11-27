Received: from eggs.gnu.org ([2001:4830:134:3::10]:55520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gRTef-0002Xn-VQ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 22:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gRTee-0002DS-Vy
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 22:03:17 -0500
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:56312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gRTee-0002DM-RX
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 22:03:16 -0500
Received: by mail-it1-x142.google.com with SMTP id o19so31944800itg.5
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 19:03:16 -0800 (PST)
MIME-Version: 1.0
References: <1541052148-28752-1-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1541052148-28752-1-git-send-email-liq3ea@gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 27 Nov 2018 11:02:40 +0800
Message-ID: <CAKXe6SJ6cF2jTBzRpPRULJFeE0Y6M7O=cET91BZ5kw4uu5UT-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw: fw_cfg: Improve error message when
 can't load splash file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, philmd@redhat.com, Laszlo Ersek <lersek@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>

Hello Paolo, Philippe

Seems this patch has been lost...

I think Philippe can merge it for 4.0, right?
Also pls notice the following fw_cfg patchset.
-->https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04097.html

Thanks,
Li Qiang


Li Qiang <liq3ea@gmail.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=881=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=882:02=E5=86=99=E9=81=93=EF=BC=9A

> read_splashfile() reports "failed to read splash file" without
> further details. Get the details from g_file_get_contents(), and
> include them in the error message. Also remove unnecessary 'res'
> variable.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/nvram/fw_cfg.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 946f765..3fcfa35 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -68,15 +68,14 @@ static char *read_splashfile(char *filename, gsize
> *file_sizep,
>                               int *file_typep)
>  {
>      GError *err =3D NULL;
> -    gboolean res;
>      gchar *content;
>      int file_type;
>      unsigned int filehead;
>      int bmp_bpp;
>
> -    res =3D g_file_get_contents(filename, &content, file_sizep, &err);
> -    if (res =3D=3D FALSE) {
> -        error_report("failed to read splash file '%s'", filename);
> +    if (!g_file_get_contents(filename, &content, file_sizep, &err)) {
> +        error_report("failed to read splash file '%s': %s",
> +                     filename, err->message);
>          g_error_free(err);
>          return NULL;
>      }
> --
> 1.8.3.1
>
>
