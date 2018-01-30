Received: from eggs.gnu.org ([2001:4830:134:3::10]:35928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ega0P-0006WI-QO
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ega0L-0004D6-N1
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:47:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ega0L-0004C8-D4
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:47:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E7EDC0587D1
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 17:47:32 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-11-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7dca2783-d284-8f8a-73b8-a270b2ca6a4d@redhat.com>
Date: Tue, 30 Jan 2018 11:47:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-11-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Om1gUvzlmmoMaNN8r4S7uFlCR8qKpnGGD"
Subject: Re: [Qemu-devel] [PATCH 10/18] Include qapi/qmp/qlist.h exactly
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
--Om1gUvzlmmoMaNN8r4S7uFlCR8qKpnGGD
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <7dca2783-d284-8f8a-73b8-a270b2ca6a4d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/18] Include qapi/qmp/qlist.h exactly where
 needed
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-11-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-11-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> This cleanup makes the number of objects depending on qapi/qmp/qlist.h
> drop from 4548 (out of 4739) to 16 in my "build everything" tree.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/tests/check-qdict.c
> @@ -9,9 +9,11 @@
>   * This work is licensed under the terms of the GNU LGPL, version 2.1 =
or later.
>   * See the COPYING.LIB file in the top-level directory.
>   */
> +
>  #include "qemu/osdep.h"

Another one of these whitespace cleanups around osdep.h that might be
worth collecting into its own patch.

> =20
>  #include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qlist.h"
>  #include "qapi/qmp/qnum.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qapi/error.h"

But at least it was in the same hunk as the actual meat of the commit.

> +++ b/tests/libqtest.c
> @@ -14,6 +14,7 @@
>   * See the COPYING file in the top-level directory.
>   *
>   */
> +
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> =20
> @@ -25,6 +26,7 @@
>  #include "qapi/qmp/json-parser.h"
>  #include "qapi/qmp/json-streamer.h"
>  #include "qapi/qmp/qjson.h"
> +#include "qapi/qmp/qlist.h"
> =20

In contrast to this location.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Om1gUvzlmmoMaNN8r4S7uFlCR8qKpnGGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwr7MACgkQp6FrSiUn
Q2oXuAf/exhcH56aLPkwnkIWKv1P4oFlPOok/1SLXUWUijsleRZlG6B4YqcGfh2F
UKXIsaZlVJ9fK+eHRXLe62LrgxBA/s9s+RdcnudFw9mq2KhOUWcpwBwpBcB/P4AR
XPgksSxYY1UDgKz9m7PbljPwKLrisoapaFT4uskjvIcjHtUYF0mj7B0JcTpxqIpt
Kuv2cM+z/ftmKUm2SYJDDE1+Z64uwyxOXmVkUSFySM4e9qKuB2LV15WDVf7ORxQB
1B/zq5tJp4p2MX1OW+N3lxxWQkSqvoOB2HA9OfJX6JtXO1fARGE8jjfkWi89xn5w
c9smC59sUYtxnZBYup9wl393LNK97w==
=ASSM
-----END PGP SIGNATURE-----

--Om1gUvzlmmoMaNN8r4S7uFlCR8qKpnGGD--
