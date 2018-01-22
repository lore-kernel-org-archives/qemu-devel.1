Received: from eggs.gnu.org ([2001:4830:134:3::10]:38678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edjAP-0001zO-P3
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edjAM-0005dT-LI
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:58:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1edjAM-0005dH-EG
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:58:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7813F4A6FA
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 20:58:05 +0000 (UTC)
References: <20180122205033.24893-1-apahim@redhat.com>
	<20180122205033.24893-3-apahim@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <55427adc-2128-4fde-9ca3-08a621d3e51a@redhat.com>
Date: Mon, 22 Jan 2018 14:57:45 -0600
MIME-Version: 1.0
In-Reply-To: <20180122205033.24893-3-apahim@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="imSIcfEuGsEHItMWcwbbncHv6jxz4p8Ic"
Subject: Re: [Qemu-devel] [PATCH v12 2/6] qemu.py: refactor launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, crosa@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--imSIcfEuGsEHItMWcwbbncHv6jxz4p8Ic
From: Eric Blake <eblake@redhat.com>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Message-ID: <55427adc-2128-4fde-9ca3-08a621d3e51a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 2/6] qemu.py: refactor launch()
References: <20180122205033.24893-1-apahim@redhat.com>
 <20180122205033.24893-3-apahim@redhat.com>
In-Reply-To: <20180122205033.24893-3-apahim@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2018 02:50 PM, Amador Pahim wrote:
> This is just an refactor to separate the exception handler from the

s/an refactor/a refactor/

> actual launch procedure, improving the readability and making future
> maintenances in this piece of code easier.
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--imSIcfEuGsEHItMWcwbbncHv6jxz4p8Ic
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpmUEkACgkQp6FrSiUn
Q2pnPQf+K7uKWlJ1Fyyhp4fRCdUYzEXlAlthqr/UgxS18SqTzVP5fSyfxhYpZ0fH
SBberAzdn8Y3Dl1tVKzZzz4uXPPoBulyYimLe6AAsQ9r2mn+yMomptGe5BpEldID
2F5hcVnxR7HWDpBTOcQMbLbZ5cs6pO/1xDD0B6Q+TiQcKmlxcnKU+bi6gOSOo8RE
7ABf3oxmIY1hiC9fiuhjQ0m6weHnOKZDPGw8So7XsaNMvuNQ4YFuFCZWev9VxQZW
bJAmIoQqk6AyGvHr4+cEy4Y/aKCUiPg6yUk/0o85y4JSvm47a1uLsAxC/qZ68BQ6
fgtd7k2zqpCZdUjZsN2nPO4tOOQ2gg==
=SORL
-----END PGP SIGNATURE-----

--imSIcfEuGsEHItMWcwbbncHv6jxz4p8Ic--
