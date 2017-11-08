Received: from eggs.gnu.org ([2001:4830:134:3::10]:45902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCRNQ-0006to-14
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCRNK-0001ik-9e
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:30:48 -0500
References: <cover.1510143008.git.berto@igalia.com>
	<0b1b95340ecdfbc6927e36adf2fd42ae6198747a.1510143008.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c90f13d4-a6fe-02cb-b054-27f96f4b0b46@redhat.com>
Date: Wed, 8 Nov 2017 08:30:30 -0600
MIME-Version: 1.0
In-Reply-To: <0b1b95340ecdfbc6927e36adf2fd42ae6198747a.1510143008.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="juigUppbjFmjXWeaWHhhlLBQuvDd3DDPr"
Subject: Re: [Qemu-devel] [PATCH 1/1] qcow2: Check that corrupted images can
 be repaired in iotest 060
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--juigUppbjFmjXWeaWHhhlLBQuvDd3DDPr
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <c90f13d4-a6fe-02cb-b054-27f96f4b0b46@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] qcow2: Check that corrupted images can
 be repaired in iotest 060
References: <cover.1510143008.git.berto@igalia.com>
 <0b1b95340ecdfbc6927e36adf2fd42ae6198747a.1510143008.git.berto@igalia.com>
In-Reply-To: <0b1b95340ecdfbc6927e36adf2fd42ae6198747a.1510143008.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 06:13 AM, Alberto Garcia wrote:
> We just fixed a few bugs that caused QEMU to crash when trying to
> write to corrupted qcow2 images, and iotest 060 was expanded to test
> all those scenarios.
>=20
> In almost all cases the corrupted images can be repaired using
> qemu-img, so this patch verifies that.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/060     | 10 ++++++++
>  tests/qemu-iotests/060.out | 64 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 74 insertions(+)

Just in case it matters to patchew:
Based-on: <cover.1509718618.git.berto@igalia.com>

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--juigUppbjFmjXWeaWHhhlLBQuvDd3DDPr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloDFQYACgkQp6FrSiUn
Q2qeMQf/c2+hJItUS1tudvU/1v5CRPoNXdpkSZvDE7iRJiIIqW98czvvvYPNQFwy
/JG5EdKgoUqw1VDGsU8O82bdgVKn4sTjGuvhkTGUfrG0iMfZUqGDDIn/gGoW7pmG
5mL4Ojr/xWm28EBSZBOA4cWulcpX7mV/9x1wn7PbUs1CPZIhsjqY/uOYKzTSqYWx
PRIXz8LF6u51VMq/XO9KO/teI25JJ2DogquEHT4IIh/Jxb6pmZCKU0TWqyzbJjKx
a2hQnIa8MQsb/EhrPlIR64z0CLqxQhw8DWjZIkf+aAm0VwDwkcoW0YHI8xKQFTc5
EdoMq5b7M86QegNyHmNu36Mx1PJ7qw==
=8BLK
-----END PGP SIGNATURE-----

--juigUppbjFmjXWeaWHhhlLBQuvDd3DDPr--
