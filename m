Received: from eggs.gnu.org ([2001:4830:134:3::10]:35227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEGM-0005z4-19
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEGI-0002kY-T7
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:31:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eMEGI-0002jg-Mm
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:31:54 -0500
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
	<20171205081744.6563-3-mark.cave-ayland@ilande.co.uk>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6e01fbfb-f7b3-952b-435b-d1e3daa3131c@redhat.com>
Date: Tue, 5 Dec 2017 08:31:50 -0600
MIME-Version: 1.0
In-Reply-To: <20171205081744.6563-3-mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Sn27Lgk8u8Fv6f1H950u199mIfaApNo1h"
Subject: Re: [Qemu-devel] [PATCHv2 2/5] net: introduce net_crc32_le()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sn27Lgk8u8Fv6f1H950u199mIfaApNo1h
From: Eric Blake <eblake@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 jasowang@redhat.com, sw@weilnetz.de
Message-ID: <6e01fbfb-f7b3-952b-435b-d1e3daa3131c@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv2 2/5] net: introduce net_crc32_le() function
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
 <20171205081744.6563-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171205081744.6563-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2017 02:17 AM, Mark Cave-Ayland wrote:
> This provides a standard ethernet CRC32 little-endian implementation.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  include/net/net.h |  2 ++
>  net/net.c         | 22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> +            if (carry) {
> +                crc =3D crc ^ POLYNOMIAL_LE;
> +            }

Worth writing as 'crc ^=3D POLYNOMIAL_LE;'?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Sn27Lgk8u8Fv6f1H950u199mIfaApNo1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlomrdYACgkQp6FrSiUn
Q2pbmgf/QhG+zmN9OnplCbYj44yo/fIRy7VMC/9zAartjV4sL/w8lGmOSjAEiWwt
vvkDZFrJsXd5D+WzSNbWmlA8+6OQMs4nSLWsriiIQ+PFkoovkaDNtPEA/1VzoieV
j3mEjz9A7pht6E20DUOl48um9+CA6kOkVwTf1ulUWIXXr4hciAykNqKMc8ZaY+Lw
VvGVSVvQ7JaDrMCi/tR2mkHKUqpyUQQaowiKVmimjTignFPaFQFDkHIDEN0XtKyH
VUufOPtuGa1oLwywvCM1uGKwiYfctWVmnk/5v/ml7sVlzS/2sYOcz+P240aO9xX2
LiA5+Cez9BeFAUn0emKCFkngzRgnSw==
=UGtj
-----END PGP SIGNATURE-----

--Sn27Lgk8u8Fv6f1H950u199mIfaApNo1h--
