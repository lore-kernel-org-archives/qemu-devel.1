Received: from eggs.gnu.org ([2001:4830:134:3::10]:49827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8qfQ-0007p8-F6
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8qfP-0002dE-Nn
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:10:16 -0400
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-7-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4f74b071-4bc3-9a86-c968-8f3f0d51ca25@redhat.com>
Date: Thu, 11 May 2017 11:10:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170511144208.24075-7-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GVwOphJur4e2kLewiBqdgSNUh5FomvT7e"
Subject: Re: [Qemu-devel] [PATCH 06/18] block: access io_plugged with atomic
 ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GVwOphJur4e2kLewiBqdgSNUh5FomvT7e
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com
Message-ID: <4f74b071-4bc3-9a86-c968-8f3f0d51ca25@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/18] block: access io_plugged with atomic
 ops
References: <20170511144208.24075-1-pbonzini@redhat.com>
 <20170511144208.24075-7-pbonzini@redhat.com>
In-Reply-To: <20170511144208.24075-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/11/2017 09:41 AM, Paolo Bonzini wrote:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/io.c                | 4 ++--
>  include/block/block_int.h | 8 +++++---
>  2 files changed, 7 insertions(+), 5 deletions(-)

> @@ -625,6 +622,11 @@ struct BlockDriverState {
>       */
>      bool wakeup;
> =20
> +    /* counter for nested bdrv_io_plug.
> +     * Accessed with atomic ops.
> +    */
> +    unsigned io_plugged;

Indentation is odd.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GVwOphJur4e2kLewiBqdgSNUh5FomvT7e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFIzZAAoJEKeha0olJ0Nq4SMH/1mxyUxrjebjmrTxRsBS4Bwi
8rG6RpGz85KQYVWtoiLlvm0gUCqIxaQCOCDemu7xGrZJRQgeBXuO4glzkT5oH6mD
hJ8Q4ewPEiGoAe1MNw8LaemlPaaBveEhXp/QhlaRCIAlFkDUen3SpJYkzWYLqegR
SCRofP5Yf5ApDnGCFZaKo1yOyzsHGRn/BtRcF5/uMKgxaYjIaq5U8cBZuMMkch2x
9eFXgL6GZ9jNL1qdkzkylFLjW1p7u2ZGunKrbavFFV8UKN2l+mp5HY5L6XtqvrQn
CVDCi8Uu27Z4NtljRfCIP+q3ie2hjFHEQOyJDIYS5B2NMVyPAeSGNY3BAeh7kwA=
=6qRk
-----END PGP SIGNATURE-----

--GVwOphJur4e2kLewiBqdgSNUh5FomvT7e--
