Received: from eggs.gnu.org ([2001:4830:134:3::10]:60389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxxPe-000894-Cc
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxxPZ-0006RN-Ix
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:08:58 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
	<w5137dfyq1f.fsf@maestria.local.igalia.com>
	<20170411144921.GN4516@noname.str.redhat.com>
	<b5fb4bc7-d07b-6b7a-4fd5-d17c6e380ce7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1bbcc4ba-e889-2242-cb44-c933eedfb212@redhat.com>
Date: Tue, 11 Apr 2017 10:08:28 -0500
MIME-Version: 1.0
In-Reply-To: <b5fb4bc7-d07b-6b7a-4fd5-d17c6e380ce7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5Hl1WHsPvsOUHkLCkcdbFiVdputLgF5Fi"
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Hl1WHsPvsOUHkLCkcdbFiVdputLgF5Fi
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <1bbcc4ba-e889-2242-cb44-c933eedfb212@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
 <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
 <w5160ibyufr.fsf@maestria.local.igalia.com>
 <9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
 <w5137dfyq1f.fsf@maestria.local.igalia.com>
 <20170411144921.GN4516@noname.str.redhat.com>
 <b5fb4bc7-d07b-6b7a-4fd5-d17c6e380ce7@redhat.com>
In-Reply-To: <b5fb4bc7-d07b-6b7a-4fd5-d17c6e380ce7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2017 09:59 AM, Max Reitz wrote:

>=20
> Good point, but that also means that (with (2)) you can only use
> subcluster configurations where the L2 entry size increases by a power
> of two. Unfortunately, only one of those configurations itself is a
> power of two, and that is 32.
>=20
> (With 32 subclusters, you take up 64 bits, which means an L2 entry will=

> take 128 bits; with any higher 2^n, you'd take up 2^{n+1} bits and the
> L2 entry would take 2^{n+1} + 64 which is impossible to be a power of t=
wo.)

Or we add padding. If you want 64 subclusters, you burn 256 bits per
entry, even though only 192 of those bits are used.

>=20
> I don't know how useful non-power-of-two subcluster configurations are.=

> Probably not at all.
>=20
> Since using subcluster would always result in the L2 table taking more
> than 512 bytes, you could therefore never guarantee that there is no
> entry overlapping a sector border (except with 32 subclusters).

Yes, there's definite benefits to keeping whatever structure we end up
with aligned so that it naturally falls into sector boundaries, even if
it means more padding bits.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5Hl1WHsPvsOUHkLCkcdbFiVdputLgF5Fi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7PFsAAoJEKeha0olJ0Nqd7AIAJN6KHagOR4c24Nwzi7Dqoi4
t2UjXVCQSB0cLwKnIt2VhNUgLE2T+SFPZlN2jb8PrnlBRbvemZ2IBnfiv+QinFiN
3baK2FJZlw/s0lcwvIdWoJZMkzXm9c50m3LlpqzGNdYSMyuaZgfuUuYLVsqVPKtQ
PDTg40agk9IABb6ZJRCuwxZ+yXTsFDcus5r3dcG5uTvv/oMBdfaJudJnlqbwnztn
GfRc2UgBP32iOGavZZBlCkO0ypx1ukw9atxqNg0XxUWZsp1Lg5V9YN9dR9OP6YbF
SsUBn0xBn13CJ/wrfchKRQWY+fz3hft9ywIGrO5uDhJX+rvsBDSPyCTClfEW37s=
=iGCw
-----END PGP SIGNATURE-----

--5Hl1WHsPvsOUHkLCkcdbFiVdputLgF5Fi--
