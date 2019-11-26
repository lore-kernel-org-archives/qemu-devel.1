Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4E1C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DA12073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DA12073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZVEW-0000pj-Q3
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 02:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iZUwp-0008Gl-EN
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 02:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iZUwm-00006y-Vm
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 02:07:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:13100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iZUwm-0008Oz-MX
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 02:07:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Nov 2019 23:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,244,1571727600"; d="scan'208";a="211325433"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga006.jf.intel.com with ESMTP; 25 Nov 2019 23:07:33 -0800
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 25 Nov 2019 23:07:33 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 25 Nov 2019 23:07:33 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.149]) with mapi id 14.03.0439.000;
 Tue, 26 Nov 2019 15:07:31 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [RFC v2 09/22] vfio/pci: add iommu_context notifier for pasid
 alloc/free
Thread-Topic: [RFC v2 09/22] vfio/pci: add iommu_context notifier for pasid
 alloc/free
Thread-Index: AQHVimsw6XlsA5+cTkCxXGelXmRQYKdxCjoAgA0JSACAFQdKAIAKE4Wg
Date: Tue, 26 Nov 2019 07:07:31 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A10E709@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-10-git-send-email-yi.l.liu@intel.com>
 <20191029121544.GS3552@umbus.metropole.lan>
 <A2975661238FB949B60364EF0F2C25743A0EF2CE@SHSMSX104.ccr.corp.intel.com>
 <20191120042752.GF5582@umbus.fritz.box>
In-Reply-To: <20191120042752.GF5582@umbus.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGIyZWI2NTEtMzM4Yi00YzYxLWJiYTMtMWVjYjU5NmY2NGNjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS2xaV3pkV0tXeHJQcGlNakdESWZ6S2NOaUtKZDExMWZrNGJ5V0dLRUlFd0l0M0RzMGswaWkrVUl0Vm9lRUxxSyJ9
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

Hi David,

> From: David Gibson < david@gibson.dropbear.id.au>
> Sent: Wednesday, November 20, 2019 12:28 PM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v2 09/22] vfio/pci: add iommu_context notifier for pasi=
d alloc/free
>=20
> On Wed, Nov 06, 2019 at 12:14:50PM +0000, Liu, Yi L wrote:
> > > From: David Gibson [mailto:david@gibson.dropbear.id.au]
> > > Sent: Tuesday, October 29, 2019 8:16 PM
> > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > Subject: Re: [RFC v2 09/22] vfio/pci: add iommu_context notifier for =
pasid
> alloc/free
> > >
> > > On Thu, Oct 24, 2019 at 08:34:30AM -0400, Liu Yi L wrote:
> > > > This patch adds pasid alloc/free notifiers for vfio-pci. It is
> > > > supposed to be fired by vIOMMU. VFIO then sends PASID allocation
> > > > or free request to host.
> > > >
> > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Cc: Peter Xu <peterx@redhat.com>
> > > > Cc: Eric Auger <eric.auger@redhat.com>
> > > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > > ---
> > > >  hw/vfio/common.c         |  9 ++++++
> > > >  hw/vfio/pci.c            | 81
[...]
> > > > +
> > > > +static void vfio_iommu_pasid_alloc_notify(IOMMUCTXNotifier *n,
> > > > +                                          IOMMUCTXEventData *event=
_data)
> > > > +{
> > > > +    VFIOIOMMUContext *giommu_ctx =3D container_of(n, VFIOIOMMUCont=
ext,
> n);
> > > > +    VFIOContainer *container =3D giommu_ctx->container;
> > > > +    IOMMUCTXPASIDReqDesc *pasid_req =3D
> > > > +                              (IOMMUCTXPASIDReqDesc *) event_data-=
>data;
> > > > +    struct vfio_iommu_type1_pasid_request req;
> > > > +    unsigned long argsz;
> > > > +    int pasid;
> > > > +
> > > > +    argsz =3D sizeof(req);
> > > > +    req.argsz =3D argsz;
> > > > +    req.flag =3D VFIO_IOMMU_PASID_ALLOC;
> > > > +    req.min_pasid =3D pasid_req->min_pasid;
> > > > +    req.max_pasid =3D pasid_req->max_pasid;
> > > > +
> > > > +    pasid =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req)=
;
> > > > +    if (pasid < 0) {
> > > > +        error_report("%s: %d, alloc failed", __func__, -errno);
> > > > +    }
> > > > +    pasid_req->alloc_result =3D pasid;
> > >
> > > Altering the event data from the notifier doesn't make sense.  By
> > > definition there can be multiple notifiers on the chain, so in that
> > > case which one is responsible for updating the writable field?
> >
> > I guess you mean multiple pasid_alloc nofitiers. right?
> >
> > It works for VT-d now, as Intel vIOMMU maintains the IOMMUContext
> > per-bdf. And there will be only 1 pasid_alloc notifier in the chain. Bu=
t, I
> > agree it is not good if other module just share an IOMMUConext across
> > devices. Definitely, it would have multiple pasid_alloc notifiers.
>=20
> Right.
>=20
> > How about enforcing IOMMUContext layer to only invoke one successful
> > pasid_alloc/free notifier if PASID_ALLOC/FREE event comes? pasid
> > alloc/free are really special as it requires feedback. And a potential
> > benefit is that the pasid_alloc/free will not be affected by hot plug
> > scenario. There will be always a notifier to work for pasid_alloc/free
> > work unless all passthru devices are hot plugged. How do you think? Or
> > if any other idea?
>=20
> Hrm, that still doesn't seem right to me.  I don't think a notifier is
> really the right mechanism for something that needs to return values.
> This seems like something where you need to find a _single_
> responsible object and call a method / callback on that specifically.

Agreed. For alloc/free operations, we need an explicit calling instead
of notifier which is usally to be a chain notification.

> But it seems to me there's a more fundamental problem here.  AIUI the
> idea is that a single IOMMUContext could hold multiple devices.  But
> if the devices are responsible for assigning their own pasid values
> (by passing that decisionon to the host through vfio) then that really
> can't work.
>
> I'm assuming it's impossible from the hardware side to virtualize the
> pasids (so that we could assign them from qemu without host
> intervention).

Actually, this is possible. On Intel platform, we've introduced ENQCMD
to do PASID translation which essentially supports PASID virtualization.
You may get more details in section 3.3. This is also why we want to have
host's intervention in PASID alloc/free.

https://software.intel.com/sites/default/files/managed/c5/15/architecture-i=
nstruction-set-extensions-programming-reference.pdf

> If so, then the pasid allocation really has to be a Context level, not
> device level operation.  We'd have to wire the VFIO backend up to the
> context itself, not a device... I'm not immediately sure how to do
> that, though.

I think for the pasid alloc/free, we want it to be a vfio container
operation. right? However, we cannot expose vfio container out of vfio
or we don't want to do such thing. Then I'm wondering if we can have
a PASIDObject which is allocated per container creation, and registered
to vIOMMU. The PASIDObject can provide pasid alloc/free ops. vIOMMU can
consume the ops to get host pasid or free a host pasid.

While for the current IOMMUContext in this patchset, I think we may keep
it to support bind_gpasid and iommu_cache_invalidate. Also, as far as I
can see, we may want to extend it to support host IOMMU translation fault
injection to vIOMMU. This is also an important operation after config
nested translation for vIOMMU (a.k.a. dual stage translation).

> --
> David Gibson                  | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au        | minimalist, thank you.  NOT _the_=
 _other_
>                               | _way_ _around_!
> http://www.ozlabs.org/~dgibson

Thanks,
Yi Liu

