Received: from eggs.gnu.org ([2001:4830:134:3::10]:43303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f896s-0002KW-Hi
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f896o-00047S-JI
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:44:14 -0400
Date: Mon, 16 Apr 2018 19:44:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180416184406.GC14488@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180416181844.7851-1-marcandre.lureau@redhat.com>
	<CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] mux: fix ctrl-a b again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On Mon, Apr 16, 2018 at 07:28:28PM +0100, Peter Maydell wrote:
> On 16 April 2018 at 19:18, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> > Commit fb5e19d2e1472e96d72d5e4d89c20033f8ab345c originally fixed the
> > regression, but was inadvertently broken again in merge commit
> > 2d6752d38d8acda.
> >
> > Fixes:
> > https://bugs.launchpad.net/qemu/+bug/1654137
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  chardev/char-mux.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> > index 1b925c8dec..6055e76293 100644
> > --- a/chardev/char-mux.c
> > +++ b/chardev/char-mux.c
> > @@ -304,6 +304,7 @@ void mux_set_focus(Chardev *chr, int focus)
> >      }
> >
> >      d->focus =3D focus;
> > +    chr->be =3D d->backends[focus];
> >      mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
> >  }
> >
> > --
> > 2.17.0.rc1.36.gcedb63ea2f
>=20
> Opinions welcome on whether this is a regression fix worth
> putting into rc4.

It is a regression, but a long standing one - we've been broken for quite
a while since 2.9.0 or even before.

If we're doing an rc4 anyway I'd suggest including it, but not the end of
the world if it has to go in via -stable given how long we've been broken
for.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
