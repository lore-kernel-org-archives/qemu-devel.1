Received: from eggs.gnu.org ([2001:4830:134:3::10]:39963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCt8p-0005yI-IH
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCt8l-0000Tf-Ll
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:37:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCt8l-0000T7-Ca
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:37:15 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-12-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be27430f-d63b-5e2a-6d87-f3753c9a7e26@redhat.com>
Date: Mon, 22 May 2017 14:37:04 -0500
MIME-Version: 1.0
In-Reply-To: <1495186480-114192-12-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CujWjU6pPro8S8NnaINNx4awPJtmLC3oa"
Subject: Re: [Qemu-devel] [PATCH v1 11/13] qcow2-cluster: make
 handle_dependencies() logic easier to follow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, "Denis V . Lunev" <den@openvz.org>, den@virtuozzo.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CujWjU6pPro8S8NnaINNx4awPJtmLC3oa
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, "Denis V . Lunev" <den@openvz.org>, den@virtuozzo.com,
 mreitz@redhat.com
Message-ID: <be27430f-d63b-5e2a-6d87-f3753c9a7e26@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 11/13] qcow2-cluster: make
 handle_dependencies() logic easier to follow
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1495186480-114192-12-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-12-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 04:34 AM, Anton Nefedov wrote:
> Avoid complicated nested conditions; return or continue asap instead.
> The logic is not changed.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  block/qcow2-cluster.c | 45 ++++++++++++++++++++++---------------------=
--
>  1 file changed, 22 insertions(+), 23 deletions(-)
>=20

> =20
> -            /* Stop if already an l2meta exists. After yielding, it wo=
uldn't

As long as you're touching this,


> -            }
> +        /* Stop if already an l2meta exists. After yielding, it wouldn=
't

fix the grammar: s/already an l2meta/an l2meta already/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CujWjU6pPro8S8NnaINNx4awPJtmLC3oa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIz3gAAoJEKeha0olJ0Nqia8H/24h8SOTdTwldBsCFMVqiIVF
jraa1rVdAuPmQtYaxYTCKJ2yke94w7s39wTbnWLu7ouixRk1ZnozQpJ/px5XgtWV
Sn+YRMfoTsjP2SgcPoc5ZfpRNkJ5yADG+B3oVetMicova2ZNPhaUJwwlUv+pP02u
jCB5p69Ec1IyUtNcWhkY84XHAQS6Eo1hAku32+sjRBsRvH8SJgp/wTfjiGM0te2/
r9L5JQlRgrJxO1bm++uUsZkaGXNnpBV8B2T3Bbh3lS63sbtqIB1GRXUsvdZE955o
rKmjQR2k/O3ES+al7C5a6oNs0ipPQ1TAgQSFEBe0wgl5B+Mq13uQkikP2xhX0jI=
=EJAb
-----END PGP SIGNATURE-----

--CujWjU6pPro8S8NnaINNx4awPJtmLC3oa--
