Received: from eggs.gnu.org ([2001:4830:134:3::10]:58479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehhV4-0000y5-Bg
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehhV1-0007dW-AI
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:59:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehhV1-0007d4-2H
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:59:51 -0500
References: <20180202183731.29990-1-armbru@redhat.com>
	<20180202183731.29990-16-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5a7bf20e-4787-e173-258c-a2254e97ff9d@redhat.com>
Date: Fri, 2 Feb 2018 13:59:48 -0600
MIME-Version: 1.0
In-Reply-To: <20180202183731.29990-16-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QzJsYWngLijXCQz3zeY0pUknThXtVp58B"
Subject: Re: [Qemu-devel] [PATCH v7 15/15] target: Use qemu_log() instead of
 fprintf(stderr, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QzJsYWngLijXCQz3zeY0pUknThXtVp58B
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com
Message-ID: <5a7bf20e-4787-e173-258c-a2254e97ff9d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 15/15] target: Use qemu_log() instead of
 fprintf(stderr, ...)
References: <20180202183731.29990-1-armbru@redhat.com>
 <20180202183731.29990-16-armbru@redhat.com>
In-Reply-To: <20180202183731.29990-16-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 12:37 PM, Markus Armbruster wrote:
> From: Alistair Francis <alistair.francis@xilinx.com>
>=20
> Convert fprintf(stderr, ...) to use qemu_log(). Double prints in
> target/ppc/translate.c were manually remove. A fprintf() in
> target/sh4/translate.c was kept as it's inside a #if 0. The #if 0 and
> fflush() was removed around the unimplemented log in
> target/sh4/translate.c as well.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> [Trivial conflict with 6f1c2af641d resolved]
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  dtc                          |  2 +-
>  target/cris/translate.c      |  2 +-
>  target/ppc/translate.c       | 36 ++++++++++--------------------------=

>  target/sh4/translate.c       |  7 ++-----
>  target/unicore32/translate.c |  2 +-
>  5 files changed, 15 insertions(+), 34 deletions(-)
>=20
> diff --git a/dtc b/dtc
> index e54388015a..558cd81bdd 160000
> --- a/dtc
> +++ b/dtc
> @@ -1 +1 @@
> -Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
> +Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d

Intentional?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QzJsYWngLijXCQz3zeY0pUknThXtVp58B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0wzQACgkQp6FrSiUn
Q2rEbggAkvMxXWtWRM0KzZZqBjGC5BA2pWVV1ke3cDtR0x8lu3wWxrh7EbweleWM
vnNCBorN85g9nxrFijfH4S32Vf/mI7GZiTjKerAKr2JM+0ha/EpA56vdqAbpbwSh
EFUeQHxgrNxK6W12Ai1GlJBf7nS5mCYwXSWGMDQjEfp8Q8k6bZm17/0Ouf87CjNd
MC1WUUr0wa5XlXG9a4RUQw0Q9j/3RfdjHEQWK0sHUulkpQF8ybMIZtNCN/G3SN9C
3Oflb+0ohTk+SJ5U+zk51W9pw/Rgjvm94cl6ewlPdoyTCwpTnWX9RiwRUCH2la3A
O8gBCABmXjxe3OfqQe3F0kXK8uf1UQ==
=Ca4/
-----END PGP SIGNATURE-----

--QzJsYWngLijXCQz3zeY0pUknThXtVp58B--
