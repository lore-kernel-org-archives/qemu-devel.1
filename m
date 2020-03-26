Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143FCC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE002073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE002073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSKv-000727-0h
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jHSKJ-0006Uo-Jz
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jHSKH-0008Dn-H8
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:13:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:38256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>)
 id 1jHSKH-0008DW-A1; Thu, 26 Mar 2020 09:13:37 -0400
IronPort-SDR: YqRTi94eWTktwQTEGgZtwHVKzL1X46NMQxZWipLsDvIHDDk2rcLnDatPvVki8r72Qun21qAtmD
 aT0kDNVDOsRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 06:13:32 -0700
IronPort-SDR: gMn7iuYRMuIEtF25zmXu0iCA0a9il9/1joqf694JTqs5IyvErTdk2nT0Ewmv1KFJFKcrlnxWlT
 jkljHO5XbhFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; d="scan'208";a="238798886"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga007.fm.intel.com with ESMTP; 26 Mar 2020 06:13:32 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 06:13:32 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 06:13:31 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.43]) with mapi id 14.03.0439.000;
 Thu, 26 Mar 2020 21:13:29 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
Subject: RE: [RFC v6 05/24] memory: Introduce IOMMU Memory Region
 inject_faults API
Thread-Topic: [RFC v6 05/24] memory: Introduce IOMMU Memory Region
 inject_faults API
Thread-Index: AQHV/tkL56HOGmRgQUStEsCG5C4Dkqha4D1w
Date: Thu, 26 Mar 2020 13:13:28 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A2044AD@SHSMSX104.ccr.corp.intel.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
 <20200320165840.30057-6-eric.auger@redhat.com>
In-Reply-To: <20200320165840.30057-6-eric.auger@redhat.com>
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
X-Received-From: 134.134.136.100
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

I'm also considering how to inject iommu fault to vIOMMU. As our
previous discussion (long time ago), MemoryRegion way doesn't work
well for VTd case. So I'd like see your opinion on the proposal
below:
I've a patch to make vIOMMUs register PCIIOMMUOps to PCI layer.
Current usage is to get address space and set/unset HostIOMMUContext
(added by me). I think it may be also nice to add the fault injection
callback in the PCIIOMMUOps. Thoughts?

https://patchwork.ozlabs.org/patch/1259645/

Regards,
Yi Liu

> From: Eric Auger <eric.auger@redhat.com>
> Sent: Saturday, March 21, 2020 12:58 AM
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-devel@nongnu.or=
g;
> Subject: [RFC v6 05/24] memory: Introduce IOMMU Memory Region inject_faul=
ts
> API
>=20
> This new API allows to inject @count iommu_faults into
> the IOMMU memory region.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/exec/memory.h | 25 +++++++++++++++++++++++++
>  memory.c              | 10 ++++++++++
>  2 files changed, 35 insertions(+)
>=20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index f2c773163f..141a5dc197 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -57,6 +57,8 @@ struct MemoryRegionMmio {
>      CPUWriteMemoryFunc *write[3];
>  };
>=20
> +struct iommu_fault;
> +
>  typedef struct IOMMUTLBEntry IOMMUTLBEntry;
>=20
>  /* See address_space_translate: bit 0 is read, bit 1 is write.  */
> @@ -357,6 +359,19 @@ typedef struct IOMMUMemoryRegionClass {
>       * @iommu: the IOMMUMemoryRegion
>       */
>      int (*num_indexes)(IOMMUMemoryRegion *iommu);
> +
> +    /*
> +     * Inject @count faults into the IOMMU memory region
> +     *
> +     * Optional method: if this method is not provided, then
> +     * memory_region_injection_faults() will return -ENOENT
> +     *
> +     * @iommu: the IOMMU memory region to inject the faults in
> +     * @count: number of faults to inject
> +     * @buf: fault buffer
> +     */
> +    int (*inject_faults)(IOMMUMemoryRegion *iommu, int count,
> +                         struct iommu_fault *buf);
>  } IOMMUMemoryRegionClass;
>=20
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
> @@ -1365,6 +1380,16 @@ int
> memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
>   */
>  int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
>=20
> +/**
> + * memory_region_inject_faults : inject @count faults stored in @buf
> + *
> + * @iommu_mr: the IOMMU memory region
> + * @count: number of faults to be injected
> + * @buf: buffer containing the faults
> + */
> +int memory_region_inject_faults(IOMMUMemoryRegion *iommu_mr, int count,
> +                                struct iommu_fault *buf);
> +
>  /**
>   * memory_region_name: get a memory region's name
>   *
> diff --git a/memory.c b/memory.c
> index 09be40edd2..9cdd77e0de 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2001,6 +2001,16 @@ int
> memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr)
>      return imrc->num_indexes(iommu_mr);
>  }
>=20
> +int memory_region_inject_faults(IOMMUMemoryRegion *iommu_mr, int count,
> +                                struct iommu_fault *buf)
> +{
> +    IOMMUMemoryRegionClass *imrc =3D
> IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
> +    if (!imrc->inject_faults) {
> +        return -ENOENT;
> +    }
> +    return imrc->inject_faults(iommu_mr, count, buf);
> +}
> +
>  void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
>  {
>      uint8_t mask =3D 1 << client;
> --
> 2.20.1


