Received: from eggs.gnu.org ([2001:4830:134:3::10]:33765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1edfE5-00086c-QP
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1edfE5-0002Pc-2j
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:45:41 -0500
References: <20180122072102.4141-1-lma@suse.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <17afc198-ba65-e0b8-f568-34f5899e7477@redhat.com>
Date: Mon, 22 Jan 2018 17:45:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180122072102.4141-1-lma@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Pqtt93JpTXhvrA386iQk5LUYvPOZv0FeU"
Subject: Re: [Qemu-devel] [PATCH] raw: Disable probing if image format is
 given by driver-specific options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pqtt93JpTXhvrA386iQk5LUYvPOZv0FeU
From: Max Reitz <mreitz@redhat.com>
To: Lin Ma <lma@suse.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com
Message-ID: <17afc198-ba65-e0b8-f568-34f5899e7477@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] raw: Disable probing if image format is
 given by driver-specific options
References: <20180122072102.4141-1-lma@suse.com>
In-Reply-To: <20180122072102.4141-1-lma@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-22 08:21, Lin Ma wrote:
> If the user specifies image format through driver-specific options, The=

> format probing should be prohibited and the warning message should not
> be printed.
>=20
> e.g.:
> $ qemu-system-x86_64 ... -drive file.file.filename=3Ddisk0.raw,file.dri=
ver=3Draw ...
> WARNING: Image format was not specified for 'disk0.raw' and probing gue=
ssed raw.
>          Automatically detecting the format is dangerous for raw images=
, ...
>=20
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  blockdev.c | 2 ++
>  1 file changed, 2 insertions(+)

But what has been proped is the driver for the root BDS, so the warning
is actually correct.

(That command line is creating a chain of three BDS:
raw (probed) -> raw (explicitly specified) -> file (default protocol))

Max


--Pqtt93JpTXhvrA386iQk5LUYvPOZv0FeU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpmFScSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9A0H/AnaiaKsS7cTBNwyFXOFvEV6o8I1GpPK
lwbJo/GKeucP34ADNsweSZnZ/GurrdUBxM/nGwln2oA4fas32Ec/mfDDXgeDuzqA
AcfA2wA1ojkdKdKoQEJAm60PCL7L2fSiPaDStiv6X6P8Wmdlbtlewxg86DW2nY+w
AgwD3OvSaMtDaSOQJnPwRjZ5XNN6RSBJCwMYCkrNzpmJx/DhKTK2R/41Vsy2jP+6
zMmRnEqhllT6dE1GJAp6gEn0cmIUKcbErQcx90FqswmNNYTqlk0wiXzJPXesdmBi
1snrPJ7t2teehsmdKoNpa2iT7bB19tuLiRx/LQtnQJnQo3k4UrmPJL4=
=nrfl
-----END PGP SIGNATURE-----

--Pqtt93JpTXhvrA386iQk5LUYvPOZv0FeU--
