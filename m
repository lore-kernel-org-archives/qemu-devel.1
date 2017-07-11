Received: from eggs.gnu.org ([2001:4830:134:3::10]:55473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUsBk-0001bT-Lg
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUsBg-0008WC-LQ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:14:40 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dUsBg-0008Vx-8w
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:14:36 -0400
Received: by mail-wr0-f193.google.com with SMTP id 77so31074043wrb.3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 03:14:36 -0700 (PDT)
Date: Tue, 11 Jul 2017 11:13:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711101332.GO17792@stefanha-x1.localdomain>
References: <1499237876.3041.4.camel@linux.intel.com>
	<6ad73f55-c48a-c083-e0ef-b8ac162ec989@redhat.com>
	<20170705110757.GF22008@redhat.com>
	<20170706103043.GJ30447@stefanha-x1.localdomain>
	<20170706104156.GI3988@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aTCJOP0qgkSGqHWA"
Content-Disposition: inline
In-Reply-To: <20170706104156.GI3988@redhat.com>
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


--aTCJOP0qgkSGqHWA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 11:41:56AM +0100, Daniel P. Berrange wrote:
> On Thu, Jul 06, 2017 at 11:30:43AM +0100, Stefan Hajnoczi wrote:
> > On Wed, Jul 05, 2017 at 12:07:57PM +0100, Daniel P. Berrange wrote:
> > > On Wed, Jul 05, 2017 at 10:14:23AM +0200, Thomas Huth wrote:
> > > >  Hi,
> > > >=20
> > > > On 05.07.2017 08:57, Chao Peng wrote:
> > > > >=20
> > > > > Q35 has been in QEMU for quite a while. Compared to the current d=
efault
> > > > > i440FX, Q35 is probably not that mature and not widely used, howe=
ver in
> > > > > some case, Q35 has advantages, for example, in supporting new fea=
tures.
> > > > > For instance, we have some features require PCI-e support which i=
s only
> > > > > available on Q35 and some others need it for EFI support. It is of
> > > > > course not necessary to change it as the default but if more and =
more
> > > > > features have dependencies on Q35 because of requiring much more =
modern
> > > > > features then I think it may be worth to do so. In such case we c=
an have
> > > > > more people to use it and find problems we may know or not know.
> > > >=20
> > > > Yes, IMHO at one point in time, we should switch the default machine
> > > > type to q35. The i440FX is really quite old...
> > > >=20
> > > > > There are certainly some drawbacks:
> > > > > -        Compatibility: current code or script may need adjustment
> > > >=20
> > > > That might be a real concern ... so I think a good point in time to
> > > > switch to the q35 machine type would be when we switch to the next =
major
> > > > version number of QEMU, i.e. when we switch to version 3.0. If the =
users
> > > > see a new major version number, they might be more willing to accept
> > > > such major changes (yeah, I know, we've discussed in the past that
> > > > version numbers are just numbers ... but still, there is some kind =
of
> > > > psychological aspect to this, too, I think)
> > >=20
> > > Most users aren't even aware of version numbers of QEMU - they'll just
> > > take whatever their distro has provided run it. The notion that their
> > > latest distro version happened to pull in a "major" version instead of
> > > previously pulling in a "minor" version is invisible to everyone,
> > > except the minority of people who care about the low level details.
> >=20
> > When user-visible changes break existing setups it's common for
> > packagers to ship a new family of packages that includes the major
> > version number (e.g. apache2, postgresql-9.6).
> >=20
> > The last QEMU 2.x version would be considered stable and still available
> > from package repos.  Only critical bug and security fixes could be
> > released for another, say, 2 years.
> >=20
> > This way users don't have to migrate to QEMU 3.x until they are ready.
>=20
> Given the number of security vulnerabilities packagers have to deal with
> for QEMU, maintaining multiple QEMU streams in parallel is a pretty
> major undertaking. I can't say that would be appealing from a Fedora
> maintainer POV - it'd likely just end up shipping only the newest version
> to avoid that extra maint burden. I doubt enterprise distros would ship
> both versions in parallel in this way [1].
>=20
> Even if both versions are available, the people affected by the breakage
> still need to figure out that the breakage they're seeing is caused by
> the change in machine type, and that installing the old version will
> fix it. This is still an unpleasant experiance IMHO.=20

True, package naming doesn't provide an upgrade path.  That will still
be painful.

Stefan

--aTCJOP0qgkSGqHWA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZKTMAAoJEJykq7OBq3PIRE0IAJ/7vJuIL5rpTo03XHp9kmo8
GSHeO78E1osj1LNtYeaD0IwwYLP2xAag1Jf5iAD/EvOZlobXh4ox/cNqWPYXrLuE
oI0XMhhYEKy6Uv8TPKZLhBciIligyuKc/+Gh+Ye1ifBZslR2PJ/8ioi1Pon2iQH8
LFF19RmV9bKbKMUp4q0SFwuF8yIgqC/3Ilp+Yqy8vbaz6JKE/oxpN3kKC+wzL3S2
0ikyqM4U77RV2bJGZ8n9ZjohyKCVLW5XakKXniRdYJ4PWNNdyWIVhxMXo/rbqvFH
hohwusebvQCOB91GmKp23An4N2cA1WnBufbHvTEk5gapuHXiFSW4OB9MR1htscw=
=JUaK
-----END PGP SIGNATURE-----

--aTCJOP0qgkSGqHWA--
