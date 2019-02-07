Received: from eggs.gnu.org ([209.51.188.92]:39990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1griwk-0006Ok-Kg
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1griwe-0002SI-O5
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:38:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1griwa-0002QD-NO
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:38:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20D9489AFF
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 12:29:55 +0000 (UTC)
Date: Thu, 7 Feb 2019 13:29:50 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190207122950.GA1854@andariel.pipo.sk>
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-17-armbru@redhat.com>
	<0e7c814c-5d82-e9c0-3d53-bcc576019b65@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <0e7c814c-5d82-e9c0-3d53-bcc576019b65@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, libvirt-list@redhat.com


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 12:42:05 -0600, Eric Blake wrote:
> Adding libvirt in cc
>=20
> On 2/6/19 12:17 PM, Markus Armbruster wrote:
> > query-events doesn't reflect compile-time configuration.  Instead of
> > fixing that, deprecate the command in favor of query-qmp-schema.
> >=20
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  monitor.c            | 5 +++++
> >  qapi/misc.json       | 7 +++++--
> >  qemu-deprecated.texi | 5 +++++
> >  3 files changed, 15 insertions(+), 2 deletions(-)
>=20
> Libvirt uses query-events; we'll need to patch libvirt to start relying
> on query-qmp-schema before this deprecation cycle can complete (although
> I'm in favor of making the change).

Patches to use 'query-qmp-schema' output rather than 'query-events' in
libvirt:

https://www.redhat.com/archives/libvir-list/2019-February/msg00298.html

You can start the deprecation clock.

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlxcJLsACgkQHGwCByjY
1Go82A/+MbBkogU/eO1tIR5JD6VqTvDdWLsEKE6u6y2f/azYoFnhHMq/xzYzmeSr
ap4al+BBZecjNZsukQSwrqggRnvu1lgEXR0ZRVPyCMVTAv6sS5fPU1iZSnP+H/xE
Y6VtKJgPc1RBrl3xfGoxaHy3ffAOlDacbM8YMKcO5jvVl5Zha68H0rXypzbet2BX
kA+6Tog0emvSA0bnqbNHDJi9x5enrLK2cUOm+WMUPVUU03UC/ro7buKdmqIVzGBw
o7B9IL4SoIMcI7jtVVlPFnkU1ZZxCN188y6uG3g5K6ZjOYMjksaKjw6npPZuBVbJ
DORCq6S634/++kGO/mW74hBDFQPGZJRG8G2CCL1sd9HS/33K6XkFWqkoOeCFCMWR
PyDHQ+ZoS14Jb5wa/8r0Lt8QTLvDMC4t6QWIfYPayN1Qb4BEqeD9i6AZZEVtCR1t
/XmOh5aAtei3h0YWDXvyFVUWuxaJzGk+9h6w04gzKXvGkIS1/rDs1AR2QkD5sPtu
cWuSiofehge3pu5IVlfnPLg7uHN2mi3+hsC0YU9v+rlUk5mHeidDS/cnAaEsaJaK
NyglusPdeLlO/S/XXs7Te43EvDHNwXovyktsWfYNTRsvcuZfRt/q3+YvyPEpdk0X
oFl2OsbAdx3AAlKjYquwe8LC7avaebne3cOUj49gajWe0TcVAms=
=fZlm
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
