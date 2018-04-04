Received: from eggs.gnu.org ([2001:4830:134:3::10]:36840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3n90-00011w-MK
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3n8w-0002TO-W6
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:28:26 -0400
References: <1522029982-4650-1-git-send-email-suhang16@mails.ucas.ac.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2cc2bda7-aeb9-f632-f658-06273fd70311@redhat.com>
Date: Wed, 4 Apr 2018 13:28:13 -0500
MIME-Version: 1.0
In-Reply-To: <1522029982-4650-1-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="97zQ9hsO340b5HSZHFFZZXaxdeSUhs9pE"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.12?] scripts/checkpatch.pl:
 Bug fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, vsementsov@virtuozzo.com
Cc: qemu-devel@nongnu.org, qemu-trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--97zQ9hsO340b5HSZHFFZZXaxdeSUhs9pE
From: Eric Blake <eblake@redhat.com>
To: Su Hang <suhang16@mails.ucas.ac.cn>, vsementsov@virtuozzo.com
Cc: qemu-devel@nongnu.org, qemu-trivial <qemu-trivial@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2cc2bda7-aeb9-f632-f658-06273fd70311@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.12?] scripts/checkpatch.pl: Bug
 fix
References: <1522029982-4650-1-git-send-email-suhang16@mails.ucas.ac.cn>
In-Reply-To: <1522029982-4650-1-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding a few more cc's]

On 03/25/2018 09:06 PM, Su Hang wrote:
> Commit 2b9aef6fcd96ba7ed8c1ee723e391901852d344c introduced a regression=
:
> checkpatch.pl started complaining about the following valid pattern:
> do {
>      /* something */
> } while (condition);
>=20
> Fix the script to once again permit this pattern.

We can probably drop the RFC from the title (RFC means you are unsure if
the patch is in its final form), and probably want this patch included
in 2.12 as we are still getting emails that hit the false positive:

https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00403.html

>=20
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> ---
> v1: fix bug.
> v2: correct inappropriate patch description.
> v3: put version description under Signed-off-by line.
>=20
>  scripts/checkpatch.pl | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Perl is not my strongest point, so take my review with a grain of salt.
However, since I already have a couple of other random patches that may
still be appropriate for -rc3, I can pick this up in a pull request if I
get at least one more review (and if no one else picks it up first, such
as the qemu-trivial process or Paolo's misc tree)

>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 57daae05ea18..d52207a3cc9d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2356,6 +2356,18 @@ sub process {
>  # check for missing bracing around if etc
>  		if ($line =3D~ /(^.*)\b(?:if|while|for)\b/ &&
>  			$line !~ /\#\s*if/) {
> +			my $allowed =3D 0;
> +
> +			# Check the pre-context.
> +			if ($line =3D~ /(\}.*?)$/) {

Why are you using minimal match coupled with an anchored expression?
Isn't '($line  =3D~ /(\}.*)$/)' going to match the same subexpression
(namely, any line containing } but not as the last character)?

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--97zQ9hsO340b5HSZHFFZZXaxdeSUhs9pE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrFGT0ACgkQp6FrSiUn
Q2qLGQgAmwWPjYCwEDcCQt8c0LqqDOvxAI46b1SNodpsrWAnXeTWXukRWbU1e2kn
gSKt5HpdAMWCh+7xLqvxoyz4S59/P9mWd9xcr806+mRLcVRfYT/Tn/NQdPuH3QMd
SMWBv0mmDxRTihJJq3QczzAnokUwMYmn8fbe2IZZbmZ3S8jv5wueiaFdEnBNCrNP
Wvd2RP5HjBkBziqCxaCAF9ks3gF8eiiX++Wvtti0mBubdW+uC3pwOq+4GMfhZzwD
CumCr97hjlof0h0MPZEgT64IK72kQYMagyzi6x+Crj8qnUcWU9ikRs7qKL56dMT9
NzRvPGfSsbtV47p+AjpjPnqEB7tYNw==
=XvD7
-----END PGP SIGNATURE-----

--97zQ9hsO340b5HSZHFFZZXaxdeSUhs9pE--
