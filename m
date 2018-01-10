Received: from eggs.gnu.org ([2001:4830:134:3::10]:34084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZHce-00065W-Gb
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZHcd-0006qA-LK
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:44:56 -0500
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-4-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <51927002-e1b5-6bd0-2ebd-5270d6153339@redhat.com>
Date: Wed, 10 Jan 2018 08:44:36 -0600
MIME-Version: 1.0
In-Reply-To: <20180110091846.10699-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OrI9yZ9ru5ia53lpWoMSTdYXC2bYRNw1E"
Subject: Re: [Qemu-devel] [PATCH v4 3/9] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OrI9yZ9ru5ia53lpWoMSTdYXC2bYRNw1E
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>
Message-ID: <51927002-e1b5-6bd0-2ebd-5270d6153339@redhat.com>
Subject: Re: [PATCH v4 3/9] block: Add VFIO based NVMe driver
References: <20180110091846.10699-1-famz@redhat.com>
 <20180110091846.10699-4-famz@redhat.com>
In-Reply-To: <20180110091846.10699-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2018 03:18 AM, Fam Zheng wrote:
> This is a new protocol driver that exclusively opens a host NVMe
> controller through VFIO. It achieves better latency than linux-aio by
> completely bypassing host kernel vfs/block layer.
>=20

> +static BlockDriver bdrv_nvme =3D {
> +    .format_name              =3D "nvme",
> +    .protocol_name            =3D "nvme",
> +    .instance_size            =3D sizeof(BDRVNVMeState),
> +
> +    .bdrv_parse_filename      =3D nvme_parse_filename,
> +    .bdrv_file_open           =3D nvme_file_open,
> +    .bdrv_close               =3D nvme_close,
> +    .bdrv_getlength           =3D nvme_getlength,
> +
> +    .bdrv_co_preadv           =3D nvme_co_preadv,
> +    .bdrv_co_pwritev          =3D nvme_co_pwritev,
> +    .bdrv_co_flush_to_disk    =3D nvme_co_flush,
> +    .bdrv_reopen_prepare      =3D nvme_reopen_prepare,
> +
> +    .bdrv_co_get_block_status =3D nvme_co_get_block_status,

Semantic conflict with my pending patches to switch to byte-based block
status in the drivers.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OrI9yZ9ru5ia53lpWoMSTdYXC2bYRNw1E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpWJtQACgkQp6FrSiUn
Q2qOoQf8DUO9fGyNgWOqPgS34W65063LBXaf0pT6mOhKlvZNZn9mhIOLKNQbVd/L
kzGkYK9ywStK5Z5VyNFCOsWDdziYuH7mjBh82Z9KZPcIV1H9aM6/dJdYBG2/JcCT
XcgrfEtHg2fLDDxWm8i+TPveAhAyxEazl5bW+CIa3/zLupzKFikQnQSQtcZSKBLW
aeip6YTMme0LcpXHRw2ycImYhiiejsWqNrBEPWMaDDOESwWggGgFfNrldryP8NI/
jvSWRIb2mCnRGmKqGqydfgEQLX9HqfTlXNUYTsoeeI6ElphfWjgfngPAq1ERFJEh
TeX2UN6c4/l3gZscrCxk0per8M3o/Q==
=qn8y
-----END PGP SIGNATURE-----

--OrI9yZ9ru5ia53lpWoMSTdYXC2bYRNw1E--
