Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FA1C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEE72173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEE72173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho42x-0002gm-4y
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 06:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39533)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1ho42m-0002Ht-8Z
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ho42l-0004HU-6S
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:53:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ho42l-0004GA-08
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:53:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so28211276wrs.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 03:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ToRJX8G3o8jVtFMgWuqRlhiFW8xDM8Rl2W9LzjNECmo=;
 b=WulXVzwdFvF+6fRVWZyihxZNneIgHOXgfIXR028rl4T3dkVBVgfCiyQ8qlWSrhyRBM
 crI/vRgHFORM3hwGZNOI0fJIB2iZyvyH0lh44oa3qLsJ2DfqbcvWwln5mTQbmJGdEXT6
 ayw9pBG7+t/oWaIDrTklukzcBen8wFB1yS/pIqc8XSYGSapk22onTWYPBFAX2dlqtn72
 HKN18vFG5XEfxqs4NMWSweGFUhI223CuOVjrUCFJxicI2CcZW19H7h3npVUyBNOrhbtB
 WDTGpHLhBEqSY3apDyuxcSTkm1N0JQp/jbfJ8LICK/PNsG/BYVkgvRJK5MKMmYRDSPm1
 RGvg==
X-Gm-Message-State: APjAAAWO/EOAO1rdZmODnoHe14/qgZUvwEOU/BFqZJS1v/p++9s/71Bq
 hpX6OAF5VJdo7vZrtXCZkjoUMw==
X-Google-Smtp-Source: APXvYqwyCJ5ptOHeLmfabJZD6/FShRfEl4lzkHolzXqmMmCuf3oC6Z5rWu2TEHyE2/csGvclvxk8Ww==
X-Received: by 2002:adf:de10:: with SMTP id b16mr17345333wrm.296.1563447225895; 
 Thu, 18 Jul 2019 03:53:45 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id c11sm46102417wrq.45.2019.07.18.03.53.44
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 03:53:45 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190718092219.20081-1-chen.zhang@intel.com>
 <375615d7-7cdf-4711-68fb-47ce3c8cb308@redhat.com>
 <CAFEAcA8oQ0buYaOAXsjzUecDjrsk+=BAtM3bW3skKkTEZ5Ngtg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <664c3b23-4d19-cda6-dbd7-4a7195a96ec3@redhat.com>
Date: Thu, 18 Jul 2019 12:53:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8oQ0buYaOAXsjzUecDjrsk+=BAtM3bW3skKkTEZ5Ngtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH V3] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/18/19 12:37 PM, Peter Maydell wrote:
> On Thu, 18 Jul 2019 at 11:28, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> On 7/18/19 11:22 AM, Zhang Chen wrote:
>>> From: Zhang Chen <chen.zhang@intel.com>
>>>
>>> This patch to fix the origin "char *data" menory leak, code style issue
>>
>> "memory"
>>
>>> and add necessary check here.
>>> Reported-by: Coverity (CID 1402785)
>>>
>>> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
>>> ---
>>>  net/colo-compare.c | 28 +++++++++++++++++++++-------
>>>  1 file changed, 21 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>>> index 909dd6c6eb..fcccb4c6f6 100644
>>> --- a/net/colo-compare.c
>>> +++ b/net/colo-compare.c
>>> @@ -127,6 +127,17 @@ static int compare_chr_send(CompareState *s,
>>>                              uint32_t vnet_hdr_len,
>>>                              bool notify_remote_frame);
>>>
>>> +static bool packet_matches_str(const char *str,
>>> +                               uint8_t *buf,
>>
>> You can use 'uint8_t *buf'.
> 
> ?? that seems to be the same as what is written...

Oops sorry, I copy/pasted and  did not noticed I removed the 'const'
word. So I meant: You can use 'const uint8_t *buf'

>>
>>> +                               uint32_t packet_len)
>>> +{
>>> +    if (packet_len != strlen(str)) {
>>> +        return false;
>>> +    }
>>> +
>>> +    return !memcmp(str, buf, strlen(str));
>>
>> If you don't want to use a local variable to hold strlen(str), you can
>> reuse packet_len since it is the same value:
>>
>>        return !memcmp(str, buf, packet_len);
>>
>> However it makes the review harder, so I'd prefer using a str_len local var.
> 
> I'm pretty sure the compiler is going to optimise the
> strlen() away into a compile time constant anyway, so
> this is somewhat unnecessary micro-optimisation I think.

I was not sure, I'm glad to learn that :)

Thanks,

Phil.

