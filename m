Received: from eggs.gnu.org ([2001:4830:134:3::10]:34614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cKBgQ-0005vg-N2
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 17:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cKBgN-0008D4-84
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 17:17:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cKBgN-0008CW-2k
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 17:17:51 -0500
References: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
	<1482434287-26044-1-git-send-email-minyard@acm.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c2115571-c5cc-ca63-3e54-cc0430fa9680@redhat.com>
Date: Thu, 22 Dec 2016 16:17:48 -0600
MIME-Version: 1.0
In-Reply-To: <1482434287-26044-1-git-send-email-minyard@acm.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="v8rQf3IwGxVVQ1mtW4BrnEUA55QAUJ0Mh"
Subject: Re: [Qemu-devel] [PATCH v2] ipmi: Fix macro issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, Bug 1651167 <1651167@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v8rQf3IwGxVVQ1mtW4BrnEUA55QAUJ0Mh
From: Eric Blake <eblake@redhat.com>
To: minyard@acm.org, Bug 1651167 <1651167@bugs.launchpad.net>,
 qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>
Message-ID: <c2115571-c5cc-ca63-3e54-cc0430fa9680@redhat.com>
Subject: Re: [PATCH v2] ipmi: Fix macro issues
References: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
 <1482434287-26044-1-git-send-email-minyard@acm.org>
In-Reply-To: <1482434287-26044-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/22/2016 01:18 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> Macro parameters should almost always have () around them when used.
> llvm reported an error on this.
>=20
> Remove redundant parenthesis and put parenthesis around the entire
> macros with assignments in case they are used in an expression.
>=20
> Remove some unused macros.
>=20
> Reported in https://bugs.launchpad.net/bugs/1651167
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  hw/ipmi/isa_ipmi_bt.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--v8rQf3IwGxVVQ1mtW4BrnEUA55QAUJ0Mh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYXFEMAAoJEKeha0olJ0NqIAkIAK9RzKgSo7KRr8fG7JLnu0WU
81B+M6pFv7idmRFWQgUAZWKP53cR0tVQUP8PKnd91y6eIfmGlVXByISBwGC/A0+T
NJPtxRpq3B48wX29MU2GP4m9YQhgzoBKEPufv2Vg1SkAv2ptrZr9D15uU7lanFKG
eNVrAyXsKMPbyCpOj2qPp16CuQYo3mvQRTauteYky3GLajY0YFZxJpkmv4cwrydH
8cLDDX1ifzqVP1DR5SY8xlgEvmE1AW7O1bkjis7VU753tz0xc7pDt6LgwQze9+Fh
P7vH4pZdnHQtTDLZ6pEayGwyhnJRtn7+/lRhvWSXhSivLYvB1DzBEhRK5VaFShY=
=bcnx
-----END PGP SIGNATURE-----

--v8rQf3IwGxVVQ1mtW4BrnEUA55QAUJ0Mh--
