Received: from eggs.gnu.org ([2001:4830:134:3::10]:39622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT43h-0004Dv-MT
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT43c-0006O7-G4
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:30:53 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dT43c-0006Nr-81
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:30:48 -0400
Received: by mail-lf0-x242.google.com with SMTP id t72so1743626lff.0
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 03:30:48 -0700 (PDT)
Date: Thu, 6 Jul 2017 11:30:43 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170706103043.GJ30447@stefanha-x1.localdomain>
References: <1499237876.3041.4.camel@linux.intel.com>
	<6ad73f55-c48a-c083-e0ef-b8ac162ec989@redhat.com>
	<20170705110757.GF22008@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Content-Disposition: inline
In-Reply-To: <20170705110757.GF22008@redhat.com>
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, Laszlo Ersek <lersek@redhat.com>


--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 12:07:57PM +0100, Daniel P. Berrange wrote:
> On Wed, Jul 05, 2017 at 10:14:23AM +0200, Thomas Huth wrote:
> >  Hi,
> >=20
> > On 05.07.2017 08:57, Chao Peng wrote:
> > >=20
> > > Q35 has been in QEMU for quite a while. Compared to the current defau=
lt
> > > i440FX, Q35 is probably not that mature and not widely used, however =
in
> > > some case, Q35 has advantages, for example, in supporting new feature=
s.
> > > For instance, we have some features require PCI-e support which is on=
ly
> > > available on Q35 and some others need it for EFI support. It is of
> > > course not necessary to change it as the default but if more and more
> > > features have dependencies on Q35 because of requiring much more mode=
rn
> > > features then I think it may be worth to do so. In such case we can h=
ave
> > > more people to use it and find problems we may know or not know.
> >=20
> > Yes, IMHO at one point in time, we should switch the default machine
> > type to q35. The i440FX is really quite old...
> >=20
> > > There are certainly some drawbacks:
> > > -        Compatibility: current code or script may need adjustment
> >=20
> > That might be a real concern ... so I think a good point in time to
> > switch to the q35 machine type would be when we switch to the next major
> > version number of QEMU, i.e. when we switch to version 3.0. If the users
> > see a new major version number, they might be more willing to accept
> > such major changes (yeah, I know, we've discussed in the past that
> > version numbers are just numbers ... but still, there is some kind of
> > psychological aspect to this, too, I think)
>=20
> Most users aren't even aware of version numbers of QEMU - they'll just
> take whatever their distro has provided run it. The notion that their
> latest distro version happened to pull in a "major" version instead of
> previously pulling in a "minor" version is invisible to everyone,
> except the minority of people who care about the low level details.

When user-visible changes break existing setups it's common for
packagers to ship a new family of packages that includes the major
version number (e.g. apache2, postgresql-9.6).

The last QEMU 2.x version would be considered stable and still available
=66rom package repos.  Only critical bug and security fixes could be
released for another, say, 2 years.

This way users don't have to migrate to QEMU 3.x until they are ready.

Stefan

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXhFTAAoJEJykq7OBq3PIFP0IAJ8kIuSTFToucgKvX7xCHlOL
VX1AmfLoJvLxv5xSA8Eq6qwII7HpTjzXxP1Or/z/xPse+xA0v+CQNNyG0EuVV3Dt
SGKOXN59B9xKfrjR3vYi1C8OkNeznMlgOAyk2jJ0RSZguVasEyYM8g3+OZCqhCk8
jU4lwPiXaS60KzUQh03+PTU6LXQ61Mm/4/vBho9zwDNgWSl7+sYAksxCpwEYB1n4
JSSbHmlYEyw/DHNgAIqSTk2TYDK6s7v2OsGEpIJJpkRa2xKkIBvu+deEoKkvFLuM
MomFJ7h9tBsxtnyiD928OiEv1LF0+wOB2kaafKueWrWccLmkEtPR7cv9ATMI708=
=gSBJ
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--
