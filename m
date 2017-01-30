Received: from eggs.gnu.org ([2001:4830:134:3::10]:46211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYChz-0001ib-1S
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYChv-0008No-42
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:13:27 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYChu-0008NQ-U5
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:13:23 -0500
Received: by mail-wm0-x242.google.com with SMTP id r18so6097457wmd.3
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 06:13:22 -0800 (PST)
Date: Mon, 30 Jan 2017 14:13:20 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130141320.GF2118@stefanha-x1.localdomain>
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
	<1485436265-12573-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Content-Disposition: inline
In-Reply-To: <1485436265-12573-3-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/5] checkpatch: check utf-8 content
 from a commit log when it's missing from charset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 02:11:02PM +0100, Thomas Huth wrote:
> This is a port of the following commit from the Linux kernel:
>=20
> commit fa64205df9dfd7b7662cc64a7e82115c00e428e5
> Author: Pasi Savanainen <pasi.savanainen@nixu.com>
> Date:   Thu Oct 4 17:13:29 2012 -0700
>=20
>     checkpatch: check utf-8 content from a commit log when it's missing f=
rom charset
>=20
>     Check that a commit log doesn't contain UTF-8 when a mail header
>     explicitly defines a different charset, like
>=20
>     'Content-Type: text/plain; charset=3D"us-ascii"'
>=20
>     Signed-off-by: Pasi Savanainen <pasi.savanainen@nixu.com>
>     Cc: Joe Perches <joe@perches.com>
>     Cc: Andy Whitcroft <apw@canonical.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>=20
> Note: I slightly updated the regex for the "Content-Type" line check
> since most of the time, the character set does not seem to be given
> in quotes.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  scripts/checkpatch.pl | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj0oAAAoJEJykq7OBq3PImngIAKy35UYKQOMiGF/9IzTARaSs
wKBFBqEP9GsJdZSWkHNvaIgb9jb3AgPFuqdVMUBCMiyPpQktPAID6XPHWmdx+zBu
hEIhqAqBAX0Su65Hxj4gd9nXov321sJPwMwke/eb/WvyO8bpDC/Uvnu9AIXkoi5+
aE6zXs9KBuSDLAX+DLah71YKu8s7lW3D0ko/FzP6yFBTPCEUT1vIYSMPy+LiU09i
QfV3qGuRayOi9Ig+pRLucToJayy67LhtPbEqONwOdzRVGGaDCN0lDZ06kwmSqY7T
z/Y+QhVGA8cFlfEtUYkUq955goRFYbkr7ptIiYFu+UaPF1rbF6kqccNxB7ve1Gg=
=0WFd
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
