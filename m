Received: from eggs.gnu.org ([2001:4830:134:3::10]:52710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egaAl-0005RB-IX
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egaAI-0007Tr-O6
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:58:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egaAI-0007S5-C1
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:57:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6017F72668
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 17:57:49 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-14-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <276c8085-0327-c270-574a-a66f21128870@redhat.com>
Date: Tue, 30 Jan 2018 11:57:48 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-14-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KVzP76wojVHPcke9OQKo04xLlYDanKYit"
Subject: Re: [Qemu-devel] [PATCH 13/18] Include qapi/qmp/qbool.h exactly
 where needed
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
--KVzP76wojVHPcke9OQKo04xLlYDanKYit
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <276c8085-0327-c270-574a-a66f21128870@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/18] Include qapi/qmp/qbool.h exactly where
 needed
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-14-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-14-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block.c                        | 1 -
>  block/blkdebug.c               | 1 -
>  block/curl.c                   | 1 -
>  block/qcow2.c                  | 1 -
>  block/quorum.c                 | 1 -
>  block/vvfat.c                  | 1 -
>  hw/usb/xen-usb.c               | 1 -
>  monitor.c                      | 1 -
>  qemu-img.c                     | 1 -
>  qemu-io.c                      | 1 -
>  target/s390x/cpu_models.c      | 1 -
>  tests/check-qlit.c             | 1 -
>  tests/device-introspect-test.c | 1 -
>  ui/spice-core.c                | 1 -
>  14 files changed, 14 deletions(-)

All deletions =3D=3D fun patch

(Obviously, the header is still in use, but your earlier patches in the
series fixed the other .c files that actually need the header, and
weren't already including it, as side effects of cleaning other messes)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KVzP76wojVHPcke9OQKo04xLlYDanKYit
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwshwACgkQp6FrSiUn
Q2q+Bgf9ELbHC4VM9hw9D2jRNySABMpZhRKPyXPJwjd7i7Ar5rh4IVC+gIYNX4O1
JM6sFeANdkV0FzdK1jlJd8iy13QPwQErLJy4mPPZ0tCXCU/mV668a64quoxXUCVa
gFWT8Or3BiP7RMBRYZNH+3BBhQZY5JGGB6SyWGhPlHyhcEKGauw5uUdw557MW1vi
9SzsiJo2X9TYi19TLA1fRlz6Ji9Z939e/RWBlumnUlzaNpg+lO9B2f6VL3N+b89/
HXb8CjoAblct6MNk75wQi4i/AfxZu7oULVBj0SzzuIylra8aRR4mEs25swOWJIv0
VrUJItML0LlTe/ASk5PGJNMTy6WQJA==
=sxD/
-----END PGP SIGNATURE-----

--KVzP76wojVHPcke9OQKo04xLlYDanKYit--
