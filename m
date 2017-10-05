Received: from eggs.gnu.org ([2001:4830:134:3::10]:48652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e07bs-0002UL-6o
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e07bn-0004Yx-SR
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e07bn-0004YW-Is
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:58:43 -0400
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c3221525-70bc-475d-07c0-bbf47b507e5e@redhat.com>
Date: Thu, 5 Oct 2017 09:58:38 -0500
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-3-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HCm9FEgImTxrSOhIS3Wd8iPOiQHFRoX2r"
Subject: Re: [Qemu-devel] [RFC PATCH 02/32] texi2pod: Support @verbatim
 environment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HCm9FEgImTxrSOhIS3Wd8iPOiQHFRoX2r
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <c3221525-70bc-475d-07c0-bbf47b507e5e@redhat.com>
Subject: Re: [RFC PATCH 02/32] texi2pod: Support @verbatim environment
References: <20171002152552.27999-1-armbru@redhat.com>
 <20171002152552.27999-3-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 10:25 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/texi2pod.pl | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

My perl is a bit rusty, but I think I can handle this one.

>=20
> diff --git a/scripts/texi2pod.pl b/scripts/texi2pod.pl
> index 39ce584a32..2171f8b819 100755
> --- a/scripts/texi2pod.pl
> +++ b/scripts/texi2pod.pl
> @@ -85,6 +85,13 @@ if (defined $out) {
> =20
>  while(defined $inf) {
>  while(<$inf>) {
> +    # Verbatim environment
> +    if (defined $endw and $endw eq "verbatim"
> +	and not (/^\@end\s+([a-z]+)/ and $1 eq $endw)) {

You anchored to the beginning, but not the end, of the line; that means
you accept '@end verbatim garbage' as an end marker.  Worth adding $?

If that's the only change, I'm okay with adding:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HCm9FEgImTxrSOhIS3Wd8iPOiQHFRoX2r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnWSJ4ACgkQp6FrSiUn
Q2os7QgAjwv4ZBrlinr1tVLI8iwrs4/adyMttivqTWUfQUsFeXi0C0pvgrjX9uVU
ACl8mPyNaVIWoIMOpuzWpllSXiUtmv30RHQjTaBNc0rdK+P3oDTGiBgcAJXNGX4q
PCh5Ih87AfR8CiaJpp6VNCcBNxCoSQG5xvhfwKD+yGewUp0dqPrzKN6n05gzUyJj
iv5zHHXREmjbW1NZMstBIRo1SEsbpwXHs9NIRY0wJHtCptSU+iA/9LARIoCGapIm
Ik/RlBCrpZcQTN+bbkOl0mL/+pbJDopJAdrl+w5HkEDm5wsxrNYuWMhY4jDf/FoF
J0yodsG2VG72tJ2We0YHNLM2HpFb6g==
=pujV
-----END PGP SIGNATURE-----

--HCm9FEgImTxrSOhIS3Wd8iPOiQHFRoX2r--
