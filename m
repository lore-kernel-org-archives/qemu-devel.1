Received: from eggs.gnu.org ([2001:4830:134:3::10]:41931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBmYi-00089v-ID
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBmYf-0002Lz-Dm
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:28:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBmYf-0002La-7T
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:27:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B69F581A88D6
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 19:27:52 +0000 (UTC)
References: <20180426183404.3756-1-lersek@redhat.com>
	<20180426183404.3756-3-lersek@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1addfd3-f3c2-06da-10a8-73f76c441be5@redhat.com>
Date: Thu, 26 Apr 2018 14:27:49 -0500
MIME-Version: 1.0
In-Reply-To: <20180426183404.3756-3-lersek@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Tvctswkpr5D4EfE5zxqIiVENutraSzuK1"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qapi: add SysEmuTarget to
 "common.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tvctswkpr5D4EfE5zxqIiVENutraSzuK1
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <c1addfd3-f3c2-06da-10a8-73f76c441be5@redhat.com>
Subject: Re: [PATCH v2 2/4] qapi: add SysEmuTarget to "common.json"
References: <20180426183404.3756-1-lersek@redhat.com>
 <20180426183404.3756-3-lersek@redhat.com>
In-Reply-To: <20180426183404.3756-3-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 01:34 PM, Laszlo Ersek wrote:
> We'll soon need an enumeration type that lists all the softmmu targets
> that QEMU (the project) supports. Introduce @SysEmuTarget to
> "common.json".
>=20
> The enum constant @x86_64 is not spelled @x86-64 because the correspond=
ing
> emulator is called qemu-system-x86_64.
>=20
> Like other enum types, @SysEmuTarget too can be used for discriminator
> fields in unions. For the @i386 constant, a C-language union member cal=
led
> "i386" would be generated. On mingw build hosts, "i386" is a macro
> however. Add "i386" to "polluted_words" at once.
>=20
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---

> +++ b/qapi/common.json

> +
> +##
> +# @SysEmuTarget:
> +#
> +# The comprehensive enumeration of QEMU system emulation ("softmmu")
> +# targets. Run "./configure --help" in the project root directory, and=

> +# look for the *-softmmu targets near the "--target-list" option. The
> +# individual target constants are not documented here, for the time
> +# being.
> +#
> +# Notes: @x86_64 doesn't match the QAPI convention of preferring hyphe=
n
> +#        ("-") over underscore ("_"). This is intentional; the
> +#        @SysEmuTarget constants are supposed to produce QEMU executab=
le
> +#        names when stringified and appended to the "qemu-system-"
> +#        prefix. Put differently, the replacement text of the
> +#        TARGET_NAME preprocessor macro must be possible to look up in=

> +#        the list of (stringified) enum constants.

I think the Notes: goes a little bit deep into implementation details,
considering that it is part of the user-facing documentation.  Maybe it
is sufficient to shorten to just:

Notes: The resulting QMP strings can be appended to the "qemu-system-"
prefix to produce the corresponding QEMU executable name.

and maybe add:

This is true even for "qemu-system-x86_64".

and leave the rest for the commit message.

Everything else looks good, so depending on what happens to the Notes
section after other reviewers have chimed in, you can probably add:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Tvctswkpr5D4EfE5zxqIiVENutraSzuK1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlriKDUACgkQp6FrSiUn
Q2ra2wf+PDhkdSvYzhC3cmtB8UOVcWiuuxO+3x28yPlPG1BRVdwjTqGglmyzCurz
pt13T3YFyqJ77Qr1hGEfawjm/oXQZP9QQRWQRnDaeJ6/d+20L8+ruhQag3m3Gj+g
YFEtMprCUzYv+I+MkQTMTxCqtCccsKsbiozE4GdLSbJi3h56oUy+t1BpCHES2rWt
PyRL7YjGCfK5CXqxvTvOgacqHahRAv41zT8PN7x0DD23bNRxWEMufnAWeud5NHO8
cxnGkOvANdmmVJIBiANjWiDP0FMgmiVgGWC+uv1qD+gg+04026xkWAgxoxENtlRQ
f42fns5d1XFqEgtnR2M7Z9MW5iIeFA==
=ok6N
-----END PGP SIGNATURE-----

--Tvctswkpr5D4EfE5zxqIiVENutraSzuK1--
