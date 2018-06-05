Received: from eggs.gnu.org ([2001:4830:134:3::10]:59470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1fQCGd-0008J1-U9
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1fQCGZ-0002Um-Vs
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:44:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <phrdina@redhat.com>) id 1fQCGZ-0002Tv-QF
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:44:51 -0400
Date: Tue, 5 Jun 2018 15:44:39 +0200
From: Pavel Hrdina <phrdina@redhat.com>
Message-ID: <20180605134439.GN8876@antique-desktop>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<20180605130646.GF7451@localhost.localdomain>
	<20180605131232.GG32286@redhat.com>
	<20180605133538.GG7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U0B5otXy6WXfork9"
Content-Disposition: inline
In-Reply-To: <20180605133538.GG7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [libvirt] libvirt default machine-type guarantees?
 (was Re: [PATCH RFC] hw/pc: set q35 as the default x86 machine)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, pbonzini@redhat.com, rth@twiddle.net


--U0B5otXy6WXfork9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 10:35:38AM -0300, Eduardo Habkost wrote:
> On Tue, Jun 05, 2018 at 02:12:32PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Jun 05, 2018 at 10:06:46AM -0300, Eduardo Habkost wrote:
> > > (CCing libvir-list)
> > >=20
> > > On Tue, Jun 05, 2018 at 09:43:00AM +0100, Daniel P. Berrang=C3=A9 wro=
te:
> > > > On Tue, Jun 05, 2018 at 09:27:46AM +0200, Gerd Hoffmann wrote:
> > > > >   Hi,
> > > > >=20
> > > > > > >   Add to that shortcuts like -cdrom
> > > > > > > stop working,
> > > > > >=20
> > > > > > Maybe is fixable.
> > > > >=20
> > > > > Already fixed for ages.
> > > > >=20
> > > > > > I see marking Q35 as the default machine a first step.
> > > > >=20
> > > > > Maybe the better option is to go the arm route:  Just don't defin=
e a
> > > > > default, so users have to specify pc or q35.  That will make them=
 notice
> > > > > there is a world beside 'pc', and we also avoid breaking things
> > > > > silently.
> > > >=20
> > > > If QEMU removes the default, then libvirt will have to hardcode
> > > > 'pc' as the default to maintain back compatibility, so I don't
> > > > think that ends up as a net win
> > >=20
> > > Is there an actual promise to never change the default
> > > machine-type documented in the libvirt API, or is this just fear
> > > of breaking existing code?
> >=20
> > The risk of breaking things that currently work. Some of the things
> > discussed here that risk breaking users if QEMU changes the default,
> > have the same risk if libvirt changes the default.
> >=20
> > eg old OS versions that only work with PC, or more commonly pre-existing
> > cloud disk images that were built against PC can't be assumed to just
> > work against q35, even if the OS in the image supports it.
> >=20
> > If we want to get q35 broadly used for modern OS, then IMHO the best
> > option is to record that metadata in libosinfo, as ew do for other
> > virtual hardware preferences.  That doesn't fix the problem of disk
> > images that might not transparently boot between pc/q35, but at least
> > avoids breaking OS that don't support q35 at all.
>=20
> This leads to a more general question: sometimes the defaults
> chosen by libvirt are obsolete or broken, and we might want to
> change them.
>=20
> Is there a process for changing defaults in libvirt, or libvirt
> is bound by past decisions forever?

If the default was always recorded in the domain XML it is safe to
change it because it will not affect already existing domains or
migration but if the default is not recorded in the domain XML there
needs to be a lot of compatibility code.

In the past we've changed some of the defaults, for example default
device model.

Pavel

--U0B5otXy6WXfork9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAlsWk8cACgkQUi1kczAH
4Yxw/BAAokfjpD/weZMXe6a8XNK9V2sMkbEUVug6jQMOdziTB9JA2oLyIk7k3v+E
xsv/hX/J3klUMUcydpEwgNBxmvpsejqq5J+bgl0C8KMIaZ4uHCtWUuZrHrpZ5kq4
C5ry+fAnk+zAV4DEVaDxsIujmEQ+a36xGcAvLNKxt8+1HXZBdE5act8TD82g03m8
H7a44WpBpkYUsy34VzwFZw+GrNkwXkzxOAtvFQvGS2S0wYm4ZmLytCAIoYkWPtJ/
6xJsP3QWFcC9bxPMow6lKQsP3kBxRpyrHS+Kc6QDw7T45MONQ56BY3yTctNg+KGW
pdmYePM93YQwnbSiKWRjyttuVNKsuFqY3SiT0Vq7tjUU8rkNLN74nGSZJyVHpObO
uvOh8PJ5sxL9bXY67kPIAo7oUJ0HW/WXtLLDmeOY93EHheQBj1MYB0OVy+TMF1CW
vt/zOSssfQY/s2Antrffqxs+dyg5w6RE8if7S6DAUoqQgdjJrdARv6khNpn9Jqw0
X8eTcCM0v827Rk4lvpQWX015wZ3nGpslRORDhO/eVu5OEvNPyKQ9EHcENJzuIRQ+
eZvETjI5EZ01Bm7wR7KnMiuGS7xeZJ0pHjuiR8CqUsaPFPRCG9424WIz2qevqqTX
ydMhxhUSlF9UxrjGkWN2OWJ1/NcrbkSSQYj1vpZI0pI/LiGZc54=
=CGAd
-----END PGP SIGNATURE-----

--U0B5otXy6WXfork9--
