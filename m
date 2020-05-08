Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90114C47254
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C1424970
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C1424970
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2jB-0005wx-Cv
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miaoyubo@huawei.com>)
 id 1jX2TA-0006XB-Pq
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:51:12 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2519 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miaoyubo@huawei.com>)
 id 1jX2T9-0002qi-0Y
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:51:12 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id BD974AED847D04E6F656;
 Fri,  8 May 2020 20:50:55 +0800 (CST)
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 8 May 2020 20:50:55 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 8 May 2020 20:50:54 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Fri, 8 May 2020 20:50:54 +0800
From: miaoyubo <miaoyubo@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v6 2/8] fw_cfg: Write the extra roots into the fw_cfg
Thread-Topic: [PATCH v6 2/8] fw_cfg: Write the extra roots into the fw_cfg
Thread-Index: AQHWDaVtFt2HHsrzj0S5wEUUfu+NQ6iXl+gAgAa6uLA=
Date: Fri, 8 May 2020 12:50:54 +0000
Message-ID: <f3e847eb9e4744c2b4ef0a6f53bcd4d4@huawei.com>
References: <20200408125816.955-1-miaoyubo@huawei.com>
 <20200408125816.955-3-miaoyubo@huawei.com>
 <20200504100057-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200504100057-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.221.29]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188; envelope-from=miaoyubo@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 08:50:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Monday, May 4, 2020 10:03 PM
> To: miaoyubo <miaoyubo@huawei.com>
> Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com;
> lersek@redhat.com; imammedo@redhat.com; qemu-devel@nongnu.org;
> berrange@redhat.com; Xiexiangyou <xiexiangyou@huawei.com>
> Subject: Re: [PATCH v6 2/8] fw_cfg: Write the extra roots into the fw_cfg
>=20
> On Wed, Apr 08, 2020 at 08:58:10PM +0800, Yubo Miao wrote:
> > From: miaoyubo <miaoyubo@huawei.com>
> >
> > Write the extra roots into the fw_cfg therefore the uefi could get the
> > extra roots. Only if the uefi know there are extra roots, the config
> > space of devices behind the root could be obtained.
> >
> > Signed-off-by: miaoyubo <miaoyubo@huawei.com>
> > ---
> >  hw/arm/virt.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c index
> > 7dc96abf72..0fdfe4129c 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -77,6 +77,7 @@
> >  #include "hw/acpi/generic_event_device.h"
> >  #include "hw/virtio/virtio-iommu.h"
> >  #include "hw/char/pl011.h"
> > +#include "hw/pci/pci_bus.h"
> >
> >  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
> >      static void virt_##major##_##minor##_class_init(ObjectClass *oc,
> > \ @@ -1435,6 +1436,12 @@ void virt_machine_done(Notifier *notifier,
> void *data)
> >      ARMCPU *cpu =3D ARM_CPU(first_cpu);
> >      struct arm_boot_info *info =3D &vms->bootinfo;
> >      AddressSpace *as =3D arm_boot_address_space(cpu, info);
> > +    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
> > +                                   object_resolve_path_type("",
> > +                                   "pcie-host-bridge", NULL),
> > +                                   TYPE_PCI_HOST_BRIDGE);
> > +
> > +    PCIBus *bus =3D s->bus;
> >
> >      /*
> >       * If the user provided a dtb, we assume the dynamic sysbus nodes
>=20
>=20
> Seems duplicated all over the place. Add an API for that?
>

Thanks for your reply. I will add the API in patch v7.
=20
> > @@ -1453,6 +1460,22 @@ void virt_machine_done(Notifier *notifier, void
> *data)
> >          exit(1);
> >      }
> >
> > +    if (bus) {
> > +        int extra_hosts =3D 0;
> > +        QLIST_FOREACH(bus, &bus->child, sibling) {
> > +            /* look for expander root buses */
> > +            if (pci_bus_is_root(bus)) {
> > +                extra_hosts++;
> > +            }
> > +        }
> > +        if (extra_hosts && vms->fw_cfg) {
> > +            uint64_t *val =3D g_malloc(sizeof(*val));
> > +            *val =3D cpu_to_le64(extra_hosts);
> > +            fw_cfg_add_file(vms->fw_cfg,
> > +                   "etc/extra-pci-roots", val, sizeof(*val));
> > +        }
> > +    }
> > +
> >      virt_acpi_setup(vms);
> >      virt_build_smbios(vms);
>=20
>=20
> Duplicated from pc. Pls refactor.
>=20

Sure. It would be done in patch v7

> >  }
> > --
> > 2.19.1
> >

Regards,
Miao

