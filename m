Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FCDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 16:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6AB223C7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 16:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7JuDLH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6AB223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRHnY-0007ap-Qh
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 12:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRHmS-00074D-9a
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 12:31:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRHmP-0006bs-3H
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 12:31:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id i1so7446759wro.1
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1VCDzKo6H+iv98OOiwsju5sUnsCpI2InauTA5DZcxSw=;
 b=e7JuDLH1WWOZTYUyupeZwbEtqyS6h8zVR1b9TlrECq9IgS1bKB3++AOhYI/cyP6zHU
 eOxsoVRfZNygFXvtjf4p6ZmeXbwIoLEQZpTJQIDxJ0pL8JBMee2p/vd/VoeVxeAuqZwI
 xzJgrnbLT4XSOwmuL0IHH3GUmb3eoBZF7cHXkpuLOGHv1se5LvrbLJPP01lFx8vKoyFd
 g0dRn4ngRoYQdmP7h3kXhUKN7v93Ocxsg8/GuV0Vp9j0I47Nu2GT5OASDVo9faCSq2Od
 56vZ7hktKbXPxdNACVXAgi8em6Hx9FGgC2x8Q2GE2j8e4HPJGFZoU9Kz1ZoMtrnpPagw
 8Otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1VCDzKo6H+iv98OOiwsju5sUnsCpI2InauTA5DZcxSw=;
 b=d65Vyvrb+vFLO1fSkDBmivMhBrrzCU832ZTDfsJhB3VVbuJwBDFDweXvkjjxgBBWPv
 WxUlJrJTuDmtYwzQeYIxfnnbHWLy+eisl9Kcidzlunf2gq2hNCFGSb39HebSyXGWwK1L
 rWiyc14ChuY7N2G2NqC7UiADuai/nfwbiRfIgmcNNJYK9q8lrR0lvBOrM+kEsxOsmDHS
 ZVPuApuXP+Hp2yXGskIVtu2zQDIJH3IP/c6hng8tiIS7mZtce7+t0l8Rih573Fk9H7lZ
 3Txh79MENs76V0/09dfOH0A0uWtst7bVEV8+kQ5nOCztDDhDCLgqQsbJF9XiJbVeE9Av
 pVwA==
X-Gm-Message-State: AOAM530QrDSv2St/FhKE0za6QCoGyxNhHj0VCmcFKL2u/QDrXD8gol40
 ITEl1h3XEedSnxU4CiM0Uo8=
X-Google-Smtp-Source: ABdhPJyoZ69O63DFFzXPH0DrG4bJPFcRdBqv1kM0NgfgZ5aG/4xJoWgznEfdD7ZIPtzMIBFGtuDOjQ==
X-Received: by 2002:adf:e445:: with SMTP id t5mr19953294wrm.387.1602347491163; 
 Sat, 10 Oct 2020 09:31:31 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p21sm16725513wmc.28.2020.10.10.09.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 09:31:30 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] util/cutils: Introduce freq_to_str() to display
 Hertz units
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20201001164322.1585392-1-f4bug@amsat.org>
 <20201001164322.1585392-2-f4bug@amsat.org>
 <20201001184238.GI3717385@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2d771247-fda7-80e9-6603-e7bd940c37ba@amsat.org>
Date: Sat, 10 Oct 2020 18:31:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001184238.GI3717385@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.207,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>, qemu-devel@nongnu.org,
 Tyrone Ting <kfting@nuvoton.com>, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc@lmichel.fr>,
 Damien Hedde <damien.hedde@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 8:42 PM, Eduardo Habkost wrote:
> On Thu, Oct 01, 2020 at 06:43:20PM +0200, Philippe Mathieu-Daudé wrote:
>> Introduce freq_to_str() to convert frequency values in human
>> friendly units using the SI units for Hertz.
>>
>> Suggested-by: Luc Michel <luc@lmichel.fr>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   include/qemu/cutils.h | 12 ++++++++++++
>>   util/cutils.c         | 14 ++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
>> index 3a86ec0321..4bbf4834ea 100644
>> --- a/include/qemu/cutils.h
>> +++ b/include/qemu/cutils.h
>> @@ -158,6 +158,18 @@ int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result);
>>   
>>   char *size_to_str(uint64_t val);
>>   
>> +/**
>> + * freq_to_str:
>> + * @freq_hz: frequency to stringify
>> + *
>> + * Return human readable string for frequency @freq_hz.
>> + * Use SI units like KHz, MHz, and so forth.
>> + *
>> + * The caller is responsible for releasing the value returned
>> + * with g_free() after use.
>> + */
>> +char *freq_to_str(uint64_t freq_hz);
>> +
>>   /* used to print char* safely */
>>   #define STR_OR_NULL(str) ((str) ? (str) : "null")
>>   
>> diff --git a/util/cutils.c b/util/cutils.c
>> index 8da34e04b0..be4e43a9ef 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -885,6 +885,20 @@ char *size_to_str(uint64_t val)
>>       return g_strdup_printf("%0.3g %sB", (double)val / div, suffixes[i]);
>>   }
>>   
>> +char *freq_to_str(uint64_t freq_hz)
>> +{
>> +    static const char *const suffixes[] = { "", "K", "M", "G", "T", "P", "E" };
>> +    double freq = freq_hz;
>> +    size_t idx = 0;
>> +
>> +    while (freq >= 1000.0 && idx < ARRAY_SIZE(suffixes)) {
>> +        freq /= 1000.0;
>> +        idx++;
>> +    }
>> +
>> +    return g_strdup_printf("%0.3g %sHz", freq, suffixes[idx]);
> 
> The only thing protecting this from out of bounds array access is
> the fact that UINT64_MAX is smaller than 1000E.  I wonder if this
> causes a Coverity warning.

Aren't we protected by the "idx < ARRAY_SIZE(suffixes)" check?

> 
>> +}
>> +
>>   int qemu_pstrcmp0(const char **str1, const char **str2)
>>   {
>>       return g_strcmp0(*str1, *str2);
>> -- 
>> 2.26.2
>>
> 

