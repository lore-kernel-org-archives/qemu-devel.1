Received: from eggs.gnu.org ([2001:4830:134:3::10]:39910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGmhX-0002JR-28
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGmhU-0008SC-01
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:33:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGmhT-0008QV-Q0
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:33:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA670142A97
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 13:33:10 +0000 (UTC)
References: <20170601214056.30387-1-quintela@redhat.com>
	<20170601214056.30387-3-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f4e5463f-64b9-b645-d0cf-64c6a2704ef7@redhat.com>
Date: Fri, 2 Jun 2017 08:33:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170601214056.30387-3-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CDVPw9qvFvAtsx4P6imxHacOo8AgOdtDn"
Subject: Re: [Qemu-devel] [PATCH 2/4] ram: We only print throttling
 information sometimes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CDVPw9qvFvAtsx4P6imxHacOo8AgOdtDn
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <f4e5463f-64b9-b645-d0cf-64c6a2704ef7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] ram: We only print throttling
 information sometimes
References: <20170601214056.30387-1-quintela@redhat.com>
 <20170601214056.30387-3-quintela@redhat.com>
In-Reply-To: <20170601214056.30387-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 04:40 PM, Juan Quintela wrote:
> Change it to be consistent with everything else.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CDVPw9qvFvAtsx4P6imxHacOo8AgOdtDn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMWkNAAoJEKeha0olJ0NqTioH/0Z7XlqU1x2LMYHulF4BPmET
N027hqQNr+VaLbPd93N3jXtd/YCxz5YmC6fvvKatudJwDxQsVbW3O89dlX74IrdY
xBv2IBGwFLQ7tgTrK9RloRwNnUd4cwWSO+GkwingaT10lNnaSrLK1csiOfoKSPHL
tkp9Y2uPVgpB+JO3Zp/YAGByyPjbfhAqmdEo6b+kw4+CKuAxBEJcHjFobVezLrNY
XeKhcPirOQOGC4UorHNU8LPk0GLxg3PBnfMa+wavyzkSuFClTfYXx3fhB+grhJes
W7D/4fdVl274aWEWxJyqbY3BYYJctBQKb6h4wMtS3k+jdzBJy0KA6Lh6AAPvbAo=
=lCza
-----END PGP SIGNATURE-----

--CDVPw9qvFvAtsx4P6imxHacOo8AgOdtDn--
