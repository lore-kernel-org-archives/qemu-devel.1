Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE7AC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4308720732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4308720732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGDv-0004pr-De
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jFGDK-0004Ko-6G
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jFGDI-00068s-2j
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:53:22 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2084 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jFGDD-000679-NQ; Fri, 20 Mar 2020 07:53:15 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 289BF22D7CBE89B1FA93;
 Fri, 20 Mar 2020 11:53:09 +0000 (GMT)
Received: from lhreml704-chm.china.huawei.com (10.201.108.53) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 20 Mar 2020 11:53:08 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml704-chm.china.huawei.com (10.201.108.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 20 Mar 2020 11:53:08 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Fri, 20 Mar 2020 11:53:08 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v3 02/10] fw_cfg: Migrate ACPI table mr sizes separately
Thread-Topic: [PATCH v3 02/10] fw_cfg: Migrate ACPI table mr sizes separately
Thread-Index: AQHV98nfLQ/oyrUoTECo1X+eD0njY6hD4yyAgADIa/CAC5LegIABKo/A
Date: Fri, 20 Mar 2020 11:53:08 +0000
Message-ID: <b19f79ed1a214a28a73f3007f648a062@huawei.com>
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
 <20200311172014.33052-3-shameerali.kolothum.thodi@huawei.com>
 <20200311170827-mutt-send-email-mst@kernel.org>
 <cf6384c5b66a4c9ba37c39a07ec9ed6a@huawei.com>
 <20200319135036-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200319135036-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.83.186]
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
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: 19 March 2020 17:51
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> eric.auger@redhat.com; imammedo@redhat.com; peter.maydell@linaro.org;
> shannon.zhaosl@gmail.com; xiaoguangrong.eric@gmail.com;
> david@redhat.com; xuwei (O) <xuwei5@huawei.com>; lersek@redhat.com;
> Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v3 02/10] fw_cfg: Migrate ACPI table mr sizes separat=
ely
>=20
> On Thu, Mar 12, 2020 at 09:27:32AM +0000, Shameerali Kolothum Thodi
> wrote:
> >
> >
> > > -----Original Message-----
> > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > Sent: 11 March 2020 21:10
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> > > eric.auger@redhat.com; imammedo@redhat.com;
> peter.maydell@linaro.org;
> > > shannon.zhaosl@gmail.com; xiaoguangrong.eric@gmail.com;
> > > david@redhat.com; xuwei (O) <xuwei5@huawei.com>;
> lersek@redhat.com;
> > > Linuxarm <linuxarm@huawei.com>
> > > Subject: Re: [PATCH v3 02/10] fw_cfg: Migrate ACPI table mr sizes
> separately
> > >
> > > On Wed, Mar 11, 2020 at 05:20:06PM +0000, Shameer Kolothum wrote:
> > > > Any sub-page size update to ACPI table MRs will be lost during
> > > > migration, as we use aligned size in ram_load_precopy() ->
> > > > qemu_ram_resize() path. This will result in inconsistency in sizes
> > > > between source and destination. In order to avoid this, save and
> > > > restore them separately during migration.
> >
> >
> > > Is there a reason this is part of nvdimm patchset?
> >
> > Not really. But this problem is more visible if we have nvdimm hotplug
> > support added to arm/virt. On x86, both acpi table and linker MRs are a=
lready
> > aligned and I don't know a use case where you can change RSDP MR size(S=
ee
> below).
> >
> > >
> > > Hmm but for old machine types we still have a problem right?
> > > How about aligning size on source for them?
> > > Then there won't be an inconsistency across migration.
> > > Wastes some boot time/memory but maybe that's better
> > > than a chance of not booting ...
> >
> > Right. That was considered. On x86, except RSDP MR, both the LINKER and
> ACPI
> > TABLE MRs are already aligned/padded. And we cannot make RSDP mr
> aligned
> > as it will break the seabios based boot.
>=20
> Hmm. So right now if we migrate just before RSDP is read, there's
> a failure?

I am not sure that will be the case. IIUC, on migration path, ram_load_prec=
opy() -->qemu_ram_resize()
won't be called as both length and block->used_length will be aligned size.
Even if it calls, the current qemu_ram_resize() works on aligned size and w=
ont invoke
the callback to update the FWCfgEntry. And I believe on destination, the bi=
os read will trigger
the fw_cfg_select() which will call the acpi_build_update() to rebuild the =
tables and update the
FWCfgEntry.

Having said that my knowledge on this is limited, but I can test and confir=
m this, if there is
an easy way to trigger this usecase. Please let me know.

Thanks,
Shameer






> > So a generic solution based on alignment
> > is not possible unless we guarantee that RSDP is not going to be modifi=
ed.
> >
> > What we could do for Arm/virt is just follow the x86 way and add paddin=
g for
> > table and linker MRs. But this was discussed before and IIRC, was not w=
ell
> > received.
> >
> > Thanks,
> > Shameer
> >
> > > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > > > ---
> > > > Please find the discussion here,
> > > > https://patchwork.kernel.org/patch/11339591/
> > > > ---
> > > >  hw/core/machine.c         |  1 +
> > > >  hw/nvram/fw_cfg.c         | 86
> > > ++++++++++++++++++++++++++++++++++++++-
> > > >  include/hw/nvram/fw_cfg.h |  6 +++
> > > >  3 files changed, 92 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > index 9e8c06036f..6d960bd47f 100644
> > > > --- a/hw/core/machine.c
> > > > +++ b/hw/core/machine.c
> > > > @@ -39,6 +39,7 @@ GlobalProperty hw_compat_4_2[] =3D {
> > > >      { "usb-redir", "suppress-remote-wake", "off" },
> > > >      { "qxl", "revision", "4" },
> > > >      { "qxl-vga", "revision", "4" },
> > > > +    { "fw_cfg", "acpi-mr-restore", "false" },
> > > >  };
> > > >  const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
> > > >
> > > > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > > > index 179b302f01..36d1e32f83 100644
> > > > --- a/hw/nvram/fw_cfg.c
> > > > +++ b/hw/nvram/fw_cfg.c
> > > > @@ -39,6 +39,7 @@
> > > >  #include "qemu/config-file.h"
> > > >  #include "qemu/cutils.h"
> > > >  #include "qapi/error.h"
> > > > +#include "hw/acpi/aml-build.h"
> > > >
> > > >  #define FW_CFG_FILE_SLOTS_DFLT 0x20
> > > >
> > > > @@ -610,6 +611,50 @@ bool fw_cfg_dma_enabled(void *opaque)
> > > >      return s->dma_enabled;
> > > >  }
> > > >
> > > > +static bool fw_cfg_acpi_mr_restore(void *opaque)
> > > > +{
> > > > +    FWCfgState *s =3D opaque;
> > > > +    return s->acpi_mr_restore;
> > > > +}
> > > > +
> > > > +static void fw_cfg_update_mr(FWCfgState *s, uint16_t key, size_t s=
ize)
> > > > +{
> > > > +    MemoryRegion *mr;
> > > > +    ram_addr_t offset;
> > > > +    int arch =3D !!(key & FW_CFG_ARCH_LOCAL);
> > > > +    void *ptr;
> > > > +
> > > > +    key &=3D FW_CFG_ENTRY_MASK;
> > > > +    assert(key < fw_cfg_max_entry(s));
> > > > +
> > > > +    ptr =3D s->entries[arch][key].data;
> > > > +    mr =3D memory_region_from_host(ptr, &offset);
> > > > +
> > > > +    memory_region_ram_resize(mr, size, &error_abort);
> > > > +}
> > > > +
> > > > +static int fw_cfg_acpi_mr_restore_post_load(void *opaque, int
> version_id)
> > > > +{
> > > > +    FWCfgState *s =3D opaque;
> > > > +    int i, index;
> > > > +
> > > > +    assert(s->files);
> > > > +
> > > > +    index =3D be32_to_cpu(s->files->count);
> > > > +
> > > > +    for (i =3D 0; i < index; i++) {
> > > > +        if (!strcmp(s->files->f[i].name, ACPI_BUILD_TABLE_FILE)) {
> > > > +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i,
> > > s->table_mr_size);
> > > > +        } else if (!strcmp(s->files->f[i].name,
> ACPI_BUILD_LOADER_FILE)) {
> > > > +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i,
> > > s->linker_mr_size);
> > > > +        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_RSDP_FI=
LE))
> {
> > > > +            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i,
> > > s->rsdp_mr_size);
> > > > +        }
> > > > +    }
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > >  static const VMStateDescription vmstate_fw_cfg_dma =3D {
> > > >      .name =3D "fw_cfg/dma",
> > > >      .needed =3D fw_cfg_dma_enabled,
> > > > @@ -619,6 +664,20 @@ static const VMStateDescription
> > > vmstate_fw_cfg_dma =3D {
> > > >      },
> > > >  };
> > > >
> > > > +static const VMStateDescription vmstate_fw_cfg_acpi_mr =3D {
> > > > +    .name =3D "fw_cfg/acpi_mr",
> > > > +    .version_id =3D 1,
> > > > +    .minimum_version_id =3D 1,
> > > > +    .needed =3D fw_cfg_acpi_mr_restore,
> > > > +    .post_load =3D fw_cfg_acpi_mr_restore_post_load,
> > > > +    .fields =3D (VMStateField[]) {
> > > > +        VMSTATE_UINT64(table_mr_size, FWCfgState),
> > > > +        VMSTATE_UINT64(linker_mr_size, FWCfgState),
> > > > +        VMSTATE_UINT64(rsdp_mr_size, FWCfgState),
> > > > +        VMSTATE_END_OF_LIST()
> > > > +    },
> > > > +};
> > > > +
> > > >  static const VMStateDescription vmstate_fw_cfg =3D {
> > > >      .name =3D "fw_cfg",
> > > >      .version_id =3D 2,
> > > > @@ -631,6 +690,7 @@ static const VMStateDescription vmstate_fw_cfg
> =3D {
> > > >      },
> > > >      .subsections =3D (const VMStateDescription*[]) {
> > > >          &vmstate_fw_cfg_dma,
> > > > +        &vmstate_fw_cfg_acpi_mr,
> > > >          NULL,
> > > >      }
> > > >  };
> > > > @@ -815,6 +875,23 @@ static struct {
> > > >  #define FW_CFG_ORDER_OVERRIDE_LAST 200
> > > >  };
> > > >
> > > > +/*
> > > > + * Any sub-page size update to these table MRs will be lost during
> migration,
> > > > + * as we use aligned size in ram_load_precopy() -> qemu_ram_resize=
()
> path.
> > > > + * In order to avoid the inconsistency in sizes save them seperate=
ly and
> > > > + * migrate over in vmstate post_load().
> > > > + */
> > > > +static void fw_cfg_acpi_mr_save(FWCfgState *s, const char *filenam=
e,
> > > size_t len)
> > > > +{
> > > > +    if (!strcmp(filename, ACPI_BUILD_TABLE_FILE)) {
> > > > +        s->table_mr_size =3D len;
> > > > +    } else if (!strcmp(filename, ACPI_BUILD_LOADER_FILE)) {
> > > > +        s->linker_mr_size =3D len;
> > > > +    } else if (!strcmp(filename, ACPI_BUILD_RSDP_FILE)) {
> > > > +        s->rsdp_mr_size =3D len;
> > > > +    }
> > > > +}
> > > > +
> > > >  static int get_fw_cfg_order(FWCfgState *s, const char *name)
> > > >  {
> > > >      int i;
> > > > @@ -914,6 +991,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,
> > > const char *filename,
> > > >      trace_fw_cfg_add_file(s, index, s->files->f[index].name, len);
> > > >
> > > >      s->files->count =3D cpu_to_be32(count+1);
> > > > +    fw_cfg_acpi_mr_save(s, filename, len);
> > > >  }
> > > >
> > > >  void fw_cfg_add_file(FWCfgState *s,  const char *filename,
> > > > @@ -937,6 +1015,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const
> char
> > > *filename,
> > > >              ptr =3D fw_cfg_modify_bytes_read(s, FW_CFG_FILE_FIRST
> + i,
> > > >                                             data, len);
> > > >              s->files->f[i].size   =3D cpu_to_be32(len);
> > > > +            fw_cfg_acpi_mr_save(s, filename, len);
> > > >              return ptr;
> > > >          }
> > > >      }
> > > > @@ -973,7 +1052,10 @@ static void fw_cfg_machine_ready(struct
> Notifier
> > > *n, void *data)
> > > >      qemu_register_reset(fw_cfg_machine_reset, s);
> > > >  }
> > > >
> > > > -
> > > > +static Property fw_cfg_properties[] =3D {
> > > > +    DEFINE_PROP_BOOL("acpi-mr-restore", FWCfgState,
> acpi_mr_restore,
> > > true),
> > > > +    DEFINE_PROP_END_OF_LIST(),
> > > > +};
> > > >
> > > >  static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
> > > >  {
> > > > @@ -1097,6 +1179,8 @@ static void fw_cfg_class_init(ObjectClass
> *klass,
> > > void *data)
> > > >
> > > >      dc->reset =3D fw_cfg_reset;
> > > >      dc->vmsd =3D &vmstate_fw_cfg;
> > > > +
> > > > +    device_class_set_props(dc, fw_cfg_properties);
> > > >  }
> > > >
> > > >  static const TypeInfo fw_cfg_info =3D {
> > > > diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> > > > index b5291eefad..457fee7425 100644
> > > > --- a/include/hw/nvram/fw_cfg.h
> > > > +++ b/include/hw/nvram/fw_cfg.h
> > > > @@ -53,6 +53,12 @@ struct FWCfgState {
> > > >      dma_addr_t dma_addr;
> > > >      AddressSpace *dma_as;
> > > >      MemoryRegion dma_iomem;
> > > > +
> > > > +    /* restore during migration */
> > > > +    bool acpi_mr_restore;
> > > > +    size_t table_mr_size;
> > > > +    size_t linker_mr_size;
> > > > +    size_t rsdp_mr_size;
> > > >  };
> > > >
> > > >  struct FWCfgIoState {
> > > > --
> > > > 2.17.1
> > > >


