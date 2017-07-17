Received: from eggs.gnu.org ([2001:4830:134:3::10]:60042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8Tu-0008EC-Gq
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8Tr-0002pn-Db
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:02:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dX8Tr-0002oq-5P
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:02:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 204267C848
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:02:42 +0000 (UTC)
References: <20170717155632.12754-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3070e28e-7676-3397-0f8f-8810ae1f6ece@redhat.com>
Date: Mon, 17 Jul 2017 11:02:35 -0500
MIME-Version: 1.0
In-Reply-To: <20170717155632.12754-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nuoC4Llk8aCqdnhXkaRaCFKxKDPHmleLO"
Subject: Re: [Qemu-devel] [PATCH 0/5] Easier conversion from qapi to qobject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nuoC4Llk8aCqdnhXkaRaCFKxKDPHmleLO
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <3070e28e-7676-3397-0f8f-8810ae1f6ece@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] Easier conversion from qapi to qobject
References: <20170717155632.12754-1-eblake@redhat.com>
In-Reply-To: <20170717155632.12754-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 10:56 AM, Eric Blake wrote:
> I'm not sure if I'm posted this before, or if it is a cleanup I've
> just been sitting on locally.  In all likelihood, it will miss
> tomorrow's freeze due to lack of review time, and thus be 2.11
> material, but we'll see...

Answering myself, it was part of my larger (mostly-unreviewed) attempt
to rip out dynamic JSON parsing [1]. But it is independent enough that
it warrants its own thread for separate review.

[1] https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05425.html

>=20
> Eric Blake (5):
>   qapi: Add QAPI_TO_QOBJECT() convenience macro
>   nbd: Use simpler QAPI_TO_QOBJECT()
>   nfs: Use simpler QAPI_TO_QOBJECT()
>   qapi: Use simpler QAPI_TO_QOBJECT()
>   blockdev: Use simpler QAPI_TO_QOBJECT()
>=20
>  include/qapi/qobject-output-visitor.h | 19 +++++++++++++++++++
>  block/nbd.c                           |  8 +++-----
>  block/nfs.c                           |  8 +++-----
>  block/qapi.c                          |  7 +++----
>  blockdev.c                            | 13 ++++---------
>  qapi/qobject-output-visitor.c         | 16 ++++++++++++++++
>  6 files changed, 48 insertions(+), 23 deletions(-)

The diffstat is misleading because of the size of the additional
interface and comments.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nuoC4Llk8aCqdnhXkaRaCFKxKDPHmleLO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlls35sACgkQp6FrSiUn
Q2o8Zwf+LTJfFIfmmjOYCE/3KgJ3xzwAhTDjqyvU7Q+NYTxwPsu95YtrgWnKyU54
tGrB1i1/NUyVQHMg9WE4/vCIaWy62KRyrQoB8UXX879YGu8EinJk8IgtKeSWD4kl
d/9k7R3x7Qu+y4rBuowrSMLR1GUHTbIQZEneSYpVMMGmzi6OfcSzgQVh5ffQjT+p
ahjGVTA7tIpFKf7AcicxQYcX/V2PT1QAtfCasWIIVtOknEhR682Dyl/W6mT7vkYI
XFh1jkW1HJMhDV5VoFIkwNn9ur1OzcN9MswHIAsPEjNOnztcj0aBemkYwQvNvfee
5BbbOFy+xAsNOBdCty39ocnsn7DKiw==
=2/+1
-----END PGP SIGNATURE-----

--nuoC4Llk8aCqdnhXkaRaCFKxKDPHmleLO--
