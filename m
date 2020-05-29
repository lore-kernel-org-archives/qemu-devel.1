Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2B3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05ED8206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWvc6wfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05ED8206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeiBK-00072l-6Q
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 12:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeiAL-0006NE-R7; Fri, 29 May 2020 12:47:29 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeiAK-0008Q0-Pu; Fri, 29 May 2020 12:47:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id e1so4481568wrt.5;
 Fri, 29 May 2020 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LqQcfiW5QPKNV9ayrubvwaJXreo7lAe9FdNjP6gDZQs=;
 b=aWvc6wfFFLz6Tz4GKjG/og6roZYTxS05CThL+O4kCOStf0rnkXvh0kCnYS3soVC6Wb
 WTtB/bCD1dWwRGCoBwCW8ftL0y4+Kji6fRjW9390IltSM6dkCwR1H0KrPKyqYywKWMHv
 5ZABOINr937lk8uGnlSA+D33Fo0u7goKByMmIZmIKkzAE77K6WieE1xnRXUSEbQM1+I4
 OXJq/WG/dPd+FOAIUky125b685Y1l1U74yx5HwboQ5iZ/CocJ67cliuLnJF7L4zHTzjS
 NVXGbUXWrPLug2Mai8DhPsgGWAN2fKemcjbeejxfEIvZyfnmLjQAVeXFZT7e4jjvzUUY
 2atQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LqQcfiW5QPKNV9ayrubvwaJXreo7lAe9FdNjP6gDZQs=;
 b=n+l+ot8xZFEgz3BGXsLou7TlOnCnrMl5uk4JbLWi+SDdoX4tdxlft/cV3cnIH3/vUT
 3xDADhpY2TIoItGMcTiRu8DbLRAjUTc4Y0VGamfBmgeY5/lpjmkOT8KaJPoNRBVPHcmu
 MOcl0nZL+eYtXADqgVhiDcCsuVIajiSOtptHgt9J3EHzgtXtvB40iXLdLrZDxTMPaC2/
 bECvXhG9U6jnBAQuHwSmWEV+SHALhPknfDFUKsMWi56J7myZtnq9cvs0EH83dOAq7ZuA
 uwBH2dp+9FZ/h2r/qnCDLRfj3utFrQejDEU92149iaAmYyAsS+esF6HPJRutBbTOzlLj
 RNeA==
X-Gm-Message-State: AOAM531ASeoHqS6022AgwNeoDql3GvygWYlVVMoIjRu1EoR4oB857kwW
 LpNjNZ0pnhb2dCYAhVAjtX4=
X-Google-Smtp-Source: ABdhPJxb/eAI0FCuG58ftJRuvuVp+FzyJsYfx+GDgMTdBs1F+1SaF0vxrthsU5N74dDvjYAARX4+Fw==
X-Received: by 2002:a5d:6b85:: with SMTP id n5mr9414900wrx.11.1590770845332;
 Fri, 29 May 2020 09:47:25 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id n1sm10600385wrp.10.2020.05.29.09.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 09:47:24 -0700 (PDT)
Subject: Re: [PULL 00/21] Vga 20200528 patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200528123609.27362-1-kraxel@redhat.com>
 <CAFEAcA98OyyyC6gs34e3U03=dXz8GkDn5qf38UaO_XBB679V+g@mail.gmail.com>
 <bf43132b-71c2-d411-7cf3-e9a00066ccdc@amsat.org>
 <CAFEAcA_Su+2O6nm0hRfj1BqwQzSsLva+ft_f=1O47-o6U8NxBA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <542dc455-dea3-473f-f313-35cc9f1b5c58@amsat.org>
Date: Fri, 29 May 2020 18:47:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Su+2O6nm0hRfj1BqwQzSsLva+ft_f=1O47-o6U8NxBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 6:36 PM, Peter Maydell wrote:
> On Fri, 29 May 2020 at 17:15, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 5/29/20 12:29 PM, Peter Maydell wrote:
>>> Could somebody send a followup patch to fix the indentation
>>> error checkpatch notices, please?
>>
>> If this is part of your scripts, this is a nice feature :)
> 
> No, I just noticed the patchew email.
> 
>>>
>>> 5/21 Checking commit 97f369f2479d (hw/display/cirrus_vga: Use
>>> qemu_log_mask(ERROR) instead of debug printf)
>>> ERROR: suspect code indent for conditional statements (16, 12)
>>> #34: FILE: hw/display/cirrus_vga.c:1038:
>>>                 if (s->cirrus_blt_pixelwidth > 2) {
>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>
>> I explained on the patches:
>>
>>   False positive.
> 
> The code is
>             if (s->cirrus_blt_mode & CIRRUS_BLTMODE_TRANSPARENTCOMP) {
>                 if (s->cirrus_blt_pixelwidth > 2) {
>             qemu_log_mask(LOG_GUEST_ERROR,
>                           "cirrus: src transparent without colorexpand "
>                           "must be 8bpp or 16bpp\n");
>                     goto bitblt_ignore;
>                 }
> 
> checkpatch seems correct; the qemu_log_mask line is misindented,
> and looking at the commit this is a misindent introduced in
> commit 2b55f4d3504a9f34 "hw/display/cirrus_vga: Use
> qemu_log_mask(ERROR) instead of debug printf". The old
> fprintf() line was using indent of tab+tab+4 spaces, but
> the new qemu_log_mask line is indented by 12 spaces, not 20.
> (Tabs are always 8 spaces equivalent.)

OK now I understand, I use "set ts=4 sw=4" in my .vimrc and see this
file completely un-indented (and the qemu_log_mask call well placed).

I'll send a cleanup patch. Sorry and thanks for noticing this.

> 
> Some days I wonder whether we should just do a bulk detabify
> of the QEMU sources.
> 
> thanks
> -- PMM
> 

