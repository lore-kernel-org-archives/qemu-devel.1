Received: from eggs.gnu.org ([209.51.188.92]:34467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ggZRC-0000mb-0o
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ggZR9-0000lQ-N7
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:15:45 -0500
References: <1544698788-52893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3a60eace-dc00-c82c-4d2a-784e1796ab9a@redhat.com>
Date: Mon, 7 Jan 2019 19:15:31 +0100
MIME-Version: 1.0
In-Reply-To: <1544698788-52893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="47q9kjbKS0JDebtkt05QyNM26Ws0kXJRV"
Subject: Re: [Qemu-devel] [PATCH v7] qemu-img info lists bitmap directory
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--47q9kjbKS0JDebtkt05QyNM26Ws0kXJRV
From: Max Reitz <mreitz@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <3a60eace-dc00-c82c-4d2a-784e1796ab9a@redhat.com>
Subject: Re: [PATCH v7] qemu-img info lists bitmap directory entries
References: <1544698788-52893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1544698788-52893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.12.18 11:59, Andrey Shinkevich wrote:
> In the 'Format specific information' section of the 'qemu-img info'
> command output, the supplemental information about existing QCOW2
> bitmaps will be shown, such as a bitmap name, flags and granularity:
>=20
> image: /vz/vmprivate/VM1/harddisk.hdd
> file format: qcow2
> virtual size: 64G (68719476736 bytes)
> disk size: 3.0M
> cluster_size: 1048576
> Format specific information:
>     compat: 1.1
>     lazy refcounts: true
>     bitmaps:
>         [0]:
>             flags:
>                 [0]: in-use
>                 [1]: auto
>             name: back-up1
>             unknown flags: 4
>             granularity: 65536
>         [1]:
>             flags:
>                 [0]: in-use
>                 [1]: auto
>             name: back-up2
>             unknown flags: 8
>             granularity: 65536
>     refcount bits: 16
>     corrupt: false
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

The patch itself looks OK, but it breaks a couple of iotests, namely
060, 065, 082, 112, 198, and 206.

In addition, an iotest specifically for this new feature would be nice
as well.

Max


--47q9kjbKS0JDebtkt05QyNM26Ws0kXJRV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwzl0MACgkQ9AfbAGHV
z0CGHQf+KyfuJpp7/2bYZEXyzi60CcyirCjgP3HFPK+mXwyMBNFv6KFpfFgMGWqm
pmsdzDrfunFr+ioV/th78iwVrO+KR2IcH20UiMSVk/YPR021r+K7PubXyTAd7Uag
l1YEWaIwSgXJB5rp4vOl1AJgJ0JOFpMhf7/2Mj9pmEj8oB6NSgmUX1n840dbxX64
pp9FTIcxYjoTGPQ/3QwIhqbiUmhnvDDmuH6Hs2HhOB7LvgELvC/Nxmr6LELZwCZk
AkpJITBkV9lvpr9iPTJwBofVq62EYKxly3PNaNu9zHiDuxj+2vv7DiIM9WTSlB3u
gWCyoAKMKRmhLGmOK5fOJLlVdFimCg==
=9mZT
-----END PGP SIGNATURE-----

--47q9kjbKS0JDebtkt05QyNM26Ws0kXJRV--
