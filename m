Received: from eggs.gnu.org ([209.51.188.92]:46397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEGFo-0007KZ-03
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEGFn-00061P-5B
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:39:15 -0400
References: <20190410162918.9343-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa9b357f-3485-9819-fa93-23afe6fdb2d1@redhat.com>
Date: Wed, 10 Apr 2019 11:39:10 -0500
MIME-Version: 1.0
In-Reply-To: <20190410162918.9343-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ykdEib69bsE9e1IsFs087j269zlGKtBnO"
Subject: Re: [Qemu-devel] [PATCH for-4.0?] iotests: Let 245 pass on tmpfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ykdEib69bsE9e1IsFs087j269zlGKtBnO
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Message-ID: <aa9b357f-3485-9819-fa93-23afe6fdb2d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0?] iotests: Let 245 pass on tmpfs
References: <20190410162918.9343-1-mreitz@redhat.com>
In-Reply-To: <20190410162918.9343-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/10/19 11:29 AM, Max Reitz wrote:
> tmpfs does not support O_DIRECT.  Detect this case, and skip flipping
> @direct if the filesystem does not support it.
>=20
> Fixes: bf3e50f6239090e63a8ffaaec971671e66d88e07
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/245 | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Are you trying to get this in 4.0-rc3? (As a test, it has no bearing on
the actual binaries; fewer testsuite failures are nice if we squeeze it
in, but at the same time it is not enough to delay the release if it
does not get fixed until 4.1).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ykdEib69bsE9e1IsFs087j269zlGKtBnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyuHC4ACgkQp6FrSiUn
Q2qFDgf/bs7wX3VQEQzK87yKaeC7PEMLSKnFIHMwG+OUJOeOPrWOvPHj4/uTmkNb
SIrM9ajWq3vLMWl0f0CG3q5JYmKaC2F1qjJj/RrzK9h32QjdOh00Jrb9Ej7bnrEb
ScKRYVuhFk99eDPZN0/1R5BmcHwtaUH9lMUHNgMNlMKCOmzgBt4qDBizD9jggYXV
BFWeWdEPsh8gnW/5G+nVnVpbeCzPvcby5YvEsgL4sFWaz7N/+gODc3cQzN4xVmiI
TxAHHKuBTJEGVspJPDOjUohbOsaV5PVLxBjNYpr28iw77m9C+l9gZNPOUxTzbSrW
GNdH0oYlBn0vvOmBzZpdnaAaFFGqnA==
=nzo5
-----END PGP SIGNATURE-----

--ykdEib69bsE9e1IsFs087j269zlGKtBnO--
