Received: from eggs.gnu.org ([2001:4830:134:3::10]:48645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPoTC-0007y7-LO
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPoT8-0007Dr-4f
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:15:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPoT7-0007DZ-RX
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:15:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE3E9C045772
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 11:15:40 +0000 (UTC)
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-7-git-send-email-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9f1a393d-9cef-e18a-3336-91ded86f6afa@redhat.com>
Date: Tue, 27 Jun 2017 06:15:37 -0500
MIME-Version: 1.0
In-Reply-To: <1498536619-14548-7-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wNRmtqJnRHIhtQcbUtiGHnUoC8DBr0eVg"
Subject: Re: [Qemu-devel] [PATCH v6 06/10] migration: move only_migratable
 to MigrationState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wNRmtqJnRHIhtQcbUtiGHnUoC8DBr0eVg
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <9f1a393d-9cef-e18a-3336-91ded86f6afa@redhat.com>
Subject: Re: [PATCH v6 06/10] migration: move only_migratable to
 MigrationState
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
 <1498536619-14548-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1498536619-14548-7-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/26/2017 11:10 PM, Peter Xu wrote:
> One less global variable, and it does only matter with migration.
>=20
> We keep the old "--only-migratable" option, but also now we support:
>=20
>   -global migration.only-migratable=3Dtrue

Does command line introspection work to see that this new spelling is
available?  If not, what else can we do to let libvirt learn that the
new form is preferred?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wNRmtqJnRHIhtQcbUtiGHnUoC8DBr0eVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUj5ZAAoJEKeha0olJ0Nq6KwH/3Kc23vw3PR2P8CQu2Pe7150
LjKpUjmwTJJrg80ZKAy2is5S1w2d8r765mkAwrNUvy55maUd0bd8o1ah3NRBtcyM
vYsPKP65ppR0WH3hKLS/vkFd7RZrgXL2fKLm0Fq/cDVUe7hVaWYSzCr9PrMkoD+X
qpvjcqtynTACDBnvRznp07bU0I1OXc7cGbMo/XxxmTKQu+5y3+P9xD8s3ckE47u0
Vnb2rduIFM/f3JiKuw06hWQjZthuK507xHrp+G5/q1AuujycRh+JFBtuKndPvl+m
iiJ2FBRF5xcDB5R7/qT+TzQuCSmwFUEHEkMfJ7GCOQzLUygWC5+gAVuCs27NjR4=
=e6iv
-----END PGP SIGNATURE-----

--wNRmtqJnRHIhtQcbUtiGHnUoC8DBr0eVg--
