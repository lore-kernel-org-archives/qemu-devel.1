Received: from eggs.gnu.org ([208.118.235.92]:54536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdpW-0004R5-MH
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:04:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdpR-0007MX-Nn
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:04:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehdpR-0007M7-DN
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:04:41 -0500
References: <20180202111022.19269-1-kraxel@redhat.com>
	<20180202111022.19269-10-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d0d948f-aff3-8db5-09f8-c670e8a14e91@redhat.com>
Date: Fri, 2 Feb 2018 10:04:35 -0600
MIME-Version: 1.0
In-Reply-To: <20180202111022.19269-10-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="x07X52jpT6JGzNpOIPNtd4vgunXpeuKX0"
Subject: Re: [Qemu-devel] [PATCH v3 09/12] cocoa: use DisplayOptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x07X52jpT6JGzNpOIPNtd4vgunXpeuKX0
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d0d948f-aff3-8db5-09f8-c670e8a14e91@redhat.com>
Subject: Re: [PATCH v3 09/12] cocoa: use DisplayOptions
References: <20180202111022.19269-1-kraxel@redhat.com>
 <20180202111022.19269-10-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-10-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 05:10 AM, Gerd Hoffmann wrote:
> Switch cocoa ui to use qapi DisplayOptions for configuration.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/console.h | 4 ++--
>  vl.c                 | 3 ++-
>  qapi/ui.json         | 6 ++++--
>  ui/cocoa.m           | 4 ++--
>  4 files changed, 10 insertions(+), 7 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--x07X52jpT6JGzNpOIPNtd4vgunXpeuKX0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0jBMACgkQp6FrSiUn
Q2rX9gf/Z/bNavmcZPU5OJ3Zuwk0Kj/SceVKLB48/w956d7TrlVmzAZvi70SRivB
IcDZ/vDonE0XaU0/kN4CUiY623CiWhOM1uTh65SK+SPlQK/RlgqMiyANqh/x4EFy
2jmPmVef4QGDYMlkExH8jQEGwubDkUJvAAsAh8po67yUKNJ6bKnXZ1WugAnhF4ff
Wijlk8TmEvHnL3hyiANxWIWeiRlW7Eu5ePUblZBtIQJbmmu7xNLRZHM0sKXI0v4t
5lAkY24HonqVZDemQYRSdSTgIQWCuCX0wVxvX5W2Hx8/0MyIL0q127u+o0dxO828
kX6h8t2WIhAXYUJE3iNnlTITYLvPKg==
=GXMU
-----END PGP SIGNATURE-----

--x07X52jpT6JGzNpOIPNtd4vgunXpeuKX0--
