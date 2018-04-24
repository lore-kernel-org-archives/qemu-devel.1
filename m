Received: from eggs.gnu.org ([2001:4830:134:3::10]:57997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB5We-0007Yj-Ks
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB5Wd-0001B9-PJ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:31:00 -0400
References: <20180424152515.25664-1-kwolf@redhat.com>
	<20180424152515.25664-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6fddb704-b549-4b92-17e8-c5172926f441@redhat.com>
Date: Tue, 24 Apr 2018 16:30:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180424152515.25664-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BmFWCclRSxFjL2h4VV1w1YTO13vaWMbQQ"
Subject: Re: [Qemu-devel] [RFC PATCH 03/33] blockjob: Implement
 block_job_set_speed() centrally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BmFWCclRSxFjL2h4VV1w1YTO13vaWMbQQ
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <6fddb704-b549-4b92-17e8-c5172926f441@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 03/33] blockjob: Implement
 block_job_set_speed() centrally
References: <20180424152515.25664-1-kwolf@redhat.com>
 <20180424152515.25664-4-kwolf@redhat.com>
In-Reply-To: <20180424152515.25664-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 10:24 AM, Kevin Wolf wrote:
> All block job drivers support .set_speed and all of them duplicate the
> same code to implement it. Move that code to blockjob.c and remove the
> now useless callback.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/include/block/blockjob.h
> @@ -29,6 +29,8 @@
>  #include "block/block.h"
>  #include "qemu/ratelimit.h"
> =20
> +#define SLICE_TIME 100000000ULL /* ns */

I know this is just code motion; but would it be any more legible as:

#define SLICE_TIME (100ULL * 1000 * 1000) /* ns */

to make it easier to see as 100 ms without having to count the 0s?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BmFWCclRSxFjL2h4VV1w1YTO13vaWMbQQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfogQACgkQp6FrSiUn
Q2qiDAf/apD9S1z8G2rCqBOVNtsJGltIfhUZdirmDEH6ARg0Z6EX4PTSv5MdzDFY
aQOuxuqVPLrBlYWzlRDaTl3Z7bmONDAfN0iIsGBy7c+0SQouhbnyKQyEQa/zZiNp
zDA0NbdhtZMcghdnW4+RzStZU3IhlbKNAARHmFHav+oNs+EY5g08S9MRdsOc3KHu
g5lByh4zI9lwK8BWk18+ywP0icma7biuN99GPrC+YvPkcGZ6A0LdDx9pGAWm40Y3
VQoHoBde+oc4aXdIGp6QQtYYlzclLmsNUyNraxW4UmhCHWQZflwbLlqGDnsHfQLL
VY+NT+P9jRzLlXNkkPSWiJjprEgc0A==
=YNmK
-----END PGP SIGNATURE-----

--BmFWCclRSxFjL2h4VV1w1YTO13vaWMbQQ--
