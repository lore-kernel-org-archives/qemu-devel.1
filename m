Received: from eggs.gnu.org ([2001:4830:134:3::10]:52626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyPyE-0005J3-4h
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyPyA-0003nT-5P
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:15:22 -0400
References: <20180906130225.5118-1-jsnow@redhat.com>
	<20180906130225.5118-5-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bb574428-a570-0906-1ef4-8306674fb0d4@redhat.com>
Date: Sat, 8 Sep 2018 01:14:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180906130225.5118-5-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5xveIQfIVVcLPLGugHBxaaYdX7I5yCRBR"
Subject: Re: [Qemu-devel] [PATCH v5 04/16] block/commit: refactor commit to
 use job callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5xveIQfIVVcLPLGugHBxaaYdX7I5yCRBR
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <bb574428-a570-0906-1ef4-8306674fb0d4@redhat.com>
Subject: Re: [PATCH v5 04/16] block/commit: refactor commit to use job
 callbacks
References: <20180906130225.5118-1-jsnow@redhat.com>
 <20180906130225.5118-5-jsnow@redhat.com>
In-Reply-To: <20180906130225.5118-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-06 15:02, John Snow wrote:
> Use the component callbacks; prepare, abort, and clean.
>=20
> NB: prepare is only called when the job has not yet failed;
> and abort can be called after prepare.
>=20
> complete -> prepare -> abort -> clean
> complete -> abort -> clean
>=20
> During refactor, a potential problem with bdrv_drop_intermediate
> was identified, The patched behavior is no worse than the pre-patch

(s/T/t/)

(Max)

> behavior, so leave a FIXME for now to be fixed in a future patch.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/commit.c | 92 ++++++++++++++++++++++++++++++++------------------=
--------
>  1 file changed, 51 insertions(+), 41 deletions(-)


--5xveIQfIVVcLPLGugHBxaaYdX7I5yCRBR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluTBnMACgkQ9AfbAGHV
z0AVMQgAoDOH5s1SKcxt7NSvqWoU7p/wh/I0l8o4F4gjujlxBsi95FY4rdZGpNLP
T+N+/bfAbNMWc1i6exI7NFJTeIOm8EoQo8HEFRjhVkDp5ju5bxsHApWeXeHKl2mB
rEhrHY7kQZe6F5jB0RqfdFc95JBPb4JzWr+IyTVSgj3KYOky0dKKWfKLJZAkfWs2
O50Vd0XTHnJgzyHtGHDaFPj1uiwaIBHEHSNihswFjDu0cV7WZ6fTma6qurl833DA
X6XlsCp1yF3LHKk07u+vb9yOmZRQSv+UnIKl0xrPmRmeEjkvxrnc+cC1WOn8mBm7
zT+PtQ9youNW6mApIg9Dt0Gu4lTk6g==
=uYyp
-----END PGP SIGNATURE-----

--5xveIQfIVVcLPLGugHBxaaYdX7I5yCRBR--
