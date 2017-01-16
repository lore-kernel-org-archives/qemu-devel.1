Received: from eggs.gnu.org ([2001:4830:134:3::10]:48331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTGIb-0007EN-4b
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTGIa-0001k8-4F
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:02:49 -0500
References: <20170111181432.18868-1-mreitz@redhat.com>
	<20170116204921.31578-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0aa10ac5-84cb-f750-ce5e-cb6132ebbc60@redhat.com>
Date: Mon, 16 Jan 2017 17:02:39 -0600
MIME-Version: 1.0
In-Reply-To: <20170116204921.31578-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="riXiDTJ8MQJ9C5xULOsCLGIGad8ScKvQ4"
Subject: Re: [Qemu-devel] [PATCH v4 10/25] block: Add bdrv_dirname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--riXiDTJ8MQJ9C5xULOsCLGIGad8ScKvQ4
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <0aa10ac5-84cb-f750-ce5e-cb6132ebbc60@redhat.com>
Subject: Re: [PATCH v4 10/25] block: Add bdrv_dirname()
References: <20170111181432.18868-1-mreitz@redhat.com>
 <20170116204921.31578-3-mreitz@redhat.com>
In-Reply-To: <20170116204921.31578-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2017 02:49 PM, Max Reitz wrote:
> This function may be implemented by block drivers to derive a directory=

> name from a BDS. Concatenating this g_free()-able string with a relativ=
e
> filename must result in a valid (not necessarily existing) filename, so=

> this is a function that should generally be not implemented by format
> drivers, because this is protocol-specific.
>=20
> If a BDS's driver does not implement this function, bdrv_dirname() will=

> fall through to the BDS's file if it exists. If it does not, the
> exact_filename field will be used to generate a directory name.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block.h     |  1 +
>  include/block/block_int.h |  1 +
>  block.c                   | 26 ++++++++++++++++++++++++++
>  3 files changed, 28 insertions(+)

> +++ b/include/block/block_int.h
> @@ -130,6 +130,7 @@ struct BlockDriver {
>      int (*bdrv_make_empty)(BlockDriverState *bs);
> =20
>      void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options=
);
> +    char *(*bdrv_dirname)(BlockDriverState *bs, Error **errp);

I know we've been lousy at documentation in the past, but should we
start doing a better job of documenting the contract as we add new
callbacks, rather than just the commit messages?

Based on existing practice, though, I'm okay with:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--riXiDTJ8MQJ9C5xULOsCLGIGad8ScKvQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfVEPAAoJEKeha0olJ0NqJnUH/Rq0ZTnBZT7JrLKjvwR3SE/W
r6liVSaIBulgsqYTmRnAKKmSpivMnoPa7T7RF/yLkJUH9E5N5USBCYjbGRJmUCL1
mTkCutpY+5yZFxsjLWuHcX3nIF1u4zKNESDK+AXgtxz1Bo8PqasCHKYExVrreBk7
8TuAIY9IubjVddYOCIMlyetHBDgrd2Xaraoixk+r9RBQAaUx87rfJ0vph9ufO7gA
zrZ8zUYohsLblDWZ2v8YGwd0q4MM5Ru+mDBHKlPLofkoH86LfvpijyJdXYcvyenU
udAIELD1ZmA8YPfCfXYxIHtQ7Mn/tqlKS4+SNe5V0qUsz30aKCb0bEzLR70fMn0=
=/Gp9
-----END PGP SIGNATURE-----

--riXiDTJ8MQJ9C5xULOsCLGIGad8ScKvQ4--
