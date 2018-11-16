Received: from eggs.gnu.org ([2001:4830:134:3::10]:58752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gNbep-0001ig-DF
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gNbeo-0004mu-Lv
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:47:27 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:40762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gNbeo-0004m8-HJ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:47:26 -0500
Received: by mail-it1-x144.google.com with SMTP id e11so33672505itl.5
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 02:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20181116104319.10329-1-kraxel@redhat.com>
	<20181116104319.10329-5-kraxel@redhat.com>
In-Reply-To: <20181116104319.10329-5-kraxel@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 16 Nov 2018 18:46:49 +0800
Message-ID: <CAKXe6SLofps05_u3+kthow=J8x=3q0XsFpjsRHLJ-9aqd6Ft4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] keymaps: drop support for include
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:43=E5=86=99=E9=81=93=EF=BC=9A

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  ui/keymaps.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/ui/keymaps.c b/ui/keymaps.c
> index 085889b555..6e44f738ed 100644
> --- a/ui/keymaps.c
> +++ b/ui/keymaps.c
> @@ -115,10 +115,9 @@ static int parse_keyboard_layout(kbd_layout_t *k,
>              continue;
>          }
>          if (!strncmp(line, "include ", 8)) {
> -            if (parse_keyboard_layout(k, table, line + 8, errp) < 0) {
> -                ret =3D -1;
> -                goto out;
> -            }
> +            error_setg(errp, "keymap include files are not supported any
> more");
> +            ret =3D -1;
> +            goto out;
>          } else {
>              int offset =3D 0;
>              while (line[offset] !=3D 0 &&
> --
> 2.9.3
>
>
