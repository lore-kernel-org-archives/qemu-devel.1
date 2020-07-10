Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A505C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 06:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429AE206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 06:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvOqj1hD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429AE206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtmeH-0001kq-I6
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 02:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jtmcE-0000Kf-OF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 02:34:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47438
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jtmcC-0007sl-Rg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 02:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594362871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWnDwjLAKtI61PZNG7ENzjs4JhjJ9TzL6LS/QML/gIo=;
 b=hvOqj1hDbterzgM1KCXEgX41/bY6Vm+iryduG+Q6MYau/M8fPcdt7S+O2P5XuAhuoYtYAy
 FBiBRjhzbiC+4dvNe04uRMFTBMSC8PTJ1diO0u43zYGy1hSOxelt5EKZbczhRl9uazN9WD
 0InmkadF+0Ezihad5tBKRXfdtLrth54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-pB9d6YXaOYixou8WAoCXZg-1; Fri, 10 Jul 2020 02:34:29 -0400
X-MC-Unique: pB9d6YXaOYixou8WAoCXZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8F1C80183C;
 Fri, 10 Jul 2020 06:34:28 +0000 (UTC)
Received: from [10.72.13.228] (ovpn-13-228.pek2.redhat.com [10.72.13.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 952EE5F7D8;
 Fri, 10 Jul 2020 06:34:13 +0000 (UTC)
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Peter Xu <peterx@redhat.com>
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
 <20200709141037.GF199122@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fb2f8d35-3f04-55ac-e0c0-7eeedbaf2429@redhat.com>
Date: Fri, 10 Jul 2020 14:34:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709141037.GF199122@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
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
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/9 下午10:10, Peter Xu wrote:
> On Thu, Jul 09, 2020 at 01:58:33PM +0800, Jason Wang wrote:
>>>> - If we care the performance, it's better to implement the MAP event for
>>>> vhost, otherwise it could be a lot of IOTLB miss
>>> I feel like these are two things.
>>>
>>> So far what we are talking about is whether vt-d should have knowledge about
>>> what kind of events one iommu notifier is interested in.  I still think we
>>> should keep this as answered in question 1.
>>>
>>> The other question is whether we want to switch vhost from UNMAP to MAP/UNMAP
>>> events even without vDMA, so that vhost can establish the mapping even before
>>> IO starts.  IMHO it's doable, but only if the guest runs DPDK workloads.  When
>>> the guest is using dynamic iommu page mappings, I feel like that can be even
>>> slower, because then the worst case is for each IO we'll need to vmexit twice:
>>>
>>>     - The first vmexit caused by an invalidation to MAP the page tables, so vhost
>>>       will setup the page table before IO starts
>>>
>>>     - IO/DMA triggers and completes
>>>
>>>     - The second vmexit caused by another invalidation to UNMAP the page tables
>>>
>>> So it seems to be worse than when vhost only uses UNMAP like right now.  At
>>> least we only have one vmexit (when UNMAP).  We'll have a vhost translate()
>>> request from kernel to userspace, but IMHO that's cheaper than the vmexit.
>>
>> Right but then I would still prefer to have another notifier.
>>
>> Since vtd_page_walk has nothing to do with device IOTLB. IOMMU have a
>> dedicated command for flushing device IOTLB. But the check for
>> vtd_as_has_map_notifier is used to skip the device which can do demand
>> paging via ATS or device specific way. If we have two different notifiers,
>> vhost will be on the device iotlb notifier so we don't need it at all?
> But we can still have iommu notifier that only registers to UNMAP even after we
> introduce dev-iotlb notifier?  We don't want to do page walk for them as well.
> TCG should be the only one so far, but I don't know.. maybe there can still be
> new ones?


I think you're right. But looking at the codes, it looks like the check 
of vtd_as_has_map_notifier() was only used in:

1) vtd_iommu_replay()
2) vtd_iotlb_page_invalidate_notify() (PSI)

For the replay, it's expensive anyhow. For PSI, I think it's just about 
one or few mappings, not sure it will have obvious performance impact.

And I had two questions:

1) The codes doesn't check map for DSI or GI, does this match what spec 
said? (It looks to me the spec is unclear in this part)
2) for the replay() I don't see other implementations (either spapr or 
generic one) that did unmap (actually they skip unmap explicitly), any 
reason for doing this in intel IOMMU?

Thanks


>
> Thanks,
>


