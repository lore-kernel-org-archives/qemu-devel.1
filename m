Received: from eggs.gnu.org ([2001:4830:134:3::10]:40797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsRuL-0003kF-0k
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsRuK-00037O-84
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:06:40 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-6-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1948b43b-3ccc-f296-f026-aa3bdcff3902@redhat.com>
Date: Wed, 22 Aug 2018 14:06:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-6-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NlSUjxlHHNupDOuRz9j2VfBDjwWSQDFoP"
Subject: Re: [Qemu-devel] [PATCH 5/7] block/mirror: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NlSUjxlHHNupDOuRz9j2VfBDjwWSQDFoP
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com
Message-ID: <1948b43b-3ccc-f296-f026-aa3bdcff3902@redhat.com>
Subject: Re: [PATCH 5/7] block/mirror: utilize job_exit shim
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-6-jsnow@redhat.com>
In-Reply-To: <20180817190457.8292-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-17 21:04, John Snow wrote:
> Change the manual deferment to mirror_exit into the implicit
> callback to job_exit and the mirror_exit callback.
>=20
> This does change the order of some bdrv_unref calls and job_completed,
> but thanks to the new context in which we call .job_exit, this is safe
> to defer the possible flushing of any nodes to the job_finalize_single
> cleanup stage.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)

Looks OK, but the same comment from the previous patch applies (I
wouldn't throw 'ret' around and instead work with just a boolean that
signifies failure or success.  Also, you might even want to remove
s->ret because the Error object should be enough, actually.)

Max


--NlSUjxlHHNupDOuRz9j2VfBDjwWSQDFoP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt9UcUACgkQ9AfbAGHV
z0DPVggAoMGu0HuFhHxxcmTxOXFNDI2uu/PdffNANwvGZVkKB+43oWvZDq81M56C
f152FQWmPdNwecBMq6TaLWUYanD/IIl/mpEbQcGrBpdnGsL1jP26kgddSLBD6HgN
hBv8Ua7AVwxFY/JK29GxBdLG9pIsddHbgKiPOkA/F9MkJpBwNdtFASpXiqvOa6Pr
4GDFRKEf/iPXef1JCbIxG78DqmyGva5XM46/yC7UrF3fC5Yowe8uxuCLJzIDcrim
zUeJlhGLTCGGhDy5Ce1Md5PONnddgD0Uz2IzbkzrtzAw3O+Nix7ANC+QOcuhPBm6
x35tUwgAjnf04u7UGs4Gm5tpHXQvSw==
=dy7J
-----END PGP SIGNATURE-----

--NlSUjxlHHNupDOuRz9j2VfBDjwWSQDFoP--
