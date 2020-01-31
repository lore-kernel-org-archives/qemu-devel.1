Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URI_WP_DIRINDEX autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54509C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A321206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A321206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixUhr-0007M2-DE
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 06:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1ixUgg-0006DF-Q5
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1ixUgf-0007Gk-2s
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:42:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:39327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1ixUge-0007AZ-PG
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:42:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 03:42:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; d="scan'208";a="233379394"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga006.jf.intel.com with ESMTP; 31 Jan 2020 03:42:09 -0800
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 03:42:09 -0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 03:42:08 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.197]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.202]) with mapi id 14.03.0439.000;
 Fri, 31 Jan 2020 19:42:07 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [RFC v3 02/25] hw/iommu: introduce DualStageIOMMUObject
Thread-Topic: [RFC v3 02/25] hw/iommu: introduce DualStageIOMMUObject
Thread-Index: AQHV1p1Ior1b1toJXUar/sR4t0nROqgDokMAgADaZHA=
Date: Fri, 31 Jan 2020 11:42:06 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1992F1@SHSMSX104.ccr.corp.intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-3-git-send-email-yi.l.liu@intel.com>
 <20200131035914.GF15210@umbus.fritz.box>
In-Reply-To: <20200131035914.GF15210@umbus.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDVhYTM4OWMtMTk4Zi00Y2Q5LWIxNGYtN2E0ZjczZjY3NDdmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicmJJM2tSdGw2NHpXTENaeWdKNnVcL0xTSkxSbmwxdkNQRTY3dWc3d3NWd2tEbGZXditDb1FqQzl4bGNFZkg0RncifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Wu, Hao" <hao.wu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

> From: David Gibson [mailto:david@gibson.dropbear.id.au]
> Sent: Friday, January 31, 2020 11:59 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v3 02/25] hw/iommu: introduce DualStageIOMMUObject
>=20
> On Wed, Jan 29, 2020 at 04:16:33AM -0800, Liu, Yi L wrote:
> > From: Liu Yi L <yi.l.liu@intel.com>
> >
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
> > As above, dual stage DMA translation offers two stage address mappings,
> > which could have better DMA address translation support for passthru
> > devices. This is also what vIOMMU developers are doing so far. Efforts
> > includes vSVA enabling from Yi Liu and SMMUv3 Nested Stage Setup from
> > Eric Auger.
> > https://www.spinics.net/lists/kvm/msg198556.html
> > https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg02842.html
> >
> > Both efforts are aiming to expose a vIOMMU with dual stage hardware
> > backed. As so, QEMU needs to have an explicit object to stand for
> > the dual stage capability from hardware. Such object offers abstract
> > for the dual stage DMA translation related operations, like:
> >
> >  1) PASID allocation (allow host to intercept in PASID allocation)
> >  2) bind stage-1 translation structures to host
> >  3) propagate stage-1 cache invalidation to host
> >  4) DMA address translation fault (I/O page fault) servicing etc.
> >
> > This patch introduces DualStageIOMMUObject to stand for the hardware
> > dual stage DMA translation capability. PASID allocation/free are the
> > first operation included in it, in future, there will be more operation=
s
> > like bind_stage1_pgtbl and invalidate_stage1_cache and etc.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>=20
> Several overall queries about this:
>=20
> 1) Since it's explicitly handling PASIDs, this seems a lot more
>    specific to SVM than the name suggests.  I'd suggest a rename.

It is not specific to SVM in future. We have efforts to move guest
IOVA support based on host IOMMU's dual-stage DMA translation
capability. Then, guest IOVA support will also re-use the methods
provided by this abstract layer. e.g. the bind_guest_pgtbl() and
flush_iommu_iotlb().

For the naming, how about HostIOMMUContext? This layer is to provide
explicit methods for setting up dual-stage DMA translation in host.

>=20
> 2) Why are you hand rolling structures of pointers, rather than making
>    this a QOM class or interface and putting those things into methods?

Maybe the name is not proper. Although I named it as DualStageIOMMUObject,
it is actually a kind of abstract layer we discussed in previous email. I
think this is similar with VFIO_MAP/UNMAP. The difference is that VFIO_MAP/
UNMAP programs mappings to host iommu domain. While the newly added explici=
t
method is to link guest page table to host iommu domain. VFIO_MAP/UNMAP
is exposed to vIOMMU emulators via MemoryRegion layer. right? Maybe adding =
a
similar abstract layer is enough. Is adding QOM really necessary for this
case?

> 3) It's not really clear to me if this is for the case where both
>    stages of translation are visible to the guest, or only one of
>    them.

For this case, vIOMMU will only expose a single stage translation to VM.
e.g. Intel VT-d, vIOMMU exposes first-level translation to guest. Hardware
IOMMUs with the dual-stage translation capability lets guest own stage-1
translation structures and host owns the stage-2 translation structures.
VMM is responsible to bind guest's translation structures to host and
enable dual-stage translation. e.g. on Intel VT-d, config translation type
to be NESTED.

Take guest SVM as an example, guest iommu driver owns the gVA->gPA mappings=
,
which is treated as stage-1 translation from host point of view. Host itsel=
f
owns the gPA->hPPA translation and called stage-2 translation when dual-sta=
ge
translation is configured.

For guest IOVA, it is similar with guest SVM. Guest iommu driver owns the
gIOVA->gPA mappings, which is treated as stage-1 translation. Host owns the
gPA->hPA translation.

Regards,
Yi Liu

