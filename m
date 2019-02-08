Received: from eggs.gnu.org ([209.51.188.92]:34848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gs4Ac-0006Ev-AV
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gs4Aa-0004PK-OY
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:18:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1gs4Aa-0004ON-IA
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:18:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE2D68830F
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 11:18:06 +0000 (UTC)
Date: Fri, 8 Feb 2019 12:17:59 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190208111759.GH27833@angien.pipo.sk>
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-17-armbru@redhat.com>
	<0e7c814c-5d82-e9c0-3d53-bcc576019b65@redhat.com>
	<20190207122950.GA1854@andariel.pipo.sk>
	<87wombd83i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AzNpbZlgThVzWita"
Content-Disposition: inline
In-Reply-To: <87wombd83i.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [libvirt] [PATCH v3 16/17] qmp: Deprecate
 query-events in favor of query-qmp-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, libvirt-list@redhat.com, qemu-devel@nongnu.org


--AzNpbZlgThVzWita
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 14:46:41 +0100, Markus Armbruster wrote:
> Peter Krempa <pkrempa@redhat.com> writes:
>=20
> > On Wed, Feb 06, 2019 at 12:42:05 -0600, Eric Blake wrote:
> >> Adding libvirt in cc
> >>=20
> >> On 2/6/19 12:17 PM, Markus Armbruster wrote:
> >> > query-events doesn't reflect compile-time configuration.  Instead of
> >> > fixing that, deprecate the command in favor of query-qmp-schema.
> >> >=20
> >> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> > ---
> >> >  monitor.c            | 5 +++++
> >> >  qapi/misc.json       | 7 +++++--
> >> >  qemu-deprecated.texi | 5 +++++
> >> >  3 files changed, 15 insertions(+), 2 deletions(-)
> >>=20
> >> Libvirt uses query-events; we'll need to patch libvirt to start relying
> >> on query-qmp-schema before this deprecation cycle can complete (althou=
gh
> >> I'm in favor of making the change).
> >
> > Patches to use 'query-qmp-schema' output rather than 'query-events' in
> > libvirt:
> >
> > https://www.redhat.com/archives/libvir-list/2019-February/msg00298.html
> >
> > You can start the deprecation clock.
>=20
> Awesome!

It's now pushed. Thankfully our existing infrastructure for querying
schema was able to handle it without any changes.

--AzNpbZlgThVzWita
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlxdZWAACgkQHGwCByjY
1GppFA/7BZdbDqCj1RLN/2Vw2Y/NeJINbyOxr9cFNq3kzyefPRkk6GRkzDDnjDPg
51Snlre+bgx3YDrw3VXwT3uYsO2buD6tO7qLoxzo+JDuqWQL0+XdNcVqsDnmo78C
mjci8CH2bel5wCWWRtTUElvNgRIe17nA8QjMJxAXt6yMaHsqeoQhlXQC4CRtWEWg
c4Liz4Hp0yZfnPezo6zaaBkGZYcM7O7Iwk7OWL2TMZn8vOXjTeuyIk5aVreTX9j3
pl/BeZTUX+/6+LEVsi6VrCATk9iSS+Zv+AN1HZ47PdT4PKV17JUS5fxPAQO1ivTO
NhzKilO9grQOI86mt+kGYcslEJGnQ/CoVC+UYyHs7P2UVXsz/Ouy6FMv0xHWSnam
Id0s30dsYjQEFn0hIwdByPaVJJa3swQBR3O0WLYKBnaMUY77GEEsUcGxhxyL3Fbu
lp5ElIhGAm4CwT8QhEbVcNND0cy1++g7tYCH7mBSe/Q+3FYTqwDvVXuVprimizk7
higzQJDObh+nmGLT76+TYaQI6xnYeMv9Q0Ns2NrXbLMk5cabM4f9VOpcSD14KUek
S0AJMV4bo1hH4+IOoHJcedo1d0uysHlmNt5ER80EcHvFkWOmFHr3DXAq2aT13EVC
4k1eYbvn7o5C96cBKPvRFjSG4dU2gzB3ZA5f46SV1xpMoSSxRCo=
=HRzp
-----END PGP SIGNATURE-----

--AzNpbZlgThVzWita--
