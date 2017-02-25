Received: from eggs.gnu.org ([2001:4830:134:3::10]:53511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1che3w-0001vz-5O
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:15:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1che3v-0003L0-F7
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:15:08 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-53-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c459713a-5430-942e-8bee-a40676187342@redhat.com>
Date: Sat, 25 Feb 2017 16:14:59 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-53-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2uW6sw4qQJ70UDbsphXT4uitg6QE4BF9r"
Subject: Re: [Qemu-devel] [PATCH 52/54] block: Assertions for resize
 permission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2uW6sw4qQJ70UDbsphXT4uitg6QE4BF9r
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <c459713a-5430-942e-8bee-a40676187342@redhat.com>
Subject: Re: [PATCH 52/54] block: Assertions for resize permission
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-53-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-53-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> This adds an assertion that ensures that the necessary resize permissio=
n
> has been granted before bdrv_truncate() is called.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--2uW6sw4qQJ70UDbsphXT4uitg6QE4BF9r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixn3MSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4I8IAMLiZw2KecywOAYzyYpFNqElHJhx/eBa
gKbsu8/zJ9i8JHfWCvF7UHpDyuxd16bib9OoXh0rt/qrqKM/xsk1Ktv93mNVVhxE
whRDwqyfQcY03Xd8xcyZTiY4DRDBZ4FP+TFUZ3ohcYD9Rbk6UaD2x4dXrkA5dMHC
vqBoCBMkuZAXpRLNERwXe1gVNMforcKsFEK3lGAsoX0uFPIfuqcKS3xoYgCwktEn
E5d4A1jv+Kq86A/Dg4LbEzwzJ4Ds8w2cvdqcWnMZGs/SoAcrND1OBH0YlR7R0cQB
KCqjhCBVuH/THnojkEUzfScFpglyC13J6xvPy5c4cxk977WrCY7KnGw=
=HIOe
-----END PGP SIGNATURE-----

--2uW6sw4qQJ70UDbsphXT4uitg6QE4BF9r--
