Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0B1C43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BE120782
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAUcbee6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BE120782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQu9F-0004z0-0h
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQu7h-0004Ol-J5; Fri, 09 Oct 2020 11:15:57 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQu7f-0003vG-SV; Fri, 09 Oct 2020 11:15:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id i1so4562476wro.1;
 Fri, 09 Oct 2020 08:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zV5OhfB3Xvwm0HlsivDFmjvPZtSGJKFWQhvvDSrZZ64=;
 b=NAUcbee6HH3aMI0Js70rcthrTh4fTLhewM+sroKRj0NRYX3u41wy0Wi+Ay0RLE6N6C
 +oZGmMvXYdG1xzMIXtLik+5odOS+OpOLvnFBS8weuGmWUIpgPSSk3rZlYG1vXMCA+mRu
 oit2V3fevqnyEKLnotHJ0N6cZTmQ12+YhpSucyqECkLI9L+qtBrF+RHU4O60yRt0TzMH
 LQhhZB34TYgyQ1WndC3aEfk2uARbJgJki7zqv8OYUgxhirR6WqJCt8+f6r7+wud2ltff
 n8HritqfMRWTVGcT5SXnWvxlBiTvhcItNNScJzIZQ6kF/H+RsbTPfwSc04+aRK6tw1Te
 B4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zV5OhfB3Xvwm0HlsivDFmjvPZtSGJKFWQhvvDSrZZ64=;
 b=nD72fktbZm1OCglydOFw+7jNLzi9CsdU23N9cSQZBTYQGZK6WRHvOGGyeM2gMruvRI
 q1Hx5mxQSQbTkvrMcrLJpz+wSr61WF2pyCOYvVOn8Ptj4n+8mXbmXggb0Wt9JGu/BbUm
 DUMSjukTCLpRxqAPePGM2B52EB7uSHYqQwwOnq0lJmlDMLm/e1JW5jM5xxYgkcRAnRbB
 TGs7h1TG70/jltoqLEZxQcVn8KDTaulnWcs4osyUoPS3GfBRciPwz3AcT7yqIJdBTNYH
 TjhTpkut6gbojhUIofpJrtIGTHT7nEU6B9ONL6A+plvp41YGtbM/6no7++JwMM4edwx0
 V5fw==
X-Gm-Message-State: AOAM533gNNH789uiyvTuQBihNc7xln8dF5qf+xI7OV3qMjrjeXw7ARRp
 6xZOxEtgEyY6z+Ka9asyuspdDir+Z/4=
X-Google-Smtp-Source: ABdhPJyg5VnbXG01fHmcvvfRoeB6TrIpWC7O1xCYTHMp7xyYEjZ5f29dY8ktvTN/paYMzm7DI12UYw==
X-Received: by 2002:a5d:4691:: with SMTP id u17mr1506802wrq.324.1602256553368; 
 Fri, 09 Oct 2020 08:15:53 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a3sm11838322wmb.46.2020.10.09.08.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 08:15:52 -0700 (PDT)
Subject: Re: [PATCH V2 06/14] mips/: fix some comment spelling errors
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20201009064449.2336-1-zhaolichang@huawei.com>
 <20201009064449.2336-7-zhaolichang@huawei.com>
 <db7d3c7a-4889-2cd5-9d60-909175917c97@amsat.org>
Message-ID: <8a8fcbe9-f814-555a-0f27-1b056767bb4c@amsat.org>
Date: Fri, 9 Oct 2020 17:15:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <db7d3c7a-4889-2cd5-9d60-909175917c97@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
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
Cc: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 4:36 PM, Philippe Mathieu-Daudé wrote:
> On 10/9/20 8:44 AM, zhaolichang wrote:
>> I found that there are many spelling errors in the comments of 
>> qemu/target/mips.
>> I used spellcheck to check the spelling errors and found some errors 
>> in the folder.
>>
>> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
>> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
>> Reviewed-by: Philippe Mathieu-Daude<f4bug@amsat.org>
> 
> The line I sent is:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

I'm queuing this patch on mips-next and will fix that along.

> 
>> ---
>>   target/mips/internal.h           |  2 +-
>>   target/mips/translate.c          | 10 +++++-----
>>   target/mips/translate_init.c.inc |  2 +-
>>   3 files changed, 7 insertions(+), 7 deletions(-)
> 

