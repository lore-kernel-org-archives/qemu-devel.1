Received: from eggs.gnu.org ([2001:4830:134:3::10]:39776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1fQCjj-0002Sj-O5
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1fQCje-0000sb-MO
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:14:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <phrdina@redhat.com>) id 1fQCje-0000sO-EI
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:14:54 -0400
Date: Tue, 5 Jun 2018 16:14:42 +0200
From: Pavel Hrdina <phrdina@redhat.com>
Message-ID: <20180605141442.GO8876@antique-desktop>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<20180605130646.GF7451@localhost.localdomain>
	<20180605131232.GG32286@redhat.com>
	<20180605133538.GG7451@localhost.localdomain>
	<20180605134439.GN8876@antique-desktop>
	<20180605140346.GI7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pes7OZCOzfZhFQfq"
Content-Disposition: inline
In-Reply-To: <20180605140346.GI7451@localhost.localdomain>
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


--Pes7OZCOzfZhFQfq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 11:03:46AM -0300, Eduardo Habkost wrote:
> On Tue, Jun 05, 2018 at 03:44:39PM +0200, Pavel Hrdina wrote:
> > On Tue, Jun 05, 2018 at 10:35:38AM -0300, Eduardo Habkost wrote:
> > > On Tue, Jun 05, 2018 at 02:12:32PM +0100, Daniel P. Berrang=C3=A9 wro=
te:
> > > > On Tue, Jun 05, 2018 at 10:06:46AM -0300, Eduardo Habkost wrote:
> > > > > (CCing libvir-list)
> > > > >=20
> > > > > On Tue, Jun 05, 2018 at 09:43:00AM +0100, Daniel P. Berrang=C3=A9=
 wrote:
> > > > > > On Tue, Jun 05, 2018 at 09:27:46AM +0200, Gerd Hoffmann wrote:
> > > > > > >   Hi,
> > > > > > >=20
> > > > > > > > >   Add to that shortcuts like -cdrom
> > > > > > > > > stop working,
> > > > > > > >=20
> > > > > > > > Maybe is fixable.
> > > > > > >=20
> > > > > > > Already fixed for ages.
> > > > > > >=20
> > > > > > > > I see marking Q35 as the default machine a first step.
> > > > > > >=20
> > > > > > > Maybe the better option is to go the arm route:  Just don't d=
efine a
> > > > > > > default, so users have to specify pc or q35.  That will make =
them notice
> > > > > > > there is a world beside 'pc', and we also avoid breaking thin=
gs
> > > > > > > silently.
> > > > > >=20
> > > > > > If QEMU removes the default, then libvirt will have to hardcode
> > > > > > 'pc' as the default to maintain back compatibility, so I don't
> > > > > > think that ends up as a net win
> > > > >=20
> > > > > Is there an actual promise to never change the default
> > > > > machine-type documented in the libvirt API, or is this just fear
> > > > > of breaking existing code?
> > > >=20
> > > > The risk of breaking things that currently work. Some of the things
> > > > discussed here that risk breaking users if QEMU changes the default,
> > > > have the same risk if libvirt changes the default.
> > > >=20
> > > > eg old OS versions that only work with PC, or more commonly pre-exi=
sting
> > > > cloud disk images that were built against PC can't be assumed to ju=
st
> > > > work against q35, even if the OS in the image supports it.
> > > >=20
> > > > If we want to get q35 broadly used for modern OS, then IMHO the best
> > > > option is to record that metadata in libosinfo, as ew do for other
> > > > virtual hardware preferences.  That doesn't fix the problem of disk
> > > > images that might not transparently boot between pc/q35, but at lea=
st
> > > > avoids breaking OS that don't support q35 at all.
> > >=20
> > > This leads to a more general question: sometimes the defaults
> > > chosen by libvirt are obsolete or broken, and we might want to
> > > change them.
> > >=20
> > > Is there a process for changing defaults in libvirt, or libvirt
> > > is bound by past decisions forever?
> >=20
> > If the default was always recorded in the domain XML it is safe to
> > change it because it will not affect already existing domains or
> > migration but if the default is not recorded in the domain XML there
> > needs to be a lot of compatibility code.
>=20
> That's the opposite of what Daniel said above, isn't it?  The
> machine-type is always recorded in the domain XML, but it's still
> considered unsafe to change.

It's not opposite.  The thing is that some of the defaults are not that
easy change for other reasons, not from libvirt POV or because of ABI
stability.  In general yes, it is possible to change it but in some
cases it might not be good idea, one example could be the machine time.

Changing default machine time affects the whole guest and may break
a lot of use-cases but changing some default device model if the current
default is obsolete and most of the OSes supports the new one should
be safe.

Pavel

--Pes7OZCOzfZhFQfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAlsWmtIACgkQUi1kczAH
4Yxr5hAAg5+vdKx6k/E/m9f+PflNzIof9CUcGrbS0XGGNoapGfuEx28r6VhhVPrO
9joeFkcRnO3dV0kQ34hqepSHqrGcPo7VdgXGoszWyCL/EjUyHkNobCkC7K929bex
/YEUZf8+flro6eTDsBel+DlzmcAAAsZkyGyVJwcmXnCIl5pBbDJldUfUgQ/Y/3g2
ub6uy+TDERBZrpDiF2s7Dype+nmNSnuqUC3SXraITH2JU+tud4SCS1/BDT9zOpzT
ukiw92RhNrlVKSP514CTP1+z0O9K8MmLDagfTU8WpzLj4y8zlZmsb45HYD5I/Ka0
wRVmmGuBAOwwWVB6OCEp8L+C5yPR5BLwpDs4KaCPPbABj+a50urzC6VnQ1h43ZJr
bHwaI8ymwLc4ZdF6yAno+uo0zNO0U1JjAvUu3ilANg2asJc6AoUIYojkzzp0KRoo
24JEHAQI/2FuwCqqjz2PyW7h1eP4sW/Cbtoxgx/zNunqE1s6U2Ipk6ieR2jFnNeT
8nqTHH9+EsGuJcw/eCG9Dt83ZIZn5bkJ9xCi8qSErFRmgHt7CwCH05PeLiTLqYee
mM8BnwIDekQoQqg4Y6Mb6Y1mo9urT1mxsNy8q77DzZ/Axu2Ys/FUhr2bSOT0jaU3
18h144GiKIyAeJWQJDvjY2wBHRJ0WbsG35y8+7oL+5/ZVfn8fOc=
=JCIO
-----END PGP SIGNATURE-----

--Pes7OZCOzfZhFQfq--
