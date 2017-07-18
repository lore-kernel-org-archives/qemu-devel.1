Received: from eggs.gnu.org ([2001:4830:134:3::10]:50806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWen-0006vh-QK
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWek-0002tT-OF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:51:37 -0400
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-10-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6818fd68-0741-76f0-4d2c-a4d975e9d131@redhat.com>
Date: Tue, 18 Jul 2017 12:51:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-10-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V45CnDOBNvOtN7p6GFp9PhWlkgxJdAvEN"
Subject: Re: [Qemu-devel] [PATCH 09/29] net: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V45CnDOBNvOtN7p6GFp9PhWlkgxJdAvEN
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, Dmitry Fleytman <dmitry@daynix.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <6818fd68-0741-76f0-4d2c-a4d975e9d131@redhat.com>
Subject: Re: [PATCH 09/29] net: use QEMU_IS_ALIGNED macro
References: <20170718061005.29518-1-f4bug@amsat.org>
 <20170718061005.29518-10-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 01:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osde=
p.cocci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  net/eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/eth.c b/net/eth.c
> index 5b9ba26a56..187a6812f6 100644
> --- a/net/eth.c
> +++ b/net/eth.c
> @@ -332,7 +332,7 @@ eth_setup_ip4_fragmentation(const void *l2hdr, size=
_t l2hdr_len,
>          uint16_t frag_off_units =3D frag_offset / IP_FRAG_UNIT_SIZE;
>          uint16_t new_ip_off;
> =20
> -        assert(frag_offset % IP_FRAG_UNIT_SIZE =3D=3D 0);
> +        assert(QEMU_IS_ALIGNED(frag_offset, IP_FRAG_UNIT_SIZE));
>          assert((frag_off_units & ~IP_OFFMASK) =3D=3D 0);

This line is also a candidate for using the macro, albeit in the form
QEMU_IS_ALIGNED(frag_off_units, IP_OFFMASK + 1), which might not make as
much sense (but it DOES re-visit my question of whether the coccinelle
script should be taught more patterns)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--V45CnDOBNvOtN7p6GFp9PhWlkgxJdAvEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluSqIACgkQp6FrSiUn
Q2q6igf/egf/6v3M4wV/mYbWLqTbfbEZ5u9oCR+6s+zT52/+VUmPPUR9efHh5J9S
Y2zqzj6ytEmrUIiYv7NAKVe9RxM0sad3GoPJEvfb9jdAw8nPERSE4bcquX9IfBoa
ARU51sK4b4004suxZ+2yQXa3/DpkvkFPZdASJB/lrbvloF7DIPrNEGESg3FdnV4M
HCEVqNf1qlY4H7MikPQ5M/cZOZEPKB5dAOEN2WXj4qyRevRb7zVKdiTE/YDebJAC
H1ag3b1QvG03NCLFLy35amrokpnXa4G4PU4mAqpdQBxooCO6lJEiwIygzZ0Z2tZW
fN8WLWzbjtwK9RvhT5Tn7yPxDl9z4A==
=qKtd
-----END PGP SIGNATURE-----

--V45CnDOBNvOtN7p6GFp9PhWlkgxJdAvEN--
