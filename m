Received: from eggs.gnu.org ([2001:4830:134:3::10]:38720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1Q9-000709-GS
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1Q5-0004J4-B9
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:07:29 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1df1Q5-0004IZ-3b
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:07:25 -0400
Received: by mail-wm0-x22d.google.com with SMTP id m85so3068399wma.0
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 03:07:25 -0700 (PDT)
Date: Tue, 8 Aug 2017 11:07:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808100721.GC16801@stefanha-x1.localdomain>
References: <20170804213625.3756-1-ehabkost@redhat.com>
	<20170804213625.3756-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20170804213625.3756-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/5] qmp-shell: Use argparse module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 06:36:21PM -0300, Eduardo Habkost wrote:
> It makes command-line parsing and generation of help text much
> simpler.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 61 +++++++++++++++++----------------------------=
------
>  1 file changed, 20 insertions(+), 41 deletions(-)

The minimum Python version is 2.6.  The argparse module was introduced
in Python 2.7 so we cannot use it without increasing the minimum Python
version:

https://docs.python.org/2.6/modindex.html

I suggest holding off on this for now.

Stefan

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiY1ZAAoJEJykq7OBq3PI2JwH/jrPACtR9aP3VFxgzhWoSix0
4jaZcselaeTwU2zDGUoNfJ9zgqj1P6s2NDeHs+sjwHJ0zjlIk3Pd6qC1GX4LnXPa
SUCIukuArJAZT4cPLuZeAidTt3Eta0GO/AvBfIvyF4Wq85TJVKQx2zY6KStl97rZ
dxcAjV5Pli1GpfPdULxoLU60GukUSmP0tWqCpR3mFemLcz3iglxKxRTW9A4jvD44
jZG5V7LfEUMXVJiLL0w9KhNUfL+gEppQW6xMfW10GIxlJZt9+rNzNQVR3b2tJqrA
nopBMI7KEWe6coumHQeCijUXuTfds/IYZ2fCVYSKDIUm92drbOmrJ22B5PF32O0=
=HHQv
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
