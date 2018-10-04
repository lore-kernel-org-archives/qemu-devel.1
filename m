Received: from eggs.gnu.org ([2001:4830:134:3::10]:46221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7yaU-0003dx-Il
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 04:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7yaT-0002w6-8x
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 04:02:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g7yaS-0002qS-Tg
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 04:02:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id 189-v6so8085778wmw.2
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 01:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181004053507.19883-1-kraxel@redhat.com>
In-Reply-To: <20181004053507.19883-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 4 Oct 2018 12:02:07 +0400
Message-ID: <CAJ+F1CLpMw6igckE0M_8N5cVecKvxYty6tm2qVcN34hzA2FOog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gtk: initialize zoom_to_fit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Oct 4, 2018 at 9:36 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Fixes: CID 1395988
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Same patch sent by Paolo yesterday:
https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg00474.html

> ---
>  ui/gtk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 3ddb5fe162..ec935fff90 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -2136,7 +2136,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, V=
irtualConsole *vc,
>                                QemuConsole *con, int idx,
>                                GSList *group, GtkWidget *view_menu)
>  {
> -    bool zoom_to_fit;
> +    bool zoom_to_fit =3D false;
>
>      vc->label =3D qemu_console_get_label(con);
>      vc->s =3D s;
> --
> 2.9.3
>
>


--=20
Marc-Andr=C3=A9 Lureau
