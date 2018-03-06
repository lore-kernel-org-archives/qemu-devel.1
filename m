Received: from eggs.gnu.org ([2001:4830:134:3::10]:45053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etFwr-0007rX-95
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etFwl-0004KD-7E
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:00:21 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:45011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1etFwk-0004Jq-OJ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:00:15 -0500
Received: by mail-wr0-x22c.google.com with SMTP id v65so21661392wrc.11
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 09:00:14 -0800 (PST)
Date: Tue, 6 Mar 2018 17:00:11 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306170011.GP31045@stefanha-x1.localdomain>
References: <1520319890-19761-1-git-send-email-suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G+DT6X5ssgZ56VG3"
Content-Disposition: inline
In-Reply-To: <1520319890-19761-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v4] scripts/checkpatch.pl: add check for
 `while` and `for`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: thuth@redhat.com, eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org


--G+DT6X5ssgZ56VG3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 03:04:50PM +0800, Su Hang wrote:
> Adding check for `while` and `for` statements, which condition has more t=
han
> one line.
>=20
> The former checkpatch.pl can check `if` statement, which condition has mo=
re
> than one line, whether block misses brace round, like this:
> '''
> if (cond1 ||
>     cond2)
>     statement;
> '''
> But it doesn't do the same check for `for` and `while` statements.
>=20
> Using `(?:...)` instead of `(...)` in regex pattern catch.
> Because `(?:...)` is faster and avoids unwanted side-effect.
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> ---
>  scripts/checkpatch.pl | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--G+DT6X5ssgZ56VG3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanskbAAoJEJykq7OBq3PIk54IALh2ExPyyey4aWixkPFt7ZpG
I/z1AVfB4ocbhQWtkq3EpMkfH2YzDYohbvxHOVgs80COZaAtkLBRo9ca20Jiy8MW
kUg8hQc4p6uUxtxkRMO6XZg+YiKra/8BXoJLJznnjgQhToGZUxHHdgl8SLDErFjf
tsdzBhXvWcHlBPBOcwk5yT2jCMyYxMiYtxTP2Or1dU5bzd+CXxZQEQ2xCro64dcR
zUiRsJQcF5NZVHs4IbfMbvsZ/8uehci84BbbSXJb/wOeJAZgJO/3G3f3JMfhh3sx
hfhCRU2rfUO44gkeACsBwYNjnKXNfR2jae15BIdcy1lXWck4yhRYj9udSewPmFk=
=rkGH
-----END PGP SIGNATURE-----

--G+DT6X5ssgZ56VG3--
