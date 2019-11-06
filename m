Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A27C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145CB2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145CB2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJN8-0005Fr-9z
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iSJKu-0002tH-5C
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iSJKs-0001mp-4L
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:18:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:56977)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iSJKr-0001mI-Se
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:18:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 03:18:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; d="scan'208";a="403695178"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2019 03:18:48 -0800
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 03:18:47 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 03:18:46 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.2]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 19:18:43 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [RFC v2 04/22] hw/iommu: introduce IOMMUContext
Thread-Topic: [RFC v2 04/22] hw/iommu: introduce IOMMUContext
Thread-Index: AQHVimsnFZ9HHzIneEOC2B5kT89EDqduQAWAgA/RzpA=
Date: Wed, 6 Nov 2019 11:18:42 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0EF1B3@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-5-git-send-email-yi.l.liu@intel.com>
 <20191027173929.GK3552@umbus.metropole.lan>
In-Reply-To: <20191027173929.GK3552@umbus.metropole.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzllYzgxNjYtOWRhZS00NDEwLTk2NTctZmMxYTMwMmNjYTQyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia0FrVllqaUNUVlwvc2p0aHI2ZU1LdnlBanZ3cTJjdEpwNlwvMGVhbXdQa1lPdngya0VDd1d5Nm5uM2VJWVBrMXdLIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: David Gibson [mailto:david@gibson.dropbear.id.au]
> Sent: Monday, October 28, 2019 1:39 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v2 04/22] hw/iommu: introduce IOMMUContext
>=20
> On Thu, Oct 24, 2019 at 08:34:25AM -0400, Liu Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> >
> > This patch adds IOMMUContext as an abstract layer of IOMMU related
> > operations. The current usage of this abstract layer is setup dual-
> > stage IOMMU translation (vSVA) for vIOMMU.
> >
> > To setup dual-stage IOMMU translation, vIOMMU needs to propagate
> > guest changes to host via passthru channels (e.g. VFIO). To have
> > a better abstraction, it is better to avoid direct calling between
> > vIOMMU and VFIO. So we have this new structure to act as abstract
> > layer between VFIO and vIOMMU. So far, it is proposed to provide a
> > notifier mechanism, which registered by VFIO and fired by vIOMMU.
> >
> > For more background, may refer to the discussion below:
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg05022.html
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  hw/Makefile.objs         |  1 +
> >  hw/iommu/Makefile.objs   |  1 +
> >  hw/iommu/iommu.c         | 66 ++++++++++++++++++++++++++++++++++++++++
> >  include/hw/iommu/iommu.h | 79
> ++++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 147 insertions(+)
> >  create mode 100644 hw/iommu/Makefile.objs
> >  create mode 100644 hw/iommu/iommu.c
> >  create mode 100644 include/hw/iommu/iommu.h
> >
> > diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> > index ece6cc3..ac19f9c 100644
> > --- a/hw/Makefile.objs
> > +++ b/hw/Makefile.objs
> > @@ -39,6 +39,7 @@ devices-dirs-y +=3D xen/
> >  devices-dirs-$(CONFIG_MEM_DEVICE) +=3D mem/
> >  devices-dirs-y +=3D semihosting/
> >  devices-dirs-y +=3D smbios/
> > +devices-dirs-y +=3D iommu/
> >  endif
> >
> >  common-obj-y +=3D $(devices-dirs-y)
> > diff --git a/hw/iommu/Makefile.objs b/hw/iommu/Makefile.objs
> > new file mode 100644
> > index 0000000..0484b79
> > --- /dev/null
> > +++ b/hw/iommu/Makefile.objs
> > @@ -0,0 +1 @@
> > +obj-y +=3D iommu.o
> > diff --git a/hw/iommu/iommu.c b/hw/iommu/iommu.c
> > new file mode 100644
> > index 0000000..2391b0d
> > --- /dev/null
> > +++ b/hw/iommu/iommu.c
> > @@ -0,0 +1,66 @@
> > +/*
> > + * QEMU abstract of IOMMU context
> > + *
> > + * Copyright (C) 2019 Red Hat Inc.
> > + *
> > + * Authors: Peter Xu <peterx@redhat.com>,
> > + *          Liu Yi L <yi.l.liu@intel.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > +
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > +
> > + * You should have received a copy of the GNU General Public License a=
long
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/iommu/iommu.h"
> > +
> > +void iommu_ctx_notifier_register(IOMMUContext *iommu_ctx,
> > +                                 IOMMUCTXNotifier *n,
> > +                                 IOMMUCTXNotifyFn fn,
> > +                                 IOMMUCTXEvent event)
> > +{
> > +    n->event =3D event;
> > +    n->iommu_ctx_event_notify =3D fn;
> > +    QLIST_INSERT_HEAD(&iommu_ctx->iommu_ctx_notifiers, n, node);
>=20
> Having this both modify the IOMMUCTXNotifier structure and insert it
> in the list seems confusing to me - and gratuitously different from
> the interface for both IOMMUNotifier and Notifier.
>=20
> Separating out a iommu_ctx_notifier_init() as a helper and having
> register take a fully initialized structure seems better to me.

Thanks, will do it in next version.

> > +    return;
>=20
> Using an explicit return at the end of a function returning void is an
> odd style.

got it, will fix it in next version.

>=20
> > +}
> > +
> > +void iommu_ctx_notifier_unregister(IOMMUContext *iommu_ctx,
> > +                                   IOMMUCTXNotifier *notifier)
> > +{
> > +    IOMMUCTXNotifier *cur, *next;
> > +
> > +    QLIST_FOREACH_SAFE(cur, &iommu_ctx->iommu_ctx_notifiers, node, nex=
t) {
> > +        if (cur =3D=3D notifier) {
> > +            QLIST_REMOVE(cur, node);
> > +            break;
> > +        }
> > +    }
> > +}
> > +
> > +void iommu_ctx_event_notify(IOMMUContext *iommu_ctx,
> > +                            IOMMUCTXEventData *event_data)
> > +{
> > +    IOMMUCTXNotifier *cur;
> > +
> > +    QLIST_FOREACH(cur, &iommu_ctx->iommu_ctx_notifiers, node) {
> > +        if ((cur->event =3D=3D event_data->event) &&
> > +                                 cur->iommu_ctx_event_notify) {
>=20
> Do you actually need the test on iommu_ctx_event_notify?  I can't see
> any reason to register a notifier with a NULL function pointer.

sure, let me remove the check. I may have been too careful here. :-)

> > +            cur->iommu_ctx_event_notify(cur, event_data);
> > +        }
> > +    }
> > +}
> > +
> > +void iommu_context_init(IOMMUContext *iommu_ctx)
> > +{
> > +    QLIST_INIT(&iommu_ctx->iommu_ctx_notifiers);
> > +}
> > diff --git a/include/hw/iommu/iommu.h b/include/hw/iommu/iommu.h
> > new file mode 100644
> > index 0000000..c22c442
> > --- /dev/null
> > +++ b/include/hw/iommu/iommu.h
> > @@ -0,0 +1,79 @@
> > +/*
> > + * QEMU abstraction of IOMMU Context
> > + *
> > + * Copyright (C) 2019 Red Hat Inc.
> > + *
> > + * Authors: Peter Xu <peterx@redhat.com>,
> > + *          Liu, Yi L <yi.l.liu@intel.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > +
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > +
> > + * You should have received a copy of the GNU General Public License a=
long
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef HW_PCI_PASID_H
> > +#define HW_PCI_PASID_H
>=20
> These guards need to be updated for the new header name.

Oops, thanks for spotting it out.

> > +
> > +#include "qemu/queue.h"
> > +#ifndef CONFIG_USER_ONLY
> > +#include "exec/hwaddr.h"
> > +#endif
> > +
> > +typedef struct IOMMUContext IOMMUContext;
> > +
> > +enum IOMMUCTXEvent {
> > +    IOMMU_CTX_EVENT_NUM,
> > +};
> > +typedef enum IOMMUCTXEvent IOMMUCTXEvent;
> > +
> > +struct IOMMUCTXEventData {
> > +    IOMMUCTXEvent event;
> > +    uint64_t length;
> > +    void *data;
> > +};
> > +typedef struct IOMMUCTXEventData IOMMUCTXEventData;
> > +
> > +typedef struct IOMMUCTXNotifier IOMMUCTXNotifier;
> > +
> > +typedef void (*IOMMUCTXNotifyFn)(IOMMUCTXNotifier *notifier,
> > +                                 IOMMUCTXEventData *event_data);
> > +
> > +struct IOMMUCTXNotifier {
> > +    IOMMUCTXNotifyFn iommu_ctx_event_notify;
> > +    /*
> > +     * What events we are listening to. Let's allow multiple event
> > +     * registrations from beginning.
> > +     */
> > +    IOMMUCTXEvent event;
> > +    QLIST_ENTRY(IOMMUCTXNotifier) node;
> > +};
> > +
> > +/*
> > + * This is an abstraction of IOMMU context.
> > + */
> > +struct IOMMUContext {
> > +    uint32_t pasid;
>=20
> This confuses me a bit.  I thought the idea was that IOMMUContext with
> SVM would represent all the PASIDs in use, but here we have a specific
> pasid stored in the structure.

It's added by mistake. Should not be included. No patch will use this field=
.
Will remove it. Thanks for the careful review.

Thanks,
Yi Liu


