Received: from eggs.gnu.org ([2001:4830:134:3::10]:60781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZr6g-0004qg-39
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZr6c-0007Xg-RK
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:42:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZr6Z-0007TO-FD
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:42:44 -0500
Date: Thu, 20 Dec 2018 06:42:38 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181220054238.imanfs5rsidtghja@sirius.home.kraxel.org>
References: <20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
	<f3d7a0ed-785d-4176-147d-26a4d58d1a36@ilande.co.uk>
	<20181218111603.GE22638@redhat.com>
	<alpine.BSF.2.21.9999.1812181242560.99784@zero.eik.bme.hu>
	<20181218132722.GF22638@redhat.com>
	<alpine.BSF.2.21.9999.1812182000520.1576@zero.eik.bme.hu>
	<20181219095342.GA20465@redhat.com>
	<alpine.BSF.2.21.9999.1812191904120.37705@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1812191904120.37705@zero.eik.bme.hu>
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Howard Spoelstra <hsp.cat7@gmail.com>, qemu-devel@nongnu.org

On Wed, Dec 19, 2018 at 07:11:34PM +0100, BALATON Zoltan wrote:
> On Wed, 19 Dec 2018, Daniel P. Berrang=E9 wrote:
> > On Tue, Dec 18, 2018 at 08:05:59PM +0100, BALATON Zoltan wrote:
> > > On Tue, 18 Dec 2018, Daniel P. Berrang=E9 wrote:
> > > > I don't see any difference depending on whether I use Ctrl-Alt-3 =
before
> > > > or after the yellow screen - both work as expected. The fact that=
 you
> > > > see a difference though does suggest that there's something odd b=
eing
> > > > done in the ppc emulation that is in turn doing something bad to =
SDLs
> > > > rendering with your graphics setup. I don't know what it could be=
 though.
> > >=20
> > > OK thanks for checking this, at least it seems this is something th=
at not
> > > reproduces elsewhere so it's probably something specific to my setu=
p. I may
> > > try to debug this further when I'll have time.
> >=20
> > I think there's a good chance that this is still a bug in QEMU, so
> > definitely still worth trying to debug what in your setup triggers
> > it.
>=20
> Looks like Howard (cc'd) also has similar issue on Fedora 29 with NVidi=
a
> vendor driver although newer version than mine so the proprietary NVidi=
a
> driver seems to be a common point here. The difference is that for him =
the
> monitor window seems to hijack the guest screen not the serial screen l=
ike
> for me but this could be the same bug. I can't easily test with nouveau
> driver now so that's all we could find out so far. Also having some out=
put
> on serial window seems to be relevant as this works before client start=
s if
> I start with qemu-system-ppc -S but breaks after continue in monitor wi=
ndow.
> qemu-system-x86_64 also does not show the problem but maybe because the=
re's
> no content in serial window there?

qemu-system-x86_64 -machine graphics=3Doff will make seabios print stuff
to the serial line.

cheers,
  Gerd
