Received: from eggs.gnu.org ([209.51.188.92]:44247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grTgY-00048i-Lx
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grTgW-0008FR-74
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:20:40 -0500
References: <20190206195551.28893-1-mreitz@redhat.com>
	<20190206195551.28893-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <82b309a3-eed6-1d0e-8bae-50922eed0368@redhat.com>
Date: Wed, 6 Feb 2019 14:20:11 -0600
MIME-Version: 1.0
In-Reply-To: <20190206195551.28893-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="whT6pxlOq0mPlO46dTmK172IYKHr8XlJU"
Subject: Re: [Qemu-devel] [PATCH v3 3/8] tests: Add QAPI optional
 discriminator tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--whT6pxlOq0mPlO46dTmK172IYKHr8XlJU
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <82b309a3-eed6-1d0e-8bae-50922eed0368@redhat.com>
Subject: Re: [PATCH v3 3/8] tests: Add QAPI optional discriminator tests
References: <20190206195551.28893-1-mreitz@redhat.com>
 <20190206195551.28893-4-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 1:55 PM, Max Reitz wrote:
> There already is an optional discriminator test, although it also noted=

> the discriminator name itself as optional.  This already gives us one
> error test case, to which this patch adds various others.
>=20
> Furthermore, a passing test case is added to qapi-schema-test.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
Reviewed-by: Eric Blake <eblake@redhat.com>

This could also be squashed with patch 1 to avoid a window of 'make
check' breakage during a bisect; but as that makes the overall changes
bigger to review, leaving them separate is not too terrible.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--whT6pxlOq0mPlO46dTmK172IYKHr8XlJU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbQXsACgkQp6FrSiUn
Q2oTmAgAgOlwUgG1NQvpPG5LFGt0A3EHFh4zd5e3+cP9cOs7D++RYwqoA9kXp3OO
LbzM9qJOuY/a1ZUnlDyjaKv2PSnsuIS9gcxhgUw7TzFk0c8FeasyhHhX+ryApd52
iYuohL93BJaN1aWDlvuxO9DD65ioao8ASStnKkWd+qnNByYTebo422YzB+oWU6+d
tHv901fy5PbJ2CU5P0mX7b64dlrRC1h72Ev1xwWn4La0JP2JbI8bTfcHPLqeZ3Rr
my7R8z75c5jU31Q80yHpXBeTTLEJ4Ptbd+03qHwVYj/em2bx13YwCKKgq8WlVM7V
Vb3tD3l5rTb1M91oRTEzkEosytaN6w==
=z5T4
-----END PGP SIGNATURE-----

--whT6pxlOq0mPlO46dTmK172IYKHr8XlJU--
