Received: from eggs.gnu.org ([2001:4830:134:3::10]:46196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5sme-0008Dr-BK
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5smd-0003HI-CT
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:54:00 -0400
References: <20180410085809.13313-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <07dbac23-fabf-3d57-a5ad-8ec46f149dfa@redhat.com>
Date: Tue, 10 Apr 2018 07:53:45 -0500
MIME-Version: 1.0
In-Reply-To: <20180410085809.13313-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="10tzeMZqKdgLNzQnIh1ytD0rOvdxL1ANy"
Subject: Re: [Qemu-devel] [PATCH for-2.12] commit/stream: Reset delay_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--10tzeMZqKdgLNzQnIh1ytD0rOvdxL1ANy
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Message-ID: <07dbac23-fabf-3d57-a5ad-8ec46f149dfa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] commit/stream: Reset delay_ns
References: <20180410085809.13313-1-kwolf@redhat.com>
In-Reply-To: <20180410085809.13313-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2018 03:58 AM, Kevin Wolf wrote:
> Streaming and the commit block job only want to apply throttling when
> they actually copied data instead of skipping it, so they made the
> calculation of delay_ns conditional. However, delay_ns isn't reset when=

> skipping some sectors, so instead of not waiting, the old delay is
> applied again.
>=20
> Properly reset delay_ns where needed.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/commit.c | 2 ++
>  block/stream.c | 2 ++
>  2 files changed, 4 insertions(+)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--10tzeMZqKdgLNzQnIh1ytD0rOvdxL1ANy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrMs9kACgkQp6FrSiUn
Q2pgoAf/eeWZ1KtPAIlr8ainx3TAaZW4zslpaO+jsFZx8S+StuDYyr7ZpbF5KboR
SB2YQ1jBfcwhnX7Q0SOZu0XvuIhai+aIauRopmglFzegl3V3FvBD6WtvgEvO/lgP
QOlal8bETM0aB5TIzoaiIPj8P4QBOuf7yAKj+aqM6tzErEi5wAfuxxtUNzfw+6mz
uQ8buvz3NDQDyWGcHZNZRmvXBWoaUK4YjlJ8AJ65q+5atyFj+tTgDu8dXm0alBzZ
VmLa4JHyexc6Sjj+SKto8xILB+0zC80xeG9imx+lftkmesppFyWa1BRwZszlyWdS
8cZyD9p+BdSn4Y6PU6Fkp4aTol27tQ==
=QJNN
-----END PGP SIGNATURE-----

--10tzeMZqKdgLNzQnIh1ytD0rOvdxL1ANy--
