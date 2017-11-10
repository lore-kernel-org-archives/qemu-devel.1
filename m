Received: from eggs.gnu.org ([2001:4830:134:3::10]:52657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eDDPF-0008Cj-QR
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eDDPF-0002vn-7M
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:47:53 -0500
Date: Fri, 10 Nov 2017 18:47:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171110174742.GI5466@localhost.localdomain>
References: <20171004152553.30263-1-mreitz@redhat.com>
	<87zi7u4hob.fsf@dusky.pond.sub.org>
	<f051da3e-9181-0e72-b9eb-4e9c2d61e971@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <f051da3e-9181-0e72-b9eb-4e9c2d61e971@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/6] block: Don't compare strings in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.11.2017 um 18:36 hat Max Reitz geschrieben:
> On 2017-11-10 10:16, Markus Armbruster wrote:
> > Max Reitz <mreitz@redhat.com> writes:
> >=20
> >> bdrv_reopen_prepare() assumes that all BDS options are strings, which =
is
> >> not necessarily correct. This series introduces a new qobject_is_equal=
()
> >> function which can be used to test whether any options have changed,
> >> independently of their type.
> >=20
> > Series looks ready to me.  It touches QAPI to achieve its purpose in the
> > block layer; I'd be fine with merging it via a block tree.
>=20
> Thanks!  So now it's my problem to figure out whether this is 2.11
> material...? :-)

The test case in patch 5 segfaults without the series. Why would it not
be a bug fix (=3D 2.11 material)?

Kevin

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaBeY+AAoJEH8JsnLIjy/WyfEQAK3KaXz0pSsknVakl/f2prG+
ljxPOOEktuhUHGrFvmSsfDL53PEYrUb0CbJuDG8owVHJE8B7VCwk3ipZPuLPfAtZ
GhqwMqZCgp9vA4Th0RQeqEqtE6iAaYL7VZ4GZmQ+fCbK/jLWJtLBi+nijCwgVex+
fBXK1UQK/vvyFvO5Km927Lq4KXWIrkUv7hBKKU2rzuRTO0If7a6WW+I+UO0FFs/5
AD9+31MesfI0pAUG3mHzzGsndyFRkfzylAXsGDUHEIbyn3e+KYPHmndx2fIEbac0
O494zsrflCJAIL8nfI+Io8DhFXmREuCzcL72hhVD/xASeNhJSfuYr57xa9e8z7L/
B9aumNyHpe5lOKaKJjUGgAY5DodMKKC2ql2vFP0o0C1avjZlZx4lglaU3Ftz++1f
DPBCvbkyKFs8TdxoSw+dzZljtdPGLoPrmKeLNIN3V1CtrsJpTgmEIxrYj5Urn0Yy
tttmHj7zrVbrr+3kF49v9SNhCC6nDyxxo1kV53yxt7E9wl36XPVN2MXQiEPzCpfn
pNSCyVsjpBn8Ar7IHV/BLEnGe4tF+SAKs/mJmV1lyaAoCpcFFfIgZ4el0bLTK2d2
5xnaMZig5FSXYq/qLWAJGI43OfYmrRKU/zg9Gqg0vXgVghzJt3Fyqcf5sUSYYWRO
za6qnk0ui/Yz0TatsqjL
=3ezL
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
