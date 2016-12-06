Received: from eggs.gnu.org ([2001:4830:134:3::10]:39936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cENbp-0006Zt-CW
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 16:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cENbo-0004Q8-ID
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 16:49:09 -0500
References: <20161203181914.7467-1-eblake@redhat.com>
	<0c1ad753-561b-62c9-cdd6-2dfebb020b2b@redhat.com>
	<d6e0a4ba-d64b-7b9d-a7a1-53170ddbb543@redhat.com>
	<18e3382e-ec17-f25c-06e5-e49004a80f94@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b72676d4-f708-1c5e-4522-f721cedeb43a@redhat.com>
Date: Tue, 6 Dec 2016 15:48:56 -0600
MIME-Version: 1.0
In-Reply-To: <18e3382e-ec17-f25c-06e5-e49004a80f94@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GlNlOG8bu8neJhP9J2HMV7RJAm0OOpwe8"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Discard/zero clusters by byte count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GlNlOG8bu8neJhP9J2HMV7RJAm0OOpwe8
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Message-ID: <b72676d4-f708-1c5e-4522-f721cedeb43a@redhat.com>
Subject: Re: [PATCH] qcow2: Discard/zero clusters by byte count
References: <20161203181914.7467-1-eblake@redhat.com>
 <0c1ad753-561b-62c9-cdd6-2dfebb020b2b@redhat.com>
 <d6e0a4ba-d64b-7b9d-a7a1-53170ddbb543@redhat.com>
 <18e3382e-ec17-f25c-06e5-e49004a80f94@redhat.com>
In-Reply-To: <18e3382e-ec17-f25c-06e5-e49004a80f94@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2016 03:31 PM, Max Reitz wrote:

>>>
>>> The only alternative I can come up with would be "qcow2_write_zeroes"=
;
>>> that at least solves the first issue I have with this, but not the
>>> second one...
>>
>> Maybe qcow2_cluster_zeroize() and qcow2_cluster_discard()?
>=20
> I think qcow2_discard() is fine (it works with any alignment (even
> though it will only discard whole clusters)

Except that I think with my recent fix to qcow2_make_empty(), we can now
assert that all callers actually pass cluster-aligned values.  Hence my
other comment that maybe we want to (as a prereq patch) actually assert
that callers are aligned, at which point keeping cluster in the name is
once again worthwhile.

> and "discard" is mainly used
> as a verb, so at least I'm not confused there). I like
> qcow2_cluster_zeroize() if nothing else then for the "zeroize" alone. :=
-)

Okay, then I have a good idea of what name to use.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--GlNlOG8bu8neJhP9J2HMV7RJAm0OOpwe8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRzJJAAoJEKeha0olJ0Nq2vsH/37kkbmuWYrB6o1e2cdFymzg
fEHWCPhW7uKJ1lpXvMkspo7SEQ9Bnpkftl+cxIQvfESUwybrbUn7EvHB5PjSOcGU
o/6jTsTqBvbakWjcqH+eQBdzNCtkRBBVFuOEMK0kLBBvgePGKR0Y7d+BRRIuwRU2
SmesK+MWXgP/Fnio2/iTaCq2l62+t+4CDAvcunYEhDwZbW3x9+nmDn5ph6wNbuEM
O8SeFGIuErNFVGsHSkSyONGMypGvRHRsUeNBGtempprbtVimrXjbND1asciR9N6E
uKSZDFziqo9A4/NxFLglPXJMndDY+D+49SMdhrCtQnFz/mc3uUqbDQCeymyU8VE=
=mFuc
-----END PGP SIGNATURE-----

--GlNlOG8bu8neJhP9J2HMV7RJAm0OOpwe8--
