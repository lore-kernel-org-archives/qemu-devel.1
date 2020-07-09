Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E452C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1C42074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuuPv3HU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1C42074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXGm-0007ap-UJ
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jtXGA-0007BD-Sv
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:10:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jtXG9-0000ni-0M
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594303843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X9C+K8IFXHs6GEgIXOeuTGrJ0+spWy7M/yAcB1H4a0Q=;
 b=EuuPv3HU/GIVZrrnVG7rkbdVEM/kzCFf7e9LelFWihhTkiAYZn0WrW/VhST4VENabdvFIz
 NvJQgs242GsAMpx69EHZchL0hxDukTGtcTsT4gHW6SN/GhBCPcU0Di5znHuUFuVWqryc5M
 qU7T/4+c+ozDhs58RaIbx2sXGxoOOiw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-kbyPa1SKM4e9XaghEWAGjw-1; Thu, 09 Jul 2020 10:10:42 -0400
X-MC-Unique: kbyPa1SKM4e9XaghEWAGjw-1
Received: by mail-qv1-f71.google.com with SMTP id j6so1456388qvl.13
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X9C+K8IFXHs6GEgIXOeuTGrJ0+spWy7M/yAcB1H4a0Q=;
 b=kfZ7CqMinyDiENXPQOcOEpdcZAdx5Z5JxOF0lV2JZCGesj3en40BKd4NdTEp0S2H7W
 EpORaMOJ0CBjH6jrU3KIKVZJyqphZRk0dxAe5X9mGkWt9Cx4q9qL7x+2xZgqO2ZIaIbI
 +rJfmR+v19TbZfmMJbKbQ8Aw6SZQ3/Pjr5RsM0MsrZvd4U5Fed08y3VLC53AP/7sadwR
 5D2wT5Zh6Mgcd2xVy/Ngs3V30M1Sdh0hB3uRZ+r2hbFInFc1UBL2AViIfG90mnxbUvv1
 3O6g4nCRNidIllbLWid8OExfaLU9nRI7Cr0+cN953DV1YzazKi/18HndwDLKHZPhe950
 kDkw==
X-Gm-Message-State: AOAM5323uYa9+Q9rNag5Zq408UIsDUYtWowOLEdBkpad9bd5JBhOy6L2
 YLVbJ8DX6DHx1YqXRRSkOUyG6armbcJzeX/2EyLpyPXSgjZQO/oGhI/Eh6OiJSCMsMZT8l5tdVx
 pIs+szTS+zDn690o=
X-Received: by 2002:a0c:f88e:: with SMTP id u14mr63994240qvn.81.1594303841801; 
 Thu, 09 Jul 2020 07:10:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOqLUfnGnvsPJBa91TwEVHHdGNzCOKfRioWACXmNGhJ7lyfqpY2N32t4Clnl3RXXSgrBvnSg==
X-Received: by 2002:a0c:f88e:: with SMTP id u14mr63994213qvn.81.1594303841460; 
 Thu, 09 Jul 2020 07:10:41 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id a6sm3966540qkd.69.2020.07.09.07.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 07:10:40 -0700 (PDT)
Date: Thu, 9 Jul 2020 10:10:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200709141037.GF199122@xz-x1>
References: <69f6d6e7-a0b1-abae-894e-4e81b7e0cc90@redhat.com>
 <ff9e7af0-18c4-57e8-fc94-904fdce1123a@redhat.com>
 <20200702154540.GI40675@xz-x1>
 <34fe0e55-c0ae-8e56-462b-6281b6cca4f5@redhat.com>
 <20200703130338.GD6677@xz-x1>
 <c985b804-126c-94a1-b05e-430075f9e390@redhat.com>
 <20200707195429.GF88106@xz-x1>
 <5004a059-6eb0-4ef3-40b7-94dfbf9ec08f@redhat.com>
 <20200708141657.GA199122@xz-x1>
 <14b1ca26-448d-0feb-7529-6546809aaa59@redhat.com>
MIME-Version: 1.0
In-Reply-To: <14b1ca26-448d-0feb-7529-6546809aaa59@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 01:58:33PM +0800, Jason Wang wrote:
> > > - If we care the performance, it's better to implement the MAP event for
> > > vhost, otherwise it could be a lot of IOTLB miss
> > I feel like these are two things.
> > 
> > So far what we are talking about is whether vt-d should have knowledge about
> > what kind of events one iommu notifier is interested in.  I still think we
> > should keep this as answered in question 1.
> > 
> > The other question is whether we want to switch vhost from UNMAP to MAP/UNMAP
> > events even without vDMA, so that vhost can establish the mapping even before
> > IO starts.  IMHO it's doable, but only if the guest runs DPDK workloads.  When
> > the guest is using dynamic iommu page mappings, I feel like that can be even
> > slower, because then the worst case is for each IO we'll need to vmexit twice:
> > 
> >    - The first vmexit caused by an invalidation to MAP the page tables, so vhost
> >      will setup the page table before IO starts
> > 
> >    - IO/DMA triggers and completes
> > 
> >    - The second vmexit caused by another invalidation to UNMAP the page tables
> > 
> > So it seems to be worse than when vhost only uses UNMAP like right now.  At
> > least we only have one vmexit (when UNMAP).  We'll have a vhost translate()
> > request from kernel to userspace, but IMHO that's cheaper than the vmexit.
> 
> 
> Right but then I would still prefer to have another notifier.
> 
> Since vtd_page_walk has nothing to do with device IOTLB. IOMMU have a
> dedicated command for flushing device IOTLB. But the check for
> vtd_as_has_map_notifier is used to skip the device which can do demand
> paging via ATS or device specific way. If we have two different notifiers,
> vhost will be on the device iotlb notifier so we don't need it at all?

But we can still have iommu notifier that only registers to UNMAP even after we
introduce dev-iotlb notifier?  We don't want to do page walk for them as well.
TCG should be the only one so far, but I don't know.. maybe there can still be
new ones?

Thanks,

-- 
Peter Xu


