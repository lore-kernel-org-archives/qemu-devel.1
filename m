Received: from eggs.gnu.org ([2001:4830:134:3::10]:45238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwXe4-0003BI-L0
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwXe3-0008BP-CR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:58:16 -0400
References: <20170925122808.14561-1-kwolf@redhat.com>
	<20170925122808.14561-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bdecad1e-5adc-f8c1-aa1d-c73715e48c77@redhat.com>
Date: Mon, 25 Sep 2017 12:58:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170925122808.14561-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6q3ssT0e5rrCui7egvsFE93fuDcoJRWMD"
Subject: Re: [Qemu-devel] [PATCH 1/5] block: Introduce
 BdrvChildRole.update_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6q3ssT0e5rrCui7egvsFE93fuDcoJRWMD
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org
Message-ID: <bdecad1e-5adc-f8c1-aa1d-c73715e48c77@redhat.com>
Subject: Re: [PATCH 1/5] block: Introduce BdrvChildRole.update_filename
References: <20170925122808.14561-1-kwolf@redhat.com>
 <20170925122808.14561-2-kwolf@redhat.com>
In-Reply-To: <20170925122808.14561-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2017 07:28 AM, Kevin Wolf wrote:
> There is no good reason for bdrv_drop_intermediate() to know the active=

> layer above the subchain it is operating on - even more so, because
> the assumption that there is a single active layer above it is not
> generally true.
>=20
> In order to prepare removal of the active parameter, use a BdrvChildRol=
e
> callback to update the backing file string in the overlay image instead=

> of directly calling bdrv_change_backing_file().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block_int.h |  6 ++++++
>  block.c                   | 33 ++++++++++++++++++++++++++++-----
>  2 files changed, 34 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6q3ssT0e5rrCui7egvsFE93fuDcoJRWMD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnJQ7AACgkQp6FrSiUn
Q2rS1wf5AbBzMN3JophdnBS61KKBuqzDkktpHHemDi9dovSQT8edq2cmInhNeaIU
zJaKCwi8Cw8eXEWh3WD9WxCp13qFBFd/PQy77eajix5mWqK+Fzca5zQnCUdd9Vre
qSyC7upz0vmx/gOUqobvRVVc2+H3U/Xnl6GRWWh1q4lk7IYSdEO3sbCBLWjrDuIP
rBawmDdNYcrEj0/hIxf2JWqnU0xF/IoNC8OFQpYxabhw8XXStSINKjra3+Fox0DT
X5sNJvXnTkUmE3/o/vjnuyQTGqjnFaocIEkS0EjBGRhSEy3D2YmX06dOZlOg0gVz
w1fNPmbisuufpKt5ay/2cXYoM8XyCA==
=hnUT
-----END PGP SIGNATURE-----

--6q3ssT0e5rrCui7egvsFE93fuDcoJRWMD--
