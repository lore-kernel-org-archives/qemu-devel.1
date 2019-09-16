Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBBCC4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 01:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D4A2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 01:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D4A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9gDK-00024s-1D
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 21:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1i9gCd-0001f8-P8
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 21:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1i9gCc-0008Gx-Du
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 21:53:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:23284)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1i9gCc-0008Gf-69
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 21:53:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Sep 2019 18:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,510,1559545200"; d="scan'208";a="193309549"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by FMSMGA003.fm.intel.com with ESMTP; 15 Sep 2019 18:53:16 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 15 Sep 2019 18:53:16 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 15 Sep 2019 18:53:15 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 15 Sep 2019 18:53:15 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.235]) with mapi id 14.03.0439.000;
 Mon, 16 Sep 2019 09:53:13 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Thread-Topic: [PATCH v8 01/13] vfio: KABI for migration interface
Thread-Index: AQHVXEPM6Ds11z4g1kGhkyVJXk+n4qcQheKAgAKxOUCAABvDkIAAD6EAgAYgQnCADi7SAIABCiGQgACa2QCABFOlwA==
Date: Mon, 16 Sep 2019 01:53:13 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D577C02@SHSMSX104.ccr.corp.intel.com>
References: <1566845753-18993-1-git-send-email-kwankhede@nvidia.com>
 <1566845753-18993-2-git-send-email-kwankhede@nvidia.com>
 <20190828145045.20f2a7b3@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D553133@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D553184@SHSMSX104.ccr.corp.intel.com>
 <20190830103252.2b427144@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D560D74@SHSMSX104.ccr.corp.intel.com>
 <20190912154106.4e784906@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D572135@SHSMSX104.ccr.corp.intel.com>
 <20190913094750.03759a4d@x1.home>
In-Reply-To: <20190913094750.03759a4d@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODU3MGYzYWItMmVjYy00YzJlLWI5MDUtNjQzOGVmNjcyYjUxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTVR1Q2I2dXlWVG9nVThpXC9VUDArZ3QrU3lEeTBKVHB5MVMrbHFPNHJKMkU4TlViUElrMHM1d0lmWjNhcERrY1cifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH v8 01/13] vfio: KABI for migration interface
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Friday, September 13, 2019 11:48 PM
>=20
> On Thu, 12 Sep 2019 23:00:03 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
>=20
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Thursday, September 12, 2019 10:41 PM
> > >
> > > On Tue, 3 Sep 2019 06:57:27 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > >
> > > > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > > > Sent: Saturday, August 31, 2019 12:33 AM
> > > > >
> > > > > On Fri, 30 Aug 2019 08:06:32 +0000
> > > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > >
> > > > > > > From: Tian, Kevin
> > > > > > > Sent: Friday, August 30, 2019 3:26 PM
> > > > > > >
> > > > > > [...]
> > > > > > > > How does QEMU handle the fact that IOVAs are potentially
> > > dynamic
> > > > > while
> > > > > > > > performing the live portion of a migration?  For example, e=
ach
> > > time a
> > > > > > > > guest driver calls dma_map_page() or dma_unmap_page(), a
> > > > > > > > MemoryRegionSection pops in or out of the AddressSpace for
> the
> > > device
> > > > > > > > (I'm assuming a vIOMMU where the device AddressSpace is
> not
> > > > > > > > system_memory).  I don't see any QEMU code that intercepts
> that
> > > > > change
> > > > > > > > in the AddressSpace such that the IOVA dirty pfns could be
> > > recorded and
> > > > > > > > translated to GFNs.  The vendor driver can't track these be=
yond
> > > getting
> > > > > > > > an unmap notification since it only knows the IOVA pfns, wh=
ich
> > > can be
> > > > > > > > re-used with different GFN backing.  Once the DMA mapping i=
s
> > > torn
> > > > > down,
> > > > > > > > it seems those dirty pfns are lost in the ether.  If this w=
orks in
> > > QEMU,
> > > > > > > > please help me find the code that handles it.
> > > > > > >
> > > > > > > I'm curious about this part too. Interestingly, I didn't find=
 any
> > > log_sync
> > > > > > > callback registered by emulated devices in Qemu. Looks dirty
> pages
> > > > > > > by emulated DMAs are recorded in some implicit way. But KVM
> > > always
> > > > > > > reports dirty page in GFN instead of IOVA, regardless of the
> > > presence of
> > > > > > > vIOMMU. If Qemu also tracks dirty pages in GFN for emulated
> DMAs
> > > > > > >  (translation can be done when DMA happens), then we don't
> need
> > > > > > > worry about transient mapping from IOVA to GFN. Along this
> way
> > > we
> > > > > > > also want GFN-based dirty bitmap being reported through VFIO,
> > > > > > > similar to what KVM does. For vendor drivers, it needs to
> translate
> > > > > > > from IOVA to HVA to GFN when tracking DMA activities on VFIO
> > > > > > > devices. IOVA->HVA is provided by VFIO. for HVA->GFN, it can =
be
> > > > > > > provided by KVM but I'm not sure whether it's exposed now.
> > > > > > >
> > > > > >
> > > > > > HVA->GFN can be done through hva_to_gfn_memslot in
> kvm_host.h.
> > > > >
> > > > > I thought it was bad enough that we have vendor drivers that
> depend
> > > on
> > > > > KVM, but designing a vfio interface that only supports a KVM
> interface
> > > > > is more undesirable.  I also note without comment that
> > > gfn_to_memslot()
> > > > > is a GPL symbol.  Thanks,
> > > >
> > > > yes it is bad, but sometimes inevitable. If you recall our discussi=
ons
> > > > back to 3yrs (when discussing the 1st mdev framework), there were
> > > similar
> > > > hypervisor dependencies in GVT-g, e.g. querying gpa->hpa when
> > > > creating some shadow structures. gpa->hpa is definitely hypervisor
> > > > specific knowledge, which is easy in KVM (gpa->hva->hpa), but needs
> > > > hypercall in Xen. but VFIO already makes assumption based on KVM-
> > > > only flavor when implementing vfio_{un}pin_page_external.
> > >
> > > Where's the KVM assumption there?  The MAP_DMA ioctl takes an
> IOVA
> > > and
> > > HVA.  When an mdev vendor driver calls vfio_pin_pages(), we GUP the
> HVA
> > > to get an HPA and provide an array of HPA pfns back to the caller.  T=
he
> > > other vGPU mdev vendor manages to make use of this without KVM...
> the
> > > KVM interface used by GVT-g is GPL-only.
> >
> > To be clear it's the assumption on the host-based hypervisors e.g. KVM.
> > GUP is a perfect example, which doesn't work for Xen since DomU's
> > memory doesn't belong to Dom0. VFIO in Dom0 has to find the HPA
> > through Xen specific hypercalls.
>=20
> VFIO does not assume a hypervisor at all.  Yes, it happens to work well
> with a host-based hypervisor like KVM were we can simply use GUP, but
> I'd hardly call using the standard mechanism to pin a user page and get
> the pfn within the Linux kernel a KVM assumption.  The fact that Dom0
> Xen requires work here while KVM does not does is not an equivalency to
> VFIO assuming KVM.  Thanks,
>=20

Agree, thanks for clarification.

Thanks
Kevin

