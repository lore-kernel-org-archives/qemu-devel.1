Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E06C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486172074B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkngv2an"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486172074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMt42-00087H-4W
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMspE-0006zn-Cx
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:04:21 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:45973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMspC-0000lu-M6
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:04:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id x14so1211680wrl.12
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=azywYKJg1gc+g50ZaujWHfaIKkNM7KpMNPVP8nr81C0=;
 b=Mkngv2anMomUTcstKlDMoPZywZH7kCsV6lVbgY83zKYWNXHZ9Xi7z76jJ0TdnHBJKE
 prp9U434fMWgNMthVizQc9Psayw47NoSzVu6dEquvASarrPDT29m8ibMO709qjLSKWch
 kfPUAK5vXKyoaE6Nninwes8llHSf5+h3a5aE6uwKg6cmd/hhhgnTupW6cXxCqfvbZg/Z
 qvWr1sa3+tZ5pIooD50O1NYgHWWT5QWutGyEc/j6fltVoWdRTnJiLUanFS9zQxi2CmHE
 hnbG809uN1sbFOODn9Jh2BKb1xSFfokIMKNTnbmw7yu3bYxKaH3kGVGrGxo5F2FBkWXK
 j2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=azywYKJg1gc+g50ZaujWHfaIKkNM7KpMNPVP8nr81C0=;
 b=Rktq7CzhwkotOWlL/MAi/xyU8MfeeaVwTWdl23+ye2j1sGb/EEpKMZ35dMeBycKEVo
 qfqi4rO9XNdOPe2mABDqMKC3JcMawjyVtJAurC6ha42ujCN4aPMjZ/R7T2E0In9ghkiw
 B2O2Zlb/A3KEIxoCyWqKyOyaTkVcaMIGalnvZ+gUSUl0b17/u1est3/Uq+u8bh5VwrcX
 Zr0nresRJpAT3ltXrBS1ZxgnB7tWkMu0aj8wRpTELFShbU5ifpJPZz80yItC4mEZNdH6
 GSfQTDmFRWrbCViqDyGESeebLHQUsFvHtd0pcI1wlKLWKPdGbKUIvUbXi4WlYon6QL+v
 qEQg==
X-Gm-Message-State: AOAM5324/+avOu3EWEP6Is75Y1Az4p7UFGWHREBIFuf9m8viD2CMCwZb
 2dHCosMskdSUa8Ihx980pu0=
X-Google-Smtp-Source: ABdhPJx+csGb8Lh2Zwyyx/iLJ4T1Lc8sRJyA4z90/57qEkb2jLmR0JQJ50xxE9StJ8Uq6/CjLgYdXQ==
X-Received: by 2002:adf:9b8b:: with SMTP id d11mr1728575wrc.71.1601298252368; 
 Mon, 28 Sep 2020 06:04:12 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id a13sm1077957wme.26.2020.09.28.06.04.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 06:04:11 -0700 (PDT)
Subject: Re: [PATCH 1/3] util/cutils: Introduce freq_to_str() to display Hertz
 units
To: Luc Michel <luc@lmichel.fr>
References: <20200927090820.61859-1-f4bug@amsat.org>
 <20200927090820.61859-2-f4bug@amsat.org>
 <20200928075035.7faf4ccxvtfpira6@sekoia-pc.home.lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7ace89ec-f0d4-bb6b-a801-9d4fad863ca3@amsat.org>
Date: Mon, 28 Sep 2020 15:04:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200928075035.7faf4ccxvtfpira6@sekoia-pc.home.lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 9:50 AM, Luc Michel wrote:
> Hi Philippe,
> 
> On 11:08 Sun 27 Sep     , Philippe Mathieu-Daudé wrote:
>> Introduce freq_to_str() to convert frequency values in human
>> friendly units using the SI units for Hertz.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/qemu/cutils.h | 12 ++++++++++++
>>  util/cutils.c         | 10 ++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
>> index eb59852dfdf..0186c846e9c 100644
>> --- a/include/qemu/cutils.h
>> +++ b/include/qemu/cutils.h
>> @@ -158,6 +158,18 @@ int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result);
>>  
>>  char *size_to_str(uint64_t val);
>>  
>> +/**
>> + * freq_to_str:
>> + * @freq_hz: frequency to stringify
>> + *
>> + * Return human readable string for frequency @freq_hz.
>> + * Use SI units like KHz, MHz, and so forth.
>> + *
>> + * The caller is responsible for releasing the value returned with g_free()
>> + * after use.
>> + */
>> +char *freq_to_str(uint64_t freq_hz);
>> +
>>  /* used to print char* safely */
>>  #define STR_OR_NULL(str) ((str) ? (str) : "null")
>>  
>> diff --git a/util/cutils.c b/util/cutils.c
>> index 36ce712271f..dab837fd8b8 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -885,6 +885,16 @@ char *size_to_str(uint64_t val)
>>      return g_strdup_printf("%0.3g %sB", (double)val / div, suffixes[i]);
>>  }
>>  
>> +char *freq_to_str(uint64_t freq_hz)
>> +{
>> +    static const char *suffixes[] = { "", "K", "M", "G", "T", "P", "E" };
>> +    unsigned unit_index = log10(freq_hz) / 3;
>> +
>> +    return g_strdup_printf("%0.3g %sHz",
>> +                           freq_hz / pow(10.0, unit_index * 3.0),
>> +                           suffixes[unit_index]);
> 
> You could end up going out of your 'suffixes' array if freq_hz is very
> high.

Oh, good point.

> Also, to avoid the complexity of log10/pow, maybe something like:
> 
>     double freq = freq_hz;
>     size_t idx = 0;
> 
>     while (freq >= 1000.0 && idx < ARRAY_LENGTH(suffixes)) {
>         freq /= 1000.0;
>         idx++;
>     }

KISS, I like it :)

> 
>     return g_strdup_printf("%0.3g %sHz", freq, suffixes[idx]);
> 
> is enough?
> 

I'll respin, thanks!

Phil.

