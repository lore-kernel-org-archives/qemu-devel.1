Received: from eggs.gnu.org ([2001:4830:134:3::10]:49392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn93q-0004aa-HL
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn93p-000488-Ec
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:54:02 -0400
References: <cover.1504112061.git.jcody@redhat.com>
	<dd70daa66badee5dc2796f556c973e90cd5a3faf.1504112061.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89e43927-f8aa-d12c-893b-6a5cb5e9351d@redhat.com>
Date: Wed, 30 Aug 2017 14:53:53 -0500
MIME-Version: 1.0
In-Reply-To: <dd70daa66badee5dc2796f556c973e90cd5a3faf.1504112061.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mNdMetDiT0VfqsJu8dHoXBCseQ2Xhh5gL"
Subject: Re: [Qemu-devel] [PATCH v2 7/7] block/curl: code cleanup to comply
 with coding style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mNdMetDiT0VfqsJu8dHoXBCseQ2Xhh5gL
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
Message-ID: <89e43927-f8aa-d12c-893b-6a5cb5e9351d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] block/curl: code cleanup to comply
 with coding style
References: <cover.1504112061.git.jcody@redhat.com>
 <dd70daa66badee5dc2796f556c973e90cd5a3faf.1504112061.git.jcody@redhat.com>
In-Reply-To: <dd70daa66badee5dc2796f556c973e90cd5a3faf.1504112061.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 11:57 AM, Jeff Cody wrote:
> This addresses non-functional changes to help curl.c better comply
> with the coding styles (comments, indentation, brackets, etc.).
>=20
> One minor code change is the combination of two if statements into
> a single if statement.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/curl.c | 100 +++++++++++++++++++++++++++++++--------------------=
--------
>  1 file changed, 52 insertions(+), 48 deletions(-)
>=20

> -#define CURL_BLOCK_OPT_URL       "url"
> -#define CURL_BLOCK_OPT_READAHEAD "readahead"
> -#define CURL_BLOCK_OPT_SSLVERIFY "sslverify"
> -#define CURL_BLOCK_OPT_TIMEOUT "timeout"
> -#define CURL_BLOCK_OPT_COOKIE    "cookie"
> -#define CURL_BLOCK_OPT_COOKIE_SECRET "cookie-secret"
> -#define CURL_BLOCK_OPT_USERNAME "username"
> -#define CURL_BLOCK_OPT_PASSWORD_SECRET "password-secret"
> -#define CURL_BLOCK_OPT_PROXY_USERNAME "proxy-username"

Another change from inconsistent spacing,

> +#define CURL_BLOCK_OPT_URL                   "url"
> +#define CURL_BLOCK_OPT_READAHEAD             "readahead"
> +#define CURL_BLOCK_OPT_SSLVERIFY             "sslverify"
> +#define CURL_BLOCK_OPT_TIMEOUT               "timeout"
> +#define CURL_BLOCK_OPT_COOKIE                "cookie"
> +#define CURL_BLOCK_OPT_COOKIE_SECRET         "cookie-secret"
> +#define CURL_BLOCK_OPT_USERNAME              "username"
> +#define CURL_BLOCK_OPT_PASSWORD_SECRET       "password-secret"
> +#define CURL_BLOCK_OPT_PROXY_USERNAME        "proxy-username"
>  #define CURL_BLOCK_OPT_PROXY_PASSWORD_SECRET "proxy-password-secret"

to something that is consistent but requires a mass-edit if we add a
longer name.


> @@ -235,7 +236,7 @@ static size_t curl_header_cb(void *ptr, size_t size=
, size_t nmemb, void *opaque)
>  /* Called from curl_multi_do_locked, with s->mutex held.  */
>  static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void =
*opaque)
>  {
> -    CURLState *s =3D ((CURLState*)opaque);
> +    CURLState *s =3D ((CURLState *)opaque);

Umm, this is C, so why not just:

CURLState *s =3D opaque;

Those are minor findings, so whether or not you address them,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mNdMetDiT0VfqsJu8dHoXBCseQ2Xhh5gL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnF9EACgkQp6FrSiUn
Q2rjswf+NjiZlx9mBC6gUoTtiwKDHngNYSvPMHbA5xJvnCCSb9K59Zl+Ew/Vave6
e7YdsZs7kgev/7x23z59LKPUzGWSUaAF6aG44jndmqI8cMT899T7BRAh7LkngFtr
KQmluuIfaM+XmjUmn5MToFHdxfTTemoUb8mtQd0PtorZCaAe9J1FmDFaatG/bBUI
V4kMKNaUQXtKuoRJF2iZt2IXfJW6OhQV2EGPaNIRRi/LDjkObeAsG0w/q5ntA6RK
qzfAzHqU796nlki4TCwsJWr/bfgUWYmNPcNXbYSW2eqzE8tCyKfTwqk0siX+0w/0
NkIpflQKuM5TwAXigrCDYmIsUFSa3g==
=yHT9
-----END PGP SIGNATURE-----

--mNdMetDiT0VfqsJu8dHoXBCseQ2Xhh5gL--
