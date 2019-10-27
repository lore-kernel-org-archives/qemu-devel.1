Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F00CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:50:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D24420679
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FYOa76lG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D24420679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOmgZ-0006QR-W3
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 13:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iOme9-000724-19
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iOme7-0002rD-6s
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:48:08 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:33981 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iOme5-0002pn-QP; Sun, 27 Oct 2019 13:48:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 471QL975pdz9sPT; Mon, 28 Oct 2019 04:48:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572198482;
 bh=48qx/FX595PM6dv7miLCXvevRkJLXG5lUhoMdqolVYU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FYOa76lGoAqYfLcfq+da0i+eA9MojTTOoiTyf50FwPAzXsqFpuJuVyCifsecmf7p6
 SaE6YoU7QpjO4aj8PC8Z+bizHfWFoZhQ/F42khk3pPE6WfOk7pEG+AIxshuL0NEzXm
 y+cEZ5FX9UZEyqehZ4yRsjvzMvFkh0OgboFAweLE=
Date: Sun, 27 Oct 2019 18:46:31 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/5] ppc/pnv: Add a PNOR model
Message-ID: <20191027174631.GM3552@umbus.metropole.lan>
References: <20191021131215.3693-1-clg@kaod.org>
 <20191021131215.3693-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oiL9LJXJsdjS5rzq"
Content-Disposition: inline
In-Reply-To: <20191021131215.3693-2-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org,
 Joel Stanley <joel@jms.id.au>, "Marty E . Plummer" <hanetzer@startmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oiL9LJXJsdjS5rzq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 03:12:11PM +0200, C=E9dric Le Goater wrote:
> From: C=E9dric Le Goater <clg@fr.ibm.com>
>=20
> On a POWERPC PowerNV system, the host firmware is stored in a PNOR
> flash chip which contents is mapped on the LPC bus. This model adds a
> simple dummy device to map the contents of a block device in the host
> address space.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.2.  The rest of the series will need acks for the
generic IPMI changes, of course.

> ---
>  include/hw/ppc/pnv.h      |   3 +
>  include/hw/ppc/pnv_pnor.h |  25 +++++++
>  hw/ppc/pnv.c              |  14 ++++
>  hw/ppc/pnv_pnor.c         | 135 ++++++++++++++++++++++++++++++++++++++
>  hw/ppc/Makefile.objs      |   4 +-
>  5 files changed, 180 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/ppc/pnv_pnor.h
>  create mode 100644 hw/ppc/pnv_pnor.c
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 5e01a9f3df95..e2f20f2b0bc4 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -24,6 +24,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/ipmi/ipmi.h"
>  #include "hw/ppc/pnv_lpc.h"
> +#include "hw/ppc/pnv_pnor.h"
>  #include "hw/ppc/pnv_psi.h"
>  #include "hw/ppc/pnv_occ.h"
>  #include "hw/ppc/pnv_homer.h"
> @@ -173,6 +174,8 @@ typedef struct PnvMachineState {
> =20
>      IPMIBmc      *bmc;
>      Notifier     powerdown_notifier;
> +
> +    PnvPnor      *pnor;
>  } PnvMachineState;
> =20
>  static inline bool pnv_chip_is_power9(const PnvChip *chip)
> diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
> new file mode 100644
> index 000000000000..dec811695c8d
> --- /dev/null
> +++ b/include/hw/ppc/pnv_pnor.h
> @@ -0,0 +1,25 @@
> +/*
> + * QEMU PowerNV PNOR simple model
> + *
> + * Copyright (c) 2019, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +#ifndef _PPC_PNV_PNOR_H
> +#define _PPC_PNV_PNOR_H
> +
> +#define TYPE_PNV_PNOR  "pnv-pnor"
> +#define PNV_PNOR(obj)  OBJECT_CHECK(PnvPnor, (obj), TYPE_PNV_PNOR)
> +
> +typedef struct PnvPnor {
> +    SysBusDevice   parent_obj;
> +
> +    BlockBackend   *blk;
> +
> +    uint8_t        *storage;
> +    uint32_t       size;
> +    MemoryRegion   mmio;
> +} PnvPnor;
> +
> +#endif /* _PPC_PNV_PNOR_H */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 1a22dfd46031..b74528eba42a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -44,6 +44,7 @@
>  #include "hw/ppc/xics.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/ppc/pnv_xscom.h"
> +#include "hw/ppc/pnv_pnor.h"
> =20
>  #include "hw/isa/isa.h"
>  #include "hw/boards.h"
> @@ -633,6 +634,8 @@ static void pnv_init(MachineState *machine)
>      long fw_size;
>      int i;
>      char *chip_typename;
> +    DriveInfo *pnor =3D drive_get(IF_MTD, 0, 0);
> +    DeviceState *dev;
> =20
>      /* allocate RAM */
>      if (machine->ram_size < (1 * GiB)) {
> @@ -644,6 +647,17 @@ static void pnv_init(MachineState *machine)
>                                           machine->ram_size);
>      memory_region_add_subregion(get_system_memory(), 0, ram);
> =20
> +    /*
> +     * Create our simple PNOR device
> +     */
> +    dev =3D qdev_create(NULL, TYPE_PNV_PNOR);
> +    if (pnor) {
> +        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(pnor),
> +                            &error_abort);
> +    }
> +    qdev_init_nofail(dev);
> +    pnv->pnor =3D PNV_PNOR(dev);
> +
>      /* load skiboot firmware  */
>      if (bios_name =3D=3D NULL) {
>          bios_name =3D FW_FILE_NAME;
> diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
> new file mode 100644
> index 000000000000..bfb1e92b0392
> --- /dev/null
> +++ b/hw/ppc/pnv_pnor.c
> @@ -0,0 +1,135 @@
> +/*
> + * QEMU PowerNV PNOR simple model
> + *
> + * Copyright (c) 2015-2019, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/log.h"
> +#include "sysemu/block-backend.h"
> +#include "sysemu/blockdev.h"
> +#include "hw/loader.h"
> +#include "hw/ppc/pnv_pnor.h"
> +#include "hw/qdev-properties.h"
> +
> +static uint64_t pnv_pnor_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    PnvPnor *s =3D PNV_PNOR(opaque);
> +    uint64_t ret =3D 0;
> +    int i;
> +
> +    for (i =3D 0; i < size; i++) {
> +        ret |=3D (uint64_t) s->storage[addr + i] << (8 * (size - i - 1));
> +    }
> +
> +    return ret;
> +}
> +
> +static void pnv_pnor_update(PnvPnor *s, int offset, int size)
> +{
> +    int offset_end;
> +
> +    if (s->blk) {
> +        return;
> +    }
> +
> +    offset_end =3D offset + size;
> +    offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
> +    offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
> +
> +    blk_pwrite(s->blk, offset, s->storage + offset,
> +               offset_end - offset, 0);
> +}
> +
> +static void pnv_pnor_write(void *opaque, hwaddr addr, uint64_t data,
> +                           unsigned size)
> +{
> +    PnvPnor *s =3D PNV_PNOR(opaque);
> +    int i;
> +
> +    for (i =3D 0; i < size; i++) {
> +        s->storage[addr + i] =3D (data >> (8 * (size - i - 1))) & 0xFF;
> +    }
> +    pnv_pnor_update(s, addr, size);
> +}
> +
> +/*
> + * TODO: Check endianness: skiboot is BIG, Aspeed AHB is LITTLE, flash
> + * is BIG.
> + */
> +static const MemoryRegionOps pnv_pnor_ops =3D {
> +    .read =3D pnv_pnor_read,
> +    .write =3D pnv_pnor_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static void pnv_pnor_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvPnor *s =3D PNV_PNOR(dev);
> +    int ret;
> +
> +    if (s->blk) {
> +        uint64_t perm =3D BLK_PERM_CONSISTENT_READ |
> +                        (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRITE);
> +        ret =3D blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);
> +        if (ret < 0) {
> +            return;
> +        }
> +
> +        s->size =3D blk_getlength(s->blk);
> +        if (s->size <=3D 0) {
> +            error_setg(errp, "failed to get flash size");
> +            return;
> +        }
> +
> +        s->storage =3D blk_blockalign(s->blk, s->size);
> +
> +        if (blk_pread(s->blk, 0, s->storage, s->size) !=3D s->size) {
> +            error_setg(errp, "failed to read the initial flash content");
> +            return;
> +        }
> +    } else {
> +        s->storage =3D blk_blockalign(NULL, s->size);
> +        memset(s->storage, 0xFF, s->size);
> +    }
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), &pnv_pnor_ops, s,
> +                          TYPE_PNV_PNOR, s->size);
> +}
> +
> +static Property pnv_pnor_properties[] =3D {
> +    DEFINE_PROP_UINT32("size", PnvPnor, size, 128 << 20),
> +    DEFINE_PROP_DRIVE("drive", PnvPnor, blk),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pnv_pnor_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D pnv_pnor_realize;
> +    dc->props =3D pnv_pnor_properties;
> +}
> +
> +static const TypeInfo pnv_pnor_info =3D {
> +    .name          =3D TYPE_PNV_PNOR,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(PnvPnor),
> +    .class_init    =3D pnv_pnor_class_init,
> +};
> +
> +static void pnv_pnor_register_types(void)
> +{
> +    type_register_static(&pnv_pnor_info);
> +}
> +
> +type_init(pnv_pnor_register_types)
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 580bb4f0dd4c..101e9fc59185 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -9,7 +9,9 @@ obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o
>  obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
>  # IBM PowerNV
>  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
> -obj-$(CONFIG_POWERNV) +=3D pnv_homer.o
> +obj-$(CONFIG_POWERNV) +=3D pnv_homer.o pnv_pnor.o
> +
> +
>  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
>  obj-y +=3D spapr_pci_vfio.o spapr_pci_nvlink2.o
>  endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oiL9LJXJsdjS5rzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl211/cACgkQbDjKyiDZ
s5KRHg/+Pc+S3Xe1dABtxCRmzMhBycjVl67iNjTa3N1WL/ecEK/5U2zczFfhkl77
LOYaGE6X6vfyC/R2aAeMifCVXWOal9FcW4CAW4jGlvZLWGXP4+Y16rNyDcLtl5ZI
gYxE4CpPSdWmHjkCy0Hj4FP8SNjghKjjo5uvmEf2fB/fyw6W+8ad7pjkrVidP/4q
D9tVRBtwe5NT7YqIFEy1ZRpcbUdwWOGT94EL95dwHxgnVMj7wpYI6kv5+iZ3dJ+9
iVbvDgfuiUCQIkz7BlX6C9Ve/p6VPr5AQeEjXABH6UVPT+yjzdTIENoKjpcOwneO
7iTcwAv/q+Og+FAyQvhDl9AzHktKBDhSp7ZH3yV7yd7C3JFSz/cibUsIjQBWuasf
+rHjSu8fffDEH/6HVy33Krg4Mw3MjA3vhKS3meoG2Wz/5oCVhKAjYZKQQihMctYz
khEJOtHjfrSRigYAK+Nu6PorM87MC0BRxwJCwtnHACoF33cmZh3CVaB8gYLm35HT
tmdtUKI9520dHKjqXzF874wtjqRDcX+53XTzpGWiH7R6DOPRcu3dcBWbOtrr1R8b
D4UDgSQjvbp62OE8aV22rwBicVLYIFOazcVzRj91QOUB9IVYn2/UpMMqg2nMSq54
TQ3H/rrSj2E5VafXpnNRgA9sPKF8eKI4JzxCwYeaU6K8TFWErWo=
=VybM
-----END PGP SIGNATURE-----

--oiL9LJXJsdjS5rzq--

