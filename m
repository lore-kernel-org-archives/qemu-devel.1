Received: from eggs.gnu.org ([2001:4830:134:3::10]:50986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0L6-0003f2-PZ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0L5-00059Q-UG
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:57:32 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1da0L5-00058p-N5
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:57:31 -0400
Received: by mail-wr0-x241.google.com with SMTP id g32so2666612wrd.5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:57:31 -0700 (PDT)
Date: Tue, 25 Jul 2017 14:57:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725135728.GJ23343@stefanha-x1.localdomain>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-4-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jIYo0VRlfdMI9fLa"
Content-Disposition: inline
In-Reply-To: <1500645206-13559-4-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/9] tests: Pass literal format strings
 directly to qmp_FOO()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org


--jIYo0VRlfdMI9fLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 03:53:20PM +0200, Markus Armbruster wrote:
> The qmp_FOO() take a printf-like format string.  In a few places, we
> assign a string literal to a variable and pass that instead of simply
> passing the literal.  Clean that up.
>=20
> Bonus: gets rid of non-literal format strings.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/ahci-test.c | 4 +---
>  tests/ide-test.c  | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jIYo0VRlfdMI9fLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd05IAAoJEJykq7OBq3PIpwIH/2CX/pzCVmoFLnyIfEh0MLi1
lIfAKkWpuM5us+QrLSQPI2yRo7sYLadiH08k4bt+QzY3pBDLfrFEknOsEDlkgcgm
JBa35yMTztn2pwoT90SXjThSAEF7O4voS/xX0T7avOZ92ifwLYx5vukOFS0042vW
XjdyxAazIo6NVIAL+l48QSo7Rj+JvMKTfH1C+VNn5UdKGdkx67AXJZuTGpevFG24
bcWnMo9OEqj81LVgunZ0VGZWOWHH9O+aX+sjjL+ugVk1essrVqWbwCDjI4fSkOAo
xEblRSDavEcI0mqVeExg6RqZkJ9ZNYeYWckb0bicVtxyDkGsP8fBkLaFbR9BznY=
=khPL
-----END PGP SIGNATURE-----

--jIYo0VRlfdMI9fLa--
