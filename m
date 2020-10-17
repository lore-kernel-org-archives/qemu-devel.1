Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653B7C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 17:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AB12074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 17:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH/3UCKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AB12074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTqH3-0001AU-Tc
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 13:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTqFu-0000YN-L1; Sat, 17 Oct 2020 13:44:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTqFs-0002Jj-PU; Sat, 17 Oct 2020 13:44:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id n6so6894223wrm.13;
 Sat, 17 Oct 2020 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NuBMMA9P9+Uu7GYL8b5m00yUHlAcPRtsrSZIdVJw364=;
 b=AH/3UCKk4MNCjqJ3xsrX1M1lJD0bMh/bU4zZP2lyJ4Y6AC2XFRGDWW48Jgbce8F2aL
 xRJLwT/Qb3cBxyf7FQxe3RSkVDcQwo4++SyoG1PQ2d7K0vPun/5Ou2LsTs6cehdmTtlP
 9dfnAQ8pG7Bor8xjoRq4b4WKvThbIq7Tsp+YUJ/aOiMNb0oU9l3VsolvdJXItiALSsEW
 pD5WmCXdV4F4e5px+vXN0x749H+USdU4D05FF+4epKUuALDxbXLmGK1xHU65KRnbuD0S
 tW6wp/Y6Es9mJlOS9x216MJWRRl9RPLzrKGtrfGc4AiRQInUNtNe1Mh3Ah0uz/gXMxvG
 Ygmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NuBMMA9P9+Uu7GYL8b5m00yUHlAcPRtsrSZIdVJw364=;
 b=OodQwQfWz0PeJr4vRbZEZNOSR9ZEJKwV1t89Z8/R21iPXRJefGLWnSPg6qd67UolDS
 comG+RF413vBJsitOW5CNlRQpFwxaF9bC78tYrAadDBw6JvP1Uwu6xmBiExMChIEzfbu
 mWEwTcHzuAValYSHJzaGo/YGxqdaLdBOrDnUTk4lYZ1pvxLxNU6VAA6R2vp/nS1k0j4w
 4dTC0ejsQG1LqEc7FC4onveKsJPn7sg4840QfooFawnR8qIfsUq+Orn1cf0ChgIJ8z8Y
 Zb7tHEgyosFBTtI5AhuFpPAJkQaf8qOOlUNP0UaFcL2k4pbu0v+2wR4XfKj7YKzTjvXh
 RKaw==
X-Gm-Message-State: AOAM5332vKdJGlN2knDZe5HGmDBFm4tFecx/TWxvikHWWQQ57Bd+3ct8
 YJwHuD0VtYf8HwGoSK1h5oeXCF1x6yw=
X-Google-Smtp-Source: ABdhPJzvGwmg55rEmKl247fyo5L46Aj8+U806GHKIdYZaivkcO9SuJVUyJm4sJgGmHprc8lMiJrjpw==
X-Received: by 2002:adf:e70f:: with SMTP id c15mr11320079wrm.239.1602956670671; 
 Sat, 17 Oct 2020 10:44:30 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id s1sm8086802wmh.22.2020.10.17.10.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 10:44:30 -0700 (PDT)
Subject: Re: [PATCH v8 0/5] Mac Old World ROM experiment (ppc/mac_* clean ups
 and loading binary ROM)
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <cover.1602805637.git.balaton@eik.bme.hu>
 <005ed95d-65ee-ab36-c068-e96a773ef8ed@ilande.co.uk>
 <7c34f053-268e-6dbf-205f-48792328ebe8@amsat.org>
 <edb86311-6093-9776-a81-17ee8205a6c@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6598b187-7936-563c-c06b-cb4315fa4cc1@amsat.org>
Date: Sat, 17 Oct 2020 19:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <edb86311-6093-9776-a81-17ee8205a6c@eik.bme.hu>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.247,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/20 6:39 PM, BALATON Zoltan via wrote:
> On Fri, 16 Oct 2020, Philippe Mathieu-DaudÃ© wrote:
>> On 10/16/20 11:58 AM, Mark Cave-Ayland wrote:
>>> On 16/10/2020 00:47, BALATON Zoltan via wrote:
>>>
>>>> This is the cut down version of the earlier series omitting unfinished
>>>> patches that I plan to rework later and rebased to Mark's qemu-macppc
>>>> branch. Compared to v7 the only change is the cast to (target_ulong)
>>>> from (uint32_t) as requested by Mark in patch 1.
>>>
>>> FWIW the reason for suggesting the cast to target_ulong is so that 
>>> the same code works for both qemu-system-ppc and qemu-system-ppc64. 
>>> For qemu-system-ppc that should correctly drop the sign extension 
>>> from 32-bit, whilst still allowing someone to load a 64-bit ELF into 
>>> qemu-system-ppc64 if requested.
>>
>> IMO this is part of a bigger design problem. Not all
>> machines main bus is 64-bit. I did some experiments
>> but changing that involves a lot of work.
> 
> Did not want to reply to this to not bring it to your attention before 
> patch gets in finally but it's too late...
> 
> Not sure what you refer to

I refer to having machines with a N-bit main bus using a N-bit main bus
(currently all main busses are 64-bit wide).

Some 32-bit machines have access to 64-bit busses, some don't.

I have been wondering about it because of the AVR CPU which
uses a pair of busses, each less than 32-bit.

If one day I can finish my work there, the Old World mac might
benefit from it.

> but in this particular case the problem only 
> seems to be load_elf loading 32 bit ELF files returning sign extended 64 
> bit address which looks bogus but since this function is widely used I 
> did not feel confident enough to propose a patch to load_elf.
> 
> By the way, also the parameters of load_elf could take a clean up to 
> remove all the mostly NULL values as I've pointed out before:
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg03427.html
> 
> but all this could wait until later, these don't seem to be urgent 
> problems to prevent moving mac machines forward now and could all be 
> addressen in separate elf loading series. So just note the problem and 
> move on for now please.
> 
> Reagards.
> BALATON Zoltan

