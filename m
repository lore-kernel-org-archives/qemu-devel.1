Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB6BC47404
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 01:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C0020835
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 01:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C0020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHegA-0001gh-DG
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 21:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qi1.zhang@intel.com>) id 1iHeev-0000Q1-NY
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 21:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qi1.zhang@intel.com>) id 1iHeeu-0005nD-7O
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 21:51:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:64002)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qi1.zhang@intel.com>) id 1iHeet-0005m2-V5
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 21:51:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Oct 2019 18:51:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; d="scan'208";a="206542692"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by fmsmga001.fm.intel.com with ESMTP; 07 Oct 2019 18:51:25 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 7 Oct 2019 18:51:25 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 7 Oct 2019 18:51:25 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.176]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.225]) with mapi id 14.03.0439.000;
 Tue, 8 Oct 2019 09:51:23 +0800
From: "Zhang, Qi1" <qi1.zhang@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v4] intel_iommu: TM field should not be in reserved bits
Thread-Topic: [PATCH v4] intel_iommu: TM field should not be in reserved bits
Thread-Index: AQHVd04ExmFcct3DBECF6eVUCIR2IKdMGQOAgAPtvTA=
Date: Tue, 8 Oct 2019 01:51:23 +0000
Message-ID: <215440059103624D9AD9D1DCACBF45DD3E85B8D1@shsmsx102.ccr.corp.intel.com>
References: <20190930050451.13618-1-qi1.zhang@intel.com>
 <20191005174844-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191005174844-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDdmZjVkMWYtM2NlZi00NmVmLWI5NjItZWVjYjMyYzEyNjU1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWTlqQVdjUFZOSlhvdXlOVm1oSWVLK3Y3NVl6SnhSem11MmRiQm5tdDlkbm14NTE3XC9xb082WUtjaERrVEJXSjMifQ==
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Qi,
 Yadong" <yadong.qi@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you! I formatted the patch with cover-letter and submitted them again=
.=20

> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, October 6, 2019 5:50 AM
> To: Zhang, Qi1 <qi1.zhang@intel.com>
> Cc: qemu-devel@nongnu.org; marcel.apfelbaum@gmail.com;
> pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com; Qi, Yadong
> <yadong.qi@intel.com>
> Subject: Re: [PATCH v4] intel_iommu: TM field should not be in reserved b=
its
>=20
> On Mon, Sep 30, 2019 at 01:04:51PM +0800, qi1.zhang@intel.com wrote:
> > From: "Zhang, Qi" <qi1.zhang@intel.com>
> >
> > When dt is supported, TM field should not be Reserved(0).
> >
> > Refer to VT-d Spec 9.8
> >
> > Signed-off-by: Zhang, Qi <qi1.zhang@intel.com>
> > Signed-off-by: Qi, Yadong <yadong.qi@intel.com>
>=20
> I am guessing this is really a 2 patch series right?
> So you need to format it as such with
> git format-patch --cover-letter --thread=3Dshallow
>=20
> > ---
> >  hw/i386/intel_iommu.c          | 12 ++++++++----
> >  hw/i386/intel_iommu_internal.h | 17 +++++++++++++----
> >  2 files changed, 21 insertions(+), 8 deletions(-)
> > ---
> > Changelog V2:
> >  move dt_supported flag to VTD_SPTE_PAGE_LX_RSVD_MASK and
> > VTD_SPTE_LPAGE_LX_RSVD_MASK Changelog V3:
> >  based on the change to split the arrays into two ones Changelog V4:
> >  style error check
> >
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> > a118efaeaf..d62604ece3 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -3549,15 +3549,19 @@ static void vtd_init(IntelIOMMUState *s)
> >       * Rsvd field masks for spte
> >       */
> >      vtd_spte_rsvd[0] =3D ~0ULL;
> > -    vtd_spte_rsvd[1] =3D VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
> > +    vtd_spte_rsvd[1] =3D VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
> > +
> > + x86_iommu->dt_supported);
> >      vtd_spte_rsvd[2] =3D VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
> >      vtd_spte_rsvd[3] =3D VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
> >      vtd_spte_rsvd[4] =3D VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
> >
> >      vtd_spte_rsvd_large[0] =3D ~0ULL;
> > -    vtd_spte_rsvd_large[1] =3D VTD_SPTE_LPAGE_L1_RSVD_MASK(s-
> >aw_bits);
> > -    vtd_spte_rsvd_large[2] =3D VTD_SPTE_LPAGE_L2_RSVD_MASK(s-
> >aw_bits);
> > -    vtd_spte_rsvd_large[3] =3D VTD_SPTE_LPAGE_L3_RSVD_MASK(s-
> >aw_bits);
> > +    vtd_spte_rsvd_large[1] =3D VTD_SPTE_LPAGE_L1_RSVD_MASK(s-
> >aw_bits,
> > +                                                         x86_iommu->dt=
_supported);
> > +    vtd_spte_rsvd_large[2] =3D VTD_SPTE_LPAGE_L2_RSVD_MASK(s-
> >aw_bits,
> > +                                                         x86_iommu->dt=
_supported);
> > +    vtd_spte_rsvd_large[3] =3D VTD_SPTE_LPAGE_L3_RSVD_MASK(s-
> >aw_bits,
> > +
> > + x86_iommu->dt_supported);
> >      vtd_spte_rsvd_large[4] =3D VTD_SPTE_LPAGE_L4_RSVD_MASK(s-
> >aw_bits);
> >
> >      if (x86_iommu_ir_supported(x86_iommu)) { diff --git
> > a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> > index c1235a7063..3a839a8925 100644
> > --- a/hw/i386/intel_iommu_internal.h
> > +++ b/hw/i386/intel_iommu_internal.h
> > @@ -387,7 +387,9 @@ typedef union VTDInvDesc VTDInvDesc;  #define
> > VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
> >
> >  /* Rsvd field masks for spte */
> > -#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw) \
> > +#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, dt_supported) \
> > +        dt_supported ? \
> > +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM |
> VTD_SL_TM))
> > +: \
> >          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))  #define
> > VTD_SPTE_PAGE_L2_RSVD_MASK(aw) \
> >          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM)) @@ -
> 395,11
> > +397,17 @@ typedef union VTDInvDesc VTDInvDesc;
> >          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))  #define
> > VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
> >          (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM)) -#define
> > VTD_SPTE_LPAGE_L1_RSVD_MASK(aw) \
> > +#define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw, dt_supported) \
> > +        dt_supported ? \
> > +        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM |
> VTD_SL_TM))
> > +: \
> >          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM)) -#define
> > VTD_SPTE_LPAGE_L2_RSVD_MASK(aw) \
> > +#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, dt_supported) \
> > +        dt_supported ? \
> > +        (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM |
> > +VTD_SL_TM)) : \
> >          (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM)) -
> #define
> > VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
> > +#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, dt_supported) \
> > +        dt_supported ? \
> > +        (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM |
> > +VTD_SL_TM)) : \
> >          (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> > #define VTD_SPTE_LPAGE_L4_RSVD_MASK(aw) \
> >          (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM)) @@ -
> 506,5
> > +514,6 @@ typedef struct VTDRootEntry VTDRootEntry;
> >  #define VTD_SL_W                    (1ULL << 1)
> >  #define VTD_SL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) &
> VTD_HAW_MASK(aw))
> >  #define VTD_SL_IGN_COM              0xbff0000000000000ULL
> > +#define VTD_SL_TM                   (1ULL << 62)
> >
> >  #endif
> > --
> > 2.20.1

