Received: from eggs.gnu.org ([209.51.188.92]:57038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gpAWh-0006af-08
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gpAWf-0002I2-UN
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:28:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gpAWf-0002HE-JX
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:28:57 -0500
Date: Thu, 31 Jan 2019 11:28:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190131112853.GG19982@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAChFQ9RNaHyROB47QeLwc6cLCCnFx4SmXKV7rbs1MYjk7S0sbw@mail.gmail.com>
	<20190131104911.GF19982@redhat.com>
	<CAFEAcA_TYKmG+gfm1gUw-xjM3VFXUebCD22rGSPyBuZ9ugWVPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_TYKmG+gfm1gUw-xjM3VFXUebCD22rGSPyBuZ9ugWVPQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] NSIS - including DLL dependencies for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Adam Baxter <voltagex@voltagex.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 31, 2019 at 11:19:04AM +0000, Peter Maydell wrote:
> On Thu, 31 Jan 2019 at 10:50, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> >
> > On Thu, Jan 31, 2019 at 02:45:13PM +1100, Adam Baxter wrote:
> > > Hi,
> > > How do I gather and include the required DLLs (SDL, zlib etc) in th=
e NSIS
> > > installer? (and also in a standalone build to be zipped up, but tha=
t's less
> > > important)
> > >
> > > I noticed the wiki doesn't really mention bundling dependencies any=
where.
> > >
> > > The official unofficial windows builds are documented at
> > > https://qemu.weilnetz.de/FAQ but this doesn't cover building the ac=
tual
> > > installer.
> >
> > Yeah, this is a pretty major ommision in QEMU's build rules for the N=
SIS
> > installer making it pretty much useless as is. We really need to expa=
nd
> > it so that it can resolve the dlls that qemu .exe's need, locate them
> > on the host and bundle them into the installer automatically.
>=20
> I think my concern here potentially is a licensing one -- if we don't
> actually ship installer binaries then that's fine for us, but an
> installer script that automatically pulls in DLLs for glib and others
> is a bit of a footgun for anybody that uses it since it will very likel=
y
> create an installer binary that is very difficult to ship to anybody
> whilst remaining compliant with the licenses for our dependencies.

I don't see this situation as much different in terms of licensing risk
from building & hosting / distributing a docker container image. In both
cases the person is bundling up a huge set of dependancies and need to
ensure they are compliant with licenses. The only difference is the file
format that the bundled content is in.

Essentially it is relying on the fact that the distro used as input for
the docker image (or nsis installer) is providing full source + build
tool chain, as the way to achieve license compliance.

So if anything I'd say that providing a fully scripted way to pick up
the DLLs from distro packages is a better way to help users achieve
license compliance than letting them copy around DLLs manually from
unknown sources.=20

I can understand that QEMU project doesn't want to get into the business
of providing binary packages as it certainly simplifies our life from the
POV of licensing by not having to think about it at all. I think it is
reasonable to allow users to have an easy way to build an installer for
their own usage though.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
