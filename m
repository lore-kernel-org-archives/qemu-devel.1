Received: from eggs.gnu.org ([2001:4830:134:3::10]:41784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fakc3-0006L8-VA
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fakc0-0002jx-2U
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:26:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34218 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fakbz-0002jm-Tb
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:26:36 -0400
Date: Wed, 4 Jul 2018 17:26:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180704162632.GQ32267@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180704143014.8670-1-f4bug@amsat.org> <87va9v80ut.fsf@linaro.org>
	<20180704154831.GM32267@redhat.com> <87tvpf7yzm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tvpf7yzm.fsf@linaro.org>
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

On Wed, Jul 04, 2018 at 05:21:49PM +0100, Alex Benn=C3=A9e wrote:
>=20
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Wed, Jul 04, 2018 at 04:41:30PM +0100, Alex Benn=C3=A9e wrote:
> >>
> >> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
> >>
> >> > This silent (since d75402b5ee2):
> >> >
> >> >   ./configure
> >> >   [...]
> >> >   NOTE: cross-compilers enabled:  'cc'
> >> >
> >> > Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> > Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> > ---
> >> >  configure | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/configure b/configure
> >> > index b99ebdde24..fbb53ab6bb 100755
> >> > --- a/configure
> >> > +++ b/configure
> >> > @@ -7328,7 +7328,7 @@ echo "QEMU_CFLAGS+=3D$cflags" >> $config_tar=
get_mak
> >> >
> >> >  done # for target in $targets
> >> >
> >> > -if test -n "$enabled_cross_compilers"; then
> >> > +if test -n "$target_compiler" -a -n "$enabled_cross_compilers"; t=
hen
> >> >      echo
> >> >      echo "NOTE: cross-compilers enabled: $enabled_cross_compilers=
"
> >> >  fi
> >>
> >> I had also added:
> >>
> >> -    echo "NOTE: cross-compilers enabled: $enabled_cross_compilers"
> >> +    echo "NOTE: compilers enabled for TCG tests: $enabled_cross_com=
pilers"[
> >>
> >> to make things clearer.
> >
> > I think we should also 's/NOTE: //', because everything printed by
> > configure at the end is a note. Also get rid of the extra blank
> > line before it.
>=20
> *shrugs* I made the original decision because:
>=20
> WARNING: Use of SDL 1.2 is deprecated and will be removed in
> WARNING: future releases. Please switch to using SDL 2.0
> compilers enabled for TCG tests:  'aarch64-linux-gnu-gcc' 'arm-linux-gn=
ueabihf-gcc' 'cc' 'aarch64-linux-gnu-gcc' 'arm-linux-gnueabihf-gcc' 'cc'
>=20
> offended my eye, but I'm happy either way really.

Oh, I see - can we move the print out before the WARNING, as
those warnings were intended to be the last thing that was
printed. All the feature summaries were supposed to come first.

IIRC, we'll be able to delete the SDL/GTK deprecation messages
when 3.1 opens anyway, because they'll have been present for
both 2.12 and 3.0 already.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
