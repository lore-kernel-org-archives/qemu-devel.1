Received: from eggs.gnu.org ([2001:4830:134:3::10]:58984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBq3h-0003vx-Ss
	for qemu-devel@nongnu.org; Fri, 19 May 2017 18:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBq3g-0005kA-UA
	for qemu-devel@nongnu.org; Fri, 19 May 2017 18:07:41 -0400
References: <20170508171302.17805-1-eblake@redhat.com>
	<2f66f2d1-ff51-8b41-8e7d-ef21297de97b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed7c0d92-94de-820f-bb80-000d8c6c9e6e@redhat.com>
Date: Fri, 19 May 2017 17:07:31 -0500
MIME-Version: 1.0
In-Reply-To: <2f66f2d1-ff51-8b41-8e7d-ef21297de97b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k7cF9qLPtKe4Kem9pTkkpjorGpa5NBAoW"
Subject: Re: [Qemu-devel] [PATCH] block: Tweak error message related to
 qemu-img convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k7cF9qLPtKe4Kem9pTkkpjorGpa5NBAoW
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <ed7c0d92-94de-820f-bb80-000d8c6c9e6e@redhat.com>
Subject: Re: [PATCH] block: Tweak error message related to qemu-img convert
References: <20170508171302.17805-1-eblake@redhat.com>
 <2f66f2d1-ff51-8b41-8e7d-ef21297de97b@redhat.com>
In-Reply-To: <2f66f2d1-ff51-8b41-8e7d-ef21297de97b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 08:30 AM, Max Reitz wrote:
> On 2017-05-08 19:13, Eric Blake wrote:
>> When converting a 1.1 image down to 0.10, qemu-iotests 060 forces
>> a contrived failure where allocating a cluster used to replace a
>> zero cluster reads unaligned data.  Since it is a zero cluster
>> rather than a data cluster being converted, changing the error
>> message to match our earlier change in 'qcow2: Make distinction
>> bewteen zero cluster types obvious' is worthwhile.

I really had problems with that commit message. If you want to re-stage,
you could s/bewteen/between/

>>
>> Suggested-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> There's one more instance of "Data cluster offset" in qcow2-cluster.c,=

>> but that one in handle_copied() is contained inside a
>> cluster_type =3D=3D QCOW2_CLUSTER_NORMAL conditional.
>>
>>  block/qcow2-cluster.c      | 3 ++-
>>  tests/qemu-iotests/060.out | 2 +-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> Assuming no objection means consent:

Okay by me.

>=20
> Thanks, fixed the commit title and applied to my block branch:
>=20
> https://github.com/XanClic/qemu/commits/block
>=20
> Max
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--k7cF9qLPtKe4Kem9pTkkpjorGpa5NBAoW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZH2yjAAoJEKeha0olJ0NqVZEIAJgYmjOHzF0vpNf+MFjTPVrd
JZf3F5bOpiD3hHUamXLNF4T6fYt+I1GHG4C/SltS1Hnv/gm+qJwcxcJBy6t8FoVZ
0EqlAGWUtVdgEXkQ+v7encK2HdH144uGSbfr1x08D+BSV5082a0XHq9p1ANB4U4V
gjqeJM7DltjJn0RUzYjTnHE+3PHIu2CKpLqEt8JzbtCVbXDLDp3eoVcuWsvLFB9R
/rYkH3apdHfFVMrfxd0aqX2cZlGfv74Ent26gY11TRgkr+xlW8IKk/ooju7Bqkq0
rSHrKYQOHERaINx/hlptGcb+qckmiN/dodc3uUUQbhIxXlzUFdrs6Jw3RyDcwoE=
=agGT
-----END PGP SIGNATURE-----

--k7cF9qLPtKe4Kem9pTkkpjorGpa5NBAoW--
