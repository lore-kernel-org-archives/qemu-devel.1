Received: from eggs.gnu.org ([2001:4830:134:3::10]:58357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eqj7a-0001Ew-80
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eqj7W-0001W2-Aj
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:32:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eqj7W-0001Uv-4X
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:32:54 -0500
Date: Tue, 27 Feb 2018 17:32:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180227173234.GI32480@stefanha-x1.localdomain>
References: <1519613598-12270-1-git-send-email-suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline
In-Reply-To: <1519613598-12270-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v2 RFC] scripts/checkpatch.pl: add check
 for `while` and `for`
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


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 10:53:18AM +0800, Su Hang wrote:
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1b4b812e28fa..10c138344fa9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2353,7 +2353,8 @@ sub process {
>  		}
> =20
>  # check for missing bracing round if etc

Please fix the pre-existing typo in the comment:

s/round/around/

> -		if ($line =3D~ /(^.*)\bif\b/ && $line !~ /\#\s*if/) {
> +		if ($line =3D~ /(^.*)\b(for|while|if)\b/ &&
> +			$line !~ /\#\s*(for|while|if)/) {

Please use (?:...) like most other cases in checkpatch.pl.  Perl
automatically assigns groups to $1, $2, etc with (...).  Using (?:...)
is preferred since it's faster and free of this side-effect.

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJalZYyAAoJEJykq7OBq3PI9WYIALQPhHnVjqNASPqz4Xp025Tp
92eB8RTFNJcTeauDLSseK564GxFIOjK+LdfVbHF7xZZFRcR55cCz/gqBVSKmoh+L
Kq9xzQKCt2FIexLuojMTLCxqv2oFQkmgjJbOrlhDpjudzBSQkhdCFTopiuRQGl/4
dgpxc+mBCR2zT3Q6nXGf50+yrwIg7M5YdbCyusoYRwsAJLIBhesghpB05Oy4IYOd
aALmnKFQ0Pmbq0MOkLr0IGcOxpbfxQQc4PWxSyyr1Ib05RT4jKOshEQL8eGAX8RM
v1U0AKMHOCoI7g3urtTq+/cxg0Ci5qAuaiVyPY1i5AR9JE79xzJ4UovYjZV9krQ=
=NrWU
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
