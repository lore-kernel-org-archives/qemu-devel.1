Received: from eggs.gnu.org ([2001:4830:134:3::10]:36478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5Cae-0004zS-9L
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5CaY-0004Eh-NV
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:18:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e5CaY-0004DP-EQ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:18:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75C62C001CE5
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 15:18:25 +0000 (UTC)
References: <20171019142848.572-1-berrange@redhat.com>
	<20171019142848.572-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9fa35ab3-e2a0-e054-8dc1-42b6eb930730@redhat.com>
Date: Thu, 19 Oct 2017 10:18:18 -0500
MIME-Version: 1.0
In-Reply-To: <20171019142848.572-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lrLmojPxCXAwAvdo7UgfpXx7E2jKFmjad"
Subject: Re: [Qemu-devel] [PATCH v1 2/9] ui: fix crash with sendkey and raw
 key numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lrLmojPxCXAwAvdo7UgfpXx7E2jKFmjad
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <9fa35ab3-e2a0-e054-8dc1-42b6eb930730@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/9] ui: fix crash with sendkey and raw
 key numbers
References: <20171019142848.572-1-berrange@redhat.com>
 <20171019142848.572-3-berrange@redhat.com>
In-Reply-To: <20171019142848.572-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/19/2017 09:28 AM, Daniel P. Berrange wrote:
> Previously we enforced that all key events are using QKeyCodes
> at time they are sent:
>=20
>   commit af07e5ff02ae6d4258fc5331007811d0b1c4d35a
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Fri Sep 29 11:12:00 2017 +0100
>=20
>     ui: convert key events to QKeyCodes immediately
>=20
> This commit forget to fix the code for the legacy 'sendkey'
> command which still accepts key numbers from the user, which
> then need converting to QKeyCodes
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  ui/input-legacy.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lrLmojPxCXAwAvdo7UgfpXx7E2jKFmjad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnowjoACgkQp6FrSiUn
Q2pSkAf/QH0v0YfkiXOpFzbC7hg3SssM8KsqxHUWIC61rVnv2INmEMxXIb6aAkmb
RQIJNCpWrBZmAlv2eztcdTD7Yyu1FktRqPb0g9xmGThMkCmKM6IwSVa7zO/hefbd
IcgCIp/uCW31JAaMaEJxaCKPRsiREGfIyBCvuGJdvJkltq/8AWOoIvmA5LKkdpbX
E0TnllmwefJXWFUPwcwqws0+PL19et0j+9TajPnN+rkADyLHMkeSx+t8/YT+G1I9
RqhdUAtNWojCFnoSbwwHdNlJA5i+mbF+bGe6R0cN7YJIcYuwldLRd0W8wBZ1E50Z
fXJ9bzYrw1FpRDwWK8MvpFx+skgRjQ==
=Hlqn
-----END PGP SIGNATURE-----

--lrLmojPxCXAwAvdo7UgfpXx7E2jKFmjad--
