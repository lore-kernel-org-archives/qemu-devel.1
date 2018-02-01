Received: from eggs.gnu.org ([2001:4830:134:3::10]:35378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehIXU-0004gf-GY
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehIXS-0007Mv-QJ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:20:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49505)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ehIXS-0007MJ-6S
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:20:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D0EA78552
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 17:20:41 +0000 (UTC)
Date: Thu, 1 Feb 2018 17:20:39 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180201172039.GD5578@stefanha-x1.localdomain>
References: <20180201162625.4276-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <20180201162625.4276-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: avoid SystemTap "char const"
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2018 at 04:26:25PM +0000, Stefan Hajnoczi wrote:
> SystemTap's dtrace(1) produces the following warning when it encounters
> "char const" instead of "const char":
>=20
>   Warning: /usr/bin/dtrace:trace-dtrace-root.dtrace:66: syntax error near:
>   probe flatview_destroy_rcu
>=20
>   Warning: Proceeding as if --no-pyparsing was given.
>=20
> This is a limitation in current SystemTap releases.  I have sent a patch
> upstream to accept "char const" since it is valid C:
>=20
>   https://sourceware.org/ml/systemtap/2018-q1/msg00017.html
>=20
> In QEMU we still wish to avoid warnings in the current SystemTap
> release.  It's simple enough to replace "char const" with "const char".
>=20
> I'm not changing the documentation or implementing checks to prevent
> this from occurring again in the future.  The next release of SystemTap
> will hopefully resolve this issue.
>=20
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/trace-events |  4 ++--
>  trace-events          | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJac0xnAAoJEJykq7OBq3PIUuwH/jTbKJz1jzZlnYxWAgBcmlbE
TEInfWk7ywqq95IyTgdQ5i9dySFc61ZsrwkCB76xZr4WOH59/uMPFaQ6im2V85S2
m+T6vVoK3TGAqkYkuUDVwG4tClePUC+ZmTJhcNjG6eLdVCMBSxXNg6vbjerWe3DK
Uc2z9gnSL3oe8dj5Ls4JesgZk0twt6f3df36MXu7lXHgvA8HanzAVp6ZXwhR66ER
9ZO4nPoitj8RPFuLX3rRLZs7brdHvpHDwdD/ci5iWZc76eL9t+HmDTRjtDjotiIL
ZhRtCVHuk+89ZtCw7/fWw5FlHnUGSASCgEaYWjGQHP0cRMr5VAJn9lvIXPyD/uc=
=AQ5n
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
