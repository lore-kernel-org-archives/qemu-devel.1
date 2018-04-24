Received: from eggs.gnu.org ([2001:4830:134:3::10]:59904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBJvf-0007lK-3d
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBJvb-0005aY-W2
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:53:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49726 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBJvb-0005aC-QI
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:53:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD74140201AF
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 12:53:39 +0000 (UTC)
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-4-lersek@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f76e0aa-389f-82b8-9bac-8405f51b8d2c@redhat.com>
Date: Tue, 24 Apr 2018 18:11:05 -0500
MIME-Version: 1.0
In-Reply-To: <20180424214550.32549-4-lersek@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dPCY5ckbfM95tqNZ3PFEGL6frDrZQmXXo"
Subject: Re: [Qemu-devel] [PATCH 3/6] qapi: add SysEmuTarget to "common.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, David Gibson <dgibson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dPCY5ckbfM95tqNZ3PFEGL6frDrZQmXXo
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 David Gibson <dgibson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Message-ID: <5f76e0aa-389f-82b8-9bac-8405f51b8d2c@redhat.com>
Subject: Re: [PATCH 3/6] qapi: add SysEmuTarget to "common.json"
References: <20180424214550.32549-1-lersek@redhat.com>
 <20180424214550.32549-4-lersek@redhat.com>
In-Reply-To: <20180424214550.32549-4-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 04:45 PM, Laszlo Ersek wrote:
> We'll soon need an enumeration type that lists all the softmmu targets
> that QEMU (the project) supports. Introduce @SysEmuTarget to
> "common.json".
>=20
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: David Gibson <dgibson@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Kashyap Chamarthy <kchamart@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>=20

> +##
> +{ 'enum' : 'SysEmuTarget',
> +  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32'=
,
> +             'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
> +             'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> +             'ppc64', 'ppcemb', 'riscv32', 'riscv64', 's390x', 'sh4',
> +             'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
> +             'x86_64', 'xtensa', 'xtensaeb' ] }

x86_64 doesn't match our typical conventions of preferring '-' over '_';
also, wikipedia mentions both spellings but under the page name
'x86-64'.  Is it worth switching that enum constant?

https://en.wikipedia.org/wiki/X86-64

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dPCY5ckbfM95tqNZ3PFEGL6frDrZQmXXo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfuYkACgkQp6FrSiUn
Q2ry3wf/QBH/94q01zSETa6SVmzcrwOjXhYJkZgHHfmE54690h5sKliqlD25HYr1
qhT4IRiKJzoOLOh9rD0Pu7oHZ1Alu02mXojIiRqbWcTL1Kn2XniBTnIWtXeWHcIX
EiFtsGdlwjWvVz+hT49xuJhlcfjj0DVXnrgxv/o4FVVRq6vrQm6lo5A8K8PhkL3H
y7di2Nhn5f5OI5oJ1NaY8ColqQLZ2PFmIroAwlTjTSCJ9+Q3BIuVHzyrrdu43LDy
YwM3mLw9SelVp4oDUdxVJFKTEsy+NNIHkAZJIYl/xgyBgvNCwbGhlsEjjXhgQ29k
/2Ui4F2wV04Vc0+YpyYnFdjcLeTOgw==
=gN8e
-----END PGP SIGNATURE-----

--dPCY5ckbfM95tqNZ3PFEGL6frDrZQmXXo--
