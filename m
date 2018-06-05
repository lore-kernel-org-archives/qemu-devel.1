Received: from eggs.gnu.org ([2001:4830:134:3::10]:45235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1fQD4K-0001cS-JD
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1fQD4G-0003Va-HR
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:36:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36858 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <phrdina@redhat.com>) id 1fQD4G-0003U7-6d
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:36:12 -0400
Date: Tue, 5 Jun 2018 16:36:07 +0200
From: Pavel Hrdina <phrdina@redhat.com>
Message-ID: <20180605143607.GP8876@antique-desktop>
References: <20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<20180605130646.GF7451@localhost.localdomain>
	<20180605131232.GG32286@redhat.com>
	<20180605133538.GG7451@localhost.localdomain>
	<20180605134439.GN8876@antique-desktop>
	<20180605140346.GI7451@localhost.localdomain>
	<20180605140704.GM32286@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uLzYCuFow5JXEQYy"
Content-Disposition: inline
In-Reply-To: <20180605140704.GM32286@redhat.com>
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
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, pbonzini@redhat.com, rth@twiddle.net


--uLzYCuFow5JXEQYy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 03:07:04PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jun 05, 2018 at 11:03:46AM -0300, Eduardo Habkost wrote:
> > On Tue, Jun 05, 2018 at 03:44:39PM +0200, Pavel Hrdina wrote:
> > > On Tue, Jun 05, 2018 at 10:35:38AM -0300, Eduardo Habkost wrote:
> > > > On Tue, Jun 05, 2018 at 02:12:32PM +0100, Daniel P. Berrang=C3=A9 w=
rote:
> > > > > On Tue, Jun 05, 2018 at 10:06:46AM -0300, Eduardo Habkost wrote:
> > > > > > (CCing libvir-list)
> > > > > >=20
> > > > > > On Tue, Jun 05, 2018 at 09:43:00AM +0100, Daniel P. Berrang=C3=
=A9 wrote:
> > > > > > > On Tue, Jun 05, 2018 at 09:27:46AM +0200, Gerd Hoffmann wrote:
> > > > > > > >   Hi,
> > > > > > > >=20
> > > > > > > > > >   Add to that shortcuts like -cdrom
> > > > > > > > > > stop working,
> > > > > > > > >=20
> > > > > > > > > Maybe is fixable.
> > > > > > > >=20
> > > > > > > > Already fixed for ages.
> > > > > > > >=20
> > > > > > > > > I see marking Q35 as the default machine a first step.
> > > > > > > >=20
> > > > > > > > Maybe the better option is to go the arm route:  Just don't=
 define a
> > > > > > > > default, so users have to specify pc or q35.  That will mak=
e them notice
> > > > > > > > there is a world beside 'pc', and we also avoid breaking th=
ings
> > > > > > > > silently.
> > > > > > >=20
> > > > > > > If QEMU removes the default, then libvirt will have to hardco=
de
> > > > > > > 'pc' as the default to maintain back compatibility, so I don't
> > > > > > > think that ends up as a net win
> > > > > >=20
> > > > > > Is there an actual promise to never change the default
> > > > > > machine-type documented in the libvirt API, or is this just fear
> > > > > > of breaking existing code?
> > > > >=20
> > > > > The risk of breaking things that currently work. Some of the thin=
gs
> > > > > discussed here that risk breaking users if QEMU changes the defau=
lt,
> > > > > have the same risk if libvirt changes the default.
> > > > >=20
> > > > > eg old OS versions that only work with PC, or more commonly pre-e=
xisting
> > > > > cloud disk images that were built against PC can't be assumed to =
just
> > > > > work against q35, even if the OS in the image supports it.
> > > > >=20
> > > > > If we want to get q35 broadly used for modern OS, then IMHO the b=
est
> > > > > option is to record that metadata in libosinfo, as ew do for other
> > > > > virtual hardware preferences.  That doesn't fix the problem of di=
sk
> > > > > images that might not transparently boot between pc/q35, but at l=
east
> > > > > avoids breaking OS that don't support q35 at all.
> > > >=20
> > > > This leads to a more general question: sometimes the defaults
> > > > chosen by libvirt are obsolete or broken, and we might want to
> > > > change them.
> > > >=20
> > > > Is there a process for changing defaults in libvirt, or libvirt
> > > > is bound by past decisions forever?
> > >=20
> > > If the default was always recorded in the domain XML it is safe to
> > > change it because it will not affect already existing domains or
> > > migration but if the default is not recorded in the domain XML there
> > > needs to be a lot of compatibility code.
> >=20
> > That's the opposite of what Daniel said above, isn't it?  The
> > machine-type is always recorded in the domain XML, but it's still
> > considered unsafe to change.
>=20
> Yes, I disagree with that Pavel has written here. The domain XML recording
> of settings is critical for preserving guest ABI for migration, etc, so
> obviously must be stable. Even if there is *no* domain XML yet, however,
> libvirt still aims to avoid changes in defaults that are liable to break
> an existing mgmt application creating guests in future.

Yes in general we try to avoid changing defaults and no it's possible to
do it if there is good reason <568887a32f9985b95d998dd0d675255ea985013f>.

So technically there is a way but usually it's not good idea.  I should
have noted in the first reply that machine type is huge change and that
my statement applies to smaller changes.

Pavel

--uLzYCuFow5JXEQYy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAlsWn9cACgkQUi1kczAH
4Ywp4A//dOlp+7dxm9FimsIlbhDgekU4kbhzcjzazZ8y5Di2FL02m/Z6KJfNhB1H
GoHXZ6+OiDam2Zd9XYwwtcra+XjvCivYNBfhfY2OyuOKZzJVhBIxk3BjYqrGjrCj
LPDpYm2iZ3Z2/KWevbA5vdWalOWK5ybMNPtsyYfShry4pnn7EV2RJ2C9m0k71Xwg
kO6l9ia7CTZwmdR82rUHEaz50Wq66e/UfJ1+4y9O0Epg8IgsaUYcIWGWTE+sXQie
KEfdPtzQuxT+5pJ1GUbbpnveBMGht/G//XKEAyGzKMhgqtzADmzHCelFL37K8977
ztbCVgj4A1YsuNgL9fFzo+1RoUBZwO1eYM63lanZntRJzCZr2CGqhlKg+xXvYmTX
EgtY8uqDFp7hMANe8xFqJfXmIa2gNj9EtqvYL7c1uhG+QKrX25qluteovXl6wPAG
/BWvzzSqw7mvEEJV8ELMvQl+Gv+UxRSXMH6CX5S5K9hbBitE7OAktBCTcoBlOw+e
LDj9qgPCC3LVczCAM4fSuoFgWiDzH4lRdqldOoYO9DbIYHFVHs0LVRV8zy25/0o9
wPb5UejHpGd2PyfmwNwTWqrsDZq/14fMnC4P/tYN5/2JK3q0uRtW3b53KDJW2nZI
+KtUWebi/AB3SNdnzk6U4St2JsxNqNT8NXMxepI1Z2eYJt/0sWc=
=Ce+u
-----END PGP SIGNATURE-----

--uLzYCuFow5JXEQYy--
