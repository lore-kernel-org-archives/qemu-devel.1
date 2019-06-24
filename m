Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1CBC48BE9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6706205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6706205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49434 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfLzC-0007Jc-1s
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 06:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39173)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hfLx9-0005aD-JG
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hfLx7-00007V-Jg
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:11:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hfLx7-00005w-C8
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:11:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so12175840wme.4
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 03:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IuHT6jXtWfO1aMh5Zpc8WzBjRcsdBFnRl46ff1G2AAI=;
 b=fFv7ofGXIMfhLMhobaDzJuMExvuLCOLzUlSXRVn8fHO0cH9DrGuXzvQN93QHVOx7JF
 F1iWdwLSe+EfsjvBA4ZSEJ8N/4M6kEXNRrwIhxXfyhqUiNe251gD0x4GizGs1SkFclxP
 W0dJoz2DQ0ef3KMvUKaXB+q3/rDReUJRLc/SKbGufponlpGsSuUgDnwfRsVRWRrdtx+Z
 qy0hSfR2J02255qEOgQjbNrIYVs3cEq/h8v04n1bglkMCaeu3X9FW89RNS2b5DJltCHP
 JGivZGR5ly8c9pwyOGKgfujfwGNL6Y+timwyi3saNvdIxPuVJHYNgEvUVY1kMrgADWka
 +WNQ==
X-Gm-Message-State: APjAAAVoQ/cCzFYxtxYFBhluZP1XbXUrW7bfKSa1SBN24lkJ9uiKASP5
 cRuTXmF7b8fkFxGDkzEkDje1yQ==
X-Google-Smtp-Source: APXvYqwzCxJmjOM/c9u1/oK9tTX+BiasrLQvH8SMkbRbSa3TRHosD9jn8A7ox7eSsCbh4yqGRcePQA==
X-Received: by 2002:a1c:4987:: with SMTP id w129mr15003600wma.41.1561371116106; 
 Mon, 24 Jun 2019 03:11:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab?
 ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
 by smtp.gmail.com with ESMTPSA id i11sm2268261wmi.33.2019.06.24.03.11.55
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Jun 2019 03:11:55 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>
References: <20190624063733.22079-1-peterx@redhat.com>
 <20190624063733.22079-3-peterx@redhat.com>
 <20190624064122.GB27894@joy-OptiPlex-7040> <20190624065750.GE6279@xz-x1>
 <20190624070450.GC27894@joy-OptiPlex-7040> <20190624080649.GG6279@xz-x1>
 <a0a6a698-d671-9b4c-badf-75bc258242ff@redhat.com>
 <20190624090940.GH6279@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ae70a81a-f9ec-b230-79a1-3258cfe7ec8a@redhat.com>
Date: Mon, 24 Jun 2019 12:11:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190624090940.GH6279@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 2/2] intel_iommu: Fix unexpected unmaps
 during global unmap
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
Cc: Auger Eric <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yan Zhao <yan.y.zhao@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/19 11:09, Peter Xu wrote:
> On Mon, Jun 24, 2019 at 10:43:21AM +0200, Paolo Bonzini wrote:
>> On 24/06/19 10:06, Peter Xu wrote:
>>> Well, if with such an error we'd better fix it right away in this
>>> patch... :)
>>>
>>> Let me wait for some more comments, I'll touch that up too if I need a
>>> repost.
>>
>> Looks good to me, except for one minor issue in this patch.  But do not
>> attribute this one to me, it's basically all code from you.
> 
> OK.
> 
>>
>>> +static uint64_t vtd_get_next_mask(uint64_t start, uint64_t size, int gaw)
>>> +{
>>> +    /* Tries to find smallest mask from start first */
>>> +    uint64_t rmask = start & -start, max_mask = 1ULL << gaw;
>>> +
>>> +    assert(size && gaw > 0 && gaw < 64);
>>> +
>>> +    /* Zero start, or too big */
>>> +    if (!rmask || rmask > max_mask) {
>>> +        rmask = max_mask;
>>> +    }
>>
>> Perhaps simpler:
>>
>>     uint64_t max_mask = 1ULL << gaw;
>>     uint64_t alignment = start ? start & -start : max_mask;
>>
> 
> (I'll add another "alignment = MIN(alignment, max_mask)" here if no
>  one disagree...)

I do! :)  If alignment > max_mask, then it will also be > size below so
clamping is unnecessary.

There is another way which is to compute on the mask, so that start == 0
underflows to all-ones:

    uint64_t max_mask = (1ULL << gaw) - 1;
    uint64_t start_mask = (start & -start) - 1;
    uint64_t size_mask = pow2floor(size) - 1;
    return MIN(MIN(size_mask, start_mask), max_mask) + 1;

Paolo

>>     size = MIN(size, max_mask);
>>     if (alignment <= size) {
>>         /* Increase the alignment of start */
>>         return alignment;
>>     } else {
>>         /* Find the largest page mask from size */
>>         return 1ULL << (63 - clz64(size));
>>     }
>>
>> Also please rename it to get_naturally_aligned_size.
> 
> Will do.  Thanks,
> 


