Received: from eggs.gnu.org ([209.51.188.92]:59676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3K9H-0001ar-Gd
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3JqZ-0003n5-4o
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:16:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h3JqY-0003lr-Qe
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:15:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E560C4EB7
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 12:10:10 +0000 (UTC)
References: <20190309004826.9027-1-lersek@redhat.com>
	<20190309004826.9027-8-lersek@redhat.com>
	<137d7a76-5d69-6b8c-a048-c296849fec9e@redhat.com>
	<f218fbf9-12c6-96a0-09e7-c496388728a5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77c54650-7d51-1bce-7974-896ac5801a00@redhat.com>
Date: Mon, 11 Mar 2019 07:09:57 -0500
MIME-Version: 1.0
In-Reply-To: <f218fbf9-12c6-96a0-09e7-c496388728a5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XuUqmvu72FT6I69QH1OqpxQEJLvycODtd"
Subject: Re: [Qemu-devel] [PATCH 07/10] roms: build edk2 firmware binaries
 and variable store templates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, kraxel@redhat.com, mst@redhat.com
Cc: berrange@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XuUqmvu72FT6I69QH1OqpxQEJLvycODtd
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, kraxel@redhat.com, mst@redhat.com
Cc: berrange@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org
Message-ID: <77c54650-7d51-1bce-7974-896ac5801a00@redhat.com>
Subject: Re: [PATCH 07/10] roms: build edk2 firmware binaries and variable
 store templates
References: <20190309004826.9027-1-lersek@redhat.com>
 <20190309004826.9027-8-lersek@redhat.com>
 <137d7a76-5d69-6b8c-a048-c296849fec9e@redhat.com>
 <f218fbf9-12c6-96a0-09e7-c496388728a5@redhat.com>
In-Reply-To: <f218fbf9-12c6-96a0-09e7-c496388728a5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/10/19 10:10 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Laszlo,
>=20
> On 3/9/19 5:48 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 3/9/19 1:48 AM, Laszlo Ersek wrote:
>>> Add the "efi" target to "Makefile".
>>>

>>> +
>>> +toolchain =3D $(shell source ./edk2-funcs.sh && qemu_edk2_get_toolch=
ain $(1))
>=20
> Well I finally figured out why building on Ubuntu fails. It default
> shell is dash, and 'source' is a bash builtin command. The portable
> equivalent is '.' (dot).
>=20
> The fix is:
>=20
> -- >8 --
> -toolchain =3D $(shell source ./edk2-funcs.sh && qemu_edk2_get_toolchai=
n $(1))
> +toolchain =3D $(shell . ./edk2-funcs.sh && qemu_edk2_get_toolchain $(1=
))

Ouch - this changes my analysis in 1/10, where I argued that since the
file was only ever sourced by a bash script, its use of 'local' was
okay. Now that you are also sourcing it from /bin/sh via Makefile, you
HAVE to make edk2-funcs.sh portable to POSIX shell, by eliminating use
of 'local'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--XuUqmvu72FT6I69QH1OqpxQEJLvycODtd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyGUBUACgkQp6FrSiUn
Q2qZWAgAn6Va+8yT16aaVvp57xNgtr0ExYg2np6VvcM0IUVisjw2GViJ9w1Lg3gb
Zmj//fX43arVScwQmvp3hz/kXerKLVwY+SFu/nWOA6PLVeUPJYAmsISDbEbvTCQD
pixZ8HGvtPNbiGT+b+CooojabKboH+l2ENrJ/W9GnVK890kA4qoYkAEF9QAiLZPb
kOK3Jy/y1eQ4pMdujdDYlcUTzZkW9PHB08rZAoLjwcsunOwX0/ZKctnJtJM/aA65
97NcEoMpxovQKN/XW2wuptiLataO79r9V3NpyjIt1XJsqePGDo8IryzhEswswt/A
71T+dqj/Jfb6qLEprnNK+apDAI9yfQ==
=JEIy
-----END PGP SIGNATURE-----

--XuUqmvu72FT6I69QH1OqpxQEJLvycODtd--
