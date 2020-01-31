Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F02CC3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08475215A4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08475215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51793 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixUi5-0007hu-66
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 06:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1ixUgl-0006NE-Lv
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:42:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1ixUgk-0007PG-94
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:42:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:60601)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1ixUgj-0007NR-VZ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:42:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 03:42:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,385,1574150400"; d="scan'208";a="233379445"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga006.jf.intel.com with ESMTP; 31 Jan 2020 03:42:16 -0800
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 03:42:16 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jan 2020 03:42:16 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.197]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.30]) with mapi id 14.03.0439.000;
 Fri, 31 Jan 2020 19:42:14 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [RFC v3 03/25] hw/iommu: introduce IOMMUContext
Thread-Topic: [RFC v3 03/25] hw/iommu: introduce IOMMUContext
Thread-Index: AQHV1p1ISlCEZJtKwkqCei/mecuDIagDpFsAgADzWWA=
Date: Fri, 31 Jan 2020 11:42:13 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A199306@SHSMSX104.ccr.corp.intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-4-git-send-email-yi.l.liu@intel.com>
 <20200131040644.GG15210@umbus.fritz.box>
In-Reply-To: <20200131040644.GG15210@umbus.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2JhM2VjZTItYTc3Zi00M2NiLTg3YWItODUyNDhkOGY2ZDk3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoib0lGeGU1N2lWSFdxeGdjUFc0eTI3UUxsYXRMbGV0Z1wvdFlQSWRkSTB5c3lSOVJGNXZRczlzSFhiVVRnVzhKXC9PIn0=
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
> Sent: Friday, January 31, 2020 12:07 PM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v3 03/25] hw/iommu: introduce IOMMUContext
>=20
> On Wed, Jan 29, 2020 at 04:16:34AM -0800, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> >
> > Currently, many platform vendors provide the capability of dual stage
> > DMA address translation in hardware. For example, nested translation
> > on Intel VT-d scalable mode, nested stage translation on ARM SMMUv3,
> > and etc. Also there are efforts to make QEMU vIOMMU be backed by dual
> > stage DMA address translation capability provided by hardware to have
> > better address translation support for passthru devices.
> >
> > As so, making vIOMMU be backed by dual stage translation capability
> > requires QEMU vIOMMU to have a way to get aware of such hardware
> > capability and also require a way to receive DMA address translation
> > faults (e.g. I/O page request) from host as guest owns stage-1 translat=
ion
> > structures in dual stage DAM address translation.
> >
> > This patch adds IOMMUContext as an abstract of vIOMMU related operation=
s.
> > Like provide a way for passthru modules (e.g. VFIO) to register
> > DualStageIOMMUObject instances. And in future, it is expected to offer
> > support for receiving host DMA translation faults happened on stage-1
> > translation.
> >
> > For more backgrounds, may refer to the discussion below, while there
> > is also difference between the current implementation and original
> > proposal. This patch introduces the IOMMUContext as an abstract layer
> > for passthru module (e.g. VFIO) calls into vIOMMU. The first introduced
> > interface is to make QEMU vIOMMU be aware of dual stage translation
> > capability.
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg05022.html
>=20
> Again, is there a reason for not making this a QOM class or interface?

I guess it is enough to make a simple abstract layer as explained in prior
email. IOMMUContext is to provide explicit method for VFIO to call into
vIOMMU emulators.

>=20
> I'm not very clear on the relationship betwen an IOMMUContext and a
> DualStageIOMMUObject.  Can there be many IOMMUContexts to a
> DualStageIOMMUOBject?  The other way around?  Or is it just
> zero-or-one DualStageIOMMUObjects to an IOMMUContext?

It is possible. As the below patch shows, DualStageIOMMUObject is per vfio
container. IOMMUContext can be either per-device or shared across devices,
it depends on vendor specific vIOMMU emulators.
[RFC v3 10/25] vfio: register DualStageIOMMUObject to vIOMMU
https://www.spinics.net/lists/kvm/msg205198.html

Take Intel vIOMMU as an example, there is a per device structure which
includes IOMMUContext instance and a DualStageIOMMUObject pointer.

+struct VTDIOMMUContext {
+    VTDBus *vtd_bus;
+    uint8_t devfn;
+    IOMMUContext iommu_context;
+    DualStageIOMMUObject *dsi_obj;
+    IntelIOMMUState *iommu_state;
+};
https://www.spinics.net/lists/kvm/msg205196.html

I think this would leave space for vendor specific vIOMMU emulators to
design their own relationship between an IOMMUContext and a
DualStageIOMMUObject.

> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Peter Xu <peterx@redhat.com>

[...]

> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/iommu/iommu_context.h"
> > +
> > +int iommu_context_register_ds_iommu(IOMMUContext *iommu_ctx,
> > +                                    DualStageIOMMUObject *dsi_obj)
> > +{
> > +    if (!iommu_ctx || !dsi_obj) {
>=20
> Would this ever happen apart from a bug in the caller?  If not it
> should be an assert().

Got it, thanks, I'll check all other alike in this series and fix them in
next version.

Thanks,
Yi Liu

