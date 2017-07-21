Received: from eggs.gnu.org ([2001:4830:134:3::10]:46724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZS6-00073o-IT
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZS2-0003ul-Lf
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:02:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYZS2-0003uY-C0
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:02:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B0D14E33A
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 15:02:45 +0000 (UTC)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-9-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac1e24e3-a98f-3a56-8463-e3022a1b4695@redhat.com>
Date: Fri, 21 Jul 2017 10:02:43 -0500
MIME-Version: 1.0
In-Reply-To: <1500645206-13559-9-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ff0N6rXKTn9TKsd7OwelsDjSJ9dUTJ3vN"
Subject: Re: [Qemu-devel] [PATCH 8/9] tests/libqtest: Clean up how we read
 the QMP greeting
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
--Ff0N6rXKTn9TKsd7OwelsDjSJ9dUTJ3vN
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <ac1e24e3-a98f-3a56-8463-e3022a1b4695@redhat.com>
Subject: Re: [PATCH 8/9] tests/libqtest: Clean up how we read the QMP greeting
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
 <1500645206-13559-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 08:53 AM, Markus Armbruster wrote:
> qtest_init() still uses the qtest_qmp_discard_response(s, "") hack to
> receive the greeting, even though we have qtest_qmp_receive() since
> commit 66e0c7b.  Put it to use.
>=20
> Bonus: gets rid of an empty format string.  A step towards
> compile-time format string checking without triggering
> -Wformat-zero-length.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ff0N6rXKTn9TKsd7OwelsDjSJ9dUTJ3vN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyF5MACgkQp6FrSiUn
Q2qAiAgAnauAEwe95+2A7C3M2WFTBHFjpV5pcpzHLVVSL9yDWI2aO9Th3+a/QK1B
xWX1wnIHcH25nPqOkj9+nuSmk1BppbQWii7LRkVo4IQCv8ZowYwG7G8oZ0jKYrLC
je4wvAA8AZIPwcWEqFF6TLNKmjMMeEzQgbePBYeJmIcI+Bs3AJ1mlYA/NAic9bwZ
BXhbxbUrUg1CCMvwh7UUiiwBG84Kq+j14R9A/omFuFuTgNaY0KjB6rcEjcHYxvBA
qKBbourD/nGLWASJ6VaiJZwJj8xoxzvveihWvVA2Guw3dwG9BzFolJyEiyfh/I/4
VCSAtWNJVjnGaVu8trwyTYfpEEbiDw==
=3FJU
-----END PGP SIGNATURE-----

--Ff0N6rXKTn9TKsd7OwelsDjSJ9dUTJ3vN--
