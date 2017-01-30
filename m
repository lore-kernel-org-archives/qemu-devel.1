Received: from eggs.gnu.org ([2001:4830:134:3::10]:46813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYCiu-0002Nl-Or
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:14:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYCiq-0000Qq-Qq
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:14:24 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:36753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYCiq-0000QW-KI
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:14:20 -0500
Received: by mail-wj0-x244.google.com with SMTP id kq3so7928345wjc.3
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 06:14:20 -0800 (PST)
Date: Mon, 30 Jan 2017 14:14:17 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130141417.GG2118@stefanha-x1.localdomain>
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
	<1485436265-12573-4-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z0mFw3+mXTC5ycVe"
Content-Disposition: inline
In-Reply-To: <1485436265-12573-4-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 3/5] checkpatch: ignore email headers
 better
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


--Z0mFw3+mXTC5ycVe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 02:11:03PM +0100, Thomas Huth wrote:
> This is a port of the following commit from the Linux kernel:
>=20
> commit 29ee1b0c67e0dd7dea8dd718e8326076bce5b6fe
> Author: Joe Perches <joe@perches.com>
> Date:   Wed Aug 6 16:10:35 2014 -0700
>=20
>     checkpatch: ignore email headers better
>=20
>     There are some patches created by git format-patch that when scanned =
by
>     checkpatch report errors on lines like
>=20
>     To: address.tld
>=20
>     This is a checkpatch false positive.
>=20
>     Improve the logic a bit to ignore folded email headers to avoid emitt=
ing
>     these messages.
>=20
>     Signed-off-by: Joe Perches <joe@perches.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  scripts/checkpatch.pl | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Z0mFw3+mXTC5ycVe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj0o5AAoJEJykq7OBq3PI8mAH/2SJc/5XuhAo8Fi1St0yPm9R
tTqoUyI/1vVpMZNH8q8U32sc+YEOJ4qEw21Ote60bx6C5Br76+UfsTpuaGUSn7Wy
LqaH1+wFnSkXy1Bp/dA6d5sG3ZcCbRXpabcltAOv0fohMPNB/XLRkN55KuuJw0DT
ucQyeGv4SDChRVLDlD/dlLFwyfYJJyrEvEBaiP+9aYQniH2MUp/gTRf0Mj4MKVjI
Yz+7COLv8MSRyfryjMcV/motwgs/PpzrrgeOAR+vjkxemwVXbVQZ91ICeUCDYo5I
yLxn2VsOjzI98JgCXmRYWETVVm/FKKBuPQ3+Wa8hiZeF05pn8NncuL80MTsfScE=
=SasC
-----END PGP SIGNATURE-----

--Z0mFw3+mXTC5ycVe--
