Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4596C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F10208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhNE9J6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F10208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSeQy-0007fA-Tg
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 06:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSeQK-00071K-Lo
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 06:54:24 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSeQI-0001VP-Gs
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 06:54:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id l15so1414402wmh.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4gi8ayjkHyJo7ZvAynN42VjhEgcgck7k92w8J6NQFnw=;
 b=HhNE9J6Q1P740Bx6yEQfnfjYb3ND+uV6yaExWntavNL8jCxypCtBcrsSWZItr09ELT
 vZNUZDxJ4rxU0Pxj8FtMiy6AO2hadFDdsvHmF84E8VE5lSmuity94buOstG0G/ze43mb
 3pu5eBuDzYVWmrPybNW7mAIkxBp3lgzSPFQV7pVv+DJmRKbnl29GlRVUJwxaogXOFMkk
 YwSZNCDMAvXcbGPP878rs+gXafEP8RGv1/gwG79bxJpKxXSJxSHCxkfPcsDi4kJmpXae
 sa/sE2r2d5zq8JWucxntYaKIVd3V/evSBMMsdee8HU/3K9Zf1wKkvLSv0PpGnr9f8esa
 COqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4gi8ayjkHyJo7ZvAynN42VjhEgcgck7k92w8J6NQFnw=;
 b=lhDAkIbNexx31fgADLc3il9HKv4jyGFFadg9tzjEHrf6FiASXfJCA6y7/x1oVcHWBG
 lbBn/5Gv2P/RkbawOZLVm62vLwpNV0k3DxUAQP0qifJlssxB22fQPGYoWHROL6670868
 iDuCF12gWFnTuwf4vEBhbbB3LMe1k3HaFNsMtLI35AA1zIl22HoRYavu9TlgcM+a/9Bk
 wdla5gQjMjOAOulHRNQRrOBaCWZwnIYgzEU/3THnd/P9GDqwDxSsuZQg1dzVr0zc7GqU
 Tznf04QbyzlUKj3eoSVSHQuR++ZZ2DBJeiKS/RUTOat7zjv6bEVl6KHC1ndz1NdCIzlp
 yz2g==
X-Gm-Message-State: AOAM5323y4+XLT8reFUuXArKhDoQXhfe+OghA9JToD/feGyJ0ae8l+Of
 iYeelr1fKFJKHKjLp/pM6qk=
X-Google-Smtp-Source: ABdhPJzOVHi19kDAdJetlnuEnsPswYei/E1R/lI5IdGMfiPYqjY4zjbEXh6YQPYm5cxpL8SP8N13OQ==
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr2741623wmj.166.1602672860473; 
 Wed, 14 Oct 2020 03:54:20 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p13sm3251866wmb.5.2020.10.14.03.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 03:54:19 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] target/mips: Make the number of TLB entries a CPU
 property
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Victor Kamensky <kamensky@cisco.com>
References: <20201013132535.3599453-1-f4bug@amsat.org>
 <20201013132535.3599453-4-f4bug@amsat.org>
 <39e98c46-d22d-621e-c559-a6e31c5aad6c@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <15523f8d-8626-efad-abdb-e4ac17609c9e@amsat.org>
Date: Wed, 14 Oct 2020 12:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <39e98c46-d22d-621e-c559-a6e31c5aad6c@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Khem Raj <raj.khem@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 12:20 PM, Jiaxun Yang wrote:
> 在 2020/10/13 21:25, Philippe Mathieu-Daudé 写道:
>> Allow changing the number of TLB entries for
>> testing/tunning purpose.
>>
>> Example to force a 34Kf cpu with 64 TLB:
>>
>>    $ qemu-system-mipsel -cpu 34Kf,tlb-entries=64 ...
>>
>> This is helpful for developers of the Yocto Project [*]:
>>
>>    Yocto Project uses qemu-system-mips 34Kf cpu model, to run 32bit
>>    MIPS CI loop. It was observed that in this case CI test execution
>>    time was almost twice longer than 64bit MIPS variant that runs
>>    under MIPS64R2-generic model. It was investigated and concluded
>>    that the difference in number of TLBs 16 in 34Kf case vs 64 in
>>    MIPS64R2-generic is responsible for most of CI real time execution
>>    difference. Because with 16 TLBs linux user-land trashes TLB more
>>    and it needs to execute more instructions in TLB refill handler
>>    calls, as result it runs much longer.
>>
>> [*] https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html
>>
>> Buglink: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13992
>> Reported-by: Victor Kamensky <kamensky@cisco.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
> Hi Philippe,
> 
> I think name can this property vtlb-entries?
> 
> MIPS R2 had introduced dual-TLB feature and the entries specified here
> is the number of VTLB, while FTLB is another set of entries with fixed 
> pagesize.
> 
> Although MIPS TCG haven't implemented dual-TLB but it can prevent future
> confusion.

Sure, good idea.

I'll follow Richard suggestion first, having a look at the P5600.

> 
> Thanks.
> 
> - Jiaxun
> 

