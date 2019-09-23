Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01051C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 10:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C625120865
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 10:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C625120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCLCG-0000mF-Ra
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 06:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCLAh-00008U-9Y
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 06:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCLAe-00017S-Iw
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 06:02:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCLAe-00014N-21
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 06:02:16 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3FAFF36955
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 10:02:14 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id m6so4756248wmf.2
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 03:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3JBMBpWo2LKjJEWlix8J6c0TQBwlyLV+2TAM8anoO2k=;
 b=AT4KeeiZNNd5iTIq1yBejpRnEe5STlghWU0mhB0qynqqSusuhJCvcLYv29cbUNpEor
 sGfDleSWr9ldNH9++y7vreDgS2tHg0TtOF/uVjZKzrel0HgduG9lXbv037tKIf7mLtM3
 /lQ/bsckfh+/2S9FdhMZwPJL2UMIQ9lmoUPsHu3wNOCYltoMvWQBqhfbdz9rAOswOcQs
 ig54ziBzjvqUl9LblQymZ6522LNvLSCTxcFcxlqgdRqPKq6X9NeJOpllN1ROHj5o6jNF
 QTa9mc8gUADRJPJON5nO13uCaabyLjd5dzvKV5jkuGV9GGIp5kxTjwTlt96bgKkDaw7e
 BOyQ==
X-Gm-Message-State: APjAAAUyF0H8rTWSozJjNZEC9Buq+aheqszrhLJxFosjzDDKeWlIU0Pl
 kOeM2FnqFB2gkCM4LejyNt7hRwJlMqWaAoCDwS2PszaJ2l5ClJnW3o7Xz1C0y+ZTOhCBZBYgN6Y
 AqekG05NtrOr9X4U=
X-Received: by 2002:a05:600c:219a:: with SMTP id
 e26mr13745556wme.86.1569232932862; 
 Mon, 23 Sep 2019 03:02:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy4oNFYyleAXulpJJWlt4kFNoAt2ee0U4y0DMdpI+awA9m5QrhcMSBhATdYLyjdDRa4q7YcPQ==
X-Received: by 2002:a05:600c:219a:: with SMTP id
 e26mr13745532wme.86.1569232932598; 
 Mon, 23 Sep 2019 03:02:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id c132sm10530176wme.27.2019.09.23.03.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 03:02:12 -0700 (PDT)
Subject: Re: [PATCH v3 09/20] cputlb: Replace switches in load/store_helper
 with callback
To: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-10-richard.henderson@linaro.org>
 <f67383ec-9dc8-c040-8fd9-fb659b8cd2d4@redhat.com>
 <b9e498eb-6d63-11a6-01d8-1a32f5b14236@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9c254159-9b63-b66e-dca7-af3d30167f49@redhat.com>
Date: Mon, 23 Sep 2019 12:02:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b9e498eb-6d63-11a6-01d8-1a32f5b14236@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/19 11:54, David Hildenbrand wrote:
> On 23.09.19 11:51, Paolo Bonzini wrote:
>> On 22/09/19 05:54, Richard Henderson wrote:
>>> +/* Wrap the unaligned load helpers to that they have a common signature.  */
>>> +static inline uint64_t wrap_ldub(const void *haddr)
>>> +{
>>> +    return ldub_p(haddr);
>>> +}
>>> +
>>> +static inline uint64_t wrap_lduw_be(const void *haddr)
>>> +{
>>> +    return lduw_be_p(haddr);
>>> +}
>>> +
>>> +static inline uint64_t wrap_lduw_le(const void *haddr)
>>> +{
>>> +    return lduw_le_p(haddr);
>>> +}
>>> +
>>> +static inline uint64_t wrap_ldul_be(const void *haddr)
>>> +{
>>> +    return (uint32_t)ldl_be_p(haddr);
>>> +}
>>> +
>>> +static inline uint64_t wrap_ldul_le(const void *haddr)
>>> +{
>>> +    return (uint32_t)ldl_le_p(haddr);
>>> +}
>>
>> Any reason to have these five functions (plus five for stores) instead
>> of a pair
>>
>> static uint64_t ld_memop(const void *haddr, MemOp op)
>> {
>> }
>>
>> static uint64_t st_memop(void *haddr, MemOp op, uint64_t val)
>> {
>> }
>>
>> that includes the switches?  Everything should be inlined just the same
>> if you do
>>
>>         if (unlikely(tlb_addr & TLB_BSWAP)) {
>>             st_memop(haddr, op ^ MO_BSWAP, val);
>>         } else {
>>             st_memop(haddr, op, val);
>>         }
> 
> I asked the same question on v2 and Richard explained that - for
> whatever reason -  the compiler will not properly propagate the constant
> in the "op ^ MO_BSWAP" case.

Even if ld_memop and st_memop are __always_inline__?

Paolo

