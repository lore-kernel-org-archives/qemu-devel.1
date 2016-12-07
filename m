Received: from eggs.gnu.org ([2001:4830:134:3::10]:59320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEhH8-00065m-HM
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEhH7-0000es-OR
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:49:06 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-17-git-send-email-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cc7f7920-fb94-526d-3cfe-ef96a1d85929@redhat.com>
Date: Wed, 7 Dec 2016 12:48:53 -0600
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-17-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7u1aPJenJWUE1dq3gpskaeHB15rs4qwXe"
Subject: Re: [Qemu-devel] [PATCH 16/21] qmp: add persistent flag to
 block-dirty-bitmap-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7u1aPJenJWUE1dq3gpskaeHB15rs4qwXe
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <cc7f7920-fb94-526d-3cfe-ef96a1d85929@redhat.com>
Subject: Re: [PATCH 16/21] qmp: add persistent flag to block-dirty-bitmap-add
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-17-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479835586-74394-17-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/22/2016 11:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add optional 'persistent' flag to qmp command block-dirty-bitmap-add.
> Default is false.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---

> +++ b/qapi/block-core.json
> @@ -1231,10 +1231,15 @@
>  # @granularity: #optional the bitmap granularity, default is 64k for
>  #               block-dirty-bitmap-add
>  #
> +# @persistent: #optional the bitmap is persistent, i.e. it will be sav=
ed to the
> +#              corresponding block device image file on its close. Def=
ault is
> +#              false. (Since 2.8)

s/2.8/2.9/

> +#
>  # Since 2.4
>  ##
>  { 'struct': 'BlockDirtyBitmapAdd',
> -  'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32' } }=

> +  'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
> +            '*persistent': 'bool' } }
> =20
>  ##
>  # @block-dirty-bitmap-add
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7u1aPJenJWUE1dq3gpskaeHB15rs4qwXe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEbBAEBCAAGBQJYSFmVAAoJEKeha0olJ0NqvUAH92ODYrb0+CWtl3xZ+pjb+1jf
jMX+FsItXEClvobf3Gxu/t4THFQHjkdc5+Uz+8a7TNHr0lpu3yWKy0qYi9Lvt7vd
Y92Fs1oZvnujoKQD+hpMq4KCS7z6R/Z0Sc18azHywpFODHnYkmd74Fphzxfa9Syc
uAhclrMLK/6Rcc6CUtARVczbBq4FYfPP9B/uFCrTnQ6mXGB8GhsFlrBLb3mM7FtV
jZIaoQNs7oaAHG4LVDUvfP3xAFX83E1yeksnowXo48NFpKCiqEPbi8sj4FyraptD
hOfp7YbpDG47gblRWTuSQTG/CDAyKKdAV9rtLZbTvV26oHuZaMgDJNh+ZET4pA==
=1bcm
-----END PGP SIGNATURE-----

--7u1aPJenJWUE1dq3gpskaeHB15rs4qwXe--
