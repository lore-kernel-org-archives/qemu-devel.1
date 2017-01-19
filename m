Received: from eggs.gnu.org ([2001:4830:134:3::10]:43261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUKGU-0000xy-Uu
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUKGQ-000829-1P
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:29:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cUKGP-00081A-P6
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:28:57 -0500
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
	<1484859998-25074-4-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be50812d-563a-bc68-82c6-d6c69459bcfb@redhat.com>
Date: Thu, 19 Jan 2017 15:28:55 -0600
MIME-Version: 1.0
In-Reply-To: <1484859998-25074-4-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5KwhGhkitNviXD3r05sqtHPme9DMqCDSV"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] compiler: expression version of
 QEMU_BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5KwhGhkitNviXD3r05sqtHPme9DMqCDSV
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Message-ID: <be50812d-563a-bc68-82c6-d6c69459bcfb@redhat.com>
Subject: Re: [PATCH v3 3/4] compiler: expression version of QEMU_BUILD_BUG_ON
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
 <1484859998-25074-4-git-send-email-mst@redhat.com>
In-Reply-To: <1484859998-25074-4-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 03:07 PM, Michael S. Tsirkin wrote:
> QEMU_BUILD_BUG_ON uses a typedef in order to be safe
> to use outside functions, but sometimes it's useful
> to have a version that can be used within an expression.
> Following what Linux does, introduce QEMU_BUILD_BUG_ON_ZERO
> that return zero after checking condition at build time.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/compiler.h | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index c6f673e..8271eab 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -92,6 +92,9 @@
>  #define QEMU_BUILD_BUG_ON(x) typedef QEMU_BUILD_BUG_ON_STRUCT(x) \
>      glue(qemu_build_bug_on__, __LINE__) __attribute__((unused))
> =20
> +#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x))=
 - \
> +                                   sizeof(QEMU_BUILD_BUG_ON_STRUCT(x))=
)

Although this should be equally effective, with less typing:

#define QEMU_BUILD_BUG_ON_ZERO(x) (!sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)))

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5KwhGhkitNviXD3r05sqtHPme9DMqCDSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgS+XAAoJEKeha0olJ0NqB5YH/iPQR7ESKPrcyzfpK+2aItA9
6qXW26KqLfmrJT4HavuQNQM9rmSPH6ounQwdbk4SiZjpZxnLKmvDNpJ3LoGiXUlW
AdTf5dIMSJaa57Bzxqn2AYLvdoP80cZrU2csVNsP9oa6P8Z1JiOdI7aMmPrLkLdz
hKvG+wQ9Z9pNyHQScILgLmcWNHAHKTZWnkGEXNly9EnN6zIJsW7YIh1N2JQgIY1A
ppuwHebC/GIsHzDHNM9InMo8NkolRGOWnRKMH4DCCy9A3jwnkuvI997IRongk1F1
GaUkzkF1RJzxYvOePFul4um6chnE9Suf0Tg0Feu5cIV78kSQNI7gzFRVBD+Msjw=
=u1GE
-----END PGP SIGNATURE-----

--5KwhGhkitNviXD3r05sqtHPme9DMqCDSV--
