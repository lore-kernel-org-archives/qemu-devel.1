Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5A9C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 19:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA132067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 19:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGr1i0cX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA132067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipdML-0001zc-4h
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 14:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ipdKt-0000Pf-8o
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 14:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ipdKr-0006Yj-Ak
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 14:19:14 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:42068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ipdKq-0006Tq-Eh; Thu, 09 Jan 2020 14:19:12 -0500
Received: by mail-qv1-xf44.google.com with SMTP id dc14so3448115qvb.9;
 Thu, 09 Jan 2020 11:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G2lVf7Qd2N+HBtyvpViBCVWxn7bUAaymdZdBRaRMzzM=;
 b=pGr1i0cXqbE5sAp8eEu4ZqwaqcXzlOTgpaY7H/rgzG1Xx4GjI4IPgMSFNObOFatOna
 d9bjeBsnbr4bMJito7NBVouskm5dJ0rs+tN8EHgUNhg/RpEAoZoqft/KidzYEiyYxw+r
 oblnLNbYgUaLztc7bKJFVIoabJwg6u0LpKJoT5sVDSvpjYKLscD2FPLujWthZVmithEl
 0QVhtvaZL3sqKxsmFE8/YP4bMkmlMkpKDfB5ZYfF/OSWHdiu/xhmsg9zCEUsavnxgclP
 Mq73MKPgug731PhwefmScan0SyenIcDrBx2J4BNC46jebfizUyQq4lS1aF5tBOp2WCwp
 6WMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G2lVf7Qd2N+HBtyvpViBCVWxn7bUAaymdZdBRaRMzzM=;
 b=io+Ni9Q6lWaXMrzfgvIzTwvZvfcm5lNjX69bpyhKP/zMsSeIJPT6KrJtvzGRm6Ferb
 AR0VfgQe8g4y6pPkryVKLMRoeLzr2vMYOtIPOTKP5NzDqp8tyHgvydxtUsri7wxoezL4
 Lk9tiKJ+2Iq4hpYpwO9Y6SoJ1LpgWyIH8qUV70qWPl/3YUqqcfq7W4MESe6domvWmHCA
 zOhKXiWj+0btL38srhCJfEaf9zzTsxLOsakox4uXv/2sBLHoa/+cdJeIGEVcadAPcSFS
 7wc4SeN5HLMti0lnG9oiTBFx208U8Ya+o2v3o92eO9SDJOWKQBIxAj7+vcKqF+LBU0gM
 gOvg==
X-Gm-Message-State: APjAAAX2ihEvippbgD7uoPlBCG/WhBvTfSY350QJ40iT2Lb9V2r0NWAa
 eA5e97IZagQK+RbZkCNJg/S3kZBDwM8=
X-Google-Smtp-Source: APXvYqxnPDeGmr6DzZIpgFr6qPlZ9KVc9n8/sdCHmiwcOONx52sAQumS+cDTeCAo0kMP6WgKQLj0Wg==
X-Received: by 2002:a0c:e58e:: with SMTP id t14mr10052226qvm.131.1578597549762; 
 Thu, 09 Jan 2020 11:19:09 -0800 (PST)
Received: from ?IPv6:2804:431:c7c7:541e:7a5e:37ad:989b:4530?
 ([2804:431:c7c7:541e:7a5e:37ad:989b:4530])
 by smtp.gmail.com with ESMTPSA id k29sm3625598qtu.54.2020.01.09.11.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2020 11:19:09 -0800 (PST)
Subject: Re: [PATCH v1 00/59] trivial unneeded labels cleanup
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, minyard@acm.org
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106195457.GE2886@minyard.net>
 <f71eb524-571b-54d1-1a99-95d2896f6586@gmail.com>
 <20200107061613.GB4076@linux.fritz.box>
 <cacf1a76-366e-7209-3f5e-3bb6728c2e8a@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <39f056df-40fa-dac1-1868-aef241c37199@gmail.com>
Date: Thu, 9 Jan 2020 16:19:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <cacf1a76-366e-7209-3f5e-3bb6728c2e8a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/7/20 4:06 AM, Philippe Mathieu-Daudé wrote:
> On 1/7/20 7:16 AM, Kevin Wolf wrote:
>> Am 06.01.2020 um 21:35 hat Daniel Henrique Barboza geschrieben:
>>> On 1/6/20 4:54 PM, Corey Minyard wrote:
>>>> On Mon, Jan 06, 2020 at 03:23:26PM -0300, Daniel Henrique Barboza wrote:
>>>>> Hello,
>>> [...]
>>>>>
>>>>> Which is cleaner and requires less brain cycles to wonder
>>>>> whether the 'cleanup' label does anything special, such
>>>>> as a heap memory cleanup.
>>>>
>>>> I would disagree with this analysis.  To me, I often wonder
>>>> when I have to add cleanup code to a routine whether there is
>>>> some hidden return in the middle of the function.  That's a lot
>>>> harder to spot than just looking for the cleanup label at the
>>>> end of the function to see what it does.  For non-trivial
>>>> functions I prefer to have one point of return at the end
>>>> (and maybe some minor checks with returns right at the beginning).
>>>> I'm not adamant about this, just my opinion.
>>
>> It depends on the case, but yes, I had similar thoughts, at least when
>> we're talking about non-trivial parts of a function. (Very short
>> functions of just some initial checks returning directly are usually
>> fine.)
> 
>  From a debugging point of view, and when adding trace-events, it is easier to have a single function exit path.
> 
> In various functions modified by your patches, we can split big functions in smaller ones and avoid the goto label.
> 

Splitting and refactoring big funcitons wasn't the initial idea of this
work, but I see no problems in doing it. Care to point out where did you
see such cases?


Thanks,


DHB

