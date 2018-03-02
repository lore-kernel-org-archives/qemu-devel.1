Received: from eggs.gnu.org ([2001:4830:134:3::10]:49284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1erisX-0006IU-Fk
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1erisU-0005CD-BG
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:29:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1erisU-0005AU-4e
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:29:30 -0500
Date: Fri, 2 Mar 2018 11:29:11 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180302112911.GE6026@stefanha-x1.localdomain>
References: <1519788689-11967-1-git-send-email-suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <1519788689-11967-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v3] scripts/checkpatch.pl: add check for
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
Cc: thuth@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 11:31:29AM +0800, Su Hang wrote:
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

This patch doesn't apply to qemu.git/master because it's based on your
v2 patch.

Please send a single v4 patch that combines v2 and v3 changes and can be
applied to qemu.git/master.

You can use "git rebase -i origin/master" to combine changes and put
them onto the latest origin/master.  See the "fixup" and "squash"
commands in git-rebase(1)'s interactive mode for combining patches.

Thanks!

> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> ---
>  scripts/checkpatch.pl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 10c138344fa9..bed1dbbd54d1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2352,9 +2352,9 @@ sub process {
>  			}
>  		}
> =20
> -# check for missing bracing round if etc
> -		if ($line =3D~ /(^.*)\b(for|while|if)\b/ &&
> -			$line !~ /\#\s*(for|while|if)/) {
> +# check for missing bracing around if etc
> +		if ($line =3D~ /(^.*)\b(?:for|while|if)\b/ &&
> +			$line !~ /\#\s*(?:for|while|if)/) {
>  			my ($level, $endln, @chunks) =3D
>  				ctx_statement_full($linenr, $realcnt, 1);
>                          if ($dbg_adv_apw) {
> --=20
> 2.7.4
>=20

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJamTWHAAoJEJykq7OBq3PIPFcH/0q438giVt/KOrVEzjETuzc9
67jd+6HqvwWRqwH2n37i6T34BnJe+l69+VV/0iKiFXIzccBaoOy4vJI3kbdKZ59V
OMeoyIrT5aRMDudtTgy7m+wVAV6AFPc4dzCAyH9ldh9msnPcypZp/tmzIXTTGmVb
BfUtFY1GM+6L1ArgvtxqstQgizKQwzUs9GWDHv6rK4kwze3GrsAszLQwcbIBwOUQ
SRno2J06qmOS5C5DzZbjZOWhdnS4TOgTPsckXBbGlpn7B4YuxMNiHZLwYaUrgG8V
GgLRpfLLFxcYKBxDKPofcA/sxEXmCuDp0IYm0rmRg4c/M/RKR8wLIPxV4wGk9E8=
=312w
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
