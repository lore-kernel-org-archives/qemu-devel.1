Received: from eggs.gnu.org ([2001:4830:134:3::10]:60350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPtzY-0005wx-St
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPtzU-0007Ke-7D
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:09:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPtzT-0007KS-UZ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:09:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05282BBF69
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 17:09:27 +0000 (UTC)
References: <20170611123714.31292-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <afe9f097-e08f-4b11-3cf9-9af4c18915f0@redhat.com>
Date: Tue, 27 Jun 2017 12:09:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170611123714.31292-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vurS3KRLulWfET5eE5BKcCnjTjJP2nHd0"
Subject: Re: [Qemu-devel] [PATCH] qemu-nbd: Ignore SIGPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vurS3KRLulWfET5eE5BKcCnjTjJP2nHd0
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>
Message-ID: <afe9f097-e08f-4b11-3cf9-9af4c18915f0@redhat.com>
Subject: Re: [PATCH] qemu-nbd: Ignore SIGPIPE
References: <20170611123714.31292-1-mreitz@redhat.com>
In-Reply-To: <20170611123714.31292-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/11/2017 07:37 AM, Max Reitz wrote:
> qemu proper has done so for 13 years
> (8a7ddc38a60648257dc0645ab4a05b33d6040063), qemu-img and qemu-io have
> done so for four years (526eda14a68d5b3596be715505289b541288ef2a).
> Ignoring this signal is especially important in qemu-nbd because
> otherwise a client can easily take down the qemu-nbd server by dropping=

> the connection when the server wants to send something, for example:
>=20
> $ qemu-nbd -x foo -f raw -t null-co:// &
> [1] 12726
> $ qemu-io -c quit nbd://localhost/bar
> can't open device nbd://localhost/bar: No export with name 'bar' availa=
ble
> [1]  + 12726 broken pipe  qemu-nbd -x foo -f raw -t null-co://
>=20
> In this case, the client sends an NBD_OPT_ABORT and closes the
> connection (because it is not required to wait for a reply), but the
> server replies with an NBD_REP_ACK (because it is required to reply).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

As mentioned in another thread, I'm trying to figure out if this patch
belongs as a third patch to fix CVE-2017-9524, or whether we want to
open a second CVE by considering this a slightly different
denial-of-service attack than what my patches fixed.

At any rate, this is already merged, so it's too late for me to add my
R-b, although your analysis was spot-on correct ;)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vurS3KRLulWfET5eE5BKcCnjTjJP2nHd0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUpFEAAoJEKeha0olJ0NqHIsIAKnOBwb6KzECg0wdeuXOtpaS
uh84KH2zkmt+IEptFMx5b+/j5VVbEOk3nD+Y+zinNE85M8/+wwANbxduE/duG76E
XeGjPxw2VfXS26oMV3J7BeAR30poV0tIYbMABI/A9QjC0Ecwd3iq2AqHpTxUrkbJ
3Co6xzbRlPcVWhJTNZv3oAONoOnGYmZfKtHgWPBMnbltHjhe6sr7w/+EmmgpUKXK
CTEMuivBdJise5ylG7q5Szfdhuj2Zf0nPqTFamkqvoBUr+bJnj4k1M42cj05nrrc
plBwmCJQHyGJQLUK1gIKD/9qpa9kF3dOW8wQSsaS36ejn/IkHpMEmKSsboVdHU8=
=D/f8
-----END PGP SIGNATURE-----

--vurS3KRLulWfET5eE5BKcCnjTjJP2nHd0--
