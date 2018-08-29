Received: from eggs.gnu.org ([2001:4830:134:3::10]:38149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fv05h-0002V5-JH
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fv05b-0002f2-RY
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:00:57 -0400
From: Max Reitz <mreitz@redhat.com>
References: <cover.1535291602.git.berto@igalia.com>
	<d470d52cfc97265fec584e6b7d4b5a89c37a1739.1535291602.git.berto@igalia.com>
	<c9cb16fe-8e23-50c4-67c0-3c5952163099@redhat.com>
	<w51r2ih2w5m.fsf@maestria.local.igalia.com>
	<c147ca8a-da5e-bb8d-86ab-b9c34acddcf3@redhat.com>
Message-ID: <13e7e1ce-a150-99f7-ae5e-9c8ed330d204@redhat.com>
Date: Wed, 29 Aug 2018 15:00:44 +0200
MIME-Version: 1.0
In-Reply-To: <c147ca8a-da5e-bb8d-86ab-b9c34acddcf3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6vMixF2qpo4EukwwJ3PJxQZjc5DK1oJ4p"
Subject: Re: [Qemu-devel] [PATCH 5/9] block: Allow child references on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6vMixF2qpo4EukwwJ3PJxQZjc5DK1oJ4p
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <13e7e1ce-a150-99f7-ae5e-9c8ed330d204@redhat.com>
Subject: Re: [PATCH 5/9] block: Allow child references on reopen
References: <cover.1535291602.git.berto@igalia.com>
 <d470d52cfc97265fec584e6b7d4b5a89c37a1739.1535291602.git.berto@igalia.com>
 <c9cb16fe-8e23-50c4-67c0-3c5952163099@redhat.com>
 <w51r2ih2w5m.fsf@maestria.local.igalia.com>
 <c147ca8a-da5e-bb8d-86ab-b9c34acddcf3@redhat.com>
In-Reply-To: <c147ca8a-da5e-bb8d-86ab-b9c34acddcf3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-29 14:59, Max Reitz wrote:
> On 2018-08-29 14:29, Alberto Garcia wrote:
>> On Wed 29 Aug 2018 01:26:46 PM CEST, Max Reitz wrote:

[...]

>>> So why isn't it mandatory to re-specify all children for now?
>>
>> It is
> Is it?  Why does
>=20
> $ qemu-io -c 'reopen -o lazy-refcounts=3Don' foo.qcow2
>=20
> work, then?  Shouldn't I have to specify @file?

I suppose the answer is "because that's the old command".  Which is good
enough.

Max


--6vMixF2qpo4EukwwJ3PJxQZjc5DK1oJ4p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGmP0ACgkQ9AfbAGHV
z0C/zwf/XgNd+DF4mJHocwOITjCpu21DFG6IGjj1FEcVlfrdl2v9F1TMZqIEOBFO
yWaSpeedMKt/uQYeAlV5jsLYJvwBrcfBeHap+V+COxMvg+G7NmMolw5EBIkV1T0t
krnuITBOLGyVHBiXUO1OAJB4uHSaYEosGztepqyl79LIyyhJV7dMnewrxZjuAxns
PAN1cgQ4czuFmM4sahAqIEGBO9wX7ZRP4h/RTskzjNGSA1CH7EBd8rZhaZU55JI0
eqV3ieBr7pharJMkbu0bM6m6kJ1P5yUGwF6qgt3g2tnCVE/dGFOFpijSQzP/3wt8
KFocbP881LGYyY+5k8RNodZeh1VDMw==
=+re0
-----END PGP SIGNATURE-----

--6vMixF2qpo4EukwwJ3PJxQZjc5DK1oJ4p--
