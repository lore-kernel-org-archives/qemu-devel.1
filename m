Received: from eggs.gnu.org ([2001:4830:134:3::10]:32977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0RlH-0005tu-86
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0RlG-0001u8-J1
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:34:23 -0400
References: <cover.1536226505.git.berto@igalia.com>
	<70655489911f1b2335aa4ae715e153fbb57a37b1.1536226505.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <849a2a04-197a-bcbf-abf8-8822e95dee4a@redhat.com>
Date: Thu, 13 Sep 2018 15:34:13 +0200
MIME-Version: 1.0
In-Reply-To: <70655489911f1b2335aa4ae715e153fbb57a37b1.1536226505.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MZtE3WHhjHeoAEtWhO8q744wAf2vVd1ot"
Subject: Re: [Qemu-devel] [PATCH v3 09/10] block: Allow changing
 'detect-zeroes' on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MZtE3WHhjHeoAEtWhO8q744wAf2vVd1ot
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <849a2a04-197a-bcbf-abf8-8822e95dee4a@redhat.com>
Subject: Re: [PATCH v3 09/10] block: Allow changing 'detect-zeroes' on reopen
References: <cover.1536226505.git.berto@igalia.com>
 <70655489911f1b2335aa4ae715e153fbb57a37b1.1536226505.git.berto@igalia.com>
In-Reply-To: <70655489911f1b2335aa4ae715e153fbb57a37b1.1536226505.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.09.18 11:37, Alberto Garcia wrote:
> 'detect-zeroes' is one of the basic BlockdevOptions available for all
> drivers, but it's not handled by bdrv_reopen_prepare(), so any attempt
> to change it results in an error:
>=20
>    (qemu) qemu-io virtio0 "reopen -o detect-zeroes=3Don"
>    Cannot change the option 'detect-zeroes'
>=20
> Since there's no reason why we shouldn't allow changing it and the
> implementation is simple let's just do it.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c               | 64 ++++++++++++++++++++++++++++++++-----------=
--------
>  include/block/block.h |  1 +
>  2 files changed, 41 insertions(+), 24 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--MZtE3WHhjHeoAEtWhO8q744wAf2vVd1ot
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluaZ1UACgkQ9AfbAGHV
z0CTkQf+JLmeHrK2vSID2JhRvWlYvKEFDaQmKd0cXoFTUC7ic/ggVyFSWMUAjcWa
Lp67c/Nvpu0kVyi0Wt4kDm3S8G9kGb9XOH8m0qYS9MlZPsWVdvq/n7mHtygzOCK2
3yClYZFPqoGCETyX0XQDyx+520QJOP83nooQcgodNRzgCcaOd5Telsa0jN4slDGu
69aE74CSv5idNKipFxvv6UkDBYQbIon0b6QIaA7Q3WdTsIHd7kyUhsf0T/HxlWK2
58CDOwyPaJdgilidViFubqap/LCh1MDeYekX5XglvrdCKgT0nAGffPRLx1iAP13j
lIYkaoQpBBEzIAMcC5cbGqunKdlm8A==
=UnWx
-----END PGP SIGNATURE-----

--MZtE3WHhjHeoAEtWhO8q744wAf2vVd1ot--
