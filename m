Received: from eggs.gnu.org ([2001:4830:134:3::10]:46461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQlG6-0004n7-6j
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQlG5-0003e9-7Y
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:02:10 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-7-vsementsov@virtuozzo.com>
	<7089b5b7-3346-2144-eff9-64e1e77e6bd2@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4612abfc-40b0-ce2a-f953-0b5a4e6c99c0@redhat.com>
Date: Thu, 29 Jun 2017 21:01:54 -0500
MIME-Version: 1.0
In-Reply-To: <7089b5b7-3346-2144-eff9-64e1e77e6bd2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u5G5qp7uNTM0b1FQdr9WnM02k3kU36t8w"
Subject: Re: [Qemu-devel] [PATCH v22 06/30] block/dirty-bitmap: add
 deserialize_ones func
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u5G5qp7uNTM0b1FQdr9WnM02k3kU36t8w
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, jsnow@redhat.com
Message-ID: <4612abfc-40b0-ce2a-f953-0b5a4e6c99c0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v22 06/30] block/dirty-bitmap: add
 deserialize_ones func
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
 <20170628120530.31251-7-vsementsov@virtuozzo.com>
 <7089b5b7-3346-2144-eff9-64e1e77e6bd2@redhat.com>
In-Reply-To: <7089b5b7-3346-2144-eff9-64e1e77e6bd2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 08:55 PM, Eric Blake wrote:
> On 06/28/2017 07:05 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Add bdrv_dirty_bitmap_deserialize_ones() function, which is needed for=

>> qcow2 bitmap loading, to handle unallocated bitmap parts, marked as
>> all-ones.
>>

>> + * hbitmap_deserialize_ones
>> + * @hb: HBitmap to operate on.
>> + * @start: First bit to restore.
>> + * @count: Number of bits to restore.
>=20
> This part is accurate (the dirty-bitmap is using an underlying bitmap
> with "one bit per sector" before my series, afterwards it will be "one
> bit per byte", remembering that hbitmap really stores only one bit per
> granularity multiple of the underlying unit), if incomplete (the code
> asserts that things are aligned, but doesn't document that the caller
> must pass in aligned values); but again, that's matching the
> pre-existing deserialize_zeroes code.

Okay, I looked again; the documentation for
hbitmap_serialization_granularity() has a blanket statement that all
other hbitmap_serialization_* functions taking a start and count must be
aligned. Indirect, but at least documented, so I retract my statement
about the docs being incomplete.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--u5G5qp7uNTM0b1FQdr9WnM02k3kU36t8w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVbESAAoJEKeha0olJ0NqRScH/iHidcfbnN17/MKdHUO2gUaY
/6Z5qnztystauKXOHDe/pKO7EUIEV3wLhgr+nrqKgexP0P2bXFQXbGBS3oRAO1vC
EiT9LSWc496KzpvDXiWhRnj0ZtMn+7oNiZhBrtKxTDkxjSR7a6iTFhJ+MPFJ67oJ
DFVzYBIA0bN9AcW6KL4SjMHSbLuxPMGMpF7YIdERPje6Cx+CHjIaaX6kma4IycW/
wixeI6W+Qg4vh8ScX16PF3Yj7pypVXAd/8HYiduPz5k+5yjfDdHRnNMbyvZgySmA
BtrCzvZ5lWA7nAl6yNO3FbVZCr5eiPbchFw0jDET92kvX3wFeuXJlVZPOK4JNLo=
=hZtN
-----END PGP SIGNATURE-----

--u5G5qp7uNTM0b1FQdr9WnM02k3kU36t8w--
