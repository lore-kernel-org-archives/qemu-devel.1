Received: from eggs.gnu.org ([2001:4830:134:3::10]:40488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egBtd-0005OO-P8
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egBtZ-0003gO-3U
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:03:01 -0500
References: <20171226025247.11082-1-famz@redhat.com>
	<20171226025247.11082-3-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7c728aa5-4623-79c6-3e6a-04e2b19aefba@redhat.com>
Date: Mon, 29 Jan 2018 17:01:41 +0100
MIME-Version: 1.0
In-Reply-To: <20171226025247.11082-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Y1tVZeyLC4jyvIXhwyieRVq8DmUroFfix"
Subject: Re: [Qemu-devel] [PATCH v5 2/2] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kchamart@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y1tVZeyLC4jyvIXhwyieRVq8DmUroFfix
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kchamart@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com
Message-ID: <7c728aa5-4623-79c6-3e6a-04e2b19aefba@redhat.com>
Subject: Re: [PATCH v5 2/2] qemu-img: Document --force-share / -U
References: <20171226025247.11082-1-famz@redhat.com>
 <20171226025247.11082-3-famz@redhat.com>
In-Reply-To: <20171226025247.11082-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-26 03:52, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-img.texi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 60a0e080c6..e83e140f7a 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -86,6 +86,15 @@ exclusive with the @var{-O} parameters. It is curren=
tly required to also use
>  the @var{-n} parameter to skip image creation. This restriction may be=
 relaxed
>  in a future release.
> =20
> +@item --force-share (-U)
> +

So the previous patch makes the use of blank lines consistent and this
one breaks it again? :-)

> +If specified, @code{qemu-img} will open the image with shared permissi=
ons,
> +which makes it less likely to conflict with a running guest's permissi=
ons due
> +to image locking. For example, this can be used to get the image infor=
mation
> +(with 'info' subcommand) when the image is used by a running guest. No=
te that
> +this could produce inconsistent results because of concurrent metadata=
 changes,
> +etc. This option is only allowed when opening images in read-only mode=
=2E

I personally don't quite like the "makes it less likely to conflict",
because that makes it sound like qemu would be stupid and need a nudge
in the right direction -- when it's actually the user who does something
a bit risky (and qemu is right in forbidding it by default).  But since
it's only a read-only thing, I won't actually object to it.

(Maybe it should document more exactly what's happening, i.e. that this
option will allow concurrent writers (as a standard user, I wouldn't
know what "shared permissions" is supposed to mean).)

Max

> +
>  @item --backing-chain
>  will enumerate information about backing files in a disk image chain. =
Refer
>  below for further description.
>=20



--Y1tVZeyLC4jyvIXhwyieRVq8DmUroFfix
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvRWUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A8R4H/1zmd62VeR8CoSlsljL+3jCFWajphHpu
B+CgCjL9eSZqUv9ZlPJ0rYKACpG1QFNwH6mh9sWxIHm1S7rVSTtR/IKjm8B/Oz16
zj6mEpY8xYRcHgzqG4giEvf39TPHEWFGQaAjSj5t3xx8qeaLA2jA77uv8Ubgfwc/
snAWektCXaJRB49qVci2+SvXjBQIKX4SK0ZhLbukubFmZB0UoDCOkT4CmZRHlZfT
lp1mVKu15zAqLN1BZlHdc51aLhDeJxh4RbiGFFUxdO+YnapzmvPL3jSFeUBI+dG5
kdr0NpN04uav2jqGq+/uyugvnYdsRP09ObR9uUvwF3AHxL/4XHOMjHU=
=C4C/
-----END PGP SIGNATURE-----

--Y1tVZeyLC4jyvIXhwyieRVq8DmUroFfix--
