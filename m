Received: from eggs.gnu.org ([2001:4830:134:3::10]:58742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS2Z2-0005V6-L0
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS2Yz-0001mX-9O
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:19:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gS2Yz-0001kS-1R
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:19:45 -0500
Date: Wed, 28 Nov 2018 16:19:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181128161938.GR24355@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181122141741.11108-1-marcandre.lureau@redhat.com>
	<0432176d-72a6-2dd4-ccc7-8486ea49be7b@weilnetz.de>
	<CAJ+F1C+iGrQFRyQdxyWM7rF8wx8kt48C6aUuqQ6RaMU=r3MW_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+iGrQFRyQdxyWM7rF8wx8kt48C6aUuqQ6RaMU=r3MW_g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: apply some qemu.org-like CSS style
 to HTML
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Nov 28, 2018 at 07:40:09PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Nov 28, 2018 at 7:27 PM Stefan Weil <sw@weilnetz.de> wrote:
> >
> > Am 22.11.2018 um 15:17 schrieb Marc-Andr=C3=A9 Lureau:
> > > Style a bit the HTML documents, to make them look like qemu.org pag=
es.
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  Makefile                     |   2 +
> > >  docs/texinfo-extra-head.html |   7 ++
> > >  docs/texinfo.css             | 226 +++++++++++++++++++++++++++++++=
++++
> > >  3 files changed, 235 insertions(+)
> > >  create mode 100644 docs/texinfo-extra-head.html
> > >  create mode 100644 docs/texinfo.css
> >
> >
> > I tried this patch, and here are the results without the patch and wi=
th
> > the patch, so everybody can compare both looks:
> >
> > old: https://qemu.weilnetz.de/doc/qemu-doc.html
> > new: https://qemu.weilnetz.de/doc/3.1/qemu-doc.html
> >
> > I like the new look and can use it from now on, no matter whether it =
is
> > merged into QEMU 3.1 or delayed for release 4.
>=20
> With my limited knowledge of CSS, I tried to apply a style close to
> what qemu.org already uses. Further tweaks would be welcome, but
> better left to someone with more web design skills.
>=20
> >
> > Tested-by: Stefan Weil <sw@weilnetz.de>
> >
> > PS: https://qemu.weilnetz.de/doc/3.1/qemu-ga-ref.html and
> > https://qemu.weilnetz.de/doc/3.1/qemu-qmp-ref.html are also candidate=
s
> > for the new look.
>=20
> Oh, but the style is also applied for them, as they are also generated
> from the same texinfo->html process.
>=20
> I wonder if the generated pages could be somehow uploaded on release
> on qemu.org, or simply committed to qemu-web?

Committing them to qemu-web would be a fairly straightforward approach,
not requiring any extra tooling work. In particular it would make it pret=
ty
easy to provide docs for historical versions of QEMU too.

The alternative is to write a jekyll plugin which fetches the qemu
releases & generates docs dynamically, but this would much more
complex & fragile IMHO.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
