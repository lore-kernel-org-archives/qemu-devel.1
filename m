Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07FBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66B6206A1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6zeb3//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66B6206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtPD2-0002yV-Uo
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 01:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtPCR-0002QE-JN; Thu, 09 Jul 2020 01:34:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtPCQ-0002bk-44; Thu, 09 Jul 2020 01:34:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id b6so903566wrs.11;
 Wed, 08 Jul 2020 22:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OrR3Z1znEUDds/mQrhxbFHfHFATqlj6dLaDL002fzMk=;
 b=C6zeb3//BogHt4RIxTgB7dSXflWf8oWig0CjwMeCxiRfUNGmvB76tMrf8WqItGRCuX
 pQzlz47clX5FOqwd8f5AnrCtNPBoT94GdXZxQzVwgWXGRQfhj6h2D72CfPcXafFFFCaz
 /SbpMmo50jI77tMJCsE5/LhOv2M7tysayD2AtQir6hDpR+kKCkkDcAz1IgUarDi4PE4A
 tojugrrod4HAAH2BXQKZ+YG1OhUyMJ6xKAPWyhHY+cKgGj+x0vgAjMnaDxfYO3S2b2wV
 MYb9Fj4l8QswGl660C0OAdhAyIKsb67TuyvIr3xuTm9yEmvATvVK7d50ayCfP8XQxOau
 ExBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OrR3Z1znEUDds/mQrhxbFHfHFATqlj6dLaDL002fzMk=;
 b=jBk9jp7dnayyROuF/zOatc2bjq6mjoIh2wuGbYwBEDpFpWzG8ngcpQggP+O1ZGs34g
 JK6L6SOorGB21A2GbR8dUrxn6jMScPWOBZKGm38zuu53e4Cy4a7duEC/zcCRsY8puKiI
 +A2fZTgCTg7UDtO4Mjcx0/B7L1RrdpCic9uBnJ8MdnLn8h2+JVFOKGVbllxCovQf+2FV
 Lw2tyuz38grrc3ynqGCdGKWU88p1wiUSSGmK+oklsgvc+Cyq47xh4YH132mLa698CelO
 eiQL4+f0xvYNW4yyzO3l9jv+z9wopDDDBl5LjqhiCPckQGXGzGNB+jqRnSYAvopS2rih
 +1wQ==
X-Gm-Message-State: AOAM533hZwCtNSaBMvPLBErUG4Pl6KE0jNwikC1porszzmXQlT2BCsd9
 /wnTNrTlWCBJ7TRUAMc22Jw=
X-Google-Smtp-Source: ABdhPJxGfC8Z/m7rI8EUj6UsekftcZ+r5OfY9qHVQc3Dcq0tfjXVyaM1Of7aqJh2MzP4vahPqVERxw==
X-Received: by 2002:adf:f889:: with SMTP id u9mr67408394wrp.149.1594272860250; 
 Wed, 08 Jul 2020 22:34:20 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d81sm16653152wmc.0.2020.07.08.22.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 22:34:19 -0700 (PDT)
Subject: Re: [PATCH v4 05/12] hw/arm: Add NPCM730 and NPCM750 SoC models
To: Havard Skinnemoen <hskinnemoen@google.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-6-hskinnemoen@google.com>
 <4b7130f2-032c-3067-b2b6-876a2b17b707@amsat.org>
 <CAFQmdRYi5QFHbcWQH-bWqAsSCidzYMedC8n+mib1DPpJuEy-Rw@mail.gmail.com>
 <CAFQmdRZdUKvmi_eKdtCnR8uP63sRP9X0Z7oxZES56mtSz_=7FA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <af879fd1-dea8-a3f2-d3fb-13be24c0b740@amsat.org>
Date: Thu, 9 Jul 2020 07:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRZdUKvmi_eKdtCnR8uP63sRP9X0Z7oxZES56mtSz_=7FA@mail.gmail.com>
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
Cc: CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 2:06 AM, Havard Skinnemoen wrote:
> On Wed, Jul 8, 2020 at 11:13 AM Havard Skinnemoen
> <hskinnemoen@google.com> wrote:
>> On Wed, Jul 8, 2020 at 10:31 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>> On 7/7/20 8:47 PM, Havard Skinnemoen wrote:
>>>> +typedef struct NPCM7xxClass {
>>>> +    DeviceClass         parent;
>>>
>>> Similar comment that elsewhere on this series, if NPCM7xxClass not used
>>> outside of npcm7xx.c, keep it local.
>>
>> OK, will do.
> 
> Turns out it is used in npcm7xx_boards.c, so it has to stay where it is.

Indeed:

static void npcm7xx_load_kernel(MachineState *machine,
                                NPCM7xxState *soc)
{
    NPCM7xxClass *sc = NPCM7XX_GET_CLASS(soc);

    npcm7xx_binfo.ram_size = machine->ram_size;
    npcm7xx_binfo.nb_cpus = sc->num_cpus;

    arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
}

This is fine.

Just thinking loudly, we traditionally add the load_kernel() code
in the machine, because it is often specific to Linux guest, and
the SoC doesn't need to know about the guest OS.

hw/arm/boot.c contains helpers also useful for firmwares.

The SoC has a link to the DRAM so can get its size.
All the arm_boot_info fields are specific to this SoC.
So we could move a lot of code to npcm7xx.c, only declaring:

  void npcm7xx_load_kernel(MachineState *machine,
                           NPCM7xxState *soc);

