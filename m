Received: from eggs.gnu.org ([2001:4830:134:3::10]:43952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3MyL-0007j3-Fh
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3MyK-00025w-M7
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:27:09 -0400
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <81ab2546-28a2-12aa-dadd-873f6f001ae7@redhat.com>
Date: Wed, 26 Apr 2017 08:26:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170425153858.25660-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GsWVI67gJXPLJ4df64GwhdfiULD1OcNqP"
Subject: Re: [Qemu-devel] [PATCH v6 01/18] block: expose crypto option names
 / defs to other drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GsWVI67gJXPLJ4df64GwhdfiULD1OcNqP
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <81ab2546-28a2-12aa-dadd-873f6f001ae7@redhat.com>
Subject: Re: [PATCH v6 01/18] block: expose crypto option names / defs to
 other drivers
References: <20170425153858.25660-1-berrange@redhat.com>
 <20170425153858.25660-2-berrange@redhat.com>
In-Reply-To: <20170425153858.25660-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 10:38 AM, Daniel P. Berrange wrote:
> The block/crypto.c defines a set of QemuOpts that provide
> parameters for encryption. This will also be needed by
> the qcow/qcow2 integration, so expose the relevant pieces
> in a new block/crypto.h header. Some helper methods taking
> QemuOpts are changed to take QDict to simplify usage in
> other places.
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 82 +++++++++++++++++---------------------------------=
--
>  block/crypto.h | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 117 insertions(+), 56 deletions(-)
>  create mode 100644 block/crypto.h

> +++ b/block/crypto.h
> @@ -0,0 +1,91 @@
> +/*
> + * QEMU block full disk encryption
> + *
> + * Copyright (c) 2015-2016 Red Hat, Inc.

Wow, we've been working on this for a while. Is it worth adding 2017?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GsWVI67gJXPLJ4df64GwhdfiULD1OcNqP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAKAfAAoJEKeha0olJ0Nqf2QH/326nUZiAUeJuciXUUe622SE
CQjayoWX4kS20CmmiBF8xY8lOeybv2UXONxPzau3Kmcg4E6nbI22dHE+XBc3Wfc+
eyEzAPd98SHnwkDEIwHL8dyCGS5jrh2QId2Z/hU5S+C8JMPFfrGhFLP3zSms+8zU
ZNjl2WmPPAlmfvqj1lS0hTNzROCiGu407YwH1FvpZxzswENmtj8uEdqhNevJvIpe
hbIgRC3mvoVi33k+NEXdGMuK0e6kkng53vJbPEPWiXMxxUYHEDvl6PH3Y7OejAJc
8+e9+pjkhNAyMHB0/uIndNFVcQCHe+WWxgip/iVxiDXisVBvYUo0d4aJ7+19JEs=
=6vwx
-----END PGP SIGNATURE-----

--GsWVI67gJXPLJ4df64GwhdfiULD1OcNqP--
