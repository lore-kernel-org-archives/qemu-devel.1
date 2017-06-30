Received: from eggs.gnu.org ([2001:4830:134:3::10]:58997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQwks-0001rW-9K
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQwkr-0005Hf-E9
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:18:42 -0400
References: <20170626123510.20134-1-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3eff550e-d1d9-4ec2-ca63-ec2ba7fe4936@redhat.com>
Date: Fri, 30 Jun 2017 16:18:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170626123510.20134-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dCwbOTuuD9K36hItVeuDArgSFHjuriOqD"
Subject: Re: [Qemu-devel] [PATCH v6 0/5] Improve I/O tests coverage of LUKS
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dCwbOTuuD9K36hItVeuDArgSFHjuriOqD
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Message-ID: <3eff550e-d1d9-4ec2-ca63-ec2ba7fe4936@redhat.com>
Subject: Re: [PATCH v6 0/5] Improve I/O tests coverage of LUKS driver
References: <20170626123510.20134-1-berrange@redhat.com>
In-Reply-To: <20170626123510.20134-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-26 14:35, Daniel P. Berrange wrote:
> The main goal of this series is to get the I/O tests passing
> 100% with LUKS when run with './check -luks'. It also adds a
> few more combinations to the LUKS/dmcrypt interoperability
> test.
>=20
> To make LUKS testing not quite as slow, we drop the PBKDF
> iteration count down to a very small value. This doesn't
> remove all overhead, as formatting the volume will always
> measure PBKDF timing over a 1 second interval.

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--dCwbOTuuD9K36hItVeuDArgSFHjuriOqD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVl24EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQAWP
CAC6C8Be8Tzh4TzxbQrEhnrF2xeyZykKn1ZZ73XYgeY4fLQKa3rhlJ05huDUFhWh
OD+r7Zb1ML2eP3DWZAJxkS3w9uczLLy9Vu8i+3rNwvM7SQ4TH2lUaZkTfeojm6Ki
e6TxwxPjxpg1EdWmyVUvX6Q3XPp5Jp+VD8tOj4BCBEVKkm8N6yv3z4Ai5TMYHEHs
2Fz049pzA64GXtUJINSlwXIxM4qNWE4W4BAJYvHRu0rkDqGJlX26h1Areom9Vt0L
yStlZNwl60D6lD9YAwWN/LSl+tFktKZrbSVcKpIfUZkwYSb1eFyaPXkMXnaFF7Iy
ZjtoQpHx/SvHD4pX0rHHhLHn
=Z+ZB
-----END PGP SIGNATURE-----

--dCwbOTuuD9K36hItVeuDArgSFHjuriOqD--
