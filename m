Received: from eggs.gnu.org ([2001:4830:134:3::10]:35653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e9qRp-0001PM-9Y
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e9qRl-00014k-9X
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:40:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e9qRl-00013s-3l
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:40:33 -0400
Message-ID: <1509532830.3856.7.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 01 Nov 2017 11:40:30 +0100
In-Reply-To: <20171023210803.20998-5-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-5-makovick@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] sdl2: Only accept the hotkeys on the
 main window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jindrich Makovicka <makovick@gmail.com>, qemu-devel@nongnu.org

Why?

> ---
> =C2=A0ui/sdl2.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 685e4fabec..fa54353430 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -349,7 +349,7 @@ static void handle_keydown(SDL_Event *ev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gui_key_modifier_pressed =3D mod_state;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0if (gui_key_modifier_pressed) {
> +=C2=A0=C2=A0=C2=A0=C2=A0if (gui_key_modifier_pressed && !ev->key.repea=
t &&
> qemu_console_is_graphic(scon->dcl.con)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (ev->key.k=
eysym.scancode) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case SDL_SCANCODE=
_2:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case SDL_SCANCODE=
_3:
