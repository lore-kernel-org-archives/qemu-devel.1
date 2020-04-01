Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5C2C2D0E7
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8196620714
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8196620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJY7v-0003Gn-Ne
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 03:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jJY6t-0002YB-N9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jJY6r-0007xN-U7
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:48:27 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2094 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jJY6o-0007sE-1D; Wed, 01 Apr 2020 03:48:22 -0400
Received: from lhreml703-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 2E7216FC37C1A3F8CB87;
 Wed,  1 Apr 2020 08:48:21 +0100 (IST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml703-chm.china.huawei.com (10.201.108.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 1 Apr 2020 08:48:20 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Wed, 1 Apr 2020 08:48:20 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH for-5.0 2/3] fw_cfg: Migrate ACPI table mr sizes separately
Thread-Topic: [PATCH for-5.0 2/3] fw_cfg: Migrate ACPI table mr sizes
 separately
Thread-Index: AQHWBrNmc/8JhbZhOkGXkACpglv9b6hivMgAgAEo84A=
Date: Wed, 1 Apr 2020 07:48:20 +0000
Message-ID: <26ca9fa6d82d4388b6707a5c856aeca0@huawei.com>
References: <20200330164909.28324-1-shameerali.kolothum.thodi@huawei.com>
 <20200330164909.28324-3-shameerali.kolothum.thodi@huawei.com>
 <20200331110223-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200331110223-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.88.147]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.176.76.210
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "david@redhat.com" <david@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei
 \(O\)" <xuwei5@huawei.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: 31 March 2020 16:03
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> eric.auger@redhat.com; imammedo@redhat.com; peter.maydell@linaro.org;
> shannon.zhaosl@gmail.com; xiaoguangrong.eric@gmail.com;
> david@redhat.com; xuwei (O) <xuwei5@huawei.com>; lersek@redhat.com;
> Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH for-5.0 2/3] fw_cfg: Migrate ACPI table mr sizes sepa=
rately
>=20
> On Mon, Mar 30, 2020 at 05:49:08PM +0100, Shameer Kolothum wrote:
> > Any sub-page size update to ACPI MRs will be lost during
> > migration, as we use aligned size in ram_load_precopy() ->
> > qemu_ram_resize() path. This will result in inconsistency in
> > FWCfgEntry sizes between source and destination. In order to avoid
> > this, save and restore them separately during migration.
> >
> > Up until now, this problem may not be that relevant for x86 as both
> > ACPI table and Linker MRs gets padded and aligned. Also at present,
> > qemu_ram_resize() doesn't invoke callback to update FWCfgEntry for
> > unaligned size changes. But since we are going to fix the
> > qemu_ram_resize() in the subsequent patch, the issue may become
> > more serious especially for RSDP MR case.
> >
> > Moreover, the issue will soon become prominent in arm/virt as well
> > where the MRs are not padded or aligned at all and eventually have
> > acpi table changes as part of future additions like NVDIMM hot-add
> > feature.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> > Please find previous discussions here,
> > https://patchwork.kernel.org/patch/11339591/#23140343
> > ---
> >
> >  hw/core/machine.c         |  1 +
> >  hw/nvram/fw_cfg.c         | 86
> ++++++++++++++++++++++++++++++++++++++-
> >  include/hw/nvram/fw_cfg.h |  6 +++
> >  3 files changed, 92 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index de0c425605..c1a444cb75 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -39,6 +39,7 @@ GlobalProperty hw_compat_4_2[] =3D {
> >      { "usb-redir", "suppress-remote-wake", "off" },
> >      { "qxl", "revision", "4" },
> >      { "qxl-vga", "revision", "4" },
> > +    { "fw_cfg", "acpi-mr-restore", "false" },
> >  };
> >  const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
> >
> > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > index 179b302f01..36d1e32f83 100644
> > --- a/hw/nvram/fw_cfg.c
> > +++ b/hw/nvram/fw_cfg.c
> > @@ -39,6 +39,7 @@
> >  #include "qemu/config-file.h"
> >  #include "qemu/cutils.h"
> >  #include "qapi/error.h"
> > +#include "hw/acpi/aml-build.h"
> >
> >  #define FW_CFG_FILE_SLOTS_DFLT 0x20
> >
> > @@ -610,6 +611,50 @@ bool fw_cfg_dma_enabled(void *opaque)
> >      return s->dma_enabled;
> >  }
> >
> > +static bool fw_cfg_acpi_mr_restore(void *opaque)
> > +{
> > +    FWCfgState *s =3D opaque;
> > +    return s->acpi_mr_restore;
>=20
> How about we limit this to the case where the address is
> unaligned?

Ok. I will add that check as well.

Thanks,
Shameer

> > +}
> > +
> > +static void fw_cfg_update_mr(FWCfgState *s, uint16_t key, size_t size)
> > +{
> > +    MemoryRegion *mr;
> > +    ram_addr_t offset;
> > +    int arch =3D !!(key & FW_CFG_ARCH_LOCAL);
> > +    void *ptr;
> > +
> > +    key &=3D FW_CFG_ENTRY_MASK;
> > +    assert(key < fw_cfg_max_entry(s));
> > +
> > +    ptr =3D s->entries[arch][key].data;
> > +    mr =3D memory_region_from_host(ptr, &offset);
> > +
> > +    memory_region_ram_resize(mr, size, &error_abort);
> > +}
> > +
> > +static int fw_cfg_acpi_mr_restore_post_load(void *opaque, int version_=
id)
> > +{
> > +    FWCfgState *s =3D opaque;
> > +    int i, index;
> > +
> > +    assert(s->files);
> > +
> > +    index =3D be32_to_cpu(s->files->count);
> > +
> > +    for (i =3D 0; i < index; i++) {
> > +        if (!strcmp(s->files->f[i].name, ACPI_BUILD_TABLE_FILE)) {
> > +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i,
> s->table_mr_size);
> > +        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_LOADER_FILE=
)) {
> > +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i,
> s->linker_mr_size);
> > +        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_RSDP_FILE))=
 {
> > +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i,
> s->rsdp_mr_size);
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static const VMStateDescription vmstate_fw_cfg_dma =3D {
> >      .name =3D "fw_cfg/dma",
> >      .needed =3D fw_cfg_dma_enabled,
> > @@ -619,6 +664,20 @@ static const VMStateDescription
> vmstate_fw_cfg_dma =3D {
> >      },
> >  };
> >
> > +static const VMStateDescription vmstate_fw_cfg_acpi_mr =3D {
> > +    .name =3D "fw_cfg/acpi_mr",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D fw_cfg_acpi_mr_restore,
> > +    .post_load =3D fw_cfg_acpi_mr_restore_post_load,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT64(table_mr_size, FWCfgState),
> > +        VMSTATE_UINT64(linker_mr_size, FWCfgState),
> > +        VMSTATE_UINT64(rsdp_mr_size, FWCfgState),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> >  static const VMStateDescription vmstate_fw_cfg =3D {
> >      .name =3D "fw_cfg",
> >      .version_id =3D 2,
> > @@ -631,6 +690,7 @@ static const VMStateDescription vmstate_fw_cfg =3D =
{
> >      },
> >      .subsections =3D (const VMStateDescription*[]) {
> >          &vmstate_fw_cfg_dma,
> > +        &vmstate_fw_cfg_acpi_mr,
> >          NULL,
> >      }
> >  };
> > @@ -815,6 +875,23 @@ static struct {
> >  #define FW_CFG_ORDER_OVERRIDE_LAST 200
> >  };
> >
> > +/*
> > + * Any sub-page size update to these table MRs will be lost during mig=
ration,
> > + * as we use aligned size in ram_load_precopy() -> qemu_ram_resize() p=
ath.
> > + * In order to avoid the inconsistency in sizes save them seperately a=
nd
> > + * migrate over in vmstate post_load().
> > + */
> > +static void fw_cfg_acpi_mr_save(FWCfgState *s, const char *filename,
> size_t len)
> > +{
> > +    if (!strcmp(filename, ACPI_BUILD_TABLE_FILE)) {
> > +        s->table_mr_size =3D len;
> > +    } else if (!strcmp(filename, ACPI_BUILD_LOADER_FILE)) {
> > +        s->linker_mr_size =3D len;
> > +    } else if (!strcmp(filename, ACPI_BUILD_RSDP_FILE)) {
> > +        s->rsdp_mr_size =3D len;
> > +    }
> > +}
> > +
> >  static int get_fw_cfg_order(FWCfgState *s, const char *name)
> >  {
> >      int i;
> > @@ -914,6 +991,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,
> const char *filename,
> >      trace_fw_cfg_add_file(s, index, s->files->f[index].name, len);
> >
> >      s->files->count =3D cpu_to_be32(count+1);
> > +    fw_cfg_acpi_mr_save(s, filename, len);
> >  }
> >
> >  void fw_cfg_add_file(FWCfgState *s,  const char *filename,
> > @@ -937,6 +1015,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char
> *filename,
> >              ptr =3D fw_cfg_modify_bytes_read(s, FW_CFG_FILE_FIRST + i,
> >                                             data, len);
> >              s->files->f[i].size   =3D cpu_to_be32(len);
> > +            fw_cfg_acpi_mr_save(s, filename, len);
> >              return ptr;
> >          }
> >      }
> > @@ -973,7 +1052,10 @@ static void fw_cfg_machine_ready(struct Notifier
> *n, void *data)
> >      qemu_register_reset(fw_cfg_machine_reset, s);
> >  }
> >
> > -
> > +static Property fw_cfg_properties[] =3D {
> > +    DEFINE_PROP_BOOL("acpi-mr-restore", FWCfgState, acpi_mr_restore,
> true),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> >
> >  static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
> >  {
> > @@ -1097,6 +1179,8 @@ static void fw_cfg_class_init(ObjectClass *klass,
> void *data)
> >
> >      dc->reset =3D fw_cfg_reset;
> >      dc->vmsd =3D &vmstate_fw_cfg;
> > +
> > +    device_class_set_props(dc, fw_cfg_properties);
> >  }
> >
> >  static const TypeInfo fw_cfg_info =3D {
> > diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> > index b5291eefad..457fee7425 100644
> > --- a/include/hw/nvram/fw_cfg.h
> > +++ b/include/hw/nvram/fw_cfg.h
> > @@ -53,6 +53,12 @@ struct FWCfgState {
> >      dma_addr_t dma_addr;
> >      AddressSpace *dma_as;
> >      MemoryRegion dma_iomem;
> > +
> > +    /* restore during migration */
> > +    bool acpi_mr_restore;
> > +    size_t table_mr_size;
> > +    size_t linker_mr_size;
> > +    size_t rsdp_mr_size;
> >  };
> >
> >  struct FWCfgIoState {
> > --
> > 2.17.1
> >


