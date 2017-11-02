Received: from eggs.gnu.org ([2001:4830:134:3::10]:52773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eAJ2V-0005dm-1V
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eAJ2U-00051A-4q
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:12:23 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:46186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eAJ2U-000503-0t
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:12:22 -0400
Received: by mail-qt0-x232.google.com with SMTP id 1so283726qtn.3
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 10:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-5-makovick@gmail.com>
	<1509532830.3856.7.camel@redhat.com>
In-Reply-To: <1509532830.3856.7.camel@redhat.com>
From: =?UTF-8?B?SmluZMWZaWNoIE1ha292acSNa2E=?= <makovick@gmail.com>
Date: Thu, 02 Nov 2017 17:12:11 +0000
Message-ID: <CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

This fixes the following case:

1) Ctrl-Alt-2 for console is pressed
2) console pops up and gets focus
3) console receives the Ctrl-Alt-2 keypress event
4) console closes
5) focus returns to the main window
6) main window gets the keypress event
7) goto 2 until the key is released, with 50% chance that the console
window is shown at the end


On Wed, Nov 1, 2017 at 11:40 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Why?
>
> > ---
> >  ui/sdl2.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > index 685e4fabec..fa54353430 100644
> > --- a/ui/sdl2.c
> > +++ b/ui/sdl2.c
> > @@ -349,7 +349,7 @@ static void handle_keydown(SDL_Event *ev)
> >      }
> >      gui_key_modifier_pressed =3D mod_state;
> >
> > -    if (gui_key_modifier_pressed) {
> > +    if (gui_key_modifier_pressed && !ev->key.repeat &&
> > qemu_console_is_graphic(scon->dcl.con)) {
> >          switch (ev->key.keysym.scancode) {
> >          case SDL_SCANCODE_2:
> >          case SDL_SCANCODE_3:
>
--=20
Jind=C5=99ich Makovi=C4=8Dka
