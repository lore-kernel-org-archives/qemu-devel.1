Received: from eggs.gnu.org ([2001:4830:134:3::10]:42933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dajVw-0004vl-KY
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dajVu-00012b-0V
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:11:44 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dajVt-000122-QE
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:11:41 -0400
Received: by mail-wm0-x244.google.com with SMTP id 184so23891570wmo.3
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:11:41 -0700 (PDT)
Date: Thu, 27 Jul 2017 15:11:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170727141137.GH10129@stefanha-x1.localdomain>
References: <20170725171014.25193-1-apahim@redhat.com>
	<20170725171014.25193-3-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TKYYegg/GYAC5JIZ"
Content-Disposition: inline
In-Reply-To: <20170725171014.25193-3-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/6] qemu.py: use poll() instead of
 'returncode'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com


--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 07:10:10PM +0200, Amador Pahim wrote:
> The 'returncode' Popen attribute is not guaranteed to be updated. It
> actually depends on a call to either poll(), wait() or communicate().
>=20
> On the other hand, poll() will "Check if child process has terminated.
> Set and return returncode attribute."
>=20
> Let's use the poll() to check whether the process is running and also
> to get the updated process exit code, if any.
>=20
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TKYYegg/GYAC5JIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZefSZAAoJEJykq7OBq3PI2QgH/1IxA/DRqvz5JLgRs3e3if25
TlZ1J8pwD2uHlvLwG/wyPfYf6k1oQrL3ldca3Uz5iVjLlW745yv04RGtc8lzpmlD
mj7iv1SwIIiTZ0yBLtuu3IKu0/R7Pt8/EvrlP4GrV56JLWjakhGLQprif/nwgGXd
JEL5wBwdbTfAQtERIChkvOVd+FIU7d+ZeGpVVFU7N9x+xipNXv2Q+YfrgHfynyr5
CuUvmKUfYNHOJfIsLGgN5WJuagTT6p/UGszyb9TweRPYRRXPuBeOzDlTzcU/cNtk
Ea1lYtca7kww/tk83sHS13QT4yA26Ym1t9WvLrSzYpOQgw8ZlZKv+WDQOGGQP6s=
=SBLk
-----END PGP SIGNATURE-----

--TKYYegg/GYAC5JIZ--
