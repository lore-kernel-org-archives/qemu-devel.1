Received: from eggs.gnu.org ([2001:4830:134:3::10]:33238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egY7O-000084-Hs
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egY7K-0004Kp-Kw
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:46:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egY7K-0004JA-1d
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:46:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4883E7653B
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 15:46:37 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32879051-3924-b8ec-d2e9-5765d1bb6ac8@redhat.com>
Date: Tue, 30 Jan 2018 09:46:34 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-3-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LqGwhMpIBk411INO2SjJ9L5f9czVLzNhH"
Subject: Re: [Qemu-devel] [PATCH 02/18] Drop superfluous includes of
 qapi-types.h
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
--LqGwhMpIBk411INO2SjJ9L5f9czVLzNhH
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <32879051-3924-b8ec-d2e9-5765d1bb6ac8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/18] Drop superfluous includes of
 qapi-types.h
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-3-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/tests/test-clone-visitor.c
> @@ -11,7 +11,6 @@
> =20
>  #include "qemu-common.h"
>  #include "qapi/clone-visitor.h"
> -#include "test-qapi-types.h"

Overactive sed pattern?  This is a different header.  While the tests
still pass after deleting this include, removal of the test-qapi-types.h
line here and in other tests/ files should be a separate patch, or else
the commit message updated to mention it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LqGwhMpIBk411INO2SjJ9L5f9czVLzNhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwk1oACgkQp6FrSiUn
Q2osTwf7Bypu6ujNDMPnzQ7fcMaMUSQN+NI22uJmS7T7v4e3Q+7JwnGk5q4knTok
/8Y5d9527iZNI6DGWJM8jXB2UQbYcMb+Oa1boGUBX5ilypvMFbXaPPmCg/HsVymn
pqTWJltJOchogCv6C3x8wMmk2NWAP/pI32r28xZP6F0+Dz/hQ0i2XpJe2PRYgeIL
4sezhxNQX42ro85KkAnhDKJWOWhs/zDDeMQvMQaJ+wCyBTnbH/PjoTo7s2wWEJ8F
vvVUAf+/Vx9bIqJTMoA0xBlUzQwEpYqXq/L4faKiLVh7RhXrKx+ed1fvZ27a8q7c
BAMMlbh9zVlPIeWQHyISwzaMCzTiJQ==
=0m7c
-----END PGP SIGNATURE-----

--LqGwhMpIBk411INO2SjJ9L5f9czVLzNhH--
