Received: from eggs.gnu.org ([2001:4830:134:3::10]:39663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecI5r-00025c-Pk
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:51:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecI5n-0007LH-JX
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:51:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ecI5n-0007Ks-AF
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:51:27 -0500
References: <1516308132-10272-1-git-send-email-mst@redhat.com>
	<1516308132-10272-10-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <abe7704a-0288-6345-0f3d-3fb0474a538a@redhat.com>
Date: Thu, 18 Jan 2018 15:51:17 -0600
MIME-Version: 1.0
In-Reply-To: <1516308132-10272-10-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nQiZLkrmjWbnlEoQz5MUIp9W1uD5Skit9"
Subject: Re: [Qemu-devel] [PULL v4 09/29] pci/shpc: Move function to generic
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Yuval Shaia <yuval.shaia@oracle.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nQiZLkrmjWbnlEoQz5MUIp9W1uD5Skit9
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <abe7704a-0288-6345-0f3d-3fb0474a538a@redhat.com>
Subject: Re: [Qemu-devel] [PULL v4 09/29] pci/shpc: Move function to generic
 header file
References: <1516308132-10272-1-git-send-email-mst@redhat.com>
 <1516308132-10272-10-git-send-email-mst@redhat.com>
In-Reply-To: <1516308132-10272-10-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 02:44 PM, Michael S. Tsirkin wrote:
> From: Yuval Shaia <yuval.shaia@oracle.com>
>=20
> This function should be declared in generic header file so we can
> utilize it.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/host-utils.h | 10 ++++++++++
>  hw/pci/shpc.c             | 13 ++-----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
> index 5ac621c..38da849 100644
> --- a/include/qemu/host-utils.h
> +++ b/include/qemu/host-utils.h
> @@ -400,6 +400,16 @@ static inline uint64_t pow2ceil(uint64_t value)
>      return 0x8000000000000000ull >> (n - 1);
>  }
> =20
> +static inline uint32_t pow2roundup32(uint32_t x)
> +{
> +    x |=3D (x >> 1);
> +    x |=3D (x >> 2);
> +    x |=3D (x >> 4);
> +    x |=3D (x >> 8);
> +    x |=3D (x >> 16);
> +    return x + 1;
> +}

How does this differ from pow2ceil(), other than the difference in type?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nQiZLkrmjWbnlEoQz5MUIp9W1uD5Skit9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlphFtUACgkQp6FrSiUn
Q2r70Qf7BTcpVKoIDEas6rYi2VCZ7dr0QhAfKZAxV0b1p+ya3BJBWmTDWpKIt1YB
uotGXa1Rd/x7rNwuO/gHWpOkOYf0IBteBNukjUfosRoJYtnz+rz84zcN9ckEmqHy
zcm2wbw+8xdK6EBpaAcNCY2C1oSBVEdtaJXxd/8rK4IjkthSsZsFMAWmf/fS8K/j
dogVlD6rEzzdaWNmMKDGa0fk/zdV4daWCXkqFpWY4XKmkjo6G+vu2mVky9doJeQN
uIMxOYr7QvybUmW65xY2jHRndIwlt4+Gbw4RDRx5g229g+KLEXQpxGXo6ho8up9z
DtrCPJYcMIVZ5S8K3YkurwjZFUmZFQ==
=Gs0d
-----END PGP SIGNATURE-----

--nQiZLkrmjWbnlEoQz5MUIp9W1uD5Skit9--
