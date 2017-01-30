Received: from eggs.gnu.org ([2001:4830:134:3::10]:47038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYCjt-0003Dd-NC
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYCjp-0000mj-OX
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:15:25 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYCjp-0000mY-Hj
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:15:21 -0500
Received: by mail-wm0-x244.google.com with SMTP id c85so77476858wmi.1
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 06:15:21 -0800 (PST)
Date: Mon, 30 Jan 2017 14:15:18 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130141518.GH2118@stefanha-x1.localdomain>
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
	<1485436265-12573-5-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7SAgGoIHugoKhRwh"
Content-Disposition: inline
In-Reply-To: <1485436265-12573-5-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 4/5] checkpatch: emit a reminder about
 MAINTAINERS on file add/move/delete
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


--7SAgGoIHugoKhRwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 02:11:04PM +0100, Thomas Huth wrote:
> This is a port of the following commit from the Linux kernel:
>=20
> commit 13f1937ef33950b1112049972249e6191b82e6c9
> Author: Joe Perches <joe@perches.com>
> Date:   Wed Aug 6 16:10:59 2014 -0700
>=20
>     checkpatch: emit a warning on file add/move/delete
>=20
>     Whenever files are added, moved, or deleted, the MAINTAINERS file
>     patterns can be out of sync or outdated.
>=20
>     To try to keep MAINTAINERS more up-to-date, add a one-time warning
>     whenever a patch does any of those.
>=20
>     Signed-off-by: Joe Perches <joe@perches.com>
>     Acked-by: Andy Whitcroft <apw@canonical.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>=20
> Note: I've changed the "WARNING:" into a "NOTE:" since this is often
> caused by false positives, so a warning seems too harsh to me.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  scripts/checkpatch.pl | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Yes!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7SAgGoIHugoKhRwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj0p2AAoJEJykq7OBq3PII6AH/jTO06hE3BA/ZJ7GpnaLTpr5
bTvNqgphmdXBsk/xudTSLS7/8GWemUe5mZPffdspQNEoB0pSurTHByjRrvdSZ+ig
AtFoGmtWhWmVqLbPapyhThgT4Wc5kKpyaOPNEsE0dCJ+Fe2Gap1sjcOJ9a+zKdYN
vJBldmiSxVlMqjEctdDZRM73vFJyZdQNStAYQiDPE1HoAEKDgKHYRFcWa7BWW3TO
xFoNswbj4Vu8Td1ZFKDLs2WJYGQusPwPcdtYR+bT/AxI7hEqLaUcuxQmgFw39gyi
3mOZ36izuBO4nTAKsuLp2HlgrqySHyddK9/VEKhHx37RKtjNQg16RNkh4Q89IkI=
=PmkJ
-----END PGP SIGNATURE-----

--7SAgGoIHugoKhRwh--
