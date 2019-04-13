Received: from eggs.gnu.org ([209.51.188.92]:47268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFKtC-0006v1-9Q
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFKtB-0005hm-8q
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:48:22 -0400
References: <cover.1554992449.git.berto@igalia.com>
	<6c17d784-c5e4-9a3c-c38c-19940352ea35@redhat.com>
	<w51zhoufg2l.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b30d2279-2311-5b3e-6108-e93577bc7255@redhat.com>
Date: Sat, 13 Apr 2019 17:48:11 +0200
MIME-Version: 1.0
In-Reply-To: <w51zhoufg2l.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o7fqvdit2YWUlq6Eg3L9XZTGZ5Ov4573U"
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] Fix check for default backing
 files in bdrv_reopen_prepare()
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
--o7fqvdit2YWUlq6Eg3L9XZTGZ5Ov4573U
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b30d2279-2311-5b3e-6108-e93577bc7255@redhat.com>
Subject: Re: [PATCH for-4.1 0/2] Fix check for default backing files in
 bdrv_reopen_prepare()
References: <cover.1554992449.git.berto@igalia.com>
 <6c17d784-c5e4-9a3c-c38c-19940352ea35@redhat.com>
 <w51zhoufg2l.fsf@maestria.local.igalia.com>
In-Reply-To: <w51zhoufg2l.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.04.19 10:46, Alberto Garcia wrote:
> On Sat 13 Apr 2019 02:56:57 AM CEST, Max Reitz wrote:
>>> Patch 2 fixes a different (but slightly related) issue that I found
>>> while preparing the first patch.
>>
>> I think the real problem is that bs->backing_file is not a cache for
>> bs->backing->bs->filename.
>>
>> In fact, every user of bs->backing_file expects it to be something
>> different.  Some expect it to be a cache for
>> bs->backing->bs->filename, some expect it to be what the image header
>> says (i.e., it if=E2=80=99s a relative path, it=E2=80=99s relative to =
the overlay),
>> some expect it to be what the image header says, but relative paths to=

>> be translated so they are relative to qemu=E2=80=99s CWD.
>>
>> All of this should be cleaned up and this is what patch 7 in my "block=
:
>> Deal with filters" series does:
>>
>> http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00308.html
>=20
> Ok, you can leave out the second patch then. The first one should still=

> be correct, right?

I just think it=E2=80=99s unnecessary because as of my series both backin=
g_file
and auto_backing_file serve the purpose.

Max


--o7fqvdit2YWUlq6Eg3L9XZTGZ5Ov4573U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyyBLwACgkQ9AfbAGHV
z0ACpAgAq1frsGLAm8X0VtxkMGnpJoZi3ZNIOVShcNj40bvOmn8nkUEtdcDiJMDp
AQYC3ieabrBsyKArdXfdCIbe40HwY7dQlVt/BKm03qxRd7EJribKyNTZQtjdB6c1
HGU0AutN2nOcr9pOszCNXG6ZOoSqe2xRsOjfRFCxZUfqX0qWij49WeVNMYybZaBI
pypZYZSgQbMxzuCzeGkJh24fDb9JfOsvNPLFSLWu/L2hOyBOs6Eu6vUZwL15i9rd
c98RgfTozWkbnQmNeJptEGbh/4lAwqmS+Uq/WCNP2Gskq3VxZGrOAeMIH7+mfHzh
ovuZFVeytGLEau0yQg9yQofRfxGcjA==
=MnpV
-----END PGP SIGNATURE-----

--o7fqvdit2YWUlq6Eg3L9XZTGZ5Ov4573U--
