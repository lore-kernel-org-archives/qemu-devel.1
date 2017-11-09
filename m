Received: from eggs.gnu.org ([2001:4830:134:3::10]:42595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCvSW-0000yE-T1
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 17:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCvSV-0001tM-Sl
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 17:38:04 -0500
References: <20171109221216.10248-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a4584f65-a9d9-bcfd-1f3b-2cf76553931a@redhat.com>
Date: Thu, 9 Nov 2017 23:37:53 +0100
MIME-Version: 1.0
In-Reply-To: <20171109221216.10248-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1CbIAiTNK7Sx9q316PCRbbWoXR5a3UttE"
Subject: Re: [Qemu-devel] [PATCH for-2.11] iotests: Use new-style NBD
 connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, pbonzini@redhat.com, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1CbIAiTNK7Sx9q316PCRbbWoXR5a3UttE
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, pbonzini@redhat.com,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <a4584f65-a9d9-bcfd-1f3b-2cf76553931a@redhat.com>
Subject: Re: [PATCH for-2.11] iotests: Use new-style NBD connections
References: <20171109221216.10248-1-eblake@redhat.com>
In-Reply-To: <20171109221216.10248-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-09 23:12, Eric Blake wrote:
> Old-style NBD is deprecated upstream (it is documented, but no
> longer implemented in the reference implementation), and it is
> severely limited (it cannot support structured replies, which
> means it cannot support efficient handling of zeroes), when
> compared to new-style NBD.  We are better off having our iotests
> favor new-style everywhere (although some explicit tests,
> particularly 83, still cover old-style for back-compat reasons);
> this is as simple as supplying the empty string as the default
> export name, as it does not change the URI needed to connect a
> client to the server.  This also gives us more coverage of the
> just-added structured reply code, when not overriding $QEMU_NBD
> to intentionally point to an older server.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Proposing this for 2.11; it can either go in through the NBD
> tree (although I just send my 2.11-rc1 pull request) or through
> Max' iotest tree.

random.org said 1, so: Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--1CbIAiTNK7Sx9q316PCRbbWoXR5a3UttE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloE2MESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AcVMH/Aj5vEjNQkxLhAQ1W9XThMfpEw6hQSz3
aVuKD59xE+gakd9mecqOpTvTCnSZgVqk3iOk9By5mSQajUME69LUcAdWcHdv7Tcv
9UJ1aKCbAYkOrpdQIAQszmBkBqcrVv3EHfV8N0Er3NfnD/IdZYOPAPQ85j1VKvRx
JLn11gI/qe+MJdv4VawYTI42aMx+TY0oO8oywo1cx2pdmtrmRLziue36Ce87r8hi
ZmF0PUjeqb+seLSpOwRdrkvgXy3FRoppViEh4fD+VDa0LbwePPRPob8ROAQGBtuf
QwlLhkGGhtYgLz0k9OANl0DF/QVXcPDpbK+OVh7NXzwvqgldxHYshqU=
=hXmJ
-----END PGP SIGNATURE-----

--1CbIAiTNK7Sx9q316PCRbbWoXR5a3UttE--
