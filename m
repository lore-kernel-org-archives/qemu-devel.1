Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3877C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E462065F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJBuUfTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E462065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyvJ-00033T-QN
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyyrj-0005Sl-Oa
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:40:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyyrh-0005mW-Ve
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:40:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id f18so8560575wrs.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2fqZCLPpcAj+SC+G0YHB/axRgjD28aMTaC8MED3pIFM=;
 b=aJBuUfTyTlyTrrp2Gkd6pz1yUGPpRad/5xlD0S5gWwZSPCKaGLSoxwYxEZfSF3HFWx
 +WTkblewCf5KlDD0AbCxDRrpeKy6qIi+3w7qxIYpG8XBvvlYkWGnHoZw1aauLqsse8Nf
 ALNFTgsx4chea+JNkc3sZuTfKQu8vynVnyyOjeh6xFoQDMbmy6JtBPj/iX6+1+B6RxgP
 myID/L0Py731pEmfkeap1iqNcvS+uIr25J+eUO35bs4RGM/KQzteNffk+StCWIHw3hLP
 zo795g2V4lDtFc7KOq+b+PDxN7IYI8NGr6hNNoH6Iwap/NYsICD0qqRrcq+a+A5729mY
 0HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2fqZCLPpcAj+SC+G0YHB/axRgjD28aMTaC8MED3pIFM=;
 b=geZ1IlXDM7CEdHYTI2VsRe2/OnbNEIz+7d3GpzfkBPlTDbrPXcYLShiAUrHxxjgkXF
 C8YNPOBnIkidmo18JZEd9+qwkB/3eGdVFah8WLRom1IWcz35OrZ7c51jtgOHzMV3HgO/
 oSTd9OM8HE6zjTWhGLynKurSdw94/5cqPTc3/41YSv8CcftBTLxzZjzmpPPL1GpzGTil
 ZSH19f4h3OGhrSgS8+HL5NCtZWiWVF0sMLeBq8+ZbVoILZt8QaKfGdKuw83gMZbGN6wm
 iMHTEnKf20U/Ywgsj55HNnE/gmCuk6sG7uaXQS+n6/zp8qcQja1y1NKX4v+n2CoRe0im
 AAjg==
X-Gm-Message-State: AOAM531UKT+9VCvaWmLF2meXmGi0GT3kfloE5igqbJLRm5n7HbyflFtC
 YknIJdR5IPMcQRXFQsWHm+Y=
X-Google-Smtp-Source: ABdhPJzjfoJRRMmX/U5A7CwBjG6wyNPY704HGir+4wgPGS1eFRcVP91RFYoyO11y/c+GQ6WFLEmrsw==
X-Received: by 2002:adf:dc83:: with SMTP id r3mr9730305wrj.172.1595601600342; 
 Fri, 24 Jul 2020 07:40:00 -0700 (PDT)
Received: from [192.168.1.33] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id h6sm1513745wrv.40.2020.07.24.07.39.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 07:39:59 -0700 (PDT)
Subject: Re: [RFC PATCH] buildsys: Only build capstone if softmmu/user mode is
 enabled
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200724071657.21508-1-f4bug@amsat.org>
 <5d8ade29-c085-9f6d-b896-fda48c1f5666@redhat.com>
 <0ce8f279-1ef0-6d93-5fff-032783fba2b6@amsat.org>
 <45942406-2ee2-150a-fb11-d485a12ca290@amsat.org>
 <CAFEAcA9wXHK0h6kzfX_re=Q8P3Yv93c_WFQxjbEUnj_PhV-_bQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7b9fe174-f47d-bea6-a915-1c6a45c57e51@amsat.org>
Date: Fri, 24 Jul 2020 16:39:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9wXHK0h6kzfX_re=Q8P3Yv93c_WFQxjbEUnj_PhV-_bQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 11:59 AM, Peter Maydell wrote:
> On Fri, 24 Jul 2020 at 10:47, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 7/24/20 11:38 AM, Philippe Mathieu-Daudé wrote:
>>> On 7/24/20 9:56 AM, Thomas Huth wrote:
>>>> On 24/07/2020 09.16, Philippe Mathieu-Daudé wrote:
>>>>> At least one of softmmu or user mode has to be enabled to use
>>>>> capstone. If not, don't clone/built it.
>>>>>
>>>>> This save CI time for the tools/documentation-only build jobs.
> 
>>>>> +if test -z "$capstone" && test $tcg = 'no' ; then # !tcg implies !softmmu
>>>>> +  capstone="no"
>>>>> +fi
>>>>
>>>> I don't think this is right. You could have a KVM-only build where you
>>>> still want to use the disassembler for the human monitor.
>>>
>>> I had the same question with KVM, I agree this is unclear, this is why
>>> I added RFC.
>>>
>>> Don't we have !softmmu implies !kvm?
>>
>> It works because it falls back to the old disas.c (if capstone is
>> here, use it, else fall-back).
>>
>> Does this means we can directly remove the capstone experiment &
>> submodule without waiting for the libllvm integration?
> 
> The theory (at least at the time) was that capstone was better
> than the internal disassembler for at least some targets.
> If we want to go from libllvm to capstone as our long term
> plan that's cool, but until we actually do that I don't think
> we should drop capstone.
> 
> As far as this patch goes: if you want to disable capstone for
> the tools-and-docs-only setup

This is also useful for a job downloading CI prerequisite artifacts.

> then I think the right condition is
> if [ "$bsd_user" = "no" -a "$linux_user" = "no" -a "$softmmu" = "no" ] ; then
>   capstone=no
> fi

OK, thanks!

> 
> thanks
> -- PMM
> 

