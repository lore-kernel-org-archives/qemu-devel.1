Received: from eggs.gnu.org ([2001:4830:134:3::10]:49453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Vjl-0004zV-R6
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Vjk-00013Q-Qp
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:53:53 -0400
References: <cover.1523968389.git.berto@igalia.com>
	<c5f0bde23558dd9d33b21fffc76ac9953cc19c56.1523968389.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <424ac0b5-3325-3bfd-1839-d93b8c5d89f1@redhat.com>
Date: Tue, 17 Apr 2018 13:53:45 -0500
MIME-Version: 1.0
In-Reply-To: <c5f0bde23558dd9d33b21fffc76ac9953cc19c56.1523968389.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="axgDFUzx3UYeYlHDatcxlDPtgjgbR1Zkb"
Subject: Re: [Qemu-devel] [PATCH v3 2/2] docs: Document the new default
 sizes of the qcow2 caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--axgDFUzx3UYeYlHDatcxlDPtgjgbR1Zkb
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <424ac0b5-3325-3bfd-1839-d93b8c5d89f1@redhat.com>
Subject: Re: [PATCH v3 2/2] docs: Document the new default sizes of the qcow2
 caches
References: <cover.1523968389.git.berto@igalia.com>
 <c5f0bde23558dd9d33b21fffc76ac9953cc19c56.1523968389.git.berto@igalia.com>
In-Reply-To: <c5f0bde23558dd9d33b21fffc76ac9953cc19c56.1523968389.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2018 07:37 AM, Alberto Garcia wrote:
> We have just reduced the refcount cache size to the minimum unless
> the user explicitly requests a larger one, so we have to update the
> documentation to reflect this change.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  docs/qcow2-cache.txt | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--axgDFUzx3UYeYlHDatcxlDPtgjgbR1Zkb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWQrkACgkQp6FrSiUn
Q2otfAf/bovoB4i4J9d7wqIlVsMtzplLPamFNrAt8Sruvv42gBVN+Ieobds74jcq
n0ZXSDDQvK+sCwrYHTEdl5K/V8Hs20SlC+OpCID8gcUmHCwy4mmx39KrrGjLb6x9
LehacFcuYQfXHraGDYH2/yEsnyLuJ/JQfn3jcTKrVYyZIUYERhdQ2/Y0+HJe1c1P
5/fJ4dSKtojf2ebJDn+CJPhsN1AWUpaaeqCR1a6Ycofc/orkD2TfF1DfxoFgB3Y9
O4nIH7gIaOxDb8J+YbPfacanpzP4ocNjP3RuW3qEBHpj2Gjg2nbmyW6gIWP3q2pg
q1yEsSxumDzPK3ega1/fbEpG+vBuOw==
=YlG+
-----END PGP SIGNATURE-----

--axgDFUzx3UYeYlHDatcxlDPtgjgbR1Zkb--
