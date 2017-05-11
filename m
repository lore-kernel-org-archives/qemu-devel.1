Received: from eggs.gnu.org ([2001:4830:134:3::10]:56608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8pqy-00012T-C0
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8pqx-0000FF-8d
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:18:08 -0400
References: <20170511151126.20323-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf739d3c-522a-6cac-a672-752a6efecca7@redhat.com>
Date: Thu, 11 May 2017 10:17:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170511151126.20323-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xl6ahsbExTFdmt7CUbxVVx7rhav7dkxNo"
Subject: Re: [Qemu-devel] [PATCH v3] qemu-img: Check for backing image if
 specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xl6ahsbExTFdmt7CUbxVVx7rhav7dkxNo
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <cf739d3c-522a-6cac-a672-752a6efecca7@redhat.com>
Subject: Re: [PATCH v3] qemu-img: Check for backing image if specified during
 create
References: <20170511151126.20323-1-jsnow@redhat.com>
In-Reply-To: <20170511151126.20323-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/11/2017 10:11 AM, John Snow wrote:
> Or, rather, force the open of a backing image if one was specified
> for creation. Using a similar -unsafe option as rebase, allow qemu-img
> to ignore the backing file validation if possible.
>=20
> It may not always be possible, as in the existing case when a filesize
> for the new image was not specified.
>=20
> This is accomplished by shifting around the conditionals in
> bdrv_img_create, such that a backing file is always opened unless we
> provide BDRV_O_NO_BACKING. qemu-img is adjusted to pass this new flag
> when -u is provided to create.
>=20
> Sorry for the heinous looking diffstat, but it's mostly whitespace.
>=20
> Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=3D1213786
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
> v3: Rebased
>=20

> +++ b/qemu-img.c
> @@ -145,9 +145,11 @@ static void QEMU_NORETURN help(void)
>             "  'snapshot_id_or_name' is deprecated, use 'snapshot_param=
'\n"
>             "    instead\n"
>             "  '-c' indicates that target image must be compressed (qco=
w format only)\n"
> -           "  '-u' enables unsafe rebasing. It is assumed that old and=
 new backing file\n"
> -           "       match exactly. The image doesn't need a working bac=
king file before\n"
> -           "       rebasing in this case (useful for renaming the back=
ing file)\n"
> +           "  '-u' allows unsafe backing chains. For rebasing, it is a=
ssumed that old and new\n"
> +           "       backing file match exactly. The image doesn't need =
a working backing file\n"
> +           "       before rebasing in this case (useful for renaming t=
he backing file)\n"
> +           "       For image creation, allow creating without attempti=
ng to"
> +           "       open the backing file.\n"

You forgot to fix my v2 review comments ('.', \n)

With that (actually) fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Xl6ahsbExTFdmt7CUbxVVx7rhav7dkxNo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFICZAAoJEKeha0olJ0NqG+gH/3lUqDqqppcz31tJ5PVE7AVD
4anJzyDy71umuX7Bq4F1cEESfdcZThP/Xs26/ay2eijbG14WOdz+gaRNtFUMf9Wc
/tVm4lAKV/xNH0s7dFy/H6jyM/xcHvsixlejXk4o30IY9fTsAAjwbMFMW2+c3h8R
k2ugzzhCjCdQBdMSWphwLgLbMpZr/nMn2jgyiD07z1+phnTwKAAZ6T7Ex+fXhrst
ODNIvLc8AEvLr2WapCkWpSIzZiwGOQ6Z1aWIHSB1gbzJ8K6/nRHUo/Tz2V2ItoWf
UzH+7N6GfBoRhCvZHwnf3XVhEfh811ADFjXKfKG2vTvEBNmzG6MdO+gfoj5xfuc=
=Ls19
-----END PGP SIGNATURE-----

--Xl6ahsbExTFdmt7CUbxVVx7rhav7dkxNo--
