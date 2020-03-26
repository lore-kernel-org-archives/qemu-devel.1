Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753BDC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4993220737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4993220737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHS9l-0000E8-EZ
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jHS8X-00083c-MC
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jHS8W-0008V1-9U
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:01:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:58551)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>)
 id 1jHS8W-0008UX-1M; Thu, 26 Mar 2020 09:01:28 -0400
IronPort-SDR: Q9vMwRyJPbngx1kv4kFU8b9/G9/lKIkBwac7Dz6QM1xDx/k6af0yij8+fllGYzaodTh672OMKV
 jjaBMHi8CcvQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 06:01:26 -0700
IronPort-SDR: CZooHnj5IZ6UX3vhrZQNzKb7LrfUl3kq2dYtjlz3C2avbUuqyIfsWrdbmehye7SVbGIOlsYdiQ
 98+2KH20NalA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; d="scan'208";a="240667872"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2020 06:01:26 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 06:01:26 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 06:01:25 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.145]) with mapi id 14.03.0439.000;
 Thu, 26 Mar 2020 21:01:23 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
Subject: RE: [RFC v6 08/24] pci: introduce PCIPASIDOps to PCIDevice
Thread-Topic: [RFC v6 08/24] pci: introduce PCIPASIDOps to PCIDevice
Thread-Index: AQHV/tktUfcQ5azYVUulSCglN9SHFKha3xew
Date: Thu, 26 Mar 2020 13:01:22 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A204440@SHSMSX104.ccr.corp.intel.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
 <20200320165840.30057-9-eric.auger@redhat.com>
In-Reply-To: <20200320165840.30057-9-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.120
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "tnowicki@marvell.com" <tnowicki@marvell.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "bbhushan2@marvell.com" <bbhushan2@marvell.com>,
 "will@kernel.org" <will@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

Not sure about your preference. I've modified my patch as below, which
HostIOMMUContext to provide callbacks for vIOMMU to call into VFIO.
Please feel free to give your suggestions.

https://patchwork.ozlabs.org/patch/1259665/

Regards,
Yi Liu

> From: Eric Auger <eric.auger@redhat.com>
> Sent: Saturday, March 21, 2020 12:58 AM
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-devel@nongnu.or=
g;
> Subject: [RFC v6 08/24] pci: introduce PCIPASIDOps to PCIDevice
>=20
> From: Liu Yi L <yi.l.liu@intel.com>
>=20
> This patch introduces PCIPASIDOps for IOMMU related operations.
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00078.html
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00940.html
>=20
> So far, to setup virt-SVA for assigned SVA capable device, needs to
> configure host translation structures for specific pasid. (e.g. bind
> guest page table to host and enable nested translation in host).
> Besides, vIOMMU emulator needs to forward guest's cache invalidation
> to host since host nested translation is enabled. e.g. on VT-d, guest
> owns 1st level translation table, thus cache invalidation for 1st
> level should be propagated to host.
>=20
> This patch adds two functions: alloc_pasid and free_pasid to support
> guest pasid allocation and free. The implementations of the callbacks
> would be device passthru modules. Like vfio.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>  hw/pci/pci.c         | 34 ++++++++++++++++++++++++++++++++++
>  include/hw/pci/pci.h | 11 +++++++++++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e1ed6677e1..67e03b8db1 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2695,6 +2695,40 @@ void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn,
> void *opaque)
>      bus->iommu_opaque =3D opaque;
>  }
>=20
> +void pci_setup_pasid_ops(PCIDevice *dev, PCIPASIDOps *ops)
> +{
> +    assert(ops && !dev->pasid_ops);
> +    dev->pasid_ops =3D ops;
> +}
> +
> +bool pci_device_is_pasid_ops_set(PCIBus *bus, int32_t devfn)
> +{
> +    PCIDevice *dev;
> +
> +    if (!bus) {
> +        return false;
> +    }
> +
> +    dev =3D bus->devices[devfn];
> +    return !!(dev && dev->pasid_ops);
> +}
> +
> +int pci_device_set_pasid_table(PCIBus *bus, int32_t devfn,
> +                               IOMMUConfig *config)
> +{
> +    PCIDevice *dev;
> +
> +    if (!bus) {
> +        return -EINVAL;
> +    }
> +
> +    dev =3D bus->devices[devfn];
> +    if (dev && dev->pasid_ops && dev->pasid_ops->set_pasid_table) {
> +        return dev->pasid_ops->set_pasid_table(bus, devfn, config);
> +    }
> +    return -ENOENT;
> +}
> +
>  static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
>  {
>      Range *range =3D opaque;
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index cfedf5a995..2146cb7519 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -8,6 +8,7 @@
>  #include "hw/isa/isa.h"
>=20
>  #include "hw/pci/pcie.h"
> +#include "hw/iommu/iommu.h"
>=20
>  extern bool pci_available;
>=20
> @@ -264,6 +265,11 @@ struct PCIReqIDCache {
>  };
>  typedef struct PCIReqIDCache PCIReqIDCache;
>=20
> +struct PCIPASIDOps {
> +    int (*set_pasid_table)(PCIBus *bus, int32_t devfn, IOMMUConfig *conf=
ig);
> +};
> +typedef struct PCIPASIDOps PCIPASIDOps;
> +
>  struct PCIDevice {
>      DeviceState qdev;
>      bool partially_hotplugged;
> @@ -357,6 +363,7 @@ struct PCIDevice {
>=20
>      /* ID of standby device in net_failover pair */
>      char *failover_pair_id;
> +    PCIPASIDOps *pasid_ops;
>  };
>=20
>  void pci_register_bar(PCIDevice *pci_dev, int region_num,
> @@ -490,6 +497,10 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void
> *, int);
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>  void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
>=20
> +void pci_setup_pasid_ops(PCIDevice *dev, PCIPASIDOps *ops);
> +bool pci_device_is_pasid_ops_set(PCIBus *bus, int32_t devfn);
> +int pci_device_set_pasid_table(PCIBus *bus, int32_t devfn, IOMMUConfig *=
config);
> +
>  static inline void
>  pci_set_byte(uint8_t *config, uint8_t val)
>  {
> --
> 2.20.1


