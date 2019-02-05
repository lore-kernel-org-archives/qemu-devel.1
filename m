Received: from eggs.gnu.org ([209.51.188.92]:55916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gr7WU-0006pB-Gt
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gr7WR-000171-Dt
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:40:48 -0500
References: <1549397675-189741-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1549397675-189741-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <453806a7-fc08-8b37-978f-31ea5ff639aa@redhat.com>
Date: Tue, 5 Feb 2019 14:40:24 -0600
MIME-Version: 1.0
In-Reply-To: <1549397675-189741-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AYIC6tlt3kdlHrbiAhfbnM988Qq8XkFZZ"
Subject: Re: [Qemu-devel] [PATCH v12 3/3] qcow2: list of bitmaps new test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AYIC6tlt3kdlHrbiAhfbnM988Qq8XkFZZ
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com,
 berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 John Snow <jsnow@redhat.com>
Message-ID: <453806a7-fc08-8b37-978f-31ea5ff639aa@redhat.com>
Subject: Re: [PATCH v12 3/3] qcow2: list of bitmaps new test 242
References: <1549397675-189741-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1549397675-189741-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1549397675-189741-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/5/19 2:14 PM, Andrey Shinkevich wrote:
> A new test file 242 added to the qemu-iotests set. It checks
> the format of qcow2 specific information for the new added
> section that lists details of bitmaps.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---

> +
> +disk =3D file_path('disk')
> +chunk =3D 256*1024
> +bitmap_flag_unknown =3D 1 << 2
> +flag_offset =3D 0x10002f
> +

Fragile if something else changes where this cluster gets allocated, but
hopefully such a change would be caught quickly by the iotest failure;
so I'm fine with it.

> +
> +Test 5
> +Write bitmap flag '0x4' into the QCOW2 image at offset 1048623
> +qemu-img: Could not open 'TEST_IMG': Bitmap 'bitmap-2' doesn't satisfy=
 the constraints
> +
> +Unset the unknown bitmap flag '0x4' in the bitmap directory entry:

Perhaps the error message could be made more informative, but that's
outside the scope of this patch. Thanks for adding that negative test;
it's harder to remember to be resilient to bad input, and having
testsuite coverage of intentionally bad files is a good thing.

Reviewed-by: Eric Blake <eblake@redhat.com>

I'll wait a couple days to see if any other reviewers speak up; at which
point, I'll be happy to queue this series through my NBD tree, if no one
else picks it up sooner (John may pick it up through his bitmaps tree).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--AYIC6tlt3kdlHrbiAhfbnM988Qq8XkFZZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxZ9LgACgkQp6FrSiUn
Q2os4gf/YpObD5I3Ot0kKXH+kQ2qh0KDnk44/an/1jKexXT5nvn4wVGETyVpokR5
GiK4Ip+hCVtx2WyubcGjwfhTILfUK2Hf5T3qgKfq/rUGNeU9k9j1FsS3k4CdwJnt
9001VQLZXxK+7BFXWeu/SIC2XczkuUs9qvr9XqiBbBNgwp56Xp4RnQ+FUPvyCZCg
DNidP8xOtiUAXxVyYXUou9/y/SRXB4flcGVPwERAPx9LGX2nsqOBMBRPXTO20S/7
corzHIk0pkrJj8AW1Uw0AMD2C80Sv2HJF114ku0IRgkdwifWQLMlXV39TaTwzZXJ
WJXMBqtDP7cUx5DrEKMB1p8Q/ZpOnQ==
=0eX+
-----END PGP SIGNATURE-----

--AYIC6tlt3kdlHrbiAhfbnM988Qq8XkFZZ--
