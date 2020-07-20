Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB5CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF3E20702
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgPLLdHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF3E20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxZlZ-00013I-P8
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 13:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxZkp-0000VG-GC; Mon, 20 Jul 2020 13:39:07 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxZkn-0005vU-QX; Mon, 20 Jul 2020 13:39:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id r12so18588692wrj.13;
 Mon, 20 Jul 2020 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=a/zhsPD12YsKDjMxS46wv3ILiJMOHt/1ysmAD2V8pH4=;
 b=bgPLLdHdtag3MrQtDCiTqnnXd1NkLttu/l2CenZ25dL0czDTUt4S8FFm1ZQwoXcIBn
 Qi35l/iD5BxpYKiyTjrt6fzyk/554mvpuLtnoHTjywqpvfIeX4Y3HOCQcVq1IaAwXnhr
 lNxeab5LOUJR65uGNKoGA3HeXBYda2trWC1jScOQKOn6He9GnL+/+lrh5tUsgoKQJppy
 v46tX06nOdTsks5ZEuIt9bsLJWUkgGNFrGRcmbzgDD/zEFO8uZ/IHN4bS6wC0y5oHnzq
 WN7z6drCwKXnaibPG8RjsTsapTICLF/A7LPHygjkLm6QRSgRSMl1Xfu45ITSZHpHWJ7/
 pBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a/zhsPD12YsKDjMxS46wv3ILiJMOHt/1ysmAD2V8pH4=;
 b=WvmZPJTLl8GmNlfnFKvYoOB2YpA2j7c7MV4bZyoxibCEq/LyFShErBrM3rTVSQpSzS
 HXhNcIGkFhHuxIoFtstVtZWUFvATvAaoRiX+vDQNo7MeUsk/FEmmIURxjJzU7LyfW9/x
 rwy0/WwPMXPKi7rxLYIR9R7QugWdlmYNUwVGIF/1ty4sMqRQwzaXTF28YFiaP25uW9L1
 t99p8G+nrVmri7hZ7CAyHU7SWR9OsGkNSjwxaeutrL8MgLG54naQ2cCyw5P8bWFX9sH2
 K/mCdyi9QZ8aGZ8kRhOtoTdHE9fHdINHrG9lx4nsGRwqvnviAaSuvc5C8RfBEr9KNeAw
 gYMg==
X-Gm-Message-State: AOAM532QgY4pctDezT2EpO6L9+bySz7Bi1bRQPLSUF/FzzCGBjHeP3Cm
 AX5TWRiR0c0+ACWO3QZlLFY=
X-Google-Smtp-Source: ABdhPJxYAQgoqHbTjZ8+1WlkUiOApCE2pWWHx3vJ1600dQk7c3OFQzq4pEIedXdt+58GAOIRkUkX0Q==
X-Received: by 2002:a5d:6b08:: with SMTP id v8mr23880265wrw.2.1595266743938;
 Mon, 20 Jul 2020 10:39:03 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t4sm312514wmf.4.2020.07.20.10.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 10:39:02 -0700 (PDT)
Subject: Re: [PATCH-for-5.1] hw/misc/aspeed_sdmc: Fix incorrect memory size
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
References: <20200720095829.22839-1-f4bug@amsat.org>
 <ed5e6bd0-0962-b182-3348-d3c6655ef35e@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f7dc7d48-6fd7-e1ba-f94b-cd2764490eb7@amsat.org>
Date: Mon, 20 Jul 2020 19:39:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ed5e6bd0-0962-b182-3348-d3c6655ef35e@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 6:07 PM, Cédric Le Goater wrote:
> On 7/20/20 11:58 AM, Philippe Mathieu-Daudé wrote:
>> The SDRAM Memory Controller has a 32-bit address bus, thus
>> supports up to 4 GiB of DRAM. There is a signed to unsigned
>> conversion error with the AST2600 maximum memory size:
>>
>>   (uint64_t)(2048 << 20) = (uint64_t)(-2147483648)
>>                          = 0xffffffff40000000
>>                          = 16 EiB - 2 GiB
>>
>> Fix by using the IEC suffixes which are usually safer, and add
>> a check to verify the memory is valid. This would have catched
>> this bug:
>>
>>     Unexpected error in aspeed_sdmc_realize() at hw/misc/aspeed_sdmc.c:261:
>>     qemu-system-arm: Invalid RAM size 16 EiB
> 
> Indeed :/
> 
>>
>> Fixes: 1550d72679 ("aspeed/sdmc: Add AST2600 support")
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/misc/aspeed_sdmc.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
>> index 0737d8de81..76dd7e6a20 100644
>> --- a/hw/misc/aspeed_sdmc.c
>> +++ b/hw/misc/aspeed_sdmc.c
>> @@ -256,6 +256,12 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
>>      AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
>>  
>>      s->max_ram_size = asc->max_ram_size;
>> +    if (s->max_ram_size >= 4 * GiB) {
>> +        char *szstr = size_to_str(s->max_ram_size);
>> +        error_setg(errp, "Invalid RAM size %s", szstr);
>> +        g_free(szstr);
>> +        return;
>> +    }
>>
> 
> I would put an assert() since the max RAM size is not user configurable. 

As you wish, at this point I'm completely lost with error reporting.
Per the manual
(https://www.mail-archive.com/qemu-devel@nongnu.org/msg723217.html):

 "Many, many devices neglect to clean up properly on error, and get away
  with it only because all callers treat errors as fatal.

  If you decide to take cleanup shortcuts, say because the cleanup is
  untestable, consider adding a comment at least."

So I'll go for address + comment:

  assert(s->max_ram_size < 4 * GiB); /* 32-bit address bus */

> 
> C.
> 
>>      memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops, s,
>>                            TYPE_ASPEED_SDMC, 0x1000);
>> @@ -341,7 +347,7 @@ static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
>>      AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
>>  
>>      dc->desc = "ASPEED 2400 SDRAM Memory Controller";
>> -    asc->max_ram_size = 512 << 20;
>> +    asc->max_ram_size = 512 * MiB;
>>      asc->compute_conf = aspeed_2400_sdmc_compute_conf;
>>      asc->write = aspeed_2400_sdmc_write;
>>      asc->valid_ram_sizes = aspeed_2400_ram_sizes;
>> @@ -408,7 +414,7 @@ static void aspeed_2500_sdmc_class_init(ObjectClass *klass, void *data)
>>      AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
>>  
>>      dc->desc = "ASPEED 2500 SDRAM Memory Controller";
>> -    asc->max_ram_size = 1024 << 20;
>> +    asc->max_ram_size = 1 * GiB;
>>      asc->compute_conf = aspeed_2500_sdmc_compute_conf;
>>      asc->write = aspeed_2500_sdmc_write;
>>      asc->valid_ram_sizes = aspeed_2500_ram_sizes;
>> @@ -485,7 +491,7 @@ static void aspeed_2600_sdmc_class_init(ObjectClass *klass, void *data)
>>      AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
>>  
>>      dc->desc = "ASPEED 2600 SDRAM Memory Controller";
>> -    asc->max_ram_size = 2048 << 20;
>> +    asc->max_ram_size = 2 * GiB;
>>      asc->compute_conf = aspeed_2600_sdmc_compute_conf;
>>      asc->write = aspeed_2600_sdmc_write;
>>      asc->valid_ram_sizes = aspeed_2600_ram_sizes;
>>
> 
> 

