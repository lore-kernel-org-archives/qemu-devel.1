Received: from eggs.gnu.org ([2001:4830:134:3::10]:34415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMED1-0004jI-7x
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMECy-0001Y4-1I
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:28:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eMECx-0001XX-NF
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:28:27 -0500
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
	<20171205081744.6563-5-mark.cave-ayland@ilande.co.uk>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73f0bc0d-dd3a-bb81-e56a-c3a38fc1cd71@redhat.com>
Date: Tue, 5 Dec 2017 08:28:23 -0600
MIME-Version: 1.0
In-Reply-To: <20171205081744.6563-5-mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="URfFTdF9848SjFUwGV1sHBONTwKDRe8rr"
Subject: Re: [Qemu-devel] [PATCHv2 4/5] eepro100: switch
 e100_compute_mcast_idx() over to use net_crc32()
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
--URfFTdF9848SjFUwGV1sHBONTwKDRe8rr
From: Eric Blake <eblake@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 jasowang@redhat.com, sw@weilnetz.de
Message-ID: <73f0bc0d-dd3a-bb81-e56a-c3a38fc1cd71@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv2 4/5] eepro100: switch
 e100_compute_mcast_idx() over to use net_crc32()
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
 <20171205081744.6563-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171205081744.6563-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2017 02:17 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/net/eepro100.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
>=20

> -            if (carry) {
> -                crc =3D ((crc ^ POLYNOMIAL) | carry);

How does this compile after 1/5 renames POLYNOMIAL to POLYNOMIAL_BE in
net.h?

/me looks

Oh, you have a redundant definition in the .c file, which is now a dead
define.  Patch 1 should be updated to remove the duplicate definitions,
and fix code to uniformly use POLYNOMIAL_BE.

But overall, I like what the series is doing.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--URfFTdF9848SjFUwGV1sHBONTwKDRe8rr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlomrQcACgkQp6FrSiUn
Q2qhMwgAhq96w6cTE9voxgIpy2j+bOPZqXZf69R4boLnBuGExhfC4XDe0T1b5COK
s0PXYjgXX6GYFeaWOismcDi2wbs5jtWhfSIMJQM7/RSqiLPCQj0sj5Ddlz4/DKwt
KTmBkMtKFu/5/0roj79AVWpmXB9XmDJAr2yry4ZjDIGu9F5FxB6usv/bOTRST3hD
shFzeBHsZb3cCDgfGSjWuwpbSctpFkQHZacVqp+qjiIC/RQbRmvS+qw3lpQjIPI9
1W1dpLAdVRZAbOLUkQX5wuKOuXEnDwJhzdujDZWQK/H9DyJEhlccaXnwHvg75nGb
RuWN2/EBT536XnnfiykhXefa1P9NYg==
=/DQE
-----END PGP SIGNATURE-----

--URfFTdF9848SjFUwGV1sHBONTwKDRe8rr--
