Received: from eggs.gnu.org ([2001:4830:134:3::10]:33105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5YyB-00048u-Hd
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5YyA-0004fb-E1
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:12:19 -0400
References: <20171012034720.11947-1-eblake@redhat.com>
	<20171012034720.11947-8-eblake@redhat.com>
	<20171020143124.GB3667@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <009ec057-2324-4614-6185-623edd22f559@redhat.com>
Date: Fri, 20 Oct 2017 10:12:03 -0500
MIME-Version: 1.0
In-Reply-To: <20171020143124.GB3667@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FIVjP8hsMMQ9KROHxX1tSPgGFpR2aB6h3"
Subject: Re: [Qemu-devel] [PATCH v6 07/24] block: Convert
 bdrv_get_block_status() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FIVjP8hsMMQ9KROHxX1tSPgGFpR2aB6h3
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com,
 jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <009ec057-2324-4614-6185-623edd22f559@redhat.com>
Subject: Re: [PATCH v6 07/24] block: Convert bdrv_get_block_status() to bytes
References: <20171012034720.11947-1-eblake@redhat.com>
 <20171012034720.11947-8-eblake@redhat.com>
 <20171020143124.GB3667@localhost.localdomain>
In-Reply-To: <20171020143124.GB3667@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 09:31 AM, Kevin Wolf wrote:
> Am 12.10.2017 um 05:47 hat Eric Blake geschrieben:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  In the common case, allocation is unlikely to ever use
>> values that are not naturally sector-aligned, but it is possible
>> that byte-based values will let us be more precise about allocation
>> at the end of an unaligned file that can do byte-based access.
>>

>>   *
>> - * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MA=
SK)
>> - * represent the offset in the returned BDS that is allocated for the=

>> - * corresponding raw data; however, whether that offset actually cont=
ains
>> - * data also depends on BDRV_BLOCK_DATA and BDRV_BLOCK_ZERO, as follo=
ws:
>> + * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MA=
SK) of
>> + * the return value (old interface) or the entire map parameter (new
>> + * interface) represent the offset in the returned BDS that is alloca=
ted for
>> + * the corresponding raw data.
>=20
> Are there any functions using the old interface left at the end of the
> series or do we want a final patch that removes the old interface from
> the description?

Done here, in series 4, where we get rid of the old interface in the
drivers:
https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg02941.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FIVjP8hsMMQ9KROHxX1tSPgGFpR2aB6h3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqEkMACgkQp6FrSiUn
Q2qktgf8CwABOrLLdD0txrIKDq3Fr1CenNXvrBz53unEElOxYNItjJmuGE4nFGzV
3yNbDpyKofqJ0mzSN+0mbBUzpixu5u+ucjco3FbCvo3uMsBg+cd7/l1DCdHey+Pk
eXEJEKzmRR4P67i4XvxKizmjLJkvjmOl4mFA0gG9UmlUYTwiHC8WSEEMgq+glw1R
cmUuybi38JlRT7Qk9coYNA5oIsbZXO84w8ZF089tGAheY+o1RpIAd3pu7AQcxNy8
5dO5yunZzp+amv/PViR08K8VIbEjKhhxXP11Yw8hnARXepiTyBd6Y0YbV0YI8nbf
b+m6WNTt4x5LnYqVfZNBcRWYnFw7uQ==
=z+KQ
-----END PGP SIGNATURE-----

--FIVjP8hsMMQ9KROHxX1tSPgGFpR2aB6h3--
