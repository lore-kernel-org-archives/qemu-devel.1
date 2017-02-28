Received: from eggs.gnu.org ([2001:4830:134:3::10]:53350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijQi-0006p2-1J
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijQh-0003Yh-65
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:11:07 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-19-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a4caffb1-2a24-33fb-ba92-87ada93f9d7f@redhat.com>
Date: Tue, 28 Feb 2017 16:10:56 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-19-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CfdQvHBVIQb8UvvMFrsfXeJLBTALsEuGt"
Subject: Re: [Qemu-devel] [PATCH v3 18/44] hw/block: Request permissions
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
--CfdQvHBVIQb8UvvMFrsfXeJLBTALsEuGt
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <a4caffb1-2a24-33fb-ba92-87ada93f9d7f@redhat.com>
Subject: Re: [PATCH v3 18/44] hw/block: Request permissions
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-19-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-19-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:54, Kevin Wolf wrote:
> This makes all device emulations with a qdev drive property request
> permissions on their BlockBackend. The only thing we block at this poin=
t
> is resizing images for some devices that can't support it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/block/block.c                 | 22 +++++++++++++++++++++-
>  hw/block/fdc.c                   | 25 +++++++++++++++++++++++--
>  hw/block/m25p80.c                |  8 ++++++++
>  hw/block/nand.c                  |  7 +++++++
>  hw/block/nvme.c                  |  8 +++++++-
>  hw/block/onenand.c               |  7 +++++++
>  hw/block/pflash_cfi01.c          | 18 ++++++++++++------
>  hw/block/pflash_cfi02.c          | 19 +++++++++++++------
>  hw/block/virtio-blk.c            |  8 +++++++-
>  hw/core/qdev-properties-system.c |  1 -
>  hw/ide/qdev.c                    |  8 ++++++--
>  hw/nvram/spapr_nvram.c           |  8 ++++++++
>  hw/scsi/scsi-disk.c              |  9 +++++++--
>  hw/sd/sd.c                       |  6 ++++++
>  hw/usb/dev-storage.c             |  6 +++++-
>  include/hw/block/block.h         |  3 ++-
>  tests/qemu-iotests/051.pc.out    |  6 +++---
>  17 files changed, 142 insertions(+), 27 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--CfdQvHBVIQb8UvvMFrsfXeJLBTALsEuGt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1kwASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AthUH928rF/2tnyqlwUPSJE/hn0Sfk7DiDq8m
YooIOmE5MzTkE6Hv2j1bn9+R1ZEkkD23z7VFtrPQYwamfGeHuNox3Xr4PFmtBHGJ
UoghtISCzIc+zXqHUBWFJemAn5Vd3ApB5dR3+WG3yQyqc5QoP4BTgXRnw36sG2kB
TJCBvFsOge+XRmGe6c6qnWgzTd8rHuGdaL9J7GpCqqwsTEq+K9TCso3yRDFUAww2
jmanADVpknn9+vUtpv5BlgrzO1TH07jaRj+JdoaOU2x/7nkuPmhrGDCTan5wfyFb
fvEB6HgUMKu1tSAt/saGTxWC6D0k35oQpPsZjMGRrzZq2rIp7Y8cjA==
=94mD
-----END PGP SIGNATURE-----

--CfdQvHBVIQb8UvvMFrsfXeJLBTALsEuGt--
