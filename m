Received: from eggs.gnu.org ([2001:4830:134:3::10]:55769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUDzh-0007GF-Th
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUDzd-00070N-3T
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:47:17 -0500
References: <1484802878-22681-1-git-send-email-bharata@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b867af9-a039-f0de-9072-77c2a260ec23@redhat.com>
Date: Thu, 19 Jan 2017 08:47:09 -0600
MIME-Version: 1.0
In-Reply-To: <1484802878-22681-1-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6pdhOGelU2F0gugnnQkQBcvaIE9jIDF9U"
Subject: Re: [Qemu-devel] [RFC PATCH v0] softfloat: Add round-to-odd
 rounding mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, qemu-ppc@nongnu.org, nikunj@linux.vnet.ibm.com, david@gibson.dropbear.id.au

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6pdhOGelU2F0gugnnQkQBcvaIE9jIDF9U
From: Eric Blake <eblake@redhat.com>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, qemu-ppc@nongnu.org, nikunj@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
Message-ID: <8b867af9-a039-f0de-9072-77c2a260ec23@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v0] softfloat: Add round-to-odd rounding
 mode
References: <1484802878-22681-1-git-send-email-bharata@linux.vnet.ibm.com>
In-Reply-To: <1484802878-22681-1-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2017 11:14 PM, Bharata B Rao wrote:
> Power ISA 3.0 introduces a few quadruple precision floating point
> instructions that support round-to-add rounding mode. The

s/add/odd/

> round-to-odd mode is explained as under:
>=20
> Let Z be the intermediate arithmetic result or the operand of a convert=

> operation. If Z can be represented exactly in the target format, the
> result is Z. Otherwise the result is either Z1 or Z2 whichever is odd.
> Here Z1 and Z2 are the next larger and smaller numbers representable
> in the target format respectively.

IEEE 854 and thus POSIX <float.h> specifies round-to-zero,
round-to-pos-inf, round-to-neg-inf, and round-to-even. It sounds like
round-to-odd is similar to round-to-even, only that the ties are broken
in the opposite direction.  I don't know if portable C code can even
request this mode (although float.h is allowed to add additional
implementation-defined values to FLT_ROUNDS), but since the hardware can
do it, I guess we have to emulate it.

>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
> - I am not fully sure if this the correct implementation for the above
>   described round-to-odd rounding method. Any help is appreciated.

I don't know the code either, but if round-to-even is implemented
correctly, it sounds like round-to-odd is a one-off tweak from that.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6pdhOGelU2F0gugnnQkQBcvaIE9jIDF9U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgNFtAAoJEKeha0olJ0NqlMsH+wVXPCSnWd4HN8VnIyk44vxI
vTltZbDNtfJfQi7xV4j8IGPnocjPYuWixr0wB2+FvFVqc9ObFEgHOSdpAcl2HxPs
6CJFKaKDwLMUPlriCrB9aaWfENVovWMMPBIWn/DyOGlxLCBx0Ihu6QKcSnwlOuA4
vNZidqg/tHwp2oOw+tvCIq7L+r4sUIC7we3k0VsR8l3N40tjwr1hpOJV265jSMa2
tjt0NqrYsJS3yGkTCcZrHE51W72Q/YORHoruKEm3LBHwXixHWoKjFTXnycW69UV3
udXTmCrCj22cihqBV8kAkxNenzzyxYcu8GfMXM6UJ/mi6wl4A+8ojks008t5Qzk=
=aqi5
-----END PGP SIGNATURE-----

--6pdhOGelU2F0gugnnQkQBcvaIE9jIDF9U--
