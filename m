Received: from eggs.gnu.org ([2001:4830:134:3::10]:44101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceknV-0004y8-9t
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceknR-00020e-0d
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:50:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ceknQ-0001zl-P0
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:50:08 -0500
References: <1487344340-30471-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d625bc9-4d35-a03b-03ea-4e68e24b2195@redhat.com>
Date: Fri, 17 Feb 2017 09:50:06 -0600
MIME-Version: 1.0
In-Reply-To: <1487344340-30471-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8WN5c7neh0rBuTNeRRfdcX2tGRhKWm5lv"
Subject: Re: [Qemu-devel] [PATCH] Makefile: Put VERSION info into
 version.texi rather than using -D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8WN5c7neh0rBuTNeRRfdcX2tGRhKWm5lv
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, patches@linaro.org
Message-ID: <9d625bc9-4d35-a03b-03ea-4e68e24b2195@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Makefile: Put VERSION info into version.texi
 rather than using -D
References: <1487344340-30471-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487344340-30471-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 09:12 AM, Peter Maydell wrote:
> Unfortunately some older versions of makeinfo don't correctly
> handle the -D command line option and fail to set the variable.
> This then causes them to complain
>  docs/qemu-ga-ref.texi:41: warning: undefined flag: VERSION
>=20
> Work around this by doing as the autotools do, and writing
> the information into a version.texi file which we then
> include from the .texi files that need it.

Autotools defines a few more macros, but we can always beef up our
version.texi if we find ourselves needing any of them.

>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  Makefile               | 17 ++++++++++-------
>  docs/qemu-ga-ref.texi  |  2 ++
>  docs/qemu-qmp-ref.texi |  2 ++
>  3 files changed, 14 insertions(+), 7 deletions(-)

Missing a change to .gitignore for version.texi.  With that fixed, you
can add:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8WN5c7neh0rBuTNeRRfdcX2tGRhKWm5lv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpxuuAAoJEKeha0olJ0NqJvIIAIE+gNaGwtFm5VrkVopqnynG
mNJXoBOVoG4DYuq7JAbokmTzj8yunfkI4Nus4lIy0BhvxiDz9wFJHHCV9gcffFsU
Qcn463/NS2/YnDrKMYKv2YkNCdpIcSBi88zXAK76q9f8E5HyoZDsv9/jRfwV4Llr
Wc7sfsYNVVfVnD0kg3Jn0YYJXms7+f+tm0rPASopm67/EZxiDle3qrkDGp+Mr/hD
jYwy0Jk1gKIFqdjsxTwg4nBfgl640VbKU7XNHYLJGjSSCwFXuvV/v5R/w4rSFk6F
LjGoAkFwiPafkuhRpjBXH5mMyKMtN9EyQTWNfcXa/STe0DAJWEkUxNLb6tkHQ68=
=8MKH
-----END PGP SIGNATURE-----

--8WN5c7neh0rBuTNeRRfdcX2tGRhKWm5lv--
