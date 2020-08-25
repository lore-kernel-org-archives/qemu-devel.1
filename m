Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96254C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4172067C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtI5iT3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4172067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAVhr-00043W-L1
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 05:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kAVhH-0003YO-30; Tue, 25 Aug 2020 05:56:55 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:33229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kAVhE-00021Q-24; Tue, 25 Aug 2020 05:56:54 -0400
Received: by mail-qv1-xf41.google.com with SMTP id dd12so5214923qvb.0;
 Tue, 25 Aug 2020 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ecxvzZIWbepGZcCDkmzALBrAaEPCzdXC9y78cxEFY2M=;
 b=jtI5iT3RbfZ9Ao1+zbgvoTBYw8b0A3uDIryFjEyanwmO34iCP6LLTHr+sEUWipSZXz
 vQ4UmRXOJsRu+qK8ozXBBb48AWWNP70zCHp/wmrB/ykd0LRlxHBcZFriKRaBceEtsZFs
 8wZZ59faMn6lt9JP8YtsOwwiMQKcWlJN9U6VcTokIA1H3X8EzfphGYfi289vml2LXXnM
 N8srgbQTDVuIkDVgaX58akX4dlnpdKFnOda9yhLRKKG2q0aVGBP23sfXcaREje13Wt0N
 31VIGx3Y+Nof3SsNdnYMftO4/m02wumrTCj7HeMA3BKOsFb2Pfik6LYOFfShOazAuM17
 t8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ecxvzZIWbepGZcCDkmzALBrAaEPCzdXC9y78cxEFY2M=;
 b=kRFN45KJ6guw3A0z8u0iYCSdNMr6H6j0Gj9G14DfEWkw0069QFbE0sS8mU1lLq4q8i
 jMJKUZYzvY9TbrtZG8/SlS5GoHhR/gWZkLd5K5Jh8dQSg6dxSUlX2r9a07iD7YXWPee/
 Iib3mu8f1NEJqeJjkHMKtEAQFH/BjCvA5g9Wv46CX9MFVot5/71Zklb4n2XomwAI9qOS
 S2JZeJoBE7Qvo1SfA+ZD9RSahoIAZsEwA+MQdXrnPsv21HMd3p1/t3YaetOnLbev/IW0
 YeshrMpPXoZqXGuy+6X6zShvrYvQNjW6bTRGoYeuq/txOThg5nll/UsYiCc1HBSHO7HU
 ZQ4g==
X-Gm-Message-State: AOAM532k6EYyNZbc3eFn9xLNLhVISXgM0ZrsAkNB45+YYMRaW2Q5vF04
 H0Z2IGWfqKgWdhv/MqijJGGMbE7IjOA=
X-Google-Smtp-Source: ABdhPJzxp173gKGw+1oJhD+KvGCLWMVD5r0t04fP4dc+HAaYWZWdxWxp6d7ppJVH0UmEvJ4Dd7+tSw==
X-Received: by 2002:ad4:4c0a:: with SMTP id bz10mr8330518qvb.78.1598349410491; 
 Tue, 25 Aug 2020 02:56:50 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c152:8180:e1dd:d6ac:1152?
 ([2804:431:c7c7:c152:8180:e1dd:d6ac:1152])
 by smtp.gmail.com with ESMTPSA id v202sm6827795qka.5.2020.08.25.02.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 02:56:50 -0700 (PDT)
Subject: Re: [PATCH 02/10] numa: introduce
 MachineClass::forbid_asymmetrical_numa
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-3-danielhb413@gmail.com>
 <20200820011726.GF271315@yekko.fritz.box>
 <20200820021128.GC642093@habkost.net>
 <20200820041504.GN271315@yekko.fritz.box>
 <20200820165103.GD642093@habkost.net> <20200821105538.6f6b46c8@redhat.com>
 <e007c59f-9533-48f0-a08a-6745a29b6600@gmail.com>
 <20200824060839.GE4734@yekko.fritz.box>
 <f936f3a7-78d1-dd1f-511b-1705c165fc06@gmail.com>
 <20200824234917.GF4734@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <98728fe4-1262-6be2-8dd1-1b38ffbe81e9@gmail.com>
Date: Tue, 25 Aug 2020 06:56:46 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824234917.GF4734@yekko.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/24/20 8:49 PM, David Gibson wrote:
> On Mon, Aug 24, 2020 at 08:45:12AM -0300, Daniel Henrique Barboza wrote:
>>
>>

[...]

>>>> LOPAPR support a somewhat asymmetrical NUMA setup in its current
>>>> form,
>>>
>>> Huh, I didn't even realize that.  What's the mechanism?
>>
>> LOPAPR mentions that a single resource/node can have multiple associativity
>> arrays. The idea is to contemplate the situations where the node has
>> more than one connection with the board.
>>
>> I say "somewhat" because, right after mentioning that, the spec also says that
>> the OS should consider that the distance between two nodes must always be
>> the shortest one of all available arrays. I'll copy/paste the except here
>> (end of section 15.2, "Numa Resource Associativity":
> 
> Ah.  I didn't think that's what "asymmetric NUMA" meant... but come to
> think of it, I'm not very sure about that.


This was a poor attempt of my part to cut PAPR some slack.

TBH, even if current PAPR allows for some form of NUMA asymmetry, I don't think
it's worth implementing at all. It'll be more complexity on top of what I
already added here, and the best case scenario will be the kernel ignoring it
(worst case - kernel blowing it up because we're adding more associativity
arrays in each CPU and so on).



Thanks,


DHB

> 
>> -----
>>
>> The reason that the “ibm,associativity” property may contain multiple associativity
>> lists is that a resource may be multiply connected into the platform. This resource
>> then has a different associativity characteristics relative to its multiple connections.
>> To determine the associativity between any two resources, the OS scans down the two
>> resources associativity lists in all pair wise combinations counting how many domains
>> are the same until the first domain where the two list do not agree. The highest such
>> count is the associativity between the two resources.
>>
>> ----
>>
>>
>> DHB
>>
>>
>>>
>>>> but
>>>> the Linux kernel doesn't support it. The effort to implement it in the current
>>>> spapr machine code, given that Linux wouldn't mind it, is not worth it. This
>>>> is why I chose to invalidate it for pseries.
>>>
>>> Igor,
>>>
>>> It's kind of difficult to answer that question - PAPR doesn't
>>> specifically describe limitations, it's just that the representation
>>> it uses is inherently limited.  Instead of the obvious, simple and
>>> pretty much universal method (used in the generic kernel and qemu) of
>>> having a matrix of distance between all the nodes, it instead
>>> describes the hierarchy of components that give rise to the different
>>> distances.
>>>
>>> So, for each NUMA relevant object (cpu, memory block, host bridge,
>>> etc.) there is a vector of IDs.  Each number in the vector gives one
>>> level of the objects location in the heirarchy.
>>>
>>> So, for example the first number might be the physical chip/socket.
>>> the second one which group of cores & memory interfaces sharing an Ln
>>> cache, the third one the specific core number.  So to work out how far
>>> objects are from each other you essentially look at how long a prefix
>>> of their vector they share, which tells you how far above in the
>>> hierarchy you have to go to reach it.
>>>
>>> There's a bunch of complicating details, but that's the gist of it.
>>>
>>>>>> Perhaps a warning would be better in this case?
>>>>>>
>>>>>> In either case, it sounds like this won't be a common constraint
>>>>>> and I now agree with your original suggestion of doing this in
>>>>>> machine initialization code.
>>>>> Agreed, if it goes to spapr specific machine code I will not object much.
>>>>> (it will burden just spapr maintainers, so it's about convincing
>>>>> David in the end)
>>>>
>>>> I believe he's ok with it given that he suggested it in his first reply.
>>>>
>>>> I'll move this verification to spapr machine_init in the next version.
>>>>
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> DHB
>>>>
>>>>
>>>>>
>>>>
>>>
>>
> 

