Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ED4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E8F2067D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhyDSOQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E8F2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqZrv-0003Bp-85
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqZqI-0001Uf-6b
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:19:50 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:38025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqZqG-0005HD-Jj
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:19:49 -0400
Received: by mail-ed1-x541.google.com with SMTP id n2so10090469edr.5
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Lnn+PjazrmdHQ4WC1Vxt2S6prZwVD1952oWwGTjWZw0=;
 b=NhyDSOQpk8EVmZnb5K+pEVnqJbaV1lmtsMqAMzld4TT4tOjVfNK7PC/sV4ZkwwZDgk
 ElPruLSuUn7Oz1kmD+QR4ZqatpYp3NkvEhGjY4DvuTEpk06md8yEyHqwpvbeKh8HkzAF
 cFwugCN5/IoSayJ98Q7Bkxy02LWuuIV+t/3akEDbYxhuen5iEH3OhDCXX+tZnsJ3pepw
 esBiggHcmjWg39+e5TiSIfHDtF4FJfqd7TFqH9peeuuATLUy51qBUOsxNtQfAlMAIrE8
 Wf+vuaAyjRLFivfap4xa7FVSUa28kCYXD9RCzX0c4aTKaBYNlfgngk3H6X0z1pLG966u
 pfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lnn+PjazrmdHQ4WC1Vxt2S6prZwVD1952oWwGTjWZw0=;
 b=OYC6FaGasK9O4jld0goqxfBbj2HG+PaWTgPwSaKTv9Rkx4EoSpoWNY7ROpJ1OZEWGK
 7M3ChRH5lNn2GWGiEVAvAcZN0YrQRdYLaAmNFEXoA3TKHbs4YiAfkWlTbNksN1xpJ+vw
 kAmtr1rlLOmJrvGO0xev0dJH5jln6ymdKx2nYq31LutYW2C3XegP8XLg3bag6iN7mhac
 VxZDb4/pvxkvcpFQzo7appPdF6tzrT562ozqi2/l0AOgnFPkDHZksEWlS9dhX8Tbx8Nh
 ErOAd8n6VFcpwuBwXz5DRWWzFT28yqmpBwjovIzmTc7RHyXEKhBPE+O2vzXNUSh0nA5H
 oIBQ==
X-Gm-Message-State: AOAM533suwPg3oTyxWNFGvm9osuuuI5Jl3CRmiwS0XQnCKViFZGm1PCT
 iwSN7fJ2Z9zh6ML9xft5AgQ=
X-Google-Smtp-Source: ABdhPJxbQ2FpS9umotP22AlMR9fiJuSKuRFEia4NGGL4rN7OWC925DX9L5MCwzesluZaRzBzzgXZmg==
X-Received: by 2002:aa7:d64b:: with SMTP id v11mr27081072edr.381.1593598786564; 
 Wed, 01 Jul 2020 03:19:46 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id jo25sm4274470ejb.116.2020.07.01.03.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 03:19:45 -0700 (PDT)
Subject: Re: [PULL 3/6] MAINTAINERS: Add Loongson-3 maintainer and reviewer
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1593287503-25197-4-git-send-email-aleksandar.qemu.devel@gmail.com>
 <362d8118-93c9-d020-90ba-7ddbd8ad446d@amsat.org>
 <CAHiYmc5dGWU+iQezH=AqiEV4kxoxSa4iOcjORPX2vMheyC_z+Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eb882215-add1-441d-b574-13aa8c66fed9@amsat.org>
Date: Wed, 1 Jul 2020 12:19:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc5dGWU+iQezH=AqiEV4kxoxSa4iOcjORPX2vMheyC_z+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 11:56 AM, Aleksandar Markovic wrote:
> понедељак, 29. јун 2020., Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> је написао/ла:
> 
>     On 6/27/20 9:51 PM, Aleksandar Markovic wrote:
>     > From: Huacai Chen <zltjiangshi@gmail.com
>     <mailto:zltjiangshi@gmail.com>>
>     >
>     > Add myself as the maintainer for Loongson-3 virtual platforms, and
>     > also add Jiaxun Yang as the reviewer.
>     >
>     > Signed-off-by: Huacai Chen <chenhc@lemote.com
>     <mailto:chenhc@lemote.com>>
>     > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com
>     <mailto:jiaxun.yang@flygoat.com>>
>     > Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com
>     <mailto:aleksandar.qemu.devel@gmail.com>>
>     > Signed-off-by: Aleksandar Markovic
>     <aleksandar.qemu.devel@gmail.com
>     <mailto:aleksandar.qemu.devel@gmail.com>>
>     > Message-Id: <1592995531-32600-5-git-send-email-chenhc@lemote.com
>     <mailto:1592995531-32600-5-git-send-email-chenhc@lemote.com>>
>     > ---
>     >  MAINTAINERS | 7 +++++++
>     >  1 file changed, 7 insertions(+)
>     >
>     > diff --git a/MAINTAINERS b/MAINTAINERS
>     > index 1b40446..fe925ea 100644
>     > --- a/MAINTAINERS
>     > +++ b/MAINTAINERS
>     > @@ -1096,6 +1096,13 @@ F: hw/isa/vt82c686.c
>     >  F: hw/pci-host/bonito.c
>     >  F: include/hw/isa/vt82c686.h
>     > 
>     > +Loongson-3 Virtual Platform
>     > +M: Huacai Chen <chenhc@lemote.com <mailto:chenhc@lemote.com>>
>     > +R: Jiaxun Yang <jiaxun.yang@flygoat.com
>     <mailto:jiaxun.yang@flygoat.com>>
>     > +S: Maintained
>     > +F: hw/mips/loongson3_virt.c
> 
>     This file has not been commited, is this pull request incomplete?
> 
>     > +F: hw/intc/loongson_liointc.c
> 
> 
> This line, in this patch, was my mistake. I did delete the line, but
> forgot to do "git add MAINTAINERS". So, the deletion happened in the
> next patch dealing with MAINTAINERS.
> 
> So, my bad. An honest mistake. I apoligize.
> 
> However, the final outcome of the pull request is 100% as desired, and
> as I informed other in my responses to patches.  No need to do any
> follow ups.
> 
>     How can we test this device?
> 
> 
> Please read the commit message of patch 3/4 of Huacai's recent series v6.

I suppose you are referring to this post:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg716861.html

I prepare the kernel as suggested to add an acceptance test, but then
when testing I get:

$ qemu-system-mips64el -M loongson3-virt,accel=tcg
qemu-system-mips64el: -M loongson3-virt,accel=tcg: unsupported machine type

Are you deliberately merging code into mainstream that is not build
neither used? This might be an acceptable exception, but please
explain why this is an exceptional case, and set a deadline for the
machine to be merged, it has to be in for the next 5.1 release,
else we'll have to revert commit c012e0b1f9 ("hw/intc: Add Loongson
LIOINTC support").

In the past the policy has been to reject contributions from finshed
devices but "unfinished machines". The policy is not strict regarding
that.

>  
> 
>     > +
>     >  Boston
>     >  M: Paul Burton <pburton@wavecomp.com <mailto:pburton@wavecomp.com>>
>     >  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com
>     <mailto:aleksandar.rikalo@syrmia.com>>
>     >
> 

