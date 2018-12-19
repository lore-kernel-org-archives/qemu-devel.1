Received: from eggs.gnu.org ([2001:4830:134:3::10]:53540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZYY6-0005yI-Kx
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZYY3-0002za-Ft
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:53:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gZYY3-0002z4-5t
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:53:51 -0500
Date: Wed, 19 Dec 2018 09:53:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181219095342.GA20465@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
	<20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
	<f3d7a0ed-785d-4176-147d-26a4d58d1a36@ilande.co.uk>
	<20181218111603.GE22638@redhat.com>
	<alpine.BSF.2.21.9999.1812181242560.99784@zero.eik.bme.hu>
	<20181218132722.GF22638@redhat.com>
	<alpine.BSF.2.21.9999.1812182000520.1576@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1812182000520.1576@zero.eik.bme.hu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Monitor and serial output window broken with SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Tue, Dec 18, 2018 at 08:05:59PM +0100, BALATON Zoltan wrote:
> On Tue, 18 Dec 2018, Daniel P. Berrang=C3=A9 wrote:
> > I don't see any difference depending on whether I use Ctrl-Alt-3 befo=
re
> > or after the yellow screen - both work as expected. The fact that you
> > see a difference though does suggest that there's something odd being
> > done in the ppc emulation that is in turn doing something bad to SDLs
> > rendering with your graphics setup. I don't know what it could be tho=
ugh.
>=20
> OK thanks for checking this, at least it seems this is something that n=
ot
> reproduces elsewhere so it's probably something specific to my setup. I=
 may
> try to debug this further when I'll have time.

I think there's a good chance that this is still a bug in QEMU, so
definitely still worth trying to debug what in your setup triggers
it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
