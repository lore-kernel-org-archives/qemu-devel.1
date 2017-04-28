Received: from eggs.gnu.org ([2001:4830:134:3::10]:50676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4E3p-0008B2-PN
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 18:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4E3o-0002c6-QM
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 18:08:21 -0400
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
	<1493411622-5343-15-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <972a9484-fa2e-620f-35b3-de3919b587d4@redhat.com>
Date: Fri, 28 Apr 2017 17:08:15 -0500
MIME-Version: 1.0
In-Reply-To: <1493411622-5343-15-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TLDjXi5ooCgPLlmvjob7RnnjEJr79sF7D"
Subject: Re: [Qemu-devel] [PULL 14/34] iotests: Launch qemu-nbd with -e 42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TLDjXi5ooCgPLlmvjob7RnnjEJr79sF7D
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <972a9484-fa2e-620f-35b3-de3919b587d4@redhat.com>
Subject: Re: [Qemu-devel] [PULL 14/34] iotests: Launch qemu-nbd with -e 42
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
 <1493411622-5343-15-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-15-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 03:33 PM, Kevin Wolf wrote:
> From: Max Reitz <mreitz@redhat.com>
>=20
> There is no reason for the qemu-nbd server used for tests not to accept=

> an arbitrary number of clients. In fact, test 181 will require it to
> accept two clients at the same time (and thus it fails before this
> patch).

Quick question:

Is this mention of test 181 the same test that occurs earlier in the
pull request as 8/34?  If so, should the series have been reordered for
bisectability?  If not, should the commit message be touched up?

At any rate, bisectability of qemu-iotests is less of a concern than
bisectability of 'make check' success, so I don't think your answer
invalidates the pull request.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TLDjXi5ooCgPLlmvjob7RnnjEJr79sF7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA71PAAoJEKeha0olJ0NqdrIH/22BnvMhnilQqBGC0d6PB2Ed
6kTH7fHo2onzAwPkWsnne8AWC6PN+6lBVRBl4sVMqdUzAFuLMIRCYChiPZJDmGKP
iX3uiXRCtbl0EgXDD+93HhWwMDyUE0mfMP4BJsSguMHr1km7tN8s+aTpsnLg9qUk
RJq7Hh3/HNTRRg1xfuOWg3IDNH5DykY4LFi5nOfsCuuXTjsK50WuQCLVUjabSc2r
rnv9JggkKUr7HUuqaKdzgEUEPvBGxjHhwCSE03s7ygT1BUhx22QzMUkPzxDp+efp
KsFP4+ZBcSVyIplBPsg/6R1tZIK6ea9/ZeHzdr40LoQUgMo9nUjHIJN7HyRhfvA=
=nNZr
-----END PGP SIGNATURE-----

--TLDjXi5ooCgPLlmvjob7RnnjEJr79sF7D--
