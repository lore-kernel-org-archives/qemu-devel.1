Received: from eggs.gnu.org ([2001:4830:134:3::10]:41585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzlym-0003mC-8T
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzlyh-0006YQ-NM
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:53:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dzlyh-0006XK-Dp
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:52:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CD3C61469
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 15:52:54 +0000 (UTC)
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-2-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7b27cb2f-6830-6698-4629-a1dd8dc8a08b@redhat.com>
Date: Wed, 4 Oct 2017 10:52:50 -0500
MIME-Version: 1.0
In-Reply-To: <20171004103933.7898-2-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0q0aJkO8dCvCcDkbOUTTXFMW9WfDF3ePV"
Subject: Re: [Qemu-devel] [PATCH 1/6] tests: Add basic migration precopy test
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
--0q0aJkO8dCvCcDkbOUTTXFMW9WfDF3ePV
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <7b27cb2f-6830-6698-4629-a1dd8dc8a08b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] tests: Add basic migration precopy test
References: <20171004103933.7898-1-quintela@redhat.com>
 <20171004103933.7898-2-quintela@redhat.com>
In-Reply-To: <20171004103933.7898-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2017 05:39 AM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/Makefile.include |   3 +
>  tests/migration-test.c | 497 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 500 insertions(+)
>  create mode 100644 tests/migration-test.c

New file; should it be mentioned in MAINTAINERS?

At least you picked a name that matches .gitignore's existing '*.test'
exclusion when the binary is built in-tree.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0q0aJkO8dCvCcDkbOUTTXFMW9WfDF3ePV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnVA9IACgkQp6FrSiUn
Q2ppgggAlywPSHCZDcpLHnhJr1N0zp4NbFDw4ojn9h1xGB9b2g310clfJLjpOj0S
lX7epjx0czcnuLcg23oBJ2hzxf3ixA1IgDOKdQqkiLHZYGaIi4nosQ6axcVbZOWm
afQy0ECJI6uiazCXEUY20YxIlJn+QPBH+8T7srtX659uuCd23Zyxwwe2aKZ8CyHf
/Cch9+TjNI4Ud5i+hHgJiNYzx+fHeB5zl4VkYBCL3J9CQkQaWLhe5xJVPJ2BKWAR
xbYL2Gj2zseDH/YSNha4U8gxHVYGIPPQwjp9ZUd2Xa+JvOimkp6LlZLHaY1tv7zz
Tple6mDPiwlNr4119vyUrgtw9dViTw==
=xr2T
-----END PGP SIGNATURE-----

--0q0aJkO8dCvCcDkbOUTTXFMW9WfDF3ePV--
