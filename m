Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D0DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 01:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3471321883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 01:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3471321883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Ka8-0002ma-9V
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 21:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i5KZO-0002IP-Sq
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 21:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i5KZN-0007Ay-4L
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 21:58:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i5KZM-0007AU-ST
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 21:58:49 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF0C7C002966
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 01:58:47 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id g1so12245768pfo.4
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 18:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=A7PjX/SXFR8o/059W3/K/OOcmKUuFkR+MHHL591vpNM=;
 b=FM9cQNpx9P/YE/ypxbhsP+sZymWmFsIuSfxxTWNIlN9FNJyv23y5wO7ZdcZ4J4EloI
 tiAYkr6Xh9mBud0LjdjroW5YuFfR4QaZ/QVeOZekEtutQrY6s+V5x/fpssv98/mMk9za
 1wsm/8WPeerXBFOkD3xCYOwR2PuAnNtubc+o/u1GkWb1YYNOidAzPHa/Kd1ac8Ao9VTM
 ZZguUnXc/Zb+5C3Q0o7G+n2J0NsLnLIjtr2b13SWorVDW2zh9ebAOHXZUImyNXmfaenV
 hjYru9Chj+d3Zz7DhPb7o6z9Jfhc52l1tAoqDqSEUkeg4n6c7UAEO8KlunZXjcGt2m1R
 IQoQ==
X-Gm-Message-State: APjAAAUB8s/e3jQ0YfEI6qdMurm8vR9V3PgObdXzM9uds4Ggq0AfuLKO
 jV4Usa4yX9kMl1zTtkafP662ExfoUx6k3AfQUiwnrzaKUyfcyNrfXvdDu+mUdk9rcV9dobiwmhO
 QN8yf08AMXD7Y1nM=
X-Received: by 2002:a17:90a:ec12:: with SMTP id
 l18mr2387375pjy.6.1567562327380; 
 Tue, 03 Sep 2019 18:58:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz3xRN9b/kQltE2OHfi/gcz2/8r/liM/andAIuu11sSpgjbhc86RHfO1Z7aY/SGJwsOymXHzg==
X-Received: by 2002:a17:90a:ec12:: with SMTP id
 l18mr2387347pjy.6.1567562327152; 
 Tue, 03 Sep 2019 18:58:47 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s19sm4929268pfe.86.2019.09.03.18.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 18:58:46 -0700 (PDT)
Date: Wed, 4 Sep 2019 09:58:34 +0800
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190904015834.GC30402@xz-x1>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-10-eric.auger@redhat.com>
 <20190819082424.GB13560@xz-x1>
 <d3759ba2-6ae6-2ae4-a71e-69965285f3f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3759ba2-6ae6-2ae4-a71e-69965285f3f4@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 09/15] virtio-iommu: Implement
 translate
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 tn@semihalf.com, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 01:45:22PM +0200, Auger Eric wrote:
> Hi Peter,
> 
> On 8/19/19 10:24 AM, Peter Xu wrote:
> > On Tue, Jul 30, 2019 at 07:21:31PM +0200, Eric Auger wrote:
> >> @@ -464,19 +464,75 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >>                                              int iommu_idx)
> >>  {
> >>      IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
> >> +    VirtIOIOMMU *s = sdev->viommu;
> >>      uint32_t sid;
> >> +    viommu_endpoint *ep;
> >> +    viommu_mapping *mapping;
> >> +    viommu_interval interval;
> >> +    bool bypass_allowed;
> >> +
> >> +    interval.low = addr;
> >> +    interval.high = addr + 1;
> >>  
> >>      IOMMUTLBEntry entry = {
> >>          .target_as = &address_space_memory,
> >>          .iova = addr,
> >>          .translated_addr = addr,
> >> -        .addr_mask = ~(hwaddr)0,
> >> +        .addr_mask = (1 << ctz32(s->config.page_size_mask)) - 1,
> >>          .perm = IOMMU_NONE,
> >>      };
> >>  
> >> +    bypass_allowed = virtio_has_feature(s->acked_features,
> >> +                                        VIRTIO_IOMMU_F_BYPASS);
> >> +
> >>      sid = virtio_iommu_get_sid(sdev);
> >>  
> >>      trace_virtio_iommu_translate(mr->parent_obj.name, sid, addr, flag);
> >> +    qemu_mutex_lock(&s->mutex);
> >> +
> >> +    ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(sid));
> >> +    if (!ep) {
> >> +        if (!bypass_allowed) {
> >> +            error_report("%s sid=%d is not known!!", __func__, sid);
> > 
> > Maybe use error_report_once() to avoid DOS attack?  Also would it be
> > good to unify the debug prints?  I see both error_report() and
> > qemu_log_mask() are used in the whole patchset.  Or is that attempted?
> 
> I switched to error_report_once()
> 
> I understand that qemu_log_mask() should be used whenever the root cause
> is a bad action of the guest OS (in below case, the EP was not attached
> to any domain). Above, there is an EP that attempts to talk through the
> IOMMU and this was not expected (rather a platform description issue or
> a qemu bug).

I see. It's a bit unclear at least to me on how to use these.  I have
seen, and used error_report*() to report guest misbehaves as well just
for the debugging and triaging simply because error_report*() will
always be there even without "-d" (because when issue happens most
users are without it...).  Then with these information captured by
either libvirt or direct QEMU users we can triage guest bugs easier.
I hope I'm not severly wrong, and please feel free to use
qemu_log_mask() no matter what.

Regards,

-- 
Peter Xu

