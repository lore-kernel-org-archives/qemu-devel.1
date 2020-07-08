Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C504C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639C1206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZAVAd35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639C1206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIfX-000697-H6
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jtIOZ-0004BC-Ui
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:18:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33351
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jtIOY-0000aG-D3
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0zNRKuJdNZOL+P96AeWfDN8lfkoWprOjCxNHWKJpjaY=;
 b=KZAVAd35fRKsmOBf/CcpXAa8KxhJEgaHAbKBx1vEC9sRI2fUXu10wp5f70LZwJvRRRHp+B
 r5ojEF9KSKTSVvrqaPwxDUxouJyZAXHxoXdip95Eu8rFMDepraihg7eDeWP6WUW8lgfOFb
 lgemtMPLl/afEYTW82Ds5Nh0mSh5UeQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-spEOIxOsNEGi4pHiWdMYTg-1; Wed, 08 Jul 2020 10:17:00 -0400
X-MC-Unique: spEOIxOsNEGi4pHiWdMYTg-1
Received: by mail-qt1-f198.google.com with SMTP id l53so1725883qtl.10
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 07:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0zNRKuJdNZOL+P96AeWfDN8lfkoWprOjCxNHWKJpjaY=;
 b=UUSlcDEKJ3aXqDVeuENIq60N+cZ3IgazDKp7ZMbQ8gVzWGx9F4n9mPOz6kqwIFo2sC
 h9uR7+KxY5PNXpcTvIuDQm4AN7Pkv9mBDfbcgvHDE1ZrZv10vnNY5MDPoBm1PitYAJzc
 bG4vaeaOQI/Oi2gwOF8ivGnaI0wFv1HY7OWR+AGelEXkzrK7prQvhIeQJVfNg7KM8RJX
 VNfKq1jr2r62yesbO3qdwgFMEHNFyB3nKp2GtugLAmzwXAtUVnMRsD4qVoTLInrJl29y
 KPzxkaG0c2jg//ERj1tALUNVWYdRTr8QWhtchVzTr6TS2CnMY/gFwwNrohQV8ABjpA3s
 whGw==
X-Gm-Message-State: AOAM5312iPeaQCLy6npI8NHcy2h+zOMMNBu5HbwQ9tkZEg2qR9xNUJsG
 fcAXMfdAqky5ZZ9f2l1Cv428okYugb/OtAmKa02ikGoAXtiL+40mowJAL7Eu6b4rpedVZ1ierdV
 wNxgg02pN/PFATv4=
X-Received: by 2002:a0c:e78e:: with SMTP id x14mr40423426qvn.65.1594217820205; 
 Wed, 08 Jul 2020 07:17:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCUaxenhH3eOsgIo6MbrAZAN3dmmrNXmc38NHns2mwzOM7ivBT3b62ww5246jzBKInEo8zHg==
X-Received: by 2002:a0c:e78e:: with SMTP id x14mr40423371qvn.65.1594217819653; 
 Wed, 08 Jul 2020 07:16:59 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id k14sm7909959qtb.38.2020.07.08.07.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 07:16:58 -0700 (PDT)
Date: Wed, 8 Jul 2020 10:16:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200708141657.GA199122@xz-x1>
References: <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
 <20200630153911.GD3138@xz-x1>
 <69f6d6e7-a0b1-abae-894e-4e81b7e0cc90@redhat.com>
 <ff9e7af0-18c4-57e8-fc94-904fdce1123a@redhat.com>
 <20200702154540.GI40675@xz-x1>
 <34fe0e55-c0ae-8e56-462b-6281b6cca4f5@redhat.com>
 <20200703130338.GD6677@xz-x1>
 <c985b804-126c-94a1-b05e-430075f9e390@redhat.com>
 <20200707195429.GF88106@xz-x1>
 <5004a059-6eb0-4ef3-40b7-94dfbf9ec08f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5004a059-6eb0-4ef3-40b7-94dfbf9ec08f@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 08, 2020 at 01:42:30PM +0800, Jason Wang wrote:
> > > So it should be functional equivalent to vtd_as_has_notifier().
> > For example: in vtd_iommu_replay() we'll skip the replay if vhost has
> > registered the iommu notifier because vtd_as_has_map_notifier() will return
> > false.
> 
> 
> Two questions:
> 
> - Do we care the performance here? If not, vhost may just ignore the MAP
> event?

I think we care, because vtd_page_walk() can be expensive.

> - If we care the performance, it's better to implement the MAP event for
> vhost, otherwise it could be a lot of IOTLB miss

I feel like these are two things.

So far what we are talking about is whether vt-d should have knowledge about
what kind of events one iommu notifier is interested in.  I still think we
should keep this as answered in question 1.

The other question is whether we want to switch vhost from UNMAP to MAP/UNMAP
events even without vDMA, so that vhost can establish the mapping even before
IO starts.  IMHO it's doable, but only if the guest runs DPDK workloads.  When
the guest is using dynamic iommu page mappings, I feel like that can be even
slower, because then the worst case is for each IO we'll need to vmexit twice:

  - The first vmexit caused by an invalidation to MAP the page tables, so vhost
    will setup the page table before IO starts

  - IO/DMA triggers and completes

  - The second vmexit caused by another invalidation to UNMAP the page tables

So it seems to be worse than when vhost only uses UNMAP like right now.  At
least we only have one vmexit (when UNMAP).  We'll have a vhost translate()
request from kernel to userspace, but IMHO that's cheaper than the vmexit.

-- 
Peter Xu


