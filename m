Received: from eggs.gnu.org ([2001:4830:134:3::10]:46112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX7oJ-0007Pd-8n
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX7oG-00078N-1S
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:19:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dX7oF-000789-NU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:19:43 -0400
References: <20170717144527.24534-1-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa14cf76-957b-5b19-e628-9a2618e19a2d@redhat.com>
Date: Mon, 17 Jul 2017 10:19:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170717144527.24534-1-lvivier@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uirngrHCgA9P6pEmoRPQwgmarpRWtCPVU"
Subject: Re: [Qemu-devel] [PATCH v2] accel: cleanup error output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uirngrHCgA9P6pEmoRPQwgmarpRWtCPVU
From: Eric Blake <eblake@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Ben Warren <ben@skyportsystems.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <aa14cf76-957b-5b19-e628-9a2618e19a2d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] accel: cleanup error output
References: <20170717144527.24534-1-lvivier@redhat.com>
In-Reply-To: <20170717144527.24534-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 09:45 AM, Laurent Vivier wrote:
> Only emit "XXX accelerator not found", if there are not
> further accelerators listed. eg
>=20
>    accel=3Dkvm:tcg
>=20
> doesn't print a "KVM accelerator not found" warning
> when it falls back to tcg, but a
>=20
>    accel=3Dkvm
>=20
> prints a warning, since no fallback is given.
>=20
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> v2: replace "fprintf(stderr, ...)" by error_report()
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uirngrHCgA9P6pEmoRPQwgmarpRWtCPVU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlls1YUACgkQp6FrSiUn
Q2oZqwf/Zuku2hH8yLAblPsgZ1A4Z2Rmvwb0x5CqamR4PiwcbUXNMEPc5cW48lUm
YYY2dIFUlOgThqOUoiJvbvGiD82W453GuxS8XFlDnKMy9pPw5WFP1aCGHBQ32lbS
P6qdzQHEl6qb38vWat7PoLS7n02laQJNmXxLbleLy3uef66X4dn9knD3x0ksT9k7
YWwfX3nsnVRZjCzF5WBlaqalN6tXPta/SgY2osAJgw3Bxshwi/Sa/rTFGtWs0fpY
XC1IBs1jjzbehwuJXt/Wb+0g34MKDdOtfUyKs7VVyp1QvjrBNAOX3WhSqmMd4s0D
3dPn7yeUdCJUq3ORalwvlOGRVfCbpA==
=BPhY
-----END PGP SIGNATURE-----

--uirngrHCgA9P6pEmoRPQwgmarpRWtCPVU--
