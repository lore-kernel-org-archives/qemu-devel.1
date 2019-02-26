Received: from eggs.gnu.org ([209.51.188.92]:59148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gylyq-0001KE-SV
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gylyp-00077n-Ri
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:17:44 -0500
Date: Wed, 27 Feb 2019 09:50:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226225009.GR6872@umbus.fritz.box>
References: <20190225162325.24008-1-maxiwell@linux.ibm.com>
	<20190225232009.GB30778@kermit.br.ibm.com>
	<20190226032103.GJ6872@umbus.fritz.box>
	<20190226142126.jxosththzad6h6dd@maxibm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VmyrZ50r30oK77nV"
Content-Disposition: inline
In-Reply-To: <20190226142126.jxosththzad6h6dd@maxibm>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr-rtas: add ibm,
 get-vpd RTAS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-devel@nongnu.org, "open list:sPAPR" <qemu-ppc@nongnu.org>


--VmyrZ50r30oK77nV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 11:21:26AM -0300, Maxiwell S. Garcia wrote:
> On Tue, Feb 26, 2019 at 02:21:03PM +1100, David Gibson wrote:
> > On Mon, Feb 25, 2019 at 08:20:09PM -0300, Murilo Opsfelder Araujo wrote:
> > > Hi, Maxiwell.
> > >=20
> > > On Mon, Feb 25, 2019 at 01:23:25PM -0300, Maxiwell S. Garcia wrote:
> > > > This adds a handler for ibm,get-vpd RTAS calls, allowing pseries
> > > > guest to collect host information. It is disabled by default to
> > > > avoid unwanted information leakage. To enable it, use:
> > > > =E2=80=98-M pseries,vpd-export=3Don=E2=80=99
> > >=20
> > > The patch for setting host-serial and host-model already landed Gibso=
n's
> > > ppc-for-4.0 branch:
> > >=20
> > >   commit 9e584f45868f6945c1282c938278038cba0e4af2
> > >   Author: Prasad J Pandit <pjp@fedoraproject.org>
> > >   Date:   Mon Feb 18 23:43:49 2019 +0530
> > >=20
> > >       ppc: add host-serial and host-model machine attributes (CVE-201=
9-8934)
> > >=20
> > >=20
> > > QEMU should only return host-serial and host-model from the host if t=
he
> > > following combination of parameters are provided:
> > >=20
> > >   -M host-serial=3Dpassthrough,host-model=3Dpassthrough,vpd-export=3D=
on
> > >=20
> > > If host-serial or host-model are set with a user-string, ibm,get-vpd =
should
> > > honor these values and return them, not exposing host information by =
accident.
> > >=20
> > > I'm not even sure if we need vpd-export=3D<bool> setting. Its logic c=
ould be
> > > derived from the presence of host-serial=3Dpassthrough and host-model=
=3Dpassthrough
> > > options.
> > >=20
> > > What do you think?
> >=20
> > That's an excellent point - I hadn't thought through the fact that
> > this is the same information exposed by those properties.  I do indeed
> > think that exposing the same information set in those properties - and
> > thereby avoiding the new machine option - would be a better plan.
>=20
> I saw that the patch was applied. So I will work in another patch
> to use these properties and remove the export-vpd option.

Sorry, should have said.  I did apply it, but I pulled it out again
because of the point above.

> Another thing that I thought the fact that 'host-serial' and 'host-model'
> nodes in Device Tree are not in accordance with LoPAPR document. What
> you think in use only get-vpd to get these information and remove
> nodes from device tree?
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VmyrZ50r30oK77nV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx1wqEACgkQbDjKyiDZ
s5I8XA/+Ky5g05Aygc6Fk5ua73Zbw8zlIw7y7V+qpsFOI5xW9q5sJjVeLIRbexq6
RKjy+UNdoo2DT+DXRy13k6z8rF0QXQqoownU39qaPeu32ZD64nefCo8i8+F8hcDp
M/OnCJKb++HYjGDTSG3geXzhLXFDuSoytNKwalxZ3A0NXQuIGdfOJSt3M/D621wK
z0y0zqhFw8NUvVDIqPW66FJjM3xOyQ1Hk19rqZRD77E4VznJ+yxBGtCdb1+9x8GQ
j6cvtWpJKvDYzkW+FC8Oco+SgHbxY20GFa7o1zXJDYIg8V65CAX7d0t9oCqa7acQ
341GpUuJxqdrTHKMk2YRcpUgqRGog5fwFiNlipejr1VOZ4GMdRMMGBiltZVM6kUH
XgBQhtcRlRD98XhQ1830Oz/jq0LyIPRSaUGQD0HJt1LjYTXkatEBoVdmwOxgZmcA
2ITcfd+34cM+xz/JtXfXC/8EMLqk9WMT13USK8Mcbzs4RTYj16o6tH5eao6kgNwb
uLSf0mJkzmyseOmNFBCSLoe7NBkqujVumvofzDK/z09otXF6RmDfmvrLRXJ1By5M
bU+DsHoJp/6FqflozuzXu1RrRHrtUbrUf1EA7rhei+5o4GwoFG/+wHi3QVYlhizG
/XXSIa2qJoye5wJxUCy7xMm1baA2oyzrNbr/cgIWxdjKQlkAdNg=
=NwDU
-----END PGP SIGNATURE-----

--VmyrZ50r30oK77nV--
