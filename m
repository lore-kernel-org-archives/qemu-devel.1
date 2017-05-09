Received: from eggs.gnu.org ([2001:4830:134:3::10]:57352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d89hs-0000QL-J2
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d89hr-0000kK-EX
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:17:56 -0400
References: <20170509180946.17046-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0a25ed7b-174f-1860-cef4-d141b5de3d64@redhat.com>
Date: Tue, 9 May 2017 13:17:35 -0500
MIME-Version: 1.0
In-Reply-To: <20170509180946.17046-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4ENGhb2E48spkQ3b2V4MaJG4VUKpeTMd6"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: Check for backing image if
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
--4ENGhb2E48spkQ3b2V4MaJG4VUKpeTMd6
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <0a25ed7b-174f-1860-cef4-d141b5de3d64@redhat.com>
Subject: Re: [PATCH v2] qemu-img: Check for backing image if specified during
 create
References: <20170509180946.17046-1-jsnow@redhat.com>
In-Reply-To: <20170509180946.17046-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 01:09 PM, John Snow wrote:
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
>=20
> v2: Rebased for 2.10
>     Corrected some of my less cromulent grammar
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

Missing \n

With that fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4ENGhb2E48spkQ3b2V4MaJG4VUKpeTMd6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEge/AAoJEKeha0olJ0NqxLQH/1cvOZH5E6Fue9l1G5Sirzw/
0ASGvMePsX+3+ljDM7NEoQsGTaM3tlwV/1oSDHQA7DyBB7QXsVGzzOO3/RqBt/7D
3VMRgTCRt1kiagaHauCobxXOEZ+eWbSjc2T/w+Ys3LCGk4SmTYXwZsGvideBw5W0
718kXR8zreyJ/0wyu/Emh3le1MajaBCJp81tLdMB0DpfntNXKKORFe3Mfx98FYpB
a024cqj22elQAbu01ZeVTeFGa54l2NYBS3NIZXO3RR7BBh4iXfjZjpzc4F5CcpaF
zcClUwUsVo9XZGcHkVrTz8BB4OHFItdteyUhFLIkPOIcft2v+OSnABebAnfQKRE=
=euoT
-----END PGP SIGNATURE-----

--4ENGhb2E48spkQ3b2V4MaJG4VUKpeTMd6--
