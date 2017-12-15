Received: from eggs.gnu.org ([2001:4830:134:3::10]:42423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePutc-0005Aa-T9
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePutZ-0002xI-Lt
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:39:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ePutZ-0002wZ-CO
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:39:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 853E6356C1
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 18:39:40 +0000 (UTC)
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-13-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <74e47991-54f2-cc80-3bb4-4ccc3d11e141@redhat.com>
Date: Fri, 15 Dec 2017 12:39:33 -0600
MIME-Version: 1.0
In-Reply-To: <20171215150659.1811-13-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rAb1A95L8u2Il7qhQ9SGjsRsus33QxpC3"
Subject: Re: [Qemu-devel] [PATCH v2 12/13] ucontext: annotate coroutine
 stack for ASAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rAb1A95L8u2Il7qhQ9SGjsRsus33QxpC3
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <74e47991-54f2-cc80-3bb4-4ccc3d11e141@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 12/13] ucontext: annotate coroutine stack
 for ASAN
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
 <20171215150659.1811-13-marcandre.lureau@redhat.com>
In-Reply-To: <20171215150659.1811-13-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 09:06 AM, Marc-Andr=C3=A9 Lureau wrote:
> It helps ASAN to detect more leaks on coroutine stacks, as found in
> the following patch.
>=20
> A similar work would need to be done for sigaltstack & windows fibers
> to have similar coverage. Since ucontext is prefered, I didn't bother

s/prefered/preferred/

> checking the other coroutine implementations for now.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qemu/compiler.h   |  4 ++++
>  util/coroutine-ucontext.c | 46 +++++++++++++++++++++++++++++++++++++++=
+++++++
>  2 files changed, 50 insertions(+)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rAb1A95L8u2Il7qhQ9SGjsRsus33QxpC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlo0FuUACgkQp6FrSiUn
Q2oEaQgAm8N16p80Lv2EvBMKc9fEh7Nih5NOxzfGgfiRGpGXf4wBIxPzdNnScwGb
/zB8Op8Dc3bkg5kE6s3avuiE4+gvd55wcgqOvFw6Pn+EUlBWRd25GOegZmGerpfA
ZZQwogL2yme02Rzwre9eKsPJSXr7OSqVBUGzXSoLxV94loPopA5H2hUJuiCFVRx5
YWP+aqH4fEEVpBsMLAevos0Q8JlrsAANFt3IcWAmNlKvHpFRjGmw8MYO/EOy1j0n
0190FHDgEyn8VWW5aguxV4ZXtpZ24IAHQ84PaxkMBcgNT0zGLVxEvaTguRZmrBsP
A2ZQ9g8rhOVZHRqO2cBDCzxKwZzQBQ==
=3v9r
-----END PGP SIGNATURE-----

--rAb1A95L8u2Il7qhQ9SGjsRsus33QxpC3--
