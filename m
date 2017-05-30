Received: from eggs.gnu.org ([2001:4830:134:3::10]:53545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFeEg-0007Up-T0
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFeEd-0003dr-P9
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:18:46 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFeEd-0003dd-Io
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:18:43 -0400
Received: by mail-wm0-x243.google.com with SMTP id b84so24118816wmh.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 03:18:43 -0700 (PDT)
Date: Tue, 30 May 2017 11:18:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530101840.GB25884@stefanha-x1.localdomain>
References: <20170529193016.6888-1-aurelien@aurel32.net>
	<20170529193016.6888-2-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <20170529193016.6888-2-aurelien@aurel32.net>
Subject: Re: [Qemu-devel] [PULL 1/5] target/sh4: log unauthorized accesses
 using qemu_log_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2017 at 09:30:12PM +0200, Aurelien Jarno wrote:
> qemu_log_mask() is preferred over fprintf() for logging errors.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  target/sh4/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Had to drop this series due to a merge conflict.  Please see my reply
regarding qemu_system_reset_request() with info on how to fix it.

Thanks,
Stefan

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLUcAAAoJEJykq7OBq3PI9dYH/RVmPHxUP2IV7mOVB0aDvAZ+
iHyTCsIiuBYv8ulllVgPL8+1kaujvoZzVKWbVi0tzFIwwkpwROtRpG7SjWJXr/IX
z909TYrwvvXeqIeUwaIrVBTrYjLrYXjnpB/YYvmpkggMLOcwbSsMy5QhQzJnLnyN
a774dLqqHLenlq3/cTrMqoHi4J3+GiSDAsPVkE8JrsSMwFnzOH1RjhIiX56DnN0A
/gXmZ0PjaIVFwWBSQUj7uLBIatOlRevNn9LgyB9hvgdKDfXGCU2J9N/pnzq0O2T3
YyREo6RozGPtSuYjnN8m576yK+2sePvWp8E8Qhly+MkNUFlmafqCQvUrK/NhsCc=
=ViSM
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
