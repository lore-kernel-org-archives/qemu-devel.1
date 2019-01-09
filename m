Received: from eggs.gnu.org ([209.51.188.92]:43208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghBVj-00075w-Ii
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghBVh-0007xu-Kn
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:54:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghBVh-0007wb-5X
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:54:57 -0500
Date: Wed, 9 Jan 2019 10:47:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190109104740.GF3998@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAFEAcA8Xb1DeTTus7vwfQXDGC8ETR5a9Egg4nVN=+cLy0xm2dQ@mail.gmail.com>
	<a08068ab-88ae-4068-d4d6-3a3c4a968893@redhat.com>
	<5be74ec4-8a56-a479-85b0-49817a4aaf9c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5be74ec4-8a56-a479-85b0-49817a4aaf9c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/44] MIPS pull request for December
 2018 - v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, Jan 03, 2019 at 03:06:23PM +0100, Thomas Huth wrote:
> On 2019-01-03 14:32, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 1/3/19 2:23 PM, Peter Maydell wrote:
> >> On Mon, 31 Dec 2018 at 14:56, Aleksandar Markovic
> >> <aleksandar.markovic@rt-rk.com> wrote:
> >>> MIPS queue for December 2018 - v2
> > [...]
> >> Hi; I'm afraid this doesn't build on all my test hosts:
> >>
> >> target/mips/translate.c: In function =E2=80=98gen_mxu_Q8MAX_Q8MIN=E2=
=80=99:
> >> target/mips/translate.c:25092:9: error: =E2=80=98for=E2=80=99 loop i=
nitial
> >> declarations are only allowed in C99 mode
> >>          for (int i =3D 2; i >=3D 0; i--) {
> >>          ^
> >> target/mips/translate.c:25092:9: note: use option -std=3Dc99 or
> >> -std=3Dgnu99 to compile your code
> >> target/mips/translate.c:25129:9: error: =E2=80=98for=E2=80=99 loop i=
nitial
> >> declarations are only allowed in C99 mode
> >>          for (int i =3D 2; i >=3D 0; i--) {
> >>          ^
> >>
> >> (This probably only shows up on builds with older versions
> >> of gcc which don't default to c99.)
> >>
> >> We don't use variable-declaration-in-for-loop.
> >=20
> > Hmmm I wonder if we shouldn't relax that now than all supported
> > compilers do support C99.
>=20
> Maybe we could / should enforce compiling with -std=3Dgnu11 now? That
> would also fix the problem with the duplicated typedefs on older
> compilers, see e.g.:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html

Your previous patch set min GCC to 4.8

  commit efc6c070acabd92283f8786cc835684d09def12f
  Author: Thomas Huth <thuth@redhat.com>
  Date:   Mon Dec 3 10:12:32 2018 +0100

    configure: Add a test for the minimum compiler version

The problem is that I found the 4.x series explicitly said gnu11 was
"incomplete and experimental" (ie don't use it)

  https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg02055.html

Even if QEMU built without warnings with std11 on 4.x, i'd still be
concerned that it was silently doing something wrong due to std11
being considered experimental.

We could definitely ask for std99, as while that was also incomplete
in 4.x, it was at least /not/ marked experiemental.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
