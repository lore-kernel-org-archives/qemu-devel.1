Received: from eggs.gnu.org ([2001:4830:134:3::10]:39648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrDB-0005Hc-0h
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrD6-00081q-3l
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:12:05 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dUrD5-00081B-SB
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:12:00 -0400
Received: by mail-lf0-f66.google.com with SMTP id t72so13520327lff.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 02:11:59 -0700 (PDT)
Date: Tue, 11 Jul 2017 10:10:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711091055.GD17792@stefanha-x1.localdomain>
References: <20170711081033.12399-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <20170711081033.12399-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] build: add -Wexpansion-to-defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 10:10:33AM +0200, Paolo Bonzini wrote:
> This warning is included in -Wall by clang, but not by GCC (which only
> enables it for -Wextra).  Include it in the list of warnings we enable
> to minimize the differences between the compilers:
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For anyone interested in what this warning does:
https://gcc.gnu.org/onlinedocs/gcc-7.1.0/gcc/Warning-Options.html#index-Wex=
pansion-to-defined

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZJYfAAoJEJykq7OBq3PIZ5QH/26nL6Iy0GXLNWfJEg3PutQW
+wCHCxPlh/82v3yak94m3bBorYknzKGMZTiU2nZjLpjxH00Eeqg8IWaAIkJUvu4x
J/MLAT9VPPUTsOV0qcrcieiRIicznRWdS5slLUVmfDjsOsoHdceFpMorURSyvQ8k
DYn8GBGjMYx8qMWHEwVU9azyyI9FAzw43YzbgzCZClCgNmFKVOQstpRZ9I8fbqkr
yvjHdO7kv26qQALtcj8plKiUJ90I8WICkFFNq0Cn++EJiMvpL65PlvEimV7WebqU
bjNM6JJqr8VW1EdixiCD2UyStrBaUtZS+15PhoaCxTshK/lWNm2sBxlGcw4pFQs=
=oGYR
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
