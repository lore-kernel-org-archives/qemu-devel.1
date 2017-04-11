Received: from eggs.gnu.org ([2001:4830:134:3::10]:37983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxxkP-0006SW-1w
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxxkO-0003UQ-21
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:25 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
	<w5137dfyq1f.fsf@maestria.local.igalia.com>
	<20170411144921.GN4516@noname.str.redhat.com>
	<b5fb4bc7-d07b-6b7a-4fd5-d17c6e380ce7@redhat.com>
	<1bbcc4ba-e889-2242-cb44-c933eedfb212@redhat.com>
	<760cb82c-9bff-c289-c2b3-940319c66b5c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be491b99-9ea4-d1d0-41f4-51945b64f5d4@redhat.com>
Date: Tue, 11 Apr 2017 10:30:03 -0500
MIME-Version: 1.0
In-Reply-To: <760cb82c-9bff-c289-c2b3-940319c66b5c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FJpsOR32IR9v4irC2p3nUa43n3wtOqkkT"
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
--FJpsOR32IR9v4irC2p3nUa43n3wtOqkkT
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <be491b99-9ea4-d1d0-41f4-51945b64f5d4@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
 <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
 <w5160ibyufr.fsf@maestria.local.igalia.com>
 <9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
 <w5137dfyq1f.fsf@maestria.local.igalia.com>
 <20170411144921.GN4516@noname.str.redhat.com>
 <b5fb4bc7-d07b-6b7a-4fd5-d17c6e380ce7@redhat.com>
 <1bbcc4ba-e889-2242-cb44-c933eedfb212@redhat.com>
 <760cb82c-9bff-c289-c2b3-940319c66b5c@redhat.com>
In-Reply-To: <760cb82c-9bff-c289-c2b3-940319c66b5c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2017 10:18 AM, Max Reitz wrote:

> Hm, yeah, although you have to keep in mind that the padding is almost
> pretty much the same as the the data bits we need, effectively doubling=

> the size of the L2 tables:
>=20
> padding =3D 2^{n+2} - 2^{n+1} - 64 (=3D2^6)
>         =3D 2^{n+1} - 64
>=20
> So that's not so nice, but if it's the only thing we can do...

Or we mix-and-match your ideas: since our subclusters are ternary
encoding, if you want 128 subclusters, instead of asking for 256 bits,
you ask for ld(3^128) =3D 203 bits, then use 11 padding bits of your
original 64, and you have something that still fits in 256 bits instead
of 512...

Okay, just kidding.  Anything larger than 32 subclusters does get
awkward fast.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FJpsOR32IR9v4irC2p3nUa43n3wtOqkkT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7PZ7AAoJEKeha0olJ0Nq2WEH/iKOIXrz8F6MSxCVLuA+Zo0G
fsGgY58XfNLZGcNqMnZIwlemkxZrcFjcLJIAW7OjJIPs+1pP53AeZcSXOmb2BonY
srvxvgnRyUSPutnniwOeeOURd1tDvln+Ef4I9q0ZU0tqreuINR3rDt4YLMNnjkMJ
yahF+tqptyV1PcGIzwOirUlu8Nqw6Di6EjgtzFni30Vc997987nBLZoadvjgr5JW
rhl1dCUVMuhv5z3cVb3era+rp5cMRe3I/Yw2c4Bkb0vQzKe9Wd3DMF/LWixhzncK
mSJtaZXza2AsBea7+Swc5+mvmESllKBkY4/zbLs/HRGqcSsS3z6usMMnYdGCVoM=
=SVjT
-----END PGP SIGNATURE-----

--FJpsOR32IR9v4irC2p3nUa43n3wtOqkkT--
