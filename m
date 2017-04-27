Received: from eggs.gnu.org ([2001:4830:134:3::10]:36953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3lSz-0003ef-CY
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3lSx-0007P3-PL
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:36:24 -0400
References: <20170426134649.9042-1-mreitz@redhat.com>
	<20170426134649.9042-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a78836bc-8a79-6164-1101-6aa756c07a40@redhat.com>
Date: Thu, 27 Apr 2017 10:36:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170426134649.9042-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eCpKgjOn8o5N8Uv3opuDcOLigABhJVxxB"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu-img: Document backing options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eCpKgjOn8o5N8Uv3opuDcOLigABhJVxxB
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a78836bc-8a79-6164-1101-6aa756c07a40@redhat.com>
Subject: Re: [PATCH v2 3/3] qemu-img: Document backing options
References: <20170426134649.9042-1-mreitz@redhat.com>
 <20170426134649.9042-4-mreitz@redhat.com>
In-Reply-To: <20170426134649.9042-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 08:46 AM, Max Reitz wrote:
> The create and convert subcommands have shorthands to set the
> backing_file and, in the case of create, the backing_fmt options for th=
e
> new image. However, they have not been documented so far, which is
> remedied by this patch.
>=20

> +++ b/qemu-img.texi
> @@ -224,7 +224,7 @@ If @code{-r} is specified, exit codes representing =
the image state refer to the
>  state after (the attempt at) repairing it. That is, a successful @code=
{-r all}
>  will yield the exit code 0, independently of the image state before.
> =20
> -@item create [-f @var{fmt}] [-o @var{options}] @var{filename} [@var{si=
ze}]
> +@item create [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_f=
mt}] [-o @var{options}] @var{filename} [@var{size}]
> =20
>  Create the new disk image @var{filename} of size @var{size} and format=

>  @var{fmt}. Depending on the file format, you can add one or more @var{=
options}
> @@ -302,7 +302,7 @@ Error on reading data
> =20
>  @end table
> =20
> -@item convert [-c] [-p] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{=
src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id=
_or_name}] [-l @var{snapshot_param}] [-m @var{num_coroutines}] [-W] [-S @=
var{sparse_size}] @var{filename} [@var{filename2} [...]] @var{output_file=
name}
> +@item convert [-c] [-p] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{=
src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{option=
s}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-m @var{num=
_coroutines}] [-W] [-S @var{sparse_size}] @var{filename} [@var{filename2}=
 [...]] @var{output_filename}
> =20
>  Convert the disk image @var{filename} or a snapshot @var{snapshot_para=
m}(@var{snapshot_id_or_name} is deprecated)
>  to disk image @var{output_filename} using format @var{output_fmt}. It =
can be optionally compressed (@code{-c}


On 04/27/2017 10:25 AM, Kevin Wolf wrote:

> I think originally the idea was to remove the individual special case
> options in the long term in favour of the uniform -o. But I don't think=

> the short options have fallen out of use, so we can as well document
> them again...
>
> Maybe we could change the implementation, however, so that the old
> options are really just aliases for the respective -o version.

As in, a followup patch that adds a paragraph or two to the .texi file
stating that '-B @var{backing_file}' is shorthand for '-o
backing_file=3D@var{backing_file}'?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eCpKgjOn8o5N8Uv3opuDcOLigABhJVxxB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAg/uAAoJEKeha0olJ0NqaNkH/2J/MpHocHpYwCJoI/o4jvdd
Q6tG5PwZIaAYGIQYE1LmECfOQsl2noDNtP3uqCdr355aLI6loVTpgZZFnOm1j3ry
rNegGPQ0D5I4FSRlsvpQKNyXZ6Zx6oFjAt6xAnfkcS4L5z+UGV3N1kfUnyInVtFQ
WXkPTIAjVfhYtTO1dlPNQsBspveSgziTFcXAWn65wh+LG1ruCaeVTAWw7gSln6D6
l3LD2pWAW3jwORU0cDmjQWo+AeJ+TL0JwTYz7e7Jo89JyMfmV+AiwTiQotzRghK4
Rl5Wfzb5q6eUuylwmg9DZoNBlbhUL0c0Lj0nhgHHzciFT3kqnNqc/GwzKhjrGUA=
=GVrg
-----END PGP SIGNATURE-----

--eCpKgjOn8o5N8Uv3opuDcOLigABhJVxxB--
