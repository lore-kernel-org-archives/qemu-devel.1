Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1522C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCB9207BC
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="taChZWeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCB9207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8xs-0005Tz-0F
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl8xD-0004kM-Qp; Tue, 16 Jun 2020 06:36:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl8xC-0002Xa-C1; Tue, 16 Jun 2020 06:36:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id e1so20244009wrt.5;
 Tue, 16 Jun 2020 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uAIOzgZ7nMPc6T7qV8EN7IVZnECcL0/YZD66xLZAHos=;
 b=taChZWehps6pmgOOZ6Mf7dINhGxKhXRzrQUkk+KTv5GNFtdmjlh5DbPn66fzunT1Ad
 rREVTHzp6zRCNRHiMrarD0xYE0TOu4jL7F45yOkXJcbbWudbPr49QsPu9Pxvu28exEbB
 68uEpkjie7Y2TaY4T2Wx7tubDkv3nLC1kzAVJKIL7IaE9THDf0EHVLq65W4e2zeFWpKW
 CH9qO7UaxT/RR3SFpdWChoQuvY+4Bme0F8oboAY+FL7JQOxt2lr5NcSpTq1P0skn4kMj
 AbgCL9+wOUgq3iUwNQ8qjqCm4/1uZDZeoKqkBj1gLQ+Nkgcid7ZTnhv/Q+Kc1jdUiJn1
 9ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uAIOzgZ7nMPc6T7qV8EN7IVZnECcL0/YZD66xLZAHos=;
 b=Jbm9bXTLEpJKVb7vsaljhT02v+96bqI1nniW9ArDeB4JvoOsiqYlKBYc+QwOaLYPB4
 6bf/APHT1bn7535E+nZl982ErV3JTh/DmJ/7ocKtFba9g6csE6WN8HeS94hogeJhDjD+
 qU3kbN5Puoff/R4u9WcnUUPt2hXbGjSU0dbR7cGhOzopBv28KJfsp3/ROuv7WxFTinYM
 mgGbpoPufVO471czleS1EuIeemwo8faFgtZgtRgsTQWG3CmkW2+gaG1o/HMBRBfyWEiW
 koib6xPV63gpayaZfzRr5RtKG4E5waXUUkUXIi/gdHreZOHUS+XpJAr8cznMJmq5aYoF
 U5Ng==
X-Gm-Message-State: AOAM530JatXupFogiuHd4KzSZYZaq6nOcIePIFSLmsHeY1vW5ZENmVtn
 H7PB3m+vQ3iPkbtmgM0BJhRWgxdO
X-Google-Smtp-Source: ABdhPJyhXT/G9kUHYZ/m/JKmdA6CIMbSHYnfbjqR2rXNX2IbYHxnEDi/q29Wq2drNVnRVBqYbW9sGQ==
X-Received: by 2002:adf:e744:: with SMTP id c4mr2518164wrn.71.1592303788343;
 Tue, 16 Jun 2020 03:36:28 -0700 (PDT)
Received: from [192.168.1.41] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id w15sm3413074wmk.30.2020.06.16.03.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 03:36:27 -0700 (PDT)
Subject: Re: [PATCH 6/7] hw/arm/mps2: Map the FPGA I/O block
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200616063157.16389-1-f4bug@amsat.org>
 <20200616063157.16389-7-f4bug@amsat.org>
 <CAFEAcA8HKmMpgZMTuL6PSQNd2gy8h8HSvu6GwvTy8_h93teHjg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c680c735-0a1f-3f74-13f9-bf289da0d57d@amsat.org>
Date: Tue, 16 Jun 2020 12:36:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8HKmMpgZMTuL6PSQNd2gy8h8HSvu6GwvTy8_h93teHjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

On 6/16/20 12:26 PM, Peter Maydell wrote:
> On Tue, 16 Jun 2020 at 07:32, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
> 
>> @@ -337,6 +339,11 @@ static void mps2_common_init(MachineState *machine)
>>
>>          sysbus_create_simple("versatile_i2c", i2cbase[i], NULL);
>>      }
>> +    sysbus_init_child_obj(OBJECT(mms), "fpgaio", &mms->fpgaio,
>> +                          sizeof(mms->fpgaio), TYPE_MPS2_FPGAIO);
>> +    object_property_set_bool(OBJECT(&mms->fpgaio), true, "realized",
>> +                             &error_fatal);
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->fpgaio), 0, 0x40028000);
> 
> AN385 TRM isn't entirely clear but I suspect that you need to set
> the FPGAIO's prescale-clk property because the default of 20MHz
> isn't what the AN385 runs at. The FPGAIO model's default is written
> to match the AN505, which is 20MHz, but AN385 and AN511 are both
> 25MHz:
> https://developer.arm.com/tools-and-software/development-boards/fpga-prototyping-boards/mps2

Ah I only checked for the I/O register. I'll check the clocks.

> 
> thanks
> -- PMM
> 

