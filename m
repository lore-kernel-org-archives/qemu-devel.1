Received: from eggs.gnu.org ([2001:4830:134:3::10]:50252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGt6S-0003un-No
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGt6R-0000j1-NN
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:55:40 -0500
References: <20171117190422.23626-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0ec6d36c-c576-f184-19da-7ddf8ff1f11e@redhat.com>
Date: Mon, 20 Nov 2017 21:55:29 +0100
MIME-Version: 1.0
In-Reply-To: <20171117190422.23626-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p915dOmXA7takNLkBwgpFHmRvSNQ14HiJ"
Subject: Re: [Qemu-devel] [PATCH for-2.11] iotests: Fix 176 on 32-bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p915dOmXA7takNLkBwgpFHmRvSNQ14HiJ
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <0ec6d36c-c576-f184-19da-7ddf8ff1f11e@redhat.com>
Subject: Re: [PATCH for-2.11] iotests: Fix 176 on 32-bit host
References: <20171117190422.23626-1-eblake@redhat.com>
In-Reply-To: <20171117190422.23626-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-17 20:04, Eric Blake wrote:
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
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/176     | 3 ++-
>  tests/qemu-iotests/176.out | 8 ++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)

Now that I've failed to keep my tree empty anyway:

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

(No offense taken if **someone** *cough* *cough* were to take it from me)=


Max


--p915dOmXA7takNLkBwgpFHmRvSNQ14HiJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloTQUESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AaQoIAKFj6wU8aLColwl7OyBHK3m12eHxPCwu
x3KQKPK2j/jXglRfWF29qvU1p6gMfugX3XI20sLbx3gAM23K33HPRVTzy6/MOihK
pwr6/QNRVDpXWixMlBTHnpATCT9i3hkOZPRaB78ESyhBHbUF1iktEgZp7RbiYIoG
6pOh86D8nJ46LaRCf6gMuJ62d/MZxNdpNk07VtloUJN2h2nV4vfq5sCXl/8lzEm/
penPn9OGcfXiFpsAUJdPWdzoB51qzl4uXok1AFjnsTPPyGLn43QOT+wGm25Xaq09
coBpADL9J7Z5bSRcZEpH2JIYvgF+YgqzkByX4VA0V1Fe5ZtP4H4l3Aw=
=LdnJ
-----END PGP SIGNATURE-----

--p915dOmXA7takNLkBwgpFHmRvSNQ14HiJ--
