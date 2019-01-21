Received: from eggs.gnu.org ([209.51.188.92]:36007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glWeN-0002Oc-JQ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glWeM-0003UW-Rf
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:17:51 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1glWeM-0003U4-Lg
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:17:50 -0500
Received: by mail-wm1-x343.google.com with SMTP id d15so10174115wmb.3
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 02:17:50 -0800 (PST)
Date: Mon, 21 Jan 2019 10:17:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190121101747.GB30536@stefanha-x1.localdomain>
References: <20190118120143.21631-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20190118120143.21631-1-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/5] pvh: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 01:01:38PM +0100, Stefano Garzarella wrote:
> This patch series is based on "[PATCH v3 0/4] QEMU changes to do PVH boot=
" and
> provides a PVH option rom that can be used with SeaBIOS to boot uncompres=
sed
> kernel using the x86/HVM direct boot ABI.
>=20
> Patches 1 and 2 are to prepare the PVH option rom, moving common function=
s in
> the new headers.  Patch 3 adds the new PVH option rom. Patch 4 uses it wh=
en we
> are booting an uncompressed kernel using the x86/HVM direct boot ABI. Pat=
ch 5
> adds the support of loading the initrd in the PVH option rom.
>=20
> Based-on: <1547554687-12687-1-git-send-email-liam.merwick@oracle.com>

The linuxboot_dma.bin option ROM went via Paolo's tree, so I guess he
will merge this when he's happy, too.

> Changes in v5:
> - Patch 5: added R-b's
> - Patch 3: updated .gitignore (by Liam)
>=20
> Changes in v4:
> - addressed comments by Paolo:
>   - Patch 2: linuxboot_dma.c: moved includes after the asm block to avoid
>     compiler error
>   - Patch 3: Makefile: fixed pvh.img rule
>=20
> Changes in v3:
> - added R-b's
> - added Patch 5 to support initrd
> - addressed comments by Eric and Liam:
>     - Patch 3: comments by Liam
>     - Patch 4: moved Based-on tag in the cover letter (by Eric)
> - Patch 3: added pc-bios/pvh.bin binary in the commit
>=20
> Changes in v2:
> - addressed comments by Stefan and Eric:
>   - Patch 2: moved inludes on top of linuxboot_dma.c and add <stdint.h> in
>     optrom.h
>   - Patch 4: added check of pvh.bin in xen_load_linux()
> - modified commit message of patch 2 to explain better the patch
>=20
> Stefano Garzarella (5):
>   linuxboot_dma: remove duplicate definitions of FW_CFG
>   linuxboot_dma: move common functions in a new header
>   optionrom: add new PVH option rom
>   hw/i386/pc: use PVH option rom
>   optionrom/pvh: load initrd from fw_cfg
>=20
>  .gitignore                        |   4 +
>  Makefile                          |   2 +-
>  hw/i386/pc.c                      |   5 +
>  pc-bios/optionrom/Makefile        |   5 +-
>  pc-bios/optionrom/linuxboot_dma.c | 114 +++--------------
>  pc-bios/optionrom/optrom.h        | 110 ++++++++++++++++
>  pc-bios/optionrom/optrom_fw_cfg.h |  92 ++++++++++++++
>  pc-bios/optionrom/pvh.S           | 200 ++++++++++++++++++++++++++++++
>  pc-bios/optionrom/pvh_main.c      | 133 ++++++++++++++++++++
>  pc-bios/pvh.bin                   | Bin 0 -> 1536 bytes
>  10 files changed, 568 insertions(+), 97 deletions(-)
>  create mode 100644 pc-bios/optionrom/optrom.h
>  create mode 100644 pc-bios/optionrom/optrom_fw_cfg.h
>  create mode 100644 pc-bios/optionrom/pvh.S
>  create mode 100644 pc-bios/optionrom/pvh_main.c
>  create mode 100644 pc-bios/pvh.bin
>=20
> --=20
> 2.20.1
>=20
>=20

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcRZxLAAoJEJykq7OBq3PIb2QH/RSG66EyXe3gys2Cd0wz978I
beuJHg5HctDMuSv7rhEJu8ylp0YwEuCn2fqx4ikuvlYr+5BiFmMtNxqWMXGtNPy7
4h7/VEL00CsYFuNOmFLrrZE50XxZkppip3DTUiK9oMBLJ2tJFMBLv+N8OtRIkCf9
2WaKIFAQ0oBrlZ7duNqyslLOQUFs9ciNJ8QN3TGzXOc7ISSpT2WdHQhSSjZbTNw3
I0yIPEdjW4J23C7Gy6Klwj6SyBqUPJVNaazlgfS3O4Cfv1rch9ZVD+sRr50rMDvU
RtH5y68JURooqGWRokqTFkjal/QonQsW2GA3zzJ3suk+WnRpHzOrodPmnvQletk=
=Q9vB
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
