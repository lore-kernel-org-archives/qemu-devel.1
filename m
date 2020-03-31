Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0B9C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 06:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241C220748
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 06:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241C220748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJA5l-000692-Bk
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 02:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jJA4y-0005Dg-Vr
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jJA4x-00050t-1A
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:08:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:58629)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jJA4w-0004yT-Pb
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:08:50 -0400
IronPort-SDR: j0Dy9K2ho9TGHQHq/VHyxom238SiHcNhrdumIACw7fTav3CBUH7Js/s6+QQEm0RNn3+YmU4rD6
 lKqZtGZPWlcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 23:08:46 -0700
IronPort-SDR: 3m8kJMNvedZ6Jhi9W+XpPrxLHsh7+68nleUU/7ne7N6TlQK88j7csJq1qWpx4jn8t7dhv2c6PX
 GodFGh/cDelA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; d="scan'208";a="448548189"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga005.fm.intel.com with ESMTP; 30 Mar 2020 23:08:46 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 23:08:46 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 23:08:46 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.213]) with mapi id 14.03.0439.000;
 Tue, 31 Mar 2020 14:08:43 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v2 03/22] vfio: check VFIO_TYPE1_NESTING_IOMMU support
Thread-Topic: [PATCH v2 03/22] vfio: check VFIO_TYPE1_NESTING_IOMMU support
Thread-Index: AQHWBkpiF+OzDttw/0mCFTO45dt2yKhgWqOAgAHPSbA=
Date: Tue, 31 Mar 2020 06:08:42 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21A63C@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-4-git-send-email-yi.l.liu@intel.com>
 <2c65e531-1cc8-dc01-4b06-e7baff58addd@redhat.com>
In-Reply-To: <2c65e531-1cc8-dc01-4b06-e7baff58addd@redhat.com>
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
X-Received-From: 192.55.52.151
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric,

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Monday, March 30, 2020 5:36 PM
> To: Liu, Yi L <yi.l.liu@intel.com>; qemu-devel@nongnu.org;
> Subject: Re: [PATCH v2 03/22] vfio: check VFIO_TYPE1_NESTING_IOMMU suppor=
t
>=20
> Yi,
>=20
> On 3/30/20 6:24 AM, Liu Yi L wrote:
> > VFIO needs to check VFIO_TYPE1_NESTING_IOMMU support with Kernel before
> > further using it. e.g. requires to check IOMMU UAPI version.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > ---
> >  hw/vfio/common.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 0b3593b..c276732 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -1157,12 +1157,21 @@ static void
> vfio_put_address_space(VFIOAddressSpace *space)
> >  static int vfio_get_iommu_type(VFIOContainer *container,
> >                                 Error **errp)
> >  {
> > -    int iommu_types[] =3D { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
> > +    int iommu_types[] =3D { VFIO_TYPE1_NESTING_IOMMU,
> > +                          VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
> >                            VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMM=
U };
> > -    int i;
> > +    int i, version;
> >
> >      for (i =3D 0; i < ARRAY_SIZE(iommu_types); i++) {
> >          if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])=
) {
> > +            if (iommu_types[i] =3D=3D VFIO_TYPE1_NESTING_IOMMU) {
> > +                version =3D ioctl(container->fd, VFIO_CHECK_EXTENSION,
> > +                                VFIO_NESTING_IOMMU_UAPI);
> > +                if (version < IOMMU_UAPI_VERSION) {
> > +                    info_report("IOMMU UAPI incompatible for nesting")=
;
> > +                    continue;
> > +                }
> > +            }
> This means that by default VFIO_TYPE1_NESTING_IOMMU wwould be chosen. I
> don't think this what we want. On ARM this would mean that for a
> standard VFIO assignment without vIOMMU, SL will be used instead of FL.
> This may not be harmless.
>=20
> For instance, in "[RFC v6 09/24] vfio: Force nested if iommu requires
> it", I use nested only if I detect we have a vSMMU. Otherwise I keep the
> legacy VFIO_TYPE1v2_IOMMU.
>=20
Good point. I also replied in your patch.

Regards,
Yi Liu

