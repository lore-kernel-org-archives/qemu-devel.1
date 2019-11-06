Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFA7C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3B42173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3B42173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMGR-0007wu-4C
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iSMFd-0007DU-S8
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iSMFb-00009K-GI
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:25:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iSMFb-00008O-7l
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:25:35 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E97EC057EC6
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 14:25:34 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id n34so26223159qta.12
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=31iMCcCmEX1Wa0kDQtfFxRZ0WpCEzjs94AiuqerMIf8=;
 b=Bm3OlrGihNcFvW7R1Vw2Dy+KOTqptXARU2nH2A56QZZd4K5QxHOsxIR1IQqvMq6vlI
 j4mUUWE15d49SIlgZN5nUM/g/MUa81gEKoscIfolILqwm5+uXbkauqGpppXEfOx9+Yzp
 JG866aSCOIAS7oLtaSl4Lsrm6Hx9WxwwTgjLcxntfnlBYeadhFUd/iG+CCHIzRKi85BG
 2SD7pB0b2BfQSexQkSc3G6b7j+RpK+wSRFl3F6/QEPqjhgByU1LzQLXRrqus1v0xW9LH
 pElsIu8Hl+oQCvTtRuU93tVdo5gY9U4Cfa56vKOzkBiUSnhpSBm+tNKDBTkjGoHH0fdu
 mHJw==
X-Gm-Message-State: APjAAAVeaCdCsXowjNHN/dNB4VjruIHRhb3UyogtYbenebdVLK+WrKSi
 NZ5eORaaMq5Va5LBuwxzdvmz5p3TfZSPOHu6tj53VkjmsAizP1RV59nsec+lIRHhyRFiHxwv6cL
 R2dnU+CbfmLC62Hw=
X-Received: by 2002:a37:9d0:: with SMTP id 199mr2259470qkj.356.1573050333291; 
 Wed, 06 Nov 2019 06:25:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1Kpy20MjAZEmt2B/VsODBQDaTjbkycBeMhd823BpzG029+EschXsAE7qkQQ3+/eJfx8W0tA==
X-Received: by 2002:a37:9d0:: with SMTP id 199mr2259433qkj.356.1573050332945; 
 Wed, 06 Nov 2019 06:25:32 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id h25sm905409qka.117.2019.11.06.06.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 06:25:31 -0800 (PST)
Date: Wed, 6 Nov 2019 09:25:30 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v2 14/22] vfio/pci: add iommu_context notifier for pasid
 bind/unbind
Message-ID: <20191106142530.GB29717@xz-x1>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-15-git-send-email-yi.l.liu@intel.com>
 <20191104160228.GG3552@umbus.metropole.lan>
 <A2975661238FB949B60364EF0F2C25743A0EF2F1@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A0EF2F1@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 12:22:46PM +0000, Liu, Yi L wrote:
> > From: David Gibson
> > Sent: Tuesday, November 5, 2019 12:02 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v2 14/22] vfio/pci: add iommu_context notifier for pasid
> > bind/unbind
> > 
> > On Thu, Oct 24, 2019 at 08:34:35AM -0400, Liu Yi L wrote:
> > > This patch adds notifier for pasid bind/unbind. VFIO registers this
> > > notifier to listen to the dual-stage translation (a.k.a. nested
> > > translation) configuration changes and propagate to host. Thus vIOMMU
> > > is able to set its translation structures to host.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>
> > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > ---
> > >  hw/vfio/pci.c            | 39 +++++++++++++++++++++++++++++++++++++++
> > >  include/hw/iommu/iommu.h | 11 +++++++++++
> > >  2 files changed, 50 insertions(+)
> > >
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index 8721ff6..012b8ed 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -2767,6 +2767,41 @@ static void
> > vfio_iommu_pasid_free_notify(IOMMUCTXNotifier *n,
> > >      pasid_req->free_result = ret;
> > >  }
> > >
> > > +static void vfio_iommu_pasid_bind_notify(IOMMUCTXNotifier *n,
> > > +                                         IOMMUCTXEventData *event_data)
> > > +{
> > > +#ifdef __linux__
> > 
> > Is hw/vfio/pci.c even built on non-linux hosts?
> 
> I'm not quite sure. It's based a comment from RFC v1. I think it could somehow
> prevent compiling issue when doing code porting. So I added it. If it's impossible
> to build on non-linux hosts per your experience, I can remove it to make things
> simple.

To my understanding this should not be needed because VFIO doesn't
work with non-linux after all (as said)... while...

> 
> > > +    VFIOIOMMUContext *giommu_ctx = container_of(n, VFIOIOMMUContext, n);
> > > +    VFIOContainer *container = giommu_ctx->container;
> > > +    IOMMUCTXPASIDBindData *pasid_bind =
> > > +                              (IOMMUCTXPASIDBindData *) event_data->data;
> > > +    struct vfio_iommu_type1_bind *bind;
> > > +    struct iommu_gpasid_bind_data *bind_data;
> > > +    unsigned long argsz;
> > > +
> > > +    argsz = sizeof(*bind) + sizeof(*bind_data);
> > > +    bind = g_malloc0(argsz);
> > > +    bind->argsz = argsz;
> > > +    bind->bind_type = VFIO_IOMMU_BIND_GUEST_PASID;
> > > +    bind_data = (struct iommu_gpasid_bind_data *) &bind->data;
> > > +    *bind_data = *pasid_bind->data;
> > > +
> > > +    if (pasid_bind->flag & IOMMU_CTX_BIND_PASID) {
> > > +        if (ioctl(container->fd, VFIO_IOMMU_BIND, bind) != 0) {
> > > +            error_report("%s: pasid (%llu:%llu) bind failed: %d", __func__,
> > > +                         bind_data->gpasid, bind_data->hpasid, -errno);
> > > +        }
> > > +    } else if (pasid_bind->flag & IOMMU_CTX_UNBIND_PASID) {
> > > +        if (ioctl(container->fd, VFIO_IOMMU_UNBIND, bind) != 0) {
> > > +            error_report("%s: pasid (%llu:%llu) unbind failed: %d", __func__,
> > > +                         bind_data->gpasid, bind_data->hpasid, -errno);
> > > +        }
> > > +    }
> > > +
> > > +    g_free(bind);
> > > +#endif
> > > +}
> > > +
> > >  static void vfio_realize(PCIDevice *pdev, Error **errp)
> > >  {
> > >      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
> > > @@ -3079,6 +3114,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
> > >                                           iommu_context,
> > >                                           vfio_iommu_pasid_free_notify,
> > >                                           IOMMU_CTX_EVENT_PASID_FREE);
> > > +        vfio_register_iommu_ctx_notifier(vdev,
> > > +                                         iommu_context,
> > > +                                         vfio_iommu_pasid_bind_notify,
> > > +                                         IOMMU_CTX_EVENT_PASID_BIND);
> > >      }
> > >
> > >      return;
> > > diff --git a/include/hw/iommu/iommu.h b/include/hw/iommu/iommu.h
> > > index 4352afd..4f21aa1 100644
> > > --- a/include/hw/iommu/iommu.h
> > > +++ b/include/hw/iommu/iommu.h
> > > @@ -33,6 +33,7 @@ typedef struct IOMMUContext IOMMUContext;
> > >  enum IOMMUCTXEvent {
> > >      IOMMU_CTX_EVENT_PASID_ALLOC,
> > >      IOMMU_CTX_EVENT_PASID_FREE,
> > > +    IOMMU_CTX_EVENT_PASID_BIND,
> > >      IOMMU_CTX_EVENT_NUM,
> > >  };
> > >  typedef enum IOMMUCTXEvent IOMMUCTXEvent;
> > > @@ -50,6 +51,16 @@ union IOMMUCTXPASIDReqDesc {
> > >  };
> > >  typedef union IOMMUCTXPASIDReqDesc IOMMUCTXPASIDReqDesc;
> > >
> > > +struct IOMMUCTXPASIDBindData {
> > > +#define IOMMU_CTX_BIND_PASID   (1 << 0)
> > > +#define IOMMU_CTX_UNBIND_PASID (1 << 1)
> > > +    uint32_t flag;
> > > +#ifdef __linux__
> > > +    struct iommu_gpasid_bind_data *data;
> > 
> > Embedding a linux specific structure in the notification message seems
> > dubious to me.
> 
> Just similar as your above comment in this thread. If we don't want to add
> it there, then here it is also unnecessary.

... I'm not sure but maybe we need this here because I _think_ vt-d
should even work on Windows.  However instead of __linux__ over *data,
should you cover the whole IOMMUCTXPASIDBindData?

-- 
Peter Xu

