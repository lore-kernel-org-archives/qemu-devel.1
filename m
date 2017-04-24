Received: from eggs.gnu.org ([2001:4830:134:3::10]:33271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d2cR7-00044Z-6i
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 07:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d2cR3-0006Q0-69
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 07:45:45 -0400
Date: Mon, 24 Apr 2017 13:45:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170424114527.GE4739@noname.redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
	<382b0707-233d-ab05-e054-3da43617460d@redhat.com>
	<1877dc76-87e0-650c-d76a-44e6e7754a2b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <1877dc76-87e0-650c-d76a-44e6e7754a2b@redhat.com>
Subject: Re: [Qemu-devel] proposed qcow2 extension: cluster reservations
 [was: [RFC] Proposed qcow2 extension: subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.04.2017 um 19:56 hat Max Reitz geschrieben:
> On 21.04.2017 23:09, Eric Blake wrote:
> > And meanwhile, it looks like I have some patches to propose (and
> > qemu-iotests to write) if I can help fix the bugs I've pointed out.
>=20
> You mean these?
> https://github.com/XanClic/qemu/commits/random-qcow2-stuff-v1
>=20
> ;-)
>=20
> I'll send them once I've written tests.

You were quicker with writing the patches than I could reply that I
already started a patch to reuse preallocated zero clusters, but never
got around to finish it:

http://repo.or.cz/qemu/kevin.git/commitdiff/60b9f813bb258978455944b4ace1ab5=
d93b5e7d4

I seem to remember that it still had a problem (and probably also the
refcount > 0 bug that Eric mentioned), but maybe you can reuse at least
the test case from there.

Kevin

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY/eVXAAoJEH8JsnLIjy/WucMP/i7fwuIuR2bt/G+M41LSEPoo
cSVR4orSzgiFD/ErwmToKQexLw28EViL9heCxbAU1yAekZQvAa8IcKZt/h+JqfzE
WQaroFVbL5dw4rYZgfRu4A80cMUHGBXo/huBHS/gMp2v48InppKNpNLO+HEOtyIX
J+FQ/QGxiRxkzhwB9GJPbiwBRltHjr9hLsS/BF/zktVkj65Bj8w2p4agl3eRC494
bbKCRqrOj+75+0CQEzO2B3kj8PU2Vn+BrJSfuhLbaqy57OHC8P9/G9/12oVSxQua
qhsabyoD4RwKjMF4F3Un4TqUVAxKkoJZzVNRUoNuXtl2Rz26jhc/jF7GH+p8d7Lj
ZBpr17Bbxd2kbWTuEcEDWB/y8Gyk1UDso8GxJqAZpUAmcVNaCe5UOIe4wZUD/72s
HU+7AZrgRkGcDHzRMKFpSrwzrG1Z9JysKUcMSzSHHLz82igFC22YE+Oerqj/OXrp
2OfN0z7mtbPOyMm3Pfgu8Q7idxFfapRUNS3mlqXP/P746sDUp62G9jT75VbFTW0i
6Jvpgxu57DrFLCBqW2lnpvLFhh9wxLu7mOeyVg2AA5QydT/JBAOdT3B15pAuTKQc
uLZYTIhj57PQ5/Wkxa2Dnm3NNeZVFfdP5eNsHxN09WUHQsSYdzzrb1cgi6J/ZqWX
rbCjzK3d8lwdfOsb8nN1
=e6rR
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
