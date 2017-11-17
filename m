Received: from eggs.gnu.org ([2001:4830:134:3::10]:36270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFm1q-0000ZV-PP
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFm1p-0006SM-KZ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:10:18 -0500
References: <20171117190422.23626-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f4f6793-c3fc-6711-39af-971964adb37c@redhat.com>
Date: Fri, 17 Nov 2017 13:10:10 -0600
MIME-Version: 1.0
In-Reply-To: <20171117190422.23626-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Oj5XAJmhfBBp5m3WSAXoMG4VsxRI93xSN"
Subject: Re: [Qemu-devel] [PATCH for-2.11] iotests: Fix 176 on 32-bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Oj5XAJmhfBBp5m3WSAXoMG4VsxRI93xSN
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <6f4f6793-c3fc-6711-39af-971964adb37c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] iotests: Fix 176 on 32-bit host
References: <20171117190422.23626-1-eblake@redhat.com>
In-Reply-To: <20171117190422.23626-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2017 01:04 PM, Eric Blake wrote:
> The contents of a qcow2 bitmap are rounded up to a size that
> matches the number of bits available for the granularity, but
> that granularity differs for 32-bit hosts (our default 64k
> cluster allows for 2M bitmap coverage per 'long') and 64-bit
> hosts (4M bitmap per 'long').  If the image is a multiple of
> 2M but not 4M, then the number of bytes occupied by the array
> of longs in memory differs between architecture, thus
> resulting in different SHA256 hashes.
>=20
> Furthermore (but untested by me), if our computation of the
> SHA256 hash is at all endian-dependent because of how we store
> data in memory, that's another variable we'd have to account
> for (ideally, we specified the bitmap stored in qcow2 as
> fixed-endian on disk, because the same qcow2 file must be
> usable across any architecture; but that says nothing about
> how we represent things in memory).  But we already have test
> 165 to validate that bitmaps are stored correctly on disk,
> while this test is merely testing that the bitmap exists.
>=20
> So for this test, the easiest solution is to filter out the
> actual hash value.  Broken in commit 4096974e.

Of course, if Kevin sends a v2 pull, it's probably better to just squash
this in to my original testsuite change (since a v2 would probably
invalidate that commit id).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Oj5XAJmhfBBp5m3WSAXoMG4VsxRI93xSN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloPNBIACgkQp6FrSiUn
Q2qfuQf5AaiNGkzdjyWIPOg83+Z+VihGJQFK1aDDP4mwFbou4XWTPF5do51JutsQ
7B9B7zh9zgDhW4Okx/A7I7AbvLLwHiqedLAaw9i+O9ysOFfkAzVrWVvQNcIoufvx
/Rx1QO/VKGiDNTHVFw4AsxHxDfq/J4jSqkphzQfbDEp+Vni7ve/K0clw9BzAlaBx
7C9+mKkoMqQQ1D1Yyw9sNoYzBNy6wt8mLYXgpCviLsUxS74VsUAsWvsN/W2544c+
SbSesqJEXX4O5/hewJA+n1Hj2TvOF3eY0yYFaN40Wwrrmdju9IdQcomtfJ+rUQ++
k7oLFFWNwbzv1bXsS9jfETab8ijOUA==
=SsnJ
-----END PGP SIGNATURE-----

--Oj5XAJmhfBBp5m3WSAXoMG4VsxRI93xSN--
