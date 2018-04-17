Received: from eggs.gnu.org ([2001:4830:134:3::10]:56104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8VB1-0005RK-Gi
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8VAy-0003bE-99
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:17:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8VAy-0003b3-2A
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:17:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D98A94070208
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 18:17:51 +0000 (UTC)
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<20180417133602.23832-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea5c5be8-2e0f-ed00-8ce1-aee6d6e117d4@redhat.com>
Date: Tue, 17 Apr 2018 13:17:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180417133602.23832-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tt9UumMzyFCv9gvyThCEhW0TSJaOiu8HF"
Subject: Re: [Qemu-devel] [PATCH v5 1/5] qobject: ensure base is at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tt9UumMzyFCv9gvyThCEhW0TSJaOiu8HF
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com
Message-ID: <ea5c5be8-2e0f-ed00-8ce1-aee6d6e117d4@redhat.com>
Subject: Re: [PATCH v5 1/5] qobject: ensure base is at offset 0
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
 <20180417133602.23832-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180417133602.23832-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2018 08:35 AM, Marc-Andr=C3=A9 Lureau wrote:
> All QObject types have the base QObject as first field. This allows to

s/as/as their/

> simplify qobject_to() and will allow further simplification in

s/allows to simplify/allows the simplification of/
s/in/in the/

> following patch.

Might also be worth mentioning that this explicitly guarantees that
existing casts work correctly (even though we'd prefer to get rid of
such casts in any location except the qobject.h macros); Markus pointed o=
ut:

>> Uh, there's another reason: existing type casts from QObject * to
>> subtypes.  I just spotted one in tests/check-qdict.c:
>>=20
>>     dst =3D (QDict *)qdict_crumple(src, &error_abort);


> +++ b/qobject/qobject.c
> @@ -16,6 +16,15 @@
>  #include "qapi/qmp/qlist.h"
>  #include "qapi/qmp/qstring.h"
> =20
> +QEMU_BUILD_BUG_MSG(
> +    offsetof(QNull, base) !=3D 0 ||

Is the ' !=3D 0' portion necessary?  Style-wise, I'd have avoided it, but=

HACKING doesn't forbid it, so I'm fine if you leave it.

With the commit message further improved,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tt9UumMzyFCv9gvyThCEhW0TSJaOiu8HF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWOkoACgkQp6FrSiUn
Q2qr9gf+OcHeU7nqyOJ/+SkyVUw8qqMJKRfnLkmGPi4M273rRK1B8qvOimpTY5oN
xkYes9qtYMZQ1nWi8KPZhwiZ2DLyaGNpjOQDklRAHT9RZqHu4qww9CuIxYmsT/DO
lEMCkAK4FRCawhVWN4raN06XbnqB77lkRCZKZEZqYj6LXOgcUxRvaHClCMw/ofll
HE0tyfXHLwyC4rvZK7/uSGtNHD8ov14jfp4oBwnSCJL1rOGNtFDe2jdH8SQjOLD5
dlbezRIJrOHOODMOx3D6pqUlbwzSpEF99SyhJSIYd7uLfUEBSpWdpvmGwE26trm0
BQEximUrx49jjikRSYNf7R73Z5JB/A==
=1SHK
-----END PGP SIGNATURE-----

--tt9UumMzyFCv9gvyThCEhW0TSJaOiu8HF--
