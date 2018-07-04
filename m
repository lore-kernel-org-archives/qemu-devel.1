Received: from eggs.gnu.org ([2001:4830:134:3::10]:59578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fak1G-0005eO-CW
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fak1D-0008Ai-8f
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:48:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fak1D-00089y-4m
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:48:35 -0400
Date: Wed, 4 Jul 2018 16:48:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180704154831.GM32267@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180704143014.8670-1-f4bug@amsat.org> <87va9v80ut.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87va9v80ut.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Do not display host compilers
 as cross-compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On Wed, Jul 04, 2018 at 04:41:30PM +0100, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>=20
> > This silent (since d75402b5ee2):
> >
> >   ./configure
> >   [...]
> >   NOTE: cross-compilers enabled:  'cc'
> >
> > Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  configure | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index b99ebdde24..fbb53ab6bb 100755
> > --- a/configure
> > +++ b/configure
> > @@ -7328,7 +7328,7 @@ echo "QEMU_CFLAGS+=3D$cflags" >> $config_target=
_mak
> >
> >  done # for target in $targets
> >
> > -if test -n "$enabled_cross_compilers"; then
> > +if test -n "$target_compiler" -a -n "$enabled_cross_compilers"; then
> >      echo
> >      echo "NOTE: cross-compilers enabled: $enabled_cross_compilers"
> >  fi
>=20
> I had also added:
>=20
> -    echo "NOTE: cross-compilers enabled: $enabled_cross_compilers"
> +    echo "NOTE: compilers enabled for TCG tests: $enabled_cross_compil=
ers"[
>=20
> to make things clearer.

I think we should also 's/NOTE: //', because everything printed by
configure at the end is a note. Also get rid of the extra blank
line before it.

>=20
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
>=20
> --
> Alex Benn=C3=A9e

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
