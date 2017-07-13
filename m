Received: from eggs.gnu.org ([2001:4830:134:3::10]:55059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVka1-00044l-RF
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVka0-0003PZ-Tt
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:19:21 -0400
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <047c933f-66d7-d9c8-ccd1-bbd8e1cb4fc2@redhat.com>
Date: Thu, 13 Jul 2017 15:19:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-4-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OLQCjO3dkEx6DaQ3FbCHQWeDQrSmpBW98"
Subject: Re: [Qemu-devel] [PATCH v2 03/29] vhdx: use QEMU_ALIGN_DOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org, "open list:VHDX" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OLQCjO3dkEx6DaQ3FbCHQWeDQrSmpBW98
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 "open list:VHDX" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org,
 Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <047c933f-66d7-d9c8-ccd1-bbd8e1cb4fc2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/29] vhdx: use QEMU_ALIGN_DOWN
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
 <20170713163219.9024-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 11:31 AM, Marc-Andr=C3=A9 Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/vhdx-log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/vhdx-log.c b/block/vhdx-log.c
> index 01278f3fc9..ad70706b99 100644
> --- a/block/vhdx-log.c
> +++ b/block/vhdx-log.c
> @@ -884,7 +884,7 @@ static int vhdx_log_write(BlockDriverState *bs, BDR=
VVHDXState *s,
>      }
> =20
>      sector_offset =3D offset % VHDX_LOG_SECTOR_SIZE;
> -    file_offset =3D (offset / VHDX_LOG_SECTOR_SIZE) * VHDX_LOG_SECTOR_=
SIZE;
> +    file_offset =3D QEMU_ALIGN_DOWN(offset, VHDX_LOG_SECTOR_SIZE);
> =20
>      aligned_length =3D length;
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OLQCjO3dkEx6DaQ3FbCHQWeDQrSmpBW98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ9W+AAoJEKeha0olJ0Nq71sH/j9juEwhzgdRQBITVCLsSI6C
aKEU6c7SThAXIyUFoCQIDbDFApb+ksMR8//i52AK/x29H9Jod/rdsgrE9iHIp0kg
QorDyJjN9B6cCgZkBVf7YaBZr01cCBmdP+i9lfNWDCPjcJmrf6kMaWxmj7V+SpUZ
lzVr493t5bsn7CWs7nXPLCCFmu/dvglrqCVbBYuvHdae/ZdpBNw+gu+EgC9E9I6I
q74W8g8V7vK2Y/yWJZ1XD6LFSi0niBfFjDZQpwTEZzJBKMy2gKwzeRKofWAXwQLj
/scXfN6V1uwl+XnN2Kqdy6rjfOGjKyDUpVCHEY5Ly8hzqarwT6mVD5ttNqtoW8Y=
=iyCi
-----END PGP SIGNATURE-----

--OLQCjO3dkEx6DaQ3FbCHQWeDQrSmpBW98--
