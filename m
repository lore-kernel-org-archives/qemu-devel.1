Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_WP_DIRINDEX
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72A6C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 08:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B28E206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 08:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B28E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLMka-0008L1-RH
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 04:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jLMjz-0007ve-4E
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jLMjx-0007ve-6C
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:04:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:58704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jLMjw-0007tm-St
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:04:17 -0400
IronPort-SDR: Ws30KHeU4Tgn/KH7mAjtgQYz+HYcT42G9lxEf9FYA87eIZaK9FKgCT8I9fMqMPwjfBdSBdmCB9
 xjN/kCRunNgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2020 01:04:07 -0700
IronPort-SDR: 1OJ442ZbcwfC0uDA+eB/bMqW6pbv08iG0+Ch4FZv1jzDvPXIuBJV0qg1f8I2CvoQPhulJPko93
 qXCheqOdXo6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,350,1580803200"; d="scan'208";a="296594628"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2020 01:04:07 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Apr 2020 01:04:07 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Apr 2020 01:04:06 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.209]) with mapi id 14.03.0439.000;
 Mon, 6 Apr 2020 16:04:03 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v2 04/22] hw/iommu: introduce HostIOMMUContext
Thread-Topic: [PATCH v2 04/22] hw/iommu: introduce HostIOMMUContext
Thread-Index: AQHWBkpipXk9AcbvW0ea4lbMrBMnp6hg3OsAgArnvHA=
Date: Mon, 6 Apr 2020 08:04:02 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A2230B3@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-5-git-send-email-yi.l.liu@intel.com>
 <aa1bfbd5-e6de-6475-809e-a6ca46089aaa@redhat.com>
In-Reply-To: <aa1bfbd5-e6de-6475-809e-a6ca46089aaa@redhat.com>
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
X-Received-From: 192.55.52.93
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

Hi Eric,

> From: Auger Eric < eric.auger@redhat.com>
> Sent: Tuesday, March 31, 2020 1:23 AM
> To: Liu, Yi L <yi.l.liu@intel.com>; qemu-devel@nongnu.org;
> Subject: Re: [PATCH v2 04/22] hw/iommu: introduce HostIOMMUContext
>=20
> Yi,
>=20
> On 3/30/20 6:24 AM, Liu Yi L wrote:
> > Currently, many platform vendors provide the capability of dual stage
> > DMA address translation in hardware. For example, nested translation
> > on Intel VT-d scalable mode, nested stage translation on ARM SMMUv3,
> > and etc. In dual stage DMA address translation, there are two stages
> > address translation, stage-1 (a.k.a first-level) and stage-2 (a.k.a
> > second-level) translation structures. Stage-1 translation results are
> > also subjected to stage-2 translation structures. Take vSVA (Virtual
> > Shared Virtual Addressing) as an example, guest IOMMU driver owns
> > stage-1 translation structures (covers GVA->GPA translation), and host
> > IOMMU driver owns stage-2 translation structures (covers GPA->HPA
> > translation). VMM is responsible to bind stage-1 translation structures
> > to host, thus hardware could achieve GVA->GPA and then GPA->HPA
> > translation. For more background on SVA, refer the below links.
> >  - https://www.youtube.com/watch?v=3DKq_nfGK5MwQ
> >  - https://events19.lfasiallc.com/wp-content/uploads/2017/11/\
> > Shared-Virtual-Memory-in-KVM_Yi-Liu.pdf
> >
[...]
> > +void host_iommu_ctx_init(void *_iommu_ctx, size_t instance_size,
> > +                         const char *mrtypename,
> > +                         uint64_t flags)
> > +{
> > +    HostIOMMUContext *iommu_ctx;
> > +
> > +    object_initialize(_iommu_ctx, instance_size, mrtypename);
> > +    iommu_ctx =3D HOST_IOMMU_CONTEXT(_iommu_ctx);
> > +    iommu_ctx->flags =3D flags;
> > +    iommu_ctx->initialized =3D true;
> > +}
> > +
> > +static const TypeInfo host_iommu_context_info =3D {
> > +    .parent             =3D TYPE_OBJECT,
> > +    .name               =3D TYPE_HOST_IOMMU_CONTEXT,
> > +    .class_size         =3D sizeof(HostIOMMUContextClass),
> > +    .instance_size      =3D sizeof(HostIOMMUContext),
> > +    .abstract           =3D true,
> Can't we use the usual .instance_init and .instance_finalize?
sorry, I somehow missed this comment. In prior patch, .instace_init
was used, but the current major init method is via host_iommu_ctx_init(),
so .instance_init is not really necessary.
https://www.spinics.net/lists/kvm/msg210878.html

Regards,
Yi Liu

