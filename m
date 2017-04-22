Received: from eggs.gnu.org ([2001:4830:134:3::10]:55532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d1ywo-0002ZG-C2
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 13:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d1ywn-0002se-8g
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 13:35:50 -0400
References: <1492761662-5644-1-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b1d0a84d-2cfd-f32d-31ec-673c3e7d041a@redhat.com>
Date: Sat, 22 Apr 2017 19:35:38 +0200
MIME-Version: 1.0
In-Reply-To: <1492761662-5644-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4QwoOiGlpwK5L64wfPX9twpOnlwWabO7B"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu_iotests: Remove
 _readlink()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4QwoOiGlpwK5L64wfPX9twpOnlwWabO7B
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <b1d0a84d-2cfd-f32d-31ec-673c3e7d041a@redhat.com>
Subject: Re: [Qemu-block] [PATCH] qemu_iotests: Remove _readlink()
References: <1492761662-5644-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1492761662-5644-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.04.2017 10:01, Kevin Wolf wrote:
> It is unused.
>=20
> Suggestetd-by: Fam Zheng <famz@redhat.com>

*Suggested

And, since it now would be rude not to, with that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/common.config | 18 ------------------
>  1 file changed, 18 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/comm=
on.config
> index 1222e43..66f4e0b 100644
> --- a/tests/qemu-iotests/common.config
> +++ b/tests/qemu-iotests/common.config
> @@ -204,23 +204,5 @@ fi
> =20
>  export SAMPLE_IMG_DIR
> =20
> -_readlink()
> -{
> -    if [ $# -ne 1 ]; then
> -        echo "Usage: _readlink filename" 1>&2
> -        exit 1
> -    fi
> -
> -    perl -e "\$in=3D\"$1\";" -e '
> -    $lnk =3D readlink($in);
> -    if ($lnk =3D~ m!^/.*!) {
> -        print "$lnk\n";
> -    }
> -    else {
> -        chomp($dir =3D `dirname $in`);
> -        print "$dir/$lnk\n";
> -    }'
> -}
> -
>  # make sure this script returns success
>  true
>=20



--4QwoOiGlpwK5L64wfPX9twpOnlwWabO7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlj7lGoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKVIH/3ulGO/69/SuK7fwk8B/Dc4QCk+lAU1O
bIcMeaPjdSQCSB7OIOZkv/mw7quLkNig9CQ5VFdzVvRsm1v2wTSxIBNNsCPEJcT2
1yoV9Z3VlI0DozUj+VhYW1Edt0h3F4OcuKf9nfqiPQVuDWW3v93oDHkCzJ8ZNRD7
F7ZCNCWNGG1JCTgMX7DAuhzWlZMbSzD8dybH/qRo0owgeO9OC0u1nW/FTdcolrec
km8pU7xRwVg/8BR0gXtlMYSN7pyUafZ5jLF+/3If7rvDxBMc0aiMIrOfMYl83E0B
bVWf/wgbwdSitwjhCdTrX4s1BbTvx/KRJ9mwRWlERM8HbPZW0z5P6WA=
=u3UX
-----END PGP SIGNATURE-----

--4QwoOiGlpwK5L64wfPX9twpOnlwWabO7B--
