Received: from eggs.gnu.org ([2001:4830:134:3::10]:36231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEIz-0008Sc-IC
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEIv-00048l-CA
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:34:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eMEIv-00047i-6E
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:34:37 -0500
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
	<20171205081744.6563-6-mark.cave-ayland@ilande.co.uk>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e30166fb-4393-5581-79f5-21b7ca5bcf60@redhat.com>
Date: Tue, 5 Dec 2017 08:34:31 -0600
MIME-Version: 1.0
In-Reply-To: <20171205081744.6563-6-mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1es1S8BGuxe1KQHT6SLpi47IuE6tO5XVe"
Subject: Re: [Qemu-devel] [PATCHv2 5/5] sunhme: switch sunhme_receive() over
 to use net_crc32_le()
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
--1es1S8BGuxe1KQHT6SLpi47IuE6tO5XVe
From: Eric Blake <eblake@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 jasowang@redhat.com, sw@weilnetz.de
Message-ID: <e30166fb-4393-5581-79f5-21b7ca5bcf60@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv2 5/5] sunhme: switch sunhme_receive() over
 to use net_crc32_le()
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
 <20171205081744.6563-6-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171205081744.6563-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2017 02:17 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/net/sunhme.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1es1S8BGuxe1KQHT6SLpi47IuE6tO5XVe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlomrncACgkQp6FrSiUn
Q2rK3QgAlDvppAzvoVRvo7nFqNT3sAOX7LcPobgBGu6iUaB3zMRGyRdOH7UHsL7m
xzRqkXNY8IWMXfvBptPzYDqs/tQyh5kFZDri0TJl5oh6x8/pS1nCUBbtGnNEb+Oz
bcbrNvieYI6meLFUJRj5FDds3WnFR9m8mRSI4TKI7YqG8wNQJHAQmLgSfxXAwvmV
gjK+27L7gXmzmI8HR1WbTD2hHMqnn9CLkyOaaVmuBSr/Ld9tIayTn5a1CnBCAxF3
fy1rHrC2Tym3tKQHt726IUuYpCLuW1YGL/2LOxOR6SUXy4RqwnryF3Bq/l0vohnR
DX81CgkZLs5fornQKzOl1FqheWJ4XA==
=p18n
-----END PGP SIGNATURE-----

--1es1S8BGuxe1KQHT6SLpi47IuE6tO5XVe--
