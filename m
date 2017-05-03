Received: from eggs.gnu.org ([2001:4830:134:3::10]:60991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d5usP-0003jA-V5
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d5usM-0007R6-1z
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:03:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d5usL-0007Qb-SD
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:03:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B980D61BB7
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 14:03:28 +0000 (UTC)
Date: Wed, 3 May 2017 15:03:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170503140326.GG14647@stefanha-x1.localdomain>
References: <20170428122444.23361-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UKNXkkdQCYZ6W5l3"
Content-Disposition: inline
In-Reply-To: <20170428122444.23361-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] (RFC) remove the GThread coroutine
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>


--UKNXkkdQCYZ6W5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2017 at 01:24:43PM +0100, Daniel P. Berrange wrote:
> At the 2016 summit it was suggested that we delete the GThread
> coroutine impl since it is not fully functional, and you can
> debug the ucontext impl with our GDB helper script.
>=20
> I don't recall the subject being raised again since the summit
> so here's a proposal to delete the GThread impl, as a way to
> trigger input from anyone who thinks we need to keep it......
>=20
> Daniel P. Berrange (1):
>   coroutine: remove GThread implementation
>=20
>  .travis.yml              |   5 +-
>  configure                |  19 ++---
>  util/coroutine-gthread.c | 198 -----------------------------------------=
------
>  3 files changed, 6 insertions(+), 216 deletions(-)
>  delete mode 100644 util/coroutine-gthread.c
>=20
> --=20
> 2.9.3
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--UKNXkkdQCYZ6W5l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCeMuAAoJEJykq7OBq3PIxS4H/jKWDTixSi+NG5mmEiye1Qlo
NhgjsMnABsZghX+O0PmYk0hEACpEoAjBlSFUY24FPEm0MgLiDvb3JgbtSoNBEgrh
tUduNBVPKCdw+T5B/StMKHL5f0EUTfVJys5ZJltkwu0VL2yOIp7yS5tCj9zOByF2
j5JGyLQyG6n/FVT+bw9P058ufhSlem79LcNrzayZI1+C+Ai7oUSShDSHsi7FrMDm
cWR6dh3mCAHgbkzlmXLBP7DFkiJRI8feRA3OM99QwaYZ/U+9F8fWQUDBoi+KYm3o
1Q87YZohUlKBzfrMmkxgoicuQDZNn/bRSd48seORx7ftJfEWtq10ZbzW5ooOeEU=
=P1Dn
-----END PGP SIGNATURE-----

--UKNXkkdQCYZ6W5l3--
