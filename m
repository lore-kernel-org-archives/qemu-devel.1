Received: from eggs.gnu.org ([2001:4830:134:3::10]:57063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db7dy-00085T-IY
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db7dx-0001OS-LB
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:57:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1db7dx-0001OB-Bj
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:57:37 -0400
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-17-git-send-email-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9cd34bf7-b744-f04d-a91b-26442a648b2d@redhat.com>
Date: Fri, 28 Jul 2017 10:57:12 -0500
MIME-Version: 1.0
In-Reply-To: <1501229198-30588-17-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jmmnFO3nWlmwUECO2PdqGUUxiBM8KAb0e"
Subject: Re: [Qemu-devel] [RFC 16/29] qmp: hmp: add migrate "resume" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jmmnFO3nWlmwUECO2PdqGUUxiBM8KAb0e
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <9cd34bf7-b744-f04d-a91b-26442a648b2d@redhat.com>
Subject: Re: [Qemu-devel] [RFC 16/29] qmp: hmp: add migrate "resume" option
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
 <1501229198-30588-17-git-send-email-peterx@redhat.com>
In-Reply-To: <1501229198-30588-17-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 03:06 AM, Peter Xu wrote:
> It will be used when we want to resume one paused migration.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hmp-commands.hx       | 7 ++++---
>  hmp.c                 | 4 +++-
>  migration/migration.c | 2 +-
>  qapi-schema.json      | 5 ++++-
>  4 files changed, 12 insertions(+), 6 deletions(-)
>=20

> +++ b/qapi-schema.json
> @@ -3208,6 +3208,8 @@
>  # @detach: this argument exists only for compatibility reasons and
>  #          is ignored by QEMU
>  #
> +# @resume: resume one paused migration

Mention default false, and that it is since 2.11.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jmmnFO3nWlmwUECO2PdqGUUxiBM8KAb0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7XtgACgkQp6FrSiUn
Q2qVCggAozH/QQhz2y2zF7djUotJhQY04uWOnw9QViyNPEsIgoQ/IW846f8YasoH
7gqg7P8jw1J5diwCPjHBWCzCIDuAdGn+TPr49Yi2LHSOz9poQb3sgqoSLdWyqobU
9x4Y6uJtFJ3HUoRhk86x39iAJ/ZD8svQX+IogPqLBZrnpDRGkIyIJiIHYGAKutYs
aHk1GvvGpJvpYGuOElc8tHl7IVlX0HiALPnbD2R4Q1TUINQtSdRVwQT5obFHWuRE
ceC6oTEyHYGUl0Lilojej3h3w/kWfiN6PEwRcsliIK5jg9OpU7F5xfH4/m4xxJi0
tJp5VpDg9sQhvyoFYTu4P+aDido65g==
=ZXt4
-----END PGP SIGNATURE-----

--jmmnFO3nWlmwUECO2PdqGUUxiBM8KAb0e--
