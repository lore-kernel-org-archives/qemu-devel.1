Received: from eggs.gnu.org ([2001:4830:134:3::10]:37168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cno7r-0008JO-38
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cno7q-0005SY-3j
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:12:39 -0400
References: <1489478243-10366-1-git-send-email-jemmy858585@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <420d9095-bde2-6573-e883-ab6b57d4a860@redhat.com>
Date: Tue, 14 Mar 2017 10:12:30 -0500
MIME-Version: 1.0
In-Reply-To: <1489478243-10366-1-git-send-email-jemmy858585@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Wp1oqAsToWTONtNeverHoiXBLr4kFnQuN"
Subject: Re: [Qemu-devel] [PATCH] migration/block: Avoid involve into
 blk_drain too frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com, stefanha@redhat.com, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wp1oqAsToWTONtNeverHoiXBLr4kFnQuN
From: Eric Blake <eblake@redhat.com>
To: jemmy858585@gmail.com, stefanha@redhat.com, famz@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <420d9095-bde2-6573-e883-ab6b57d4a860@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration/block: Avoid involve into
 blk_drain too frequently
References: <1489478243-10366-1-git-send-email-jemmy858585@gmail.com>
In-Reply-To: <1489478243-10366-1-git-send-email-jemmy858585@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 02:57 AM, jemmy858585@gmail.com wrote:
> From: Lidong Chen <jemmy858585@gmail.com>
>=20
> Increase bmds->cur_dirty after submit io, so reduce the frequency invol=
ve into blk_drain, and improve the performance obviously when block migra=
tion.

Long line; please wrap your commit messages, preferably around 70 bytes
since 'git log' displays them indented, and it is still nice to read
them in an 80-column window.

Do you have benchmark numbers to prove the impact of this patch, or even
a formula for reproducing the benchmark testing?

>=20
> Signed-off-by: Lidong Chen <jemmy858585@gmail.com>
> ---
>  migration/block.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/migration/block.c b/migration/block.c
> index 6741228..f059cca 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -576,6 +576,8 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMi=
gDevState *bmds,
>              }
> =20
>              bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector, nr_sec=
tors);
> +            sector +=3D nr_sectors;
> +            bmds->cur_dirty =3D sector;
>              break;
>          }
>          sector +=3D BDRV_SECTORS_PER_DIRTY_CHUNK;
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Wp1oqAsToWTONtNeverHoiXBLr4kFnQuN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyAheAAoJEKeha0olJ0NqZL8H/1upFcuh5LKrRsQQ5/dqYoO+
VioZW34MqgnnU0Yag5YTVMtKFa2ZHsxM4YxdSlsKcctG4QZIpcKtGDvrKLsQDkJJ
g74X3C2H3AMQ4JZYVDYa4J5yvpjqwf5Xx50D3aB4pAOaNUH6AAdjd314z4N48toH
gQ0KqJYU9vVvpCDW7ELleDZgXb0FCaMVjMBj8crScZZlkWhAwgIs7qUY1MTuTB+r
iPELuJLRY1OFZSYPrHNDMD/ikyBY1GkTI6knVkRjqtDK+3WXCGdszdPE9GUsk7Q+
cQOs0gjvAryCWVBzxderr7SLVzxWYW/JYtvDHRsPTuKB/CtrphrR6OKR7l/4zfI=
=sJmY
-----END PGP SIGNATURE-----

--Wp1oqAsToWTONtNeverHoiXBLr4kFnQuN--
