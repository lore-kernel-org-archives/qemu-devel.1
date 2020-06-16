Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28513C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BC020767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prC98ftq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BC020767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl94T-00050Z-8A
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl919-0008Vc-UN; Tue, 16 Jun 2020 06:40:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl918-000366-CC; Tue, 16 Jun 2020 06:40:35 -0400
Received: by mail-wm1-x343.google.com with SMTP id q25so2561619wmj.0;
 Tue, 16 Jun 2020 03:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=h7NdL+NijAu3nvj3Mja/Bszo88XodLCkY5SkSHUqUP4=;
 b=prC98ftqldHXLAR51i7Sq8GqiLTiCbsewJuT2mKyPdLD2NfF1oGrxWYJ9ckJjsZYgZ
 K9POjXntfWNgmGWD/CzwBaV2q3uwXswsd+RhvIS2ZEMBTQ0vMN6Upbk5VLzm6pe2d0UX
 ffKLMISo9KI0gy8ORJxTonkDSXpZJROl48z3daXTLgDNhD/hbPNSHh+Fgk4d27Ocrmbu
 sCH7LD/+xqu68VGanWI6DXjYNlgYmnw+4LsnbJy6mVUXeEJFACFdgBz++OycRJSq90Op
 CvjCxq9Mg0iQLoa0OgkRoeSY9vPfoMyeK+msqMexJ6TqKT3gt0PCBV9yeLVtH35m4YpG
 RrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h7NdL+NijAu3nvj3Mja/Bszo88XodLCkY5SkSHUqUP4=;
 b=AEAEiJRLxEYVDoA14Al6KH+qpz6H22flU7S5Mq+FvnweuZvC4zxnZCZSjtAhDj0amY
 60rDCpZJmESg9V8ldRhqYIN+Bsjm2cXjv58tPw5HUVyjyZR7OuDH5xKS7hFZUdaCyYvW
 uYMHjLux5poG0aZDVAiyZ+nOGnnYVyUGq/yflelopt7hCu848e02cKUu3FnV1ls903Mh
 +VyI7jjxrqqVqbEU9xXFoHnAwcfbwJCS13iH2z/jaQmGhwjjFnqhPOu/EiZaMumL2zQ7
 E3jefRJOhuQ1KlSb0KNOmlGeYZPNoPhPJKQ0mz1x3KW0vT2VQplfYsTjntUCCW3HMe/c
 or1Q==
X-Gm-Message-State: AOAM532iPBdX+cP1IiCSH4iUtZXDF6X/qtFxVkYj4N2ll8+xxj1YKj2N
 huFYjKOPkv1gOoKtolh4piMDO+Ju
X-Google-Smtp-Source: ABdhPJzCKLMKTENGl/8JD1tetTNpcBNHSq79EETyMvx7NP0tXmPpI61PrflP0FnT0AnazXLfT/d/ZA==
X-Received: by 2002:a1c:790f:: with SMTP id l15mr2497604wme.161.1592304032180; 
 Tue, 16 Jun 2020 03:40:32 -0700 (PDT)
Received: from [192.168.1.41] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id s72sm3427093wme.35.2020.06.16.03.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 03:40:31 -0700 (PDT)
Subject: Re: [PATCH 7/7] hw/misc/mps2-fpgaio: Implement push-buttons
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200616063157.16389-1-f4bug@amsat.org>
 <20200616063157.16389-8-f4bug@amsat.org>
 <CAFEAcA8c3QVD=PcfMOXn720E0ExSdV+mb3qoA61AFrFVstFHHw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <84c3ce87-fefd-5741-7588-7a8ca12fde4c@amsat.org>
Date: Tue, 16 Jun 2020 12:40:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8c3QVD=PcfMOXn720E0ExSdV+mb3qoA61AFrFVstFHHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 12:27 PM, Peter Maydell wrote:
> On Tue, 16 Jun 2020 at 07:32, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> The FPGA system control block has 2 push-buttons labelled PB0/PB1.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
> 
>> @@ -249,6 +258,8 @@ static void mps2_fpgaio_init(Object *obj)
>>      memory_region_init_io(&s->iomem, obj, &mps2_fpgaio_ops, s,
>>                            "mps2-fpgaio", 0x1000);
>>      sysbus_init_mmio(sbd, &s->iomem);
>> +
>> +    qdev_init_gpio_in_named(DEVICE(s), mps2_fpgaio_push_button, "PB", 2);
>>  }
> 
> This change seems kind of pointless unless these GPIO lines are
> actually wired up to something.

Yes, I should have kept it out of this series, or documented
better the goal in the cover.

I'm setting the roots to motivate a team of developers to
work on a visualization of the MPS2 board. The push-button is
supported by Zephyr, so the the idea is the visualizer generates
QMP GPIO event to be processed such in pca9552_set_led(), and
interact with the guest firmware.

> 
> thanks
> -- PMM
> 

