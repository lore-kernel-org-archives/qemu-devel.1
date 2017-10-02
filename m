Received: from eggs.gnu.org ([2001:4830:134:3::10]:51025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz1pQ-0007MW-1z
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz1pK-0000k2-Hm
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:36:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dz1pK-0000io-AH
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:36:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E5C013204
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:36:09 +0000 (UTC)
References: <150694455954.126.4260615671927745603@b58463cdfd5f>
From: Eric Blake <eblake@redhat.com>
Message-ID: <37ea08c6-ec95-2ab6-13dd-db9d270bfe5a@redhat.com>
Date: Mon, 2 Oct 2017 09:36:03 -0500
MIME-Version: 1.0
In-Reply-To: <150694455954.126.4260615671927745603@b58463cdfd5f>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AMWveMJ5VfLjAVrjVGEd3vG6DTs1nx4oj"
Subject: Re: [Qemu-devel] [PULL 0/3] QAPI patches for 2017-10-02
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com
Cc: famz@redhat.com
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AMWveMJ5VfLjAVrjVGEd3vG6DTs1nx4oj
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, armbru@redhat.com
Cc: famz@redhat.com
Message-ID: <37ea08c6-ec95-2ab6-13dd-db9d270bfe5a@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/3] QAPI patches for 2017-10-02
References: <150694455954.126.4260615671927745603@b58463cdfd5f>
In-Reply-To: <150694455954.126.4260615671927745603@b58463cdfd5f>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 06:42 AM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below =
for
> more information:
>=20

> Checking PATCH 2/3: watchdog.h: Drop local redefinition of actions enum=
=2E..
> ERROR: braces {} are necessary for all arms of this statement
> #57: FILE: hw/watchdog/watchdog.c:86:
> +    if (action < 0)
> [...]

Pre-existing problem, but would indeed be easy to fix up as part of this
series.  I don't know if that means Markus should respin the pull request=
?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AMWveMJ5VfLjAVrjVGEd3vG6DTs1nx4oj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSTtMACgkQp6FrSiUn
Q2omPAf+NDDO5JlVQgl7DyW4+W13czOAFZzrWo5f+s1dXXTlGEiHyEj7H/AIS6id
b78RLLqZxxKUmlu9Gs+gpuocwMWk4/Vwj2MmKDcENQqsP/bMBD4Ch/jAvRMPdY62
WT+NAR87duCGucdTZNbFEp9mp0M323IZ94wU5IQ373fac4DLRpVYRAMkvRc0Zsmj
1WxgcvxYkVWRV4sN7TbZhOaVsrykom8TVWauMVf2hNjQjX++vxkUJIjhUuD6Pa2q
XGKwtogxsPxOJPp78zr9au80nGRtuICv96U/Q6EGLkeJR6fRgaiceYghAXqIpsGW
bIumZru7aTvCbRsW/mLHt0F0AO1kEA==
=PSq8
-----END PGP SIGNATURE-----

--AMWveMJ5VfLjAVrjVGEd3vG6DTs1nx4oj--
