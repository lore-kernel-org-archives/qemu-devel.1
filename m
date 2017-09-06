Received: from eggs.gnu.org ([2001:4830:134:3::10]:40142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpbec-0005gd-5v
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpbeX-0000YW-KV
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:10 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dpbeX-0000Wa-Fz
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:05 -0400
Received: by mail-oi0-x243.google.com with SMTP id l185so4847866oib.1
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:50:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170906142109.2685-1-kraxel@redhat.com>
References: <20170906142109.2685-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Sep 2017 16:50:04 +0200
Message-ID: <CAJ+F1C+ejn8=LBMd1Oa9C6NbDZmTzhmTZbriwafiO1zKZ2Cfjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] console: fix dpy_gfx_replace_surface assert
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

On Wed, Sep 6, 2017 at 4:21 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> virtio-gpu can trigger the assert added by commit "6905b93447 console:
> add same surface replace pre-condition" in multihead setups (where
> surface can be NULL for secondary displays).  Allow surface being NULL.
>
> Fixes: 6905b93447a42e606dfd126b90f75f4cd3c6fe94
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

oops
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  ui/console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/console.c b/ui/console.c
> index d2d3534c49..f0292d7820 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1540,7 +1540,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
>      DisplaySurface *old_surface =3D con->surface;
>      DisplayChangeListener *dcl;
>
> -    assert(old_surface !=3D surface);
> +    assert(old_surface !=3D surface || surface =3D=3D NULL);
>
>      con->surface =3D surface;
>      QLIST_FOREACH(dcl, &s->listeners, next) {
> --
> 2.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
