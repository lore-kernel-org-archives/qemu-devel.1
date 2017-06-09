Received: from eggs.gnu.org ([2001:4830:134:3::10]:49055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJHRo-0000DN-IZ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJHRl-0000gY-HA
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:47:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dJHRl-0000f7-5c
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:47:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1270C0587DB
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 10:47:14 +0000 (UTC)
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<1496980142-8986-7-git-send-email-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b940fab8-7069-000a-acc7-88d70844c21c@redhat.com>
Date: Fri, 9 Jun 2017 05:47:09 -0500
MIME-Version: 1.0
In-Reply-To: <1496980142-8986-7-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LlD3kTe5dlDKJqk7ASTcdBxGwenpqdKAP"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] migration: move skip_section_footers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LlD3kTe5dlDKJqk7ASTcdBxGwenpqdKAP
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Message-ID: <b940fab8-7069-000a-acc7-88d70844c21c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] migration: move skip_section_footers
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
 <1496980142-8986-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1496980142-8986-7-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2017 10:49 PM, Peter Xu wrote:
> Move it into MigrationState, with a property binded to it. Same trick i=
s

s/binded/bound/

> played like previous patches.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LlD3kTe5dlDKJqk7ASTcdBxGwenpqdKAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOnytAAoJEKeha0olJ0NqjhUH/iTcdnhLVOHkFU/lwIuiDVfL
ymSvT5U8oVNoPgwnmlS+z2YTiTsH4beWeC3SIbwVITcVrmHP8RWOU0fB+Hu9KMQv
EPW7qJUpE3M+L0lD3oX7m0KimvDEO//uIY0VYYuZjtnq3XeNPAxNDjYkggy+OZmo
/c2c6BgTFd5V+H9oogLDUNrQoBi6Y65UhxKRzn8sj128xDjd6wQR1+2OBwk91B9V
QA9XV8cXDTY/QAsUAW3GPBRxcKKrzirvaWROjN61nSNpGnSq5nA29FQCRvkn3SoX
5HZVllwJuE8rLx1J+nluq0AOsBAaf3hBZJNZOg5F0EiLX8ATkq/C76sCfUGpeK8=
=AYzT
-----END PGP SIGNATURE-----

--LlD3kTe5dlDKJqk7ASTcdBxGwenpqdKAP--
