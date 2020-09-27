Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B5AC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 11:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06552388B
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 11:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6kuDpbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06552388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMV6A-0005eu-U9
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 07:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kMV3j-00055p-Ns; Sun, 27 Sep 2020 07:41:39 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:44233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kMV3g-0002UX-9z; Sun, 27 Sep 2020 07:41:39 -0400
Received: by mail-qk1-x744.google.com with SMTP id n133so7544667qkn.11;
 Sun, 27 Sep 2020 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sEydvP/BFeYqvUnEH7RYhQcR9E99Y0UGl8oIRXQLCr0=;
 b=u6kuDpbpkGD+bdPdmRd/rwtTsDnHDB70GZuIoimYPyWIz3JOfqpGvzZMmALE9RqVhv
 MHeRZgWusfyvNKEUcMfhTZEM59xmlatWON5z+WP5mrJm4r4SQFUL1mKHuQDQL6jlaImb
 70uJnnWfQcomOZAgcY4drPEwV/5zGDavnBip4fv00cvyp/qxCuScVZP/XDN/MrQqmZS2
 2L7gCkFXYpPxX6bQbRaZLOJOMSCTFI4rhXpWa581AfPfE1yRPL/awy+NwpusH1GLnCtQ
 ubFaGvnjtj4ArQLtBWAsBiOjYAEACCyGCftabVNlCLNeewEw+tNfKY2RkDa21gMEyIPs
 JRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sEydvP/BFeYqvUnEH7RYhQcR9E99Y0UGl8oIRXQLCr0=;
 b=Ug8QDUvRwaTPlwrrcbTii24eScTJuPxED0PfhbdF3D9U/SGdUXo8PyRtTSYGv6nL1w
 dr8Qd8AcyU3K0DemG7S4BN0tGPb+aaatwghc6MUsgCAvUE01VAr6I9Xcv5didFjtBEBo
 qBGSjC0oTtT0uEI1/dW6htnn+SVzb0Y3ygJj22Ep+MJRAAt3FTjddEErdVYXDPFT348i
 9xBBGOC5GKR2Q+uuiHbMxa343+sQpmzembr06whiGsfbma+VXWIq/siI8EtDApWYFUdE
 mC7EahF0BNfCedtzfIeuwa9lc8deL8bKyr2aBLTQw794R/HJQCQ6NvEMh6k8+r84oSum
 IToA==
X-Gm-Message-State: AOAM533jgBigb1NJqjLKX2vexnZrixOH4HaPuyeCBnpg4IsAdxU/AIuO
 bofoicXMUcMrkzvB+W9pbXI1SsC0FaU=
X-Google-Smtp-Source: ABdhPJwbxWSn1/ob80GwyY4yKFgpmC437LTKdFlMKvMX36ePMB4Q2mieqx0ozp5EshQC0XFU9mc3/g==
X-Received: by 2002:a05:620a:5a1:: with SMTP id
 q1mr7938264qkq.458.1601206894752; 
 Sun, 27 Sep 2020 04:41:34 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c625:6c0e:4720:8228:5f68?
 ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id g45sm7122313qtb.60.2020.09.27.04.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2020 04:41:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] spapr_numa: forbid asymmetrical NUMA setups
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200924195058.362984-1-danielhb413@gmail.com>
 <20200924195058.362984-3-danielhb413@gmail.com>
 <20200925034816.GV2298@yekko.fritz.box>
 <f787466e-0f39-fb2e-c36f-59a6bc2dde00@gmail.com>
 <20200926074916.GC2298@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <5097b6b6-bd8a-fbac-af11-5e9c1e054559@gmail.com>
Date: Sun, 27 Sep 2020 08:41:30 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200926074916.GC2298@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x744.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.011,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/26/20 4:49 AM, David Gibson wrote:
> On Fri, Sep 25, 2020 at 09:41:02AM -0300, Daniel Henrique Barboza wrote:
>>
>>
>> On 9/25/20 12:48 AM, David Gibson wrote:
>>> On Thu, Sep 24, 2020 at 04:50:54PM -0300, Daniel Henrique Barboza wrote:
>>>> The pSeries machine does not support asymmetrical NUMA
>>>> configurations. This doesn't make much of a different
>>>> since we're not using user input for pSeries NUMA setup,
>>>> but this will change in the next patches.
>>>>
>>>> To avoid breaking existing setups, gate this change by
>>>> checking for legacy NUMA support.
>>>>
>>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>>>
>>> Having read the rest of the series, I realized there's another type of
>>> configuration that PAPR can't represent, so possibly we should add
>>> logic to catch that as well.  That's what I'm going to call
>>> "non-transitive" configurations, e.g.
>>>
>>> Node	0	1	2
>>> 0	10	20	40
>>> 1	20	10	20
>>> 2	40	20	10	
>>>
>>> Basically the closeness of 0 to 1 and 1 to 2 forces them all to be in
>>> the same domain at every PAPR level, even though 0-2 is supposed to be
>>> more expensive.
>>
>> Yes, this is correct. I'm not sure how to proceed in this case
>> though. Should we error out?
> 
> Given that we're already erroring on asymmetric configurations, I
> think it makes sense to error for these as well.

Thing is that asymmetrical configurations is an easy concept to enforce
to the user - distance from A to B can't be different from B to A.

In the example you gave above, with 3 NUMA nodes, is easy to spot where
the non-transitivity rule would hit. I'm afraid that if we add 2-3 more
NUMA nodes in the mix this will stop being straightforward, with more and
more combinations hitting the 'non-transitivity' rule, and erroring out
will end up being frustrating to the user.

I'd say that we should report this in the documentation as one more
limitation of the implementation (and PAPR). I wouldn't oppose with
throwing a warning message either, letting the user know that the
approximation will be less precise than it already would be in this case.


Thanks,


DHB



> 

