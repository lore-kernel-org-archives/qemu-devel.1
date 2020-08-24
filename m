Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E7EC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9D9206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgzCojKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9D9206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAAvL-0000mD-29
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 07:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kAAuf-000054-F8; Mon, 24 Aug 2020 07:45:21 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:35454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kAAud-00038K-Lb; Mon, 24 Aug 2020 07:45:21 -0400
Received: by mail-qk1-x742.google.com with SMTP id p25so7048001qkp.2;
 Mon, 24 Aug 2020 04:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Q1lLaJ9ddlGcoLgGpHKFgeYQnsdSymHje3rkRj6zb3w=;
 b=dgzCojKI+9YTTA/9g5SxqB6TC52HKwdw8MjRjhY22TQbFZ2Sirr+ZiOWyElzlEqrF1
 foMf8E5ZYIH+lbgOXuyjN+l8Ew5NZ467M5caj691v1FwMkafsnj6cdgcoG160pLV8sXH
 iWtWoCL3f//zprEfKPx2T6UJTQI2HRS3n77X/Nc7aFNzSCCdmGrVAA6cbvUX5GNNtcZS
 8hXblvcQ6P8ykVwEcsFp4fP0ui0CWKu6oXP53KR3l5gWsgU2XUrD/ikWjyrsB9ozLkNZ
 bkq7Xr1d/dTmPkSWbRVsI6KH33xiwTTYThD1LNPnMw3Px/E+X492ag2qwG/OiTnuJ3zj
 1mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q1lLaJ9ddlGcoLgGpHKFgeYQnsdSymHje3rkRj6zb3w=;
 b=ulQ9o8VYTxApD4/ZT9sTsjQO313DJaw6tO+ahr1dzk0AjmfHlMmUnoJiIWYq47ZMhy
 gVdwrVTVr+LIbeibSXlRO+kln73U2SFdw622ccAtXWPahV29u04CDQAQ9qy8bIuaq3rb
 p7mI66okBPkJ5BYyqRJ1vlsPy8YU55D3F1ZuL6R6zpYYdw+3p0st0ic4dnM4PtPg7py1
 kz6dBBVwLLNbVXoHJTzaJLaR2eB+Amr+k8xggv/eR+A8EQi/XLERkuCKcia9qPQE2q1Z
 4EYIeIjEr9WlqWfrgjtDM2zSIvDijoy9jjTs9757UJsrdBVTLdAvnnnCPmgtmpE4Upgi
 3QJw==
X-Gm-Message-State: AOAM532DqcBP6tgJksgmx2uYXnxI/+leNjDyQDxmf3MVFnF7+pGS9czD
 Jbcj2JBHpI9ZOcO3OMFRK1c+YI5OTTY=
X-Google-Smtp-Source: ABdhPJwEsTYVdz+aWMXUY8ErJnVtH443L4I9D5iuXH+YyQZw1gNAZAc5EAC5acWfX7N+E2MkBIzQeA==
X-Received: by 2002:a37:4584:: with SMTP id s126mr2974578qka.61.1598269516872; 
 Mon, 24 Aug 2020 04:45:16 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c152:8180:e1dd:d6ac:1152?
 ([2804:431:c7c7:c152:8180:e1dd:d6ac:1152])
 by smtp.gmail.com with ESMTPSA id g10sm5489176qto.54.2020.08.24.04.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2020 04:45:16 -0700 (PDT)
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
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <f936f3a7-78d1-dd1f-511b-1705c165fc06@gmail.com>
Date: Mon, 24 Aug 2020 08:45:12 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824060839.GE4734@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x742.google.com
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



On 8/24/20 3:08 AM, David Gibson wrote:
> On Fri, Aug 21, 2020 at 09:47:47AM -0300, Daniel Henrique Barboza wrote:
>>
>>
>> On 8/21/20 5:55 AM, Igor Mammedov wrote:
>>> On Thu, 20 Aug 2020 12:51:03 -0400
>>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>
>>>> On Thu, Aug 20, 2020 at 02:15:04PM +1000, David Gibson wrote:
>>>>> On Wed, Aug 19, 2020 at 10:11:28PM -0400, Eduardo Habkost wrote:
>>>>>> On Thu, Aug 20, 2020 at 11:17:26AM +1000, David Gibson wrote:
>>>>>>> On Fri, Aug 14, 2020 at 05:54:16PM -0300, Daniel Henrique Barboza wrote:
>>>>>>>> The pSeries machine does not support asymmetrical NUMA
>>>>>>>> configurations.
>>>>>>>
>>>>>>> This seems a bit oddly specific to have as a global machine class
>>>>>>> property.
>>>>>>>
>>>>>>> Would it make more sense for machines with specific NUMA constraints
>>>>>>> to just verify those during their initialization?
>>>>>>
>>>>>> This would be much simpler.  However, I like the idea of
>>>>>> representing machine-specific configuration validation rules as
>>>>>> data that can eventually be exported to management software.
>>>>>
>>>>> Ah, ok, so basically the usual tradeoff between flexibility and
>>>>> advertisability.
>>>>>
>>>>> So, in that case, I guess the question is whether we envisage "no
>>>>> assymmetry" as a constraint common enough that it's worth creating an
>>>>> advertisable rule or not.  If we only ever have one user, then we
>>>>> haven't really done any better than hard coding the constraint in the
>>>>> manageent software.
>>>>>
>>>>> Of course to complicate matters, in the longer term we're looking at
>>>>> removing that constraint from pseries - but doing so will be dependent
>>>>> on the guest kernel understanding a new format for the NUMA
>>>>> information in the device tree.  So qemu alone won't have enough
>>>>> information to tell if such a configuration is possible or not.
>>>>
>>>> Requiring both QEMU (and possibly management software) to be
>>>> patched again after the guest kernel is fixed sounds undesirable.
>>> If we drop this restriction, then we don't need to touch QEMU when
>>> guest kernel is ready.
>>>
>>> Btw, what spapr spec says about the matter?
>>
>> LOPAPR support a somewhat asymmetrical NUMA setup in its current
>> form,
> 
> Huh, I didn't even realize that.  What's the mechanism?

LOPAPR mentions that a single resource/node can have multiple associativity
arrays. The idea is to contemplate the situations where the node has
more than one connection with the board.

I say "somewhat" because, right after mentioning that, the spec also says that
the OS should consider that the distance between two nodes must always be
the shortest one of all available arrays. I'll copy/paste the except here
(end of section 15.2, "Numa Resource Associativity":

-----

The reason that the “ibm,associativity” property may contain multiple associativity
lists is that a resource may be multiply connected into the platform. This resource
then has a different associativity characteristics relative to its multiple connections.
To determine the associativity between any two resources, the OS scans down the two
resources associativity lists in all pair wise combinations counting how many domains
are the same until the first domain where the two list do not agree. The highest such
count is the associativity between the two resources.

----


DHB


> 
>> but
>> the Linux kernel doesn't support it. The effort to implement it in the current
>> spapr machine code, given that Linux wouldn't mind it, is not worth it. This
>> is why I chose to invalidate it for pseries.
> 
> Igor,
> 
> It's kind of difficult to answer that question - PAPR doesn't
> specifically describe limitations, it's just that the representation
> it uses is inherently limited.  Instead of the obvious, simple and
> pretty much universal method (used in the generic kernel and qemu) of
> having a matrix of distance between all the nodes, it instead
> describes the hierarchy of components that give rise to the different
> distances.
> 
> So, for each NUMA relevant object (cpu, memory block, host bridge,
> etc.) there is a vector of IDs.  Each number in the vector gives one
> level of the objects location in the heirarchy.
> 
> So, for example the first number might be the physical chip/socket.
> the second one which group of cores & memory interfaces sharing an Ln
> cache, the third one the specific core number.  So to work out how far
> objects are from each other you essentially look at how long a prefix
> of their vector they share, which tells you how far above in the
> hierarchy you have to go to reach it.
> 
> There's a bunch of complicating details, but that's the gist of it.
> 
>>>> Perhaps a warning would be better in this case?
>>>>
>>>> In either case, it sounds like this won't be a common constraint
>>>> and I now agree with your original suggestion of doing this in
>>>> machine initialization code.
>>> Agreed, if it goes to spapr specific machine code I will not object much.
>>> (it will burden just spapr maintainers, so it's about convincing
>>> David in the end)
>>
>> I believe he's ok with it given that he suggested it in his first reply.
>>
>> I'll move this verification to spapr machine_init in the next version.
>>
>>
>>
>> Thanks,
>>
>> DHB
>>
>>
>>>
>>
> 

