Received: from eggs.gnu.org ([2001:4830:134:3::10]:45569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f8o2r-0005ek-5x
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f8o2q-000332-BY
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:26:49 -0400
Date: Wed, 18 Apr 2018 16:26:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180418142633.GG4971@localhost.localdomain>
References: <20180405170619.20480-1-kwolf@redhat.com>
	<99b844f2-7784-225a-37c4-77dad444fbd6@redhat.com>
	<20180418135009.GF4971@localhost.localdomain>
	<2769edf8-0bf6-5163-d86d-f721c1af86bd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <2769edf8-0bf6-5163-d86d-f721c1af86bd@redhat.com>
Subject: Re: [Qemu-devel] [RFC][BROKEN] rbd: Allow configuration of
 authentication scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jdurgin@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 18.04.2018 um 16:16 hat Eric Blake geschrieben:
> On 04/18/2018 08:50 AM, Kevin Wolf wrote:
>=20
> >>> @@ -3195,6 +3215,8 @@
> >>>              '*conf': 'str',
> >>>              '*snapshot': 'str',
> >>>              '*user': 'str',
> >>> +            '*auth-none': 'bool',
> >>> +            '*auth-cephx': 'RbdAuthCephx',
> >>>              '*server': ['InetSocketAddressBase'] } }
> >>
> >> Would it be better to have this be a flat union with 'auth' with enum
> >> values 'none', 'cephx', 'both' as a discriminator that determines which
> >> additional fields can be present?  Or does that require that we first
> >> fix the QAPI generator to allow nesting a flat union within another fl=
at
> >> union (probably doable, just no one has needed it before now)?  Is it
> >> also time to improve the QAPI generator to allow a default value to the
> >> discriminator field, rather than requiring the field to be present?
> >=20
> > Both options can be enabled at the same time, so that the client
> > connects to a server no matter whether it does 'cephx' authentication or
> > only 'none. This is even the default for rbd driver (in the existing
> > command line interface, but I think we need to stay compatible with it).
> > With a union you would have to explicitly choose one or the other, but
> > could never accept both.
> >=20
> > The other option we were considering was a list of authentication
> > options, which would be easier to implement, but isn't really an
> > accurate representation of what we really accept. There is no way we
> > could meaningfully implement something like this:
> >=20
> >     'auth': [ { 'type': 'cephx', 'key-secret': 'foo' },
> >               { 'type': 'cephx', 'key-secret': 'bar' } ]
> >=20
> > Because Ceph only allows us to enable the 'cephx' authentication method
> > and to set a single key for it.
>=20
> How does it look as a choice between:
>=20
> {'enum':'CephxAuth', 'data': ['none', 'cephx', 'both' ]}
>=20
> where both 'cephx' and 'both' support the optional 'key-secret'
> parameter, but 'none' does not?

Doesn't really look extensible for the case that Ceph adds a third mode.
At least I don't think we want to have an enum and associated union
branches for all possible combinations?

Kevin

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa11WZAAoJEH8JsnLIjy/W2gIQAMB2+y93zbibi6Z6fb3Wz6p8
vbYXbl8vXUgx0ztyhCTiR9hTy9TymjA8BFVg1lhyT7VCs+WVyNvwGfEMROGGkqga
d30JFa2tiFrM1Wnzkzu0bEI6iNE5pZ3fLg5ICLpAiWRUKPRPZRvMEbLxjh3bsIgt
pFW5oIcu1DIb//QR0lj5c5Nra7GMypQhwoRex+R5w1XOC58gWrfH27MEkTi6Ik7A
sbShlwV53EbpxAIrT5oqbdlnkrGBORNROmmbGCf3gOSD51KDRVIwcjHjc/0yscHy
3sKLtUKqU0L8zJ+0t0g794yHwVDyTZr45n0UkEhbO82NiYoMfn++egZ58tQPsj0y
U5TrEm13G4vKTBMFa/5SOUPDEXZwFiBBdin9XbeeYoizD4kRb/LYqaz3eruMJs6W
lbO5DUNux/F0k4vUlodaE8CecCB3BVog5MZOMB+AEoiOIz26W+d+XXepZbY8vSra
XQroGfmk65IXslwdXBVr2PxlSjrCUDL7+36mRRyWprAEdI3a+A2tFXW3MvoCTCr6
a46ah/WSr87/FlP4RdhUskop1ucrP6YZbzCMkw/NSWMwlznoWNO2Reelil7AXrzb
kJ2RN28+V52YwHVTVSLun/RTCrY/8eNaUcc2wTxoDN7mW2DyQDZd2rGccNEiJMyt
pPRPSi06mtSnsgMoKlth
=a1Y7
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
