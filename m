Received: from eggs.gnu.org ([2001:4830:134:3::10]:51253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYbUq-00028l-R2
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYbUq-0005m5-5m
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:41:32 -0500
References: <cover.1485878688.git.berto@igalia.com>
	<79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
	<f9e9efcc-2a59-db47-a048-763eed52d92f@redhat.com>
	<w51efzjnq49.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b64ed84b-ecb9-ad76-28d5-7b5d2d235f7d@redhat.com>
Date: Tue, 31 Jan 2017 10:41:23 -0600
MIME-Version: 1.0
In-Reply-To: <w51efzjnq49.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7Mc12Tbq1qj4E8jNWBaoeTKidU289DPse"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-io: don't allow I/O operations
 larger than INT_MAX
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
--7Mc12Tbq1qj4E8jNWBaoeTKidU289DPse
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <b64ed84b-ecb9-ad76-28d5-7b5d2d235f7d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-io: don't allow I/O operations
 larger than INT_MAX
References: <cover.1485878688.git.berto@igalia.com>
 <79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
 <f9e9efcc-2a59-db47-a048-763eed52d92f@redhat.com>
 <w51efzjnq49.fsf@maestria.local.igalia.com>
In-Reply-To: <w51efzjnq49.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 10:36 AM, Alberto Garcia wrote:
> On Tue 31 Jan 2017 05:31:32 PM CET, Eric Blake wrote:
>=20
>> Ideally, it would be nice to fix the block layer to allow larger
>> requests (since we already have code to auto-fragment down to device
>> limits, we should be able to rely on that code instead of having to
>> duplicate artificial constraints everywhere else in the tree).  But
>> that's a bigger task, and this is a good patch in the interim.
>=20
> Related question: what's the largest request than a guest can
> theoretically submit?

off_t supports up to 2^63 (not 2^64, because it is a signed type).
Ideally, we should be constrained only by the disk size (as no one
actually has 2^63 bytes of storage available), by using uint64_t offset
AND length in all our APIs; but right now, we still have a lot of 32-bit
length issues, and often signed length limiting us to 2^31 depending on
the API.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7Mc12Tbq1qj4E8jNWBaoeTKidU289DPse
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkL4zAAoJEKeha0olJ0NqRTUH/0D15lqYY82mHiUSjovsQJFT
VB1vMn2KP3SvUebxU3+t6+se9Zm2KBzXNv6vGaXuuSPuAdjpEvoKT0e4qGUpaYK/
fBTU7dUntMtCBhm3CgslANhJfHjs3T1xl1bsbiyrMmpzUB9YzqTGbNbMJ2gBXhoe
rhdJ+5Gin0ECGwLIfrWiOd2gEcOynrfCQwgnmEKEMGWXKw5XBmeKxwiMQ6Rh0fou
a5mIla39alwuMkaf4wT0R1hXDnbAwpn3lGmy+sUUhFjxLhiUKcm57YZSFL8h/+9t
+hs4eDZ5bdWs/fkAP7nDKSmbwXrPK+8yrN0lmlX/ae0Wg6RY1D7Dda5RUb+bNHQ=
=UsEC
-----END PGP SIGNATURE-----

--7Mc12Tbq1qj4E8jNWBaoeTKidU289DPse--
