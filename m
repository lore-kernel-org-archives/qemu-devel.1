Received: from eggs.gnu.org ([2001:4830:134:3::10]:59794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dddca-0007BK-0U
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dddc9-0006eE-Ry
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:30:35 -0400
References: <20170804140826.1351-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <08b23cf1-5fc4-bb97-dad1-75103f3c5d8a@redhat.com>
Date: Fri, 4 Aug 2017 09:28:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170804140826.1351-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xDOOuB8MGCjUOuTDhMjOmtifWT89OFW0h"
Subject: Re: [Qemu-devel] [PATCH v3] block: document semanatics of
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xDOOuB8MGCjUOuTDhMjOmtifWT89OFW0h
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <08b23cf1-5fc4-bb97-dad1-75103f3c5d8a@redhat.com>
Subject: Re: [PATCH v3] block: document semanatics of bdrv_co_preadv|pwritev
References: <20170804140826.1351-1-berrange@redhat.com>
In-Reply-To: <20170804140826.1351-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 09:08 AM, Daniel P. Berrange wrote:
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
>  - Clarify that @bytes matches @qiov total size (Kevin)
>=20
>  include/block/block_int.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

[looks like the nongnu.org infrastructure is having heavy load today, so
mails are getting through more slowly than usual - leads to lots of
crossed emails, where I'm seeing replies or direct sends sooner than
list copies]

> +    /**
> +     * @offset: position in bytes to write at
> +     * @bytes: number of bytes to write
> +     * @qiov: the buffers containing data to write
> +     * @flags: zero or more of bits allowed by 'supported_write_flags'=


maybe s/of //

> +     *
> +     * @offset and @bytes will be a multiple of 'request_alignment',
> +     * but the length of individual @qiov elements does not have to
> +     * be a multiple.
> +     *
> +     * @bytes will always equal the total size of @qiov, and will be
> +     * no larger than 'max_transfer'.
> +     *
> +     * The buffer in @qiov may point directly to guest memory.
> +     */
>      int coroutine_fn (*bdrv_co_pwritev)(BlockDriverState *bs,
>          uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags=
);

Do we make guarantees that the driver callback is never reached if the
image is currently read-only?  If so, is that a guarantee worth documenti=
ng?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xDOOuB8MGCjUOuTDhMjOmtifWT89OFW0h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEhKYACgkQp6FrSiUn
Q2rp/Qf9EGcXTfANl/VF153FPZhVAGVX6oQjybLew59CqP6jmq+jGqVIu6L+yEVP
CgswGsI9IY82bjFipL0f+JZYgMKvNUjTc9a8eRxrou0qvQkOsUWYVL+XzuB2gKu1
CRb2c7HLJJV7Pgf3y59kNyaJjwmMAsmnQmoFY+yHax0WR2GNp9ctQFZK7tkzowIJ
KrFV+NDbI9dgAg1/qnu/NSb0YiUImz0grzwL0lxhnN0KYK0751o853Lzz8tt2EoO
FVMtw28XFkAfxhX6w0H0s4ImhOmuhkUVnD4kK/Y1acXiS7rCzcUanA60VzQXprdm
c4RvDezAT7LoaIqgTlEAkA4RBdxJzQ==
=iDDC
-----END PGP SIGNATURE-----

--xDOOuB8MGCjUOuTDhMjOmtifWT89OFW0h--
