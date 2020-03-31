Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0637FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 06:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9AA2072A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 06:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9AA2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJAUr-0003ul-0k
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 02:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jJAUE-0003Nt-OK
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jJAUC-00059x-UO
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:34:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:58702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>)
 id 1jJAUC-00056n-N5; Tue, 31 Mar 2020 02:34:56 -0400
IronPort-SDR: J1dGsHU307ViwV6HFf+yj67v87+Pd508GIxMt00+zqvvRLq6RaIQZ2fpjM021WyalFtLCgLxzd
 WoZhtAjFw+Rg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 23:34:52 -0700
IronPort-SDR: T8BVdaiCpI80rxSWdUpaNaD2gb5xZvhpuIIUY5ylnn7730BWU21UP8A6lKlY/m/J0WPSJA+tjh
 QI1iUCdXjU+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; d="scan'208";a="395390940"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga004.jf.intel.com with ESMTP; 30 Mar 2020 23:34:52 -0700
Received: from fmsmsx162.amr.corp.intel.com (10.18.125.71) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 23:34:35 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx162.amr.corp.intel.com (10.18.125.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 23:34:35 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.138]) with mapi id 14.03.0439.000;
 Tue, 31 Mar 2020 14:34:33 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
Subject: RE: [RFC v6 09/24] vfio: Force nested if iommu requires it
Thread-Topic: [RFC v6 09/24] vfio: Force nested if iommu requires it
Thread-Index: AQHV/tkoyufwzZuw+kOQFrVm2InyoqhiSCKw
Date: Tue, 31 Mar 2020 06:34:32 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21A69E@SHSMSX104.ccr.corp.intel.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
 <20200320165840.30057-10-eric.auger@redhat.com>
In-Reply-To: <20200320165840.30057-10-eric.auger@redhat.com>
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
X-Received-From: 134.134.136.65
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

> From: Eric Auger <eric.auger@redhat.com>
> Sent: Saturday, March 21, 2020 12:58 AM
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-devel@nongnu.or=
g;
> Subject: [RFC v6 09/24] vfio: Force nested if iommu requires it
>=20
> In case we detect the address space is translated by
> a virtual IOMMU which requires HW nested paging to
> integrate with VFIO, let's set up the container with
> the VFIO_TYPE1_NESTING_IOMMU iommu_type.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> ---
>=20
> v4 -> v5:
> - fail immediatly if nested is wanted but not supported
>=20
> v2 -> v3:
> - add "nested only is selected if requested by @force_nested"
>   comment in this patch
> ---
>  hw/vfio/common.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0b3593b3c0..ac417b5dbd 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1155,27 +1155,38 @@ static void vfio_put_address_space(VFIOAddressSpa=
ce
> *space)
>   * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
>   */
>  static int vfio_get_iommu_type(VFIOContainer *container,
> +                               bool want_nested,
>                                 Error **errp)
>  {
> -    int iommu_types[] =3D { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
> +    int iommu_types[] =3D { VFIO_TYPE1_NESTING_IOMMU,
> +                          VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
>                            VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU =
};
> -    int i;
> +    int i, ret =3D -EINVAL;
>=20
>      for (i =3D 0; i < ARRAY_SIZE(iommu_types); i++) {
>          if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) =
{
> -            return iommu_types[i];
> +            if (iommu_types[i] =3D=3D VFIO_TYPE1_NESTING_IOMMU && !want_=
nested) {
> +                continue;
> +            }
> +            ret =3D iommu_types[i];
> +            break;
>          }
>      }
> -    error_setg(errp, "No available IOMMU models");
> -    return -EINVAL;
> +    if (ret < 0) {
> +        error_setg(errp, "No available IOMMU models");
> +    } else if (want_nested && ret !=3D VFIO_TYPE1_NESTING_IOMMU) {
> +        error_setg(errp, "Nested mode requested but not supported");
> +        ret =3D -EINVAL;
> +    }
> +    return ret;
>  }
>=20
>  static int vfio_init_container(VFIOContainer *container, int group_fd,
> -                               Error **errp)
> +                               bool want_nested, Error **errp)
>  {
>      int iommu_type, ret;
>=20
> -    iommu_type =3D vfio_get_iommu_type(container, errp);
> +    iommu_type =3D vfio_get_iommu_type(container, want_nested, errp);
>      if (iommu_type < 0) {
>          return iommu_type;
>      }
> @@ -1211,6 +1222,14 @@ static int vfio_connect_container(VFIOGroup *group=
,
> AddressSpace *as,
>      VFIOContainer *container;
>      int ret, fd;
>      VFIOAddressSpace *space;
> +    IOMMUMemoryRegion *iommu_mr;
> +    bool nested =3D false;
> +
> +    if (as !=3D &address_space_memory && memory_region_is_iommu(as->root=
)) {

I tried on my side. For virtual VT-d, it doesn't work as in intel_iommu,
we have a dynamic switch mechanism. Thus that, the
memory_region_is_iommu(as->root) won't return true as expected. I'm afraid
it doesn't work for virtual VT-d.  So firstly, I'm wondering if
as !=3D &address_space_memory is enough. Secondly, I'm considering if it is
good to let vfio_get_group() caller to provide a hint whether vIOMMU is
exposed. e.g. vfio_realize() in vfio/pci.c could figure out whether vIOMMU
is set easily. Thoughts?

Regards,
Yi Liu

