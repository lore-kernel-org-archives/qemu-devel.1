Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DB3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D2520787
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D2520787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJCMl-0006bw-CN
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jJCLw-0005w8-6Z
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jJCLt-0002qq-M2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:34:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:42603)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>)
 id 1jJCLt-0002o0-EE; Tue, 31 Mar 2020 04:34:29 -0400
IronPort-SDR: Qs2W5iWOzD846IG5sK75VVZiHqkaQTaAUEQy/eHPq0wwcCtITsLA57dpp/6Jjjoev4f/wGSmCe
 VNqUO1zH94MA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 01:34:25 -0700
IronPort-SDR: K89PERLa0J9Yzmn7MKa2KKAKrlH8UrXd+qIb7kfh2+nPw4l0UVdhhtzvJ+31z2WlQA4+9vSLpU
 jmPwGrOm96ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; d="scan'208";a="359435124"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2020 01:34:25 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 01:34:24 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 01:34:24 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.89]) with mapi id 14.03.0439.000;
 Tue, 31 Mar 2020 16:34:22 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
Subject: RE: [RFC v6 09/24] vfio: Force nested if iommu requires it
Thread-Topic: [RFC v6 09/24] vfio: Force nested if iommu requires it
Thread-Index: AQHV/tkoyufwzZuw+kOQFrVm2InyoqhiSCKw//+aMoCAAIpS0A==
Date: Tue, 31 Mar 2020 08:34:21 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21A9D3@SHSMSX104.ccr.corp.intel.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
 <20200320165840.30057-10-eric.auger@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A21A69E@SHSMSX104.ccr.corp.intel.com>
 <33fab5b6-b217-3b87-9207-b5653c268fe3@redhat.com>
In-Reply-To: <33fab5b6-b217-3b87-9207-b5653c268fe3@redhat.com>
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
X-Received-From: 134.134.136.126
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
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "bbhushan2@marvell.com" <bbhushan2@marvell.com>,
 "will@kernel.org" <will@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Tuesday, March 31, 2020 4:05 PM
> To: Liu, Yi L <yi.l.liu@intel.com>; eric.auger.pro@gmail.com; qemu-
> Subject: Re: [RFC v6 09/24] vfio: Force nested if iommu requires it
>=20
> Yi,
>=20
> On 3/31/20 8:34 AM, Liu, Yi L wrote:
> > Hi Eric,
> >
> >> From: Eric Auger <eric.auger@redhat.com>
> >> Sent: Saturday, March 21, 2020 12:58 AM
> >> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org;
> >> Subject: [RFC v6 09/24] vfio: Force nested if iommu requires it
> >>
> >> In case we detect the address space is translated by
> >> a virtual IOMMU which requires HW nested paging to
> >> integrate with VFIO, let's set up the container with
> >> the VFIO_TYPE1_NESTING_IOMMU iommu_type.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>
> >> ---
> >>
> >> v4 -> v5:
> >> - fail immediatly if nested is wanted but not supported
> >>
> >> v2 -> v3:
> >> - add "nested only is selected if requested by @force_nested"
> >>   comment in this patch
> >> ---
> >>  hw/vfio/common.c | 36 ++++++++++++++++++++++++++++--------
> >>  1 file changed, 28 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> >> index 0b3593b3c0..ac417b5dbd 100644
> >> --- a/hw/vfio/common.c
> >> +++ b/hw/vfio/common.c
> >> @@ -1155,27 +1155,38 @@ static void
> vfio_put_address_space(VFIOAddressSpace
> >> *space)
> >>   * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
> >>   */
> >>  static int vfio_get_iommu_type(VFIOContainer *container,
> >> +                               bool want_nested,
> >>                                 Error **errp)
> >>  {
> >> -    int iommu_types[] =3D { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
> >> +    int iommu_types[] =3D { VFIO_TYPE1_NESTING_IOMMU,
> >> +                          VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
> >>                            VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOM=
MU };
> >> -    int i;
> >> +    int i, ret =3D -EINVAL;
> >>
> >>      for (i =3D 0; i < ARRAY_SIZE(iommu_types); i++) {
> >>          if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i]=
)) {
> >> -            return iommu_types[i];
> >> +            if (iommu_types[i] =3D=3D VFIO_TYPE1_NESTING_IOMMU && !wa=
nt_nested)
> {
> >> +                continue;
> >> +            }
> >> +            ret =3D iommu_types[i];
> >> +            break;
> >>          }
> >>      }
> >> -    error_setg(errp, "No available IOMMU models");
> >> -    return -EINVAL;
> >> +    if (ret < 0) {
> >> +        error_setg(errp, "No available IOMMU models");
> >> +    } else if (want_nested && ret !=3D VFIO_TYPE1_NESTING_IOMMU) {
> >> +        error_setg(errp, "Nested mode requested but not supported");
> >> +        ret =3D -EINVAL;
> >> +    }
> >> +    return ret;
> >>  }
> >>
> >>  static int vfio_init_container(VFIOContainer *container, int group_fd=
,
> >> -                               Error **errp)
> >> +                               bool want_nested, Error **errp)
> >>  {
> >>      int iommu_type, ret;
> >>
> >> -    iommu_type =3D vfio_get_iommu_type(container, errp);
> >> +    iommu_type =3D vfio_get_iommu_type(container, want_nested, errp);
> >>      if (iommu_type < 0) {
> >>          return iommu_type;
> >>      }
> >> @@ -1211,6 +1222,14 @@ static int vfio_connect_container(VFIOGroup *gr=
oup,
> >> AddressSpace *as,
> >>      VFIOContainer *container;
> >>      int ret, fd;
> >>      VFIOAddressSpace *space;
> >> +    IOMMUMemoryRegion *iommu_mr;
> >> +    bool nested =3D false;
> >> +
> >> +    if (as !=3D &address_space_memory && memory_region_is_iommu(as->r=
oot))
> {
> >
> > I tried on my side. For virtual VT-d, it doesn't work as in intel_iommu=
,
> > we have a dynamic switch mechanism. Thus that, the
> > memory_region_is_iommu(as->root) won't return true as expected. I'm afr=
aid
> > it doesn't work for virtual VT-d.  So firstly, I'm wondering if
> > as !=3D &address_space_memory is enough.
>=20
> (as !=3D &address_space_memory) should be sufficient to tell that a vIOMM=
U
> is being used. But then, for example, you don't want to set nested
> paging for the virtio-iommu because virtio-iommu/VFIO uses notify-on-my
> (CM similar implementation). That's why I devised an attribute to
> retrieve the vIOMMU need for nested.
>=20
>  Secondly, I'm considering if it is
> > good to let vfio_get_group() caller to provide a hint whether vIOMMU is
> > exposed. e.g. vfio_realize() in vfio/pci.c could figure out whether vIO=
MMU
> > is set easily. Thoughts?
> Sorry I don't get your point here. Why is it easier to figure out
> whether vIOMMU is set in vfio_realize()?
>=20
> pci_device_iommu_address_space(pdev) !=3D  &address_space_memory
> does determine whether a vIOMMU is in place, no?
>=20
No it's not just pci_device_iommu_address_space(pdev) !=3D  &address_space_=
memory,
I agree with your above comment, it's not enough to tell whether nesting is
needed or not. I'd like to add an API like pci_device_iommu_nesting_require=
d(),
so that it can be determined. In the meanwhile, adding a query callback in
PCIIOMMUOps introduced in below pathc. Guess it works?

[v2,05/22] hw/pci: modify pci_setup_iommu() to set PCIIOMMUOps
https://patchwork.kernel.org/patch/11464577/

Regards,
Yi Liu


