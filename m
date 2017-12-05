Received: from eggs.gnu.org ([2001:4830:134:3::10]:35942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEI4-000832-FS
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEI0-0003d3-7m
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:33:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eMEI0-0003cx-1a
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:33:40 -0500
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
	<20171205081744.6563-4-mark.cave-ayland@ilande.co.uk>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0478b0f1-c4a8-7472-129a-ed9e7507b451@redhat.com>
Date: Tue, 5 Dec 2017 08:33:34 -0600
MIME-Version: 1.0
In-Reply-To: <20171205081744.6563-4-mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4FameTVD4omqXJSHD0JAV3uixGeGH68jS"
Subject: Re: [Qemu-devel] [PATCHv2 3/5] pcnet: switch lnc_mchash() over to
 use net_crc32_le()
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
--4FameTVD4omqXJSHD0JAV3uixGeGH68jS
From: Eric Blake <eblake@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 jasowang@redhat.com, sw@weilnetz.de
Message-ID: <0478b0f1-c4a8-7472-129a-ed9e7507b451@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv2 3/5] pcnet: switch lnc_mchash() over to use
 net_crc32_le()
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
 <20171205081744.6563-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171205081744.6563-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2017 02:17 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/net/pcnet.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4FameTVD4omqXJSHD0JAV3uixGeGH68jS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlomrj8ACgkQp6FrSiUn
Q2oP3QgAr1PH8x6Sx9a5Xvn466SUZb8vL44088EJhf+jh1m1hqoCg7VhAlOUvNAv
9OOEYwxFNE/TMt0/Cgjl541NXdPCIA81MIIEpIv0thnJPfcNeOVLpLOd5ZHwdNV+
MKVkoHtZa79AVgKlGDPxGsKVVJxxjLVwhUpRR9vYjrOYBOnTeJ4Awv9x1BNFR2BT
FC0Tqhcdbqhm9QAHA7Gsd+xFZlFJfrl/X3ivYHX8P5Johd0Sigz0VxjG/C5T1Fzd
60fv5l8WqrGYwlq3CHYfbw/g9NtEccsY+nA3/b4QD7zT01tivl78oAp43GTXa5oN
AO6x+pAj4Ahik666xfOOufx2m+nzBg==
=BVn8
-----END PGP SIGNATURE-----

--4FameTVD4omqXJSHD0JAV3uixGeGH68jS--
