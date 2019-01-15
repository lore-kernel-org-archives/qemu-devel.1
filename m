Received: from eggs.gnu.org ([209.51.188.92]:39442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjPdk-0007Xy-G5
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:24:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjPdi-0007tb-ML
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:24:28 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gjPdi-0007sr-8s
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:24:26 -0500
Received: by mail-wr1-x444.google.com with SMTP id q18so3150751wrx.9
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 06:24:25 -0800 (PST)
Date: Tue, 15 Jan 2019 14:24:21 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190115142421.GC29056@stefanha-x1.localdomain>
References: <20190115100058.44712-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <20190115100058.44712-1-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] pvh: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Maran Wilson <maran.wilson@oracle.com>, Richard Henderson <rth@twiddle.net>


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 11:00:54AM +0100, Stefano Garzarella wrote:
> This patch series is based on "[RFC v2 0/4] QEMU changes to do PVH boot" =
and
> provides a PVH option rom that can be used with SeaBIOS to boot uncompres=
sed
> kernel using the x86/HVM direct boot ABI.
>=20
> Patches 1 and 2 are to prepare the PVH option rom, moving common function=
s in a
> new header.  Patch 3 adds the new PVH option rom and patch 4 uses it when=
 we
> are booting an uncompressed kernel using the x86/HVM direct boot ABI.
>=20
> Changes in v2:
> - addressed comments by Stefan and Eric:
>   - Patch 2: moved inludes on top of linuxboot_dma.c and add <stdint.h> in
>     optrom.h
>   - Patch 4: added check of pvh.bin in xen_load_linux()
> - modified commit message of patch 2 to explain better the patch
>=20
> Stefano Garzarella (4):
>   linuxboot_dma: remove duplicate definitions of FW_CFG
>   linuxboot_dma: move common functions in a new header
>   optionrom: add new PVH option rom
>   hw/i386/pc: use PVH option rom
>=20
>  hw/i386/pc.c                      |   5 +
>  pc-bios/optionrom/Makefile        |   5 +-
>  pc-bios/optionrom/linuxboot_dma.c | 112 +++--------------
>  pc-bios/optionrom/optrom.h        | 110 ++++++++++++++++
>  pc-bios/optionrom/optrom_fw_cfg.h |  92 ++++++++++++++
>  pc-bios/optionrom/pvh.S           | 200 ++++++++++++++++++++++++++++++
>  pc-bios/optionrom/pvh_main.c      | 117 +++++++++++++++++
>  7 files changed, 544 insertions(+), 97 deletions(-)
>  create mode 100644 pc-bios/optionrom/optrom.h
>  create mode 100644 pc-bios/optionrom/optrom_fw_cfg.h
>  create mode 100644 pc-bios/optionrom/pvh.S
>  create mode 100644 pc-bios/optionrom/pvh_main.c
>=20
> --=20
> 2.20.1
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPe0VAAoJEJykq7OBq3PIKW0IAIL/UpN+ihy9GsnhMzMPMFgQ
uFPmagHkO2MX5GoZRB49/kdqOn0JJdDZ9WX6L1iZeJXOqU33hbVGGTOS0GVaKWqJ
eLGI34Nm6wWDeOouH9vvb0OBOs0ybkCv1OV9cVDeKgRrwVkE/MvaPpyJ927E+0B8
y7fPqneTk5ySs+aaf5iIpV9TfT67GF6gsjSD8g5F6e3ureWs3oLneM6Xczq0Jylc
egkeHWVLg6FvSE01JI46zqrUNbxMiarnjF9/Lp5duXsOSU1Cy14YNK9Kg4IWOoqk
98mk8CVn81yhmcnp0l+e86GMy5O3B1kVOixC5N5T3YQevCviS2iOvbgqhgQGTa4=
=+yy1
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
