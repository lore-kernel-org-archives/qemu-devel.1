Received: from eggs.gnu.org ([209.51.188.92]:52329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grS7w-0006CI-AC
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grS7n-0006cr-9e
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:40:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1grS7h-0006IJ-II
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:40:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27B0DAAA7C
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 18:40:11 +0000 (UTC)
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-18-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ad19847-14c5-fdd4-8cf5-9cacd8a95005@redhat.com>
Date: Wed, 6 Feb 2019 12:40:05 -0600
MIME-Version: 1.0
In-Reply-To: <20190206181725.14337-18-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="W49USHmz7wRN20xrPCJfP9euALgHW28hX"
Subject: Re: [Qemu-devel] [PATCH v3 17/17] qapi: move RTC_CHANGE to the
 target schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W49USHmz7wRN20xrPCJfP9euALgHW28hX
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Message-ID: <5ad19847-14c5-fdd4-8cf5-9cacd8a95005@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 17/17] qapi: move RTC_CHANGE to the target
 schema
References: <20190206181725.14337-1-armbru@redhat.com>
 <20190206181725.14337-18-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-18-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 12:17 PM, Markus Armbruster wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> A few targets don't emit RTC_CHANGE, we could restrict the event to
> the tagets that do emit it.

s/tagets/targets/

>=20
> Note: There is a lot more of events & commands that we could restrict

s/is a lot more of/are a lot more/

> to capable targets, with the cost of some additional complexity, but
> the benefit of added correctness and better introspection.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--W49USHmz7wRN20xrPCJfP9euALgHW28hX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbKgUACgkQp6FrSiUn
Q2oTnwgAkJ0A71Px64vBTWwSh4XKsyYVDrlU3zAx65CbZuxDGOO1RW1CaZ85MDdQ
qHPSfFSEHWj+2cfd0sjzUR/3qEuf1V2M7InXTUvhspfcYqtvMskzyqkdZNqOqw1+
tgtwFb07MjRCYeHqKbP760QHCIXQpg25ll3LDI04xAADlEA/PJtzI/U7v6aiivdZ
/QquYpQR2829nlMAwHwz1rqBHXrF0vQvmZCkGGOAB8gb8Gm8ad/qxK6HqPUBomVq
csaKwExXHGCePjRb/8zv02m2U0B1QVebKFKXAz8H+wGaJH/pKRl8c56EnPN38NYA
IXr7WCqbYh+b2daenAbF4mE8CbjN7w==
=jwHx
-----END PGP SIGNATURE-----

--W49USHmz7wRN20xrPCJfP9euALgHW28hX--
