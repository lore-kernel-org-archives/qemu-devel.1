Received: from eggs.gnu.org ([2001:4830:134:3::10]:36587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYAG6-0002aa-Cp
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYAG3-0004Ud-44
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:08:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYAG2-0004U7-Pl
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:08:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B75C8806D0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 12:08:41 +0000 (UTC)
References: <20170720100046.4424-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1749fce5-8f96-f0eb-6f55-40139bb4b6f7@redhat.com>
Date: Thu, 20 Jul 2017 07:08:38 -0500
MIME-Version: 1.0
In-Reply-To: <20170720100046.4424-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="U1QtMq2XfkAvVHAJDdS1thQuIlNhVV5af"
Subject: Re: [Qemu-devel] [PATCH] char-fd: remove useless chr pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U1QtMq2XfkAvVHAJDdS1thQuIlNhVV5af
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1749fce5-8f96-f0eb-6f55-40139bb4b6f7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] char-fd: remove useless chr pointer
References: <20170720100046.4424-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170720100046.4424-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 05:00 AM, Marc-Andr=C3=A9 Lureau wrote:
> Apparently unused since it was introduced in commit
> a29753f8aa79a34a324afebe340182a51a5aef11. Now, it can be trivially
> accessed by CHARDEV() of self.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/chardev/char-fd.h | 2 +-
>  chardev/char-fd.c         | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

As it is a code cleanup and not a bug fix, it may be safer to defer to
this to 2.11.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--U1QtMq2XfkAvVHAJDdS1thQuIlNhVV5af
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllwnUYACgkQp6FrSiUn
Q2rUswgAnQgFBGLAdwpFwUWXmZC2/pvqrs488WxpzdH9ouhSEpbRYwxiXb3Yk3tg
K+z384hmOX+RqpFoBoFRMJgIxAq2k/4tLtwSJfGUp6HyfTjbGNLHHDJm0JANkKvJ
bt1IEi7gUhYipLu74A+ZbfjuWz4jDbOlWOeFTVNR9VbRoP3HrvA9sL3V3UiF3GEZ
YNse+ybsvBJGehfMIT0oYZT+SWqguwJQO60zjtMI+zLy0A3dCiAHrH5FPgF9pqj9
AVKpbXhsV+aEH6W/bs547R6242Ak41WSLQC4eesqUPD3MftXT1NlbH1J++PiGION
2yBnhF5xASaSlA8U5JlTae+u5CCrGQ==
=GSWF
-----END PGP SIGNATURE-----

--U1QtMq2XfkAvVHAJDdS1thQuIlNhVV5af--
