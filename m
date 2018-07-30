Received: from eggs.gnu.org ([2001:4830:134:3::10]:44532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fk6JJ-0001nF-Sd
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fk6JI-00030e-Rr
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:25:57 -0400
Date: Mon, 30 Jul 2018 13:25:45 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180730112545.GJ20399@angien.pipo.sk>
References: <20180727141539.506-1-kwolf@redhat.com>
	<20180727141539.506-2-kwolf@redhat.com>
	<7721290c-94f0-d203-10c0-8aa586c54600@redhat.com>
	<20180727155854.GF4355@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Content-Disposition: inline
In-Reply-To: <20180727155854.GF4355@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-3.0 1/3] block/qapi: Add 'qdev' field
 to query-blockstats result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 17:58:54 +0200, Kevin Wolf wrote:
> Am 27.07.2018 um 17:07 hat Eric Blake geschrieben:
> > On 07/27/2018 09:15 AM, Kevin Wolf wrote:
> > > Like for query-block, the client needs to identify which BlockBackend
> > > the returned data is for. Anonymous BlockBackends are identified by t=
he
> > > device model they are attached to. Add a 'qdev' field that contains t=
he
> > > qdev ID or QOM path of the attached device model.
> > >=20
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> >=20
> > > @@ -879,7 +882,7 @@
> > >   # Since: 0.14.0
> > >   ##
> > >   { 'struct': 'BlockStats',
> > > -  'data': {'*device': 'str', '*node-name': 'str',
> > > +  'data': {'*device': 'str', '*qdev': 'str', '*node-name': 'str',
> > >              'stats': 'BlockDeviceStats',
> > >              '*parent': 'BlockStats',
> > >              '*backing': 'BlockStats'} }
> >=20
> > Can we also update the example under query-blockstats a few lines later=
 to
> > show the added field?
>=20
> I'll add the qdev field, but the example is hopelessly outdated anyway.
> Sounds like something for another patch.

When doing further cleanups it would be worth also noting that the
'query-nodes' argument of 'query-blockstats' does not return correct
information.

Right now it creates a false impression that it just changes the output
=66rom nested to linear and includes filter nodes, but in fact the data is
not correct in that mode.

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlte9bYACgkQHGwCByjY
1GqCvw/9GYGMLj8EzZibYdmbyWPeAoNg18aAcfu+F1sYYafn0Fr9kMKFIkr3EVsT
K1E5ZdWdhd5Sm84nwdco3uE7yRRGK7lzz1LNmMnxPDMnCVG+phhF45+OXH7rDlwS
JnpsAYYgPF1PduX9S5jkSh0hwUVsmBVvzurUupvE2ipGVuiMoeEvZNFNrwSiS0z7
89ZyiXlHiqkOuR3mrz/T08rXm/3D9qQh3T3qYsb/ga79i/Q+7ZU/gg6DA66UQWhG
uKFPr171RWcZvVRhgTxAc1i3eQZKpvtxXiVp3pdRc7onodGPxzLEyxmRREnoRKDk
nLqqwF66cqgAY2hblYd2Nsyvri7tyN9yD00TZcdomdz/AISc+3J1f9JIiCpYJVV6
rwfw9nZKhyXaMgs+lql3nDhWBErvfQ0RwYZjm4keMJ+51lqx1Oyki1BudB1Em8tB
o5cBhP86ZVtdxP9UDbGcCnl/VJYBU8AK5osL+qJUUsQn3ijCAG2kimVbiHaSCWct
ip+qnNNXG+o+wKGoqrq84957MFRxcDQsZTuTKKElPGcHfUoWank683gCfJjpP9AU
Hp7ZsXDUu3uxEcUcdv/VRcKF4weDxfDinpXvLB7ISLcBfN0F+A5FG6dPVXISKYMM
04A8gpYVbte2fAcmg0AEj//l3LJg1Hi1qAvvM1PQr8Fzuyq3mpU=
=Hq0m
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--
