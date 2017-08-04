Received: from eggs.gnu.org ([2001:4830:134:3::10]:55066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dddYW-0003Sx-TB
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dddWm-0002Cw-DQ
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:26:24 -0400
References: <20170804135545.28266-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <301cd265-7c95-e9da-7c30-e3c342bbae54@redhat.com>
Date: Fri, 4 Aug 2017 09:23:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170804135545.28266-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Kp5ambocseKwbJS0h6bHBmAMIfPMcMMNk"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-img: Clarify about
 relative backing file options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kp5ambocseKwbJS0h6bHBmAMIfPMcMMNk
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <301cd265-7c95-e9da-7c30-e3c342bbae54@redhat.com>
Subject: Re: [Qemu-block] [PATCH] qemu-img: Clarify about relative backing
 file options
References: <20170804135545.28266-1-famz@redhat.com>
In-Reply-To: <20170804135545.28266-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 08:55 AM, Fam Zheng wrote:
> It's not too surprising when a user specifies the backing file relative=

> to the current working directory instead of the top layer image. This
> causes error when they differ. Though the error message has enough
> information to infer the fact about the misunderstanding, it is better
> if we document this explicitly, so that users don't have to learn from
> mistakes.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.texi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 72dabd6b3e..cf079f90e2 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -244,6 +244,9 @@ only the differences from @var{backing_file}. No si=
ze needs to be specified in
>  this case. @var{backing_file} will never be modified unless you use th=
e
>  @code{commit} monitor command (or qemu-img commit).
> =20
> +If a relative path name is given, the backing file is looked up agains=
t
> +@var{filename}, rather than the current working directory.

Maybe better as:
the backing file is looked up relative to the directory containing
@var{filename}

In all three places

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Kp5ambocseKwbJS0h6bHBmAMIfPMcMMNk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEg1kACgkQp6FrSiUn
Q2rJ6Af/d8j/4PBTW0C2Q0HSm62Vb6b6uX7qCBNCsS7qU9ORcWQ5k7vjTpdn33pK
Ix8MIvVFzJCVpuyhSsNWdJVKJCcwNNKpoQyU0EBCqIAFUZmsqtp5dIe+0S8XRhsx
FUmRd2zw6UPGloxCizhnShwCHclgogWdJRgk50DmjdjNcibi2wparuVBgZ84PfVD
5b3znfyynN1cQ0cQxozTLYHX1CZ9XiBn4v3n55k0nP/CBR7z1mrHvb4hTWWumz5D
SN4803MJJPwBHbdqcR7ImZaqMllqOkYAiPUMbFhWxEQ05luhy0oYHLVlphJF9X+I
W7FYFHjUcD5b5g2EsV0cHSPZLpaGtg==
=dCKl
-----END PGP SIGNATURE-----

--Kp5ambocseKwbJS0h6bHBmAMIfPMcMMNk--
