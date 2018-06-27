Received: from eggs.gnu.org ([2001:4830:134:3::10]:41631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYBBM-0003or-1Z
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYBBK-0005OF-Aw
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:12:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYBBK-0005N0-5b
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 786FD401DEC9
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 14:12:25 +0000 (UTC)
Date: Wed, 27 Jun 2018 15:12:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627141222.GA6623@stefanha-x1.localdomain>
References: <20180621175451.7948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20180621175451.7948-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Partially revert "python: futurize -f
 libfuturize.fixes.fix_absolute_import"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 02:54:51PM -0300, Eduardo Habkost wrote:
> Since commit 068cf7a44cd4d65c05aa877dbebced295be5ce44, qmp-shell
> is broken:
>=20
>   $ ./scripts/qmp/qmp-shell
>   Traceback (most recent call last):
>     File "./scripts/qmp/qmp-shell", line 70, in <module>
>       from . import qmp
>   ValueError: Attempted relative import in non-package
>=20
> Relative imports don't work on scripts that are executed
> directly, so revert the change on the scripts inside scripts/qmp.
>=20
> Fixes: 068cf7a44cd4d65c05aa877dbebced295be5ce44
> Reported-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qmp/qemu-ga-client | 3 +--
>  scripts/qmp/qmp            | 3 +--
>  scripts/qmp/qmp-shell      | 3 +--
>  scripts/qmp/qom-fuse       | 3 +--
>  scripts/qmp/qom-get        | 3 +--
>  scripts/qmp/qom-list       | 3 +--
>  scripts/qmp/qom-set        | 3 +--
>  scripts/qmp/qom-tree       | 3 +--
>  8 files changed, 8 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM5tGAAoJEJykq7OBq3PIVZIH/3eP95Z8INCOVlaLx4qiN7bw
tU+QJb8oU/xdRDTzXqPtCBsUJuHqLjsaE+OI6jMl8r5oEb2LEujJVQzLLBY7BH2d
fN/xuIvRFClAByDsasNcAVqzUlxkO6cmsL2KpGplnqTfPWjthB/1Vw10j1nIzUb4
wGjNG+k4Sa0d5LFKgo2oeSzAFnGci60CJVglDvP0bifmiT2qeL7/7nGAcppy1020
bdi11a0b5W64nnvvMjXMJOZC/wKYztsY6GyMSDt9iHpT/pt0sFU+sd3AYoNRu+RI
aUC1Lq8r0ST/UHDotqfWAQPFlqUAZxdj8KH/6VedoHMXBHgl9eHQfwuuNsfgfcE=
=xHwv
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
