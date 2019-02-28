Received: from eggs.gnu.org ([209.51.188.92]:51101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gz9t2-0005jd-Om
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gz9t0-0003Oe-J9
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:49:20 -0500
Date: Thu, 28 Feb 2019 11:33:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190228003309.GB7734@umbus.fritz.box>
References: <20190225162325.24008-1-maxiwell@linux.ibm.com>
	<20190225232009.GB30778@kermit.br.ibm.com>
	<20190226032103.GJ6872@umbus.fritz.box>
	<20190226142126.jxosththzad6h6dd@maxibm>
	<20190226170830.GA16569@kermit.br.ibm.com>
	<20190226191140.GA25467@kermit.br.ibm.com>
	<20190226231920.GS6872@umbus.fritz.box>
	<20190227150449.GA9614@kermit.br.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20190227150449.GA9614@kermit.br.ibm.com>
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
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>, "open list:sPAPR" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 12:04:49PM -0300, Murilo Opsfelder Araujo wrote:
> Hi, David.
>=20
> On Wed, Feb 27, 2019 at 10:19:20AM +1100, David Gibson wrote:
> > On Tue, Feb 26, 2019 at 04:11:40PM -0300, Murilo Opsfelder Araujo wrote:
> > > On Tue, Feb 26, 2019 at 02:08:30PM -0300, Murilo Opsfelder Araujo wro=
te:
> > > > Hi, Maxiwell.
> > > >
> > > > On Tue, Feb 26, 2019 at 11:21:26AM -0300, Maxiwell S. Garcia wrote:
> > > > > On Tue, Feb 26, 2019 at 02:21:03PM +1100, David Gibson wrote:
> > > > > > On Mon, Feb 25, 2019 at 08:20:09PM -0300, Murilo Opsfelder Arau=
jo wrote:
> > > > > > > Hi, Maxiwell.
> > > > > > >
> > > > > > > On Mon, Feb 25, 2019 at 01:23:25PM -0300, Maxiwell S. Garcia =
wrote:
> > > > > > > > This adds a handler for ibm,get-vpd RTAS calls, allowing ps=
eries
> > > > > > > > guest to collect host information. It is disabled by defaul=
t to
> > > > > > > > avoid unwanted information leakage. To enable it, use:
> > > > > > > > =E2=80=98-M pseries,vpd-export=3Don=E2=80=99
> > > > > > >
> > > > > > > The patch for setting host-serial and host-model already land=
ed Gibson's
> > > > > > > ppc-for-4.0 branch:
> > > > > > >
> > > > > > >   commit 9e584f45868f6945c1282c938278038cba0e4af2
> > > > > > >   Author: Prasad J Pandit <pjp@fedoraproject.org>
> > > > > > >   Date:   Mon Feb 18 23:43:49 2019 +0530
> > > > > > >
> > > > > > >       ppc: add host-serial and host-model machine attributes =
(CVE-2019-8934)
> > > > > > >
> > > > > > >
> > > > > > > QEMU should only return host-serial and host-model from the h=
ost if the
> > > > > > > following combination of parameters are provided:
> > > > > > >
> > > > > > >   -M host-serial=3Dpassthrough,host-model=3Dpassthrough,vpd-e=
xport=3Don
> > > > > > >
> > > > > > > If host-serial or host-model are set with a user-string, ibm,=
get-vpd should
> > > > > > > honor these values and return them, not exposing host informa=
tion by accident.
> > > > > > >
> > > > > > > I'm not even sure if we need vpd-export=3D<bool> setting. Its=
 logic could be
> > > > > > > derived from the presence of host-serial=3Dpassthrough and ho=
st-model=3Dpassthrough
> > > > > > > options.
> > > > > > >
> > > > > > > What do you think?
> > > > > >
> > > > > > That's an excellent point - I hadn't thought through the fact t=
hat
> > > > > > this is the same information exposed by those properties.  I do=
 indeed
> > > > > > think that exposing the same information set in those propertie=
s - and
> > > > > > thereby avoiding the new machine option - would be a better pla=
n.
> > > > > >
> > > > >
> > > > > I saw that the patch was applied. So I will work in another patch
> > > > > to use these properties and remove the export-vpd option.
> > > > >
> > > > > Another thing that I thought the fact that 'host-serial' and 'hos=
t-model'
> > > > > nodes in Device Tree are not in accordance with LoPAPR document. =
What
> > > > > you think in use only get-vpd to get these information and remove
> > > > > nodes from device tree?
> > > >
> > > > Both "system-id" and "model" properties are described in the sectio=
n "3.3.2.1
> > > > Root Node Properties" of the "Device Tree Bindings: Linux on Power =
Architecture
> > > > Reference" document:
> > > >
> > > >   https://members.openpowerfoundation.org/wg/SYSSW/document/1455
> > >
> > > I replied too early. As Maxiwell explained to me (thanks Max!), guest=
 can end up
> > > having the following entries under /proc/device-tree/ (among other en=
tries):
> > >
> > >   $ cat host-serial
> > >   12A3B4C
> > >
> > >   $ cat host-model
> > >   1234-56A
> > >
> > >   $ cat system-id
> > >   c7b62da9-3d0c-44f9-8edb-2318271f3c1a
> > >
> > >   $ cat model
> > >   IBM pSeries (emulated by qemu)
> > >
> > > Where:
> > >
> > >   - host-serial/host-model: depend on "-M host-serial" and "-M host-m=
odel"
> > >     machine options.
> > >
> > >   - system-id: created when "-uuid <val>" exists in qemu command line=
 options.
> > >
> > >   - model: hard-coded.
> > >
> > > With this patch, RTAS ibm,get-vpd call will return "system-id" and "m=
odel" from
> > > the host, not from the guest. I found this confusing.
> >
> > Hrm.  I found the bit in LoPAPR describing how ibm,get-vpd operates,
> > but not something describing the actual data that appears within it.
> > Where's that described?  It'd be nice to check if those values are
> > supposed to be describing the host or the guest.
>=20
> Are you asking about the fields of the ibm,vpd property? They are describ=
ed in
> Table 11.2 "LoPAPR VPD Fields" of this LoPAPR document:
>=20
>   https://members.openpowerfoundation.org/wg/SYSSW/document/1461

That document appears to be only available to openpower members, which
I'm not.

I found Table 160 in my copy of LoPAPR (1.1) though, which looks like
it has the same stuff.  I wonder if I should be trying to get a more
recent LoPAPR.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx3LEIACgkQbDjKyiDZ
s5K7Lw/9Hq4T4RUlOisMmvA5OkLwaYK57beXLzvo2rylqfZlLRfeV+L7/0cPDu3L
H3n+Vg2ewRlBEA6ZKuvqY6Pwx75lkp7F46z+7qCVMrQMKFts69Mg0q80z4pr7lXH
uTkXsJwTyZs11gnvwfGV072FQmgurN5+QO+wRdyP2DHU9q5isc5aPZMCN1QrbrUn
VV8r5fUhsa4SMqdQQFpxhqpuiV5x43mwiasfY2wyf+2JBsncrlMK6JzJHW5Z1OjG
4Wg7/gz5kBLrLwXtZOeCtlhsaNJgY1M1P0Ae1JOVDdmsH82g2DLL3gN6fs5wx+DV
BwXKN1KvISsxrB7shLlyl8YXIxu+rAK6L0PHQ04Okkx/Z5+Fo9aRa4XhpIUAWO4D
LitcAVTwTydicJLbrFb7MHPEwIs8VwSKIwSVZy9GIvoHssgqP3N38c/Y3tZDTSZL
TmN3T9TwAG31q4y+dNyTp3RdHgWkvVrkGR9hrbzg/oms4oOJxqi5M5n/5kLlK5je
CZpJ6a0M2PY/XNT7tmx+vg4SzKjYNchn3W+YspAZykON6COXWbv1TvFiG2G6lbM8
Y0B2spFykq9DzcRPcDLFp5A/5P362oTCR6umfBqgkSv+o8i2NDy/eQcET2iaR4pd
L0GxaWqysUmAYOTlEaPIuKFUtv+W9ERiXPqAJZHCSjyL2KC3f6Q=
=QBtd
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
