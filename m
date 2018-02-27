Received: from eggs.gnu.org ([2001:4830:134:3::10]:47896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eqhY0-0007Xu-0r
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eqhXv-0003iS-BG
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:52:08 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eqhXv-0003i4-45
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:52:03 -0500
Received: by mail-wr0-x234.google.com with SMTP id m5so25388620wrg.1
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 07:52:02 -0800 (PST)
Date: Tue, 27 Feb 2018 15:52:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180227155200.GB32480@stefanha-x1.localdomain>
References: <1519533358-13759-1-git-send-email-suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <1519533358-13759-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v4 RFC 0/3] util/uri.c: Coding style format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: boxafox@163.com, qemu-devel@nongnu.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2018 at 12:35:55PM +0800, Su Hang wrote:
> Su Hang (3):
>   util/uri.c: Coding style check, Only whitespace involved.
>   util/uri.c: remove brackets () that wrap `return` statement's content.
>   util/uri.c: wrap single statement blocks with braces {}
>=20
>  util/uri.c | 1753 ++++++++++++++++++++++++++++++++----------------------=
------
>  1 file changed, 940 insertions(+), 813 deletions(-)
>=20
>     Using `git diff -w` to make sure that the first patch only contains
>     whitespace changes, replace all TAB with whitespace.
>     Here is what I actually use:
>     '''
>     [core]
>         whitespace =3D -trailing-space,-indent-with-non-tab,-tab-in-indent
>=20
>         git diff -w  --word-diff-regex=3D[^[:space:]]
>     '''
>=20
>     For second patch, using
>     `perl -pi -e "s/return \((.*?)\);/return \1;/g" util/uri.c`
>     to remove brackets () that wrap `return` statement's content.
>     Changing patterns like this:
>     `return (a);` to `return a;`.
>=20
>     For third patch, using curly braces to wrap `if` `while` `else` state=
ments,
>     which only hold single statement. For example:
>     '''
>     if (cond)
>         statement;
>     '''
>     to
>     '''
>     if (cond) {
>         statement;
>     }
>     '''
>=20
>     And using tricks that compare the disassemblies before and after
>     code changes, to make sure code logic isn't changed:
>     '''
>     git checkout master
>     make util/uri.o
>     strip util/uri.o
>     objdump -Drx util/uri.o > /tmp/uri-master.txt
>     git checkout cleanupbranch
>     make util/uri.o
>     strip util/uri.o
>     objdump -Drx util/uri.o > /tmp/uri-cleanup.txt
>     diff -u /tmp/uri-*.txt
>     '''
>=20
> --
> 2.7.4
>=20
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJalX6gAAoJEJykq7OBq3PIascIAJ/oW+pXi/TFMARcQnyKHsjG
un8F4QQFJQoQ9H+qSvfJ/QB+dQKbSJX3gAgaGuofo/Jheztbz/DMRMPd9/mOCjqq
uuRGqL1WE0XNvQ97NDBwFk0BnsVIy7LLPkeXdjwY0E5qq5fefZtV9lSOWu6EUegj
2A1h1K5L3se2Uk0at3JXCDQoPmkRixOM6Mu9MtF06DH7nLVX64y5bhP0x4fm9/5G
ExXgDKP3p/4O1qddPpeGAbRqQrzm8TWSRYDAoWX072G1TEbY92icCflgFHDl+LpT
MZt7vmHAEB3WXAAQalQL5u75XZj9pAEYaGcN2DkNsnDQLRY+Kcj6hY/rA6+HMK4=
=9TXi
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
