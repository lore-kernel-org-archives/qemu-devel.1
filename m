Received: from eggs.gnu.org ([209.51.188.92]:33717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtquY-00016r-St
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtquX-0005Fu-Ct
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:32:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gtquX-0004li-46
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:32:57 -0500
Date: Wed, 13 Feb 2019 09:32:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190213093241.GF13960@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAChFQ9RNaHyROB47QeLwc6cLCCnFx4SmXKV7rbs1MYjk7S0sbw@mail.gmail.com>
	<20190131104911.GF19982@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190131104911.GF19982@redhat.com>
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
To: Adam Baxter <voltagex@voltagex.org>
Cc: qemu-devel@nongnu.org

On Thu, Jan 31, 2019 at 10:49:11AM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jan 31, 2019 at 02:45:13PM +1100, Adam Baxter wrote:
> > Hi,
> > How do I gather and include the required DLLs (SDL, zlib etc) in the =
NSIS
> > installer? (and also in a standalone build to be zipped up, but that'=
s less
> > important)
> >=20
> > I noticed the wiki doesn't really mention bundling dependencies anywh=
ere.
> >=20
> > The official unofficial windows builds are documented at
> > https://qemu.weilnetz.de/FAQ but this doesn't cover building the actu=
al
> > installer.
>=20
> Yeah, this is a pretty major ommision in QEMU's build rules for the NSI=
S
> installer making it pretty much useless as is. We really need to expand
> it so that it can resolve the dlls that qemu .exe's need, locate them
> on the host and bundle them into the installer automatically.
>=20
> It seems we can get a list of deps for an .exe using=20
>=20
> $ winedump  -j import /path/to/binary.exe  | grep offset | grep dll | a=
wk '{print $3}'

FYI, I re-discovered a way to do this without needing wine, just plain
binutils

  x86_64-w64-mingw32-objdump -p /path/to/binary.exe | grep "DLL Name" | a=
wk '{print $3}'


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
