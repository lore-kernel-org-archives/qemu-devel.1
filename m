Received: from eggs.gnu.org ([2001:4830:134:3::10]:60831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYtT-00034Y-NC
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYtQ-0006nS-JI
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:27:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYYtQ-0006n1-AP
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:27:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50EE2491
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:26:59 +0000 (UTC)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c974c7c1-5c0e-19fc-4c3d-babe406d5eac@redhat.com>
Date: Fri, 21 Jul 2017 09:26:57 -0500
MIME-Version: 1.0
In-Reply-To: <1500645206-13559-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FLpepTPB0tPlruVJdDa4UuApjwfRAbgEx"
Subject: Re: [Qemu-devel] [PATCH 3/9] tests: Pass literal format strings
 directly to qmp_FOO()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FLpepTPB0tPlruVJdDa4UuApjwfRAbgEx
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <c974c7c1-5c0e-19fc-4c3d-babe406d5eac@redhat.com>
Subject: Re: [PATCH 3/9] tests: Pass literal format strings directly to
 qmp_FOO()
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
 <1500645206-13559-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 08:53 AM, Markus Armbruster wrote:
> The qmp_FOO() take a printf-like format string.  In a few places, we
> assign a string literal to a variable and pass that instead of simply
> passing the literal.  Clean that up.
>=20
> Bonus: gets rid of non-literal format strings.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/ahci-test.c | 4 +---
>  tests/ide-test.c  | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FLpepTPB0tPlruVJdDa4UuApjwfRAbgEx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyDzEACgkQp6FrSiUn
Q2rwRwf+IhWpLv83p7t3wp7QYlzhqulyCS43MtDMeLV4XjwHqHDCLkpmGZCjjiQ7
wXPW1qjMbg25o08F+BEdHmxXbq1i8wgxitg5MTc2Q1p3MQoxox012LMtiQ2reRIp
Aa6iCDtZP1xdtSKd7Dj1JsiWoAwqa4RwfFrYj4pJoakIKhVXHWCKjUGFC4xXW9uz
iwGZeqdpEj71jkhLDem7JtEVDzF4gTvXRJC86P2LwZGaXFtk8i7MeTpzWGoZjFYt
tgXieeAvoeOM9Y5lG3r/jr9iQ4KZ9u22KiDGK5BS7qp9wkJaBU7Mh1/wO+21MO0Z
nzrx4xl0E0a38dT/UTpNs1/qpHs/Cg==
=Me/o
-----END PGP SIGNATURE-----

--FLpepTPB0tPlruVJdDa4UuApjwfRAbgEx--
