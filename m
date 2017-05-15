Received: from eggs.gnu.org ([2001:4830:134:3::10]:39499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAMpo-00039M-Pg
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAMpn-0000G9-P8
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:43:16 -0400
References: <20170515203114.9477-1-hpoussin@reactos.org>
	<20170515203114.9477-2-hpoussin@reactos.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77e136d2-34f0-87db-914c-84d3990269b9@redhat.com>
Date: Mon, 15 May 2017 15:42:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170515203114.9477-2-hpoussin@reactos.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mAewADuvaLQ40PLqIOguJU4K24U3NuCo1"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 01/13] vvfat: fix qemu-img map
 and qemu-img convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mAewADuvaLQ40PLqIOguJU4K24U3NuCo1
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Message-ID: <77e136d2-34f0-87db-914c-84d3990269b9@redhat.com>
Subject: Re: [Qemu-block] [PATCH 01/13] vvfat: fix qemu-img map and qemu-img
 convert
References: <20170515203114.9477-1-hpoussin@reactos.org>
 <20170515203114.9477-2-hpoussin@reactos.org>
In-Reply-To: <20170515203114.9477-2-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2017 03:31 PM, Herv=C3=A9 Poussineau wrote:
> - bs->total_sectors is the number of sectors of the whole disk
> - s->sector_count is the number of sectors of the FAT partition
>=20
> This fixes the following assert in qemu-img map:
> qemu-img.c:2641: get_block_status: Assertion `nb_sectors' failed.
>=20
> This also fixes an infinite loop in qemu-img convert.
>=20
> Fixes: 4480e0f924a42e1db8b8cfcac4d0634dd1bb27a0

Wow - broken since 1.2? Not many vvfat users, are there.

Herv=C3=A9, you might want to work out with Kevin whether to take
co-maintainership over vvfat, in addition to your other areas.

> Fixes: https://bugs.launchpad.net/qemu/+bug/1599539
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

CC: qemu-stable@nongnu.org

> ---
>  block/vvfat.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

(I will rebase my work for changing block_status into byte-based on top
of this)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mAewADuvaLQ40PLqIOguJU4K24U3NuCo1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGhLOAAoJEKeha0olJ0NqWjIIAISySseDLyjpHygJR5eD26Tv
bqlptjFloOwqDm7qUCYax7VOInmIItGGDh666RIsYZDwf+gx5VigzOQhoxuwZPfC
NniOjmHj/LCDd6PJCmqjdDiFGCkzLmrtC1MWHClu1mX0YpEDZf/6YWeCvwjRw2eH
+EQe65KKzZkdGFDg1HRxfOPKakCnRTFO6JAQGcqWmxxNJbbVr5jIpOz30pf+ZVys
qsTBIUtu0eOMWbVAGGZ5UylbupK+Mxeyl0Nfa155A5CvoqY9+3z19oSgE6CZMDOX
NVdxGka7BAs1QOwZfY8jaDng8xU+LfaiB1TSGY24vUX4XdwPOPU3tiO8twSZmuY=
=YDPk
-----END PGP SIGNATURE-----

--mAewADuvaLQ40PLqIOguJU4K24U3NuCo1--
