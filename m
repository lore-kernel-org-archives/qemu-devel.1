Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD594C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F3F218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSRFguwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F3F218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihefY-0008SL-Rc
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iheb5-0006sv-0o
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:03:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iheb3-0002uC-H7
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:02:58 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iheb3-0002p3-7S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:02:57 -0500
Received: by mail-pf1-x441.google.com with SMTP id z16so1738654pfk.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 11:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FJ/NneotDbdMSFVuPbzyvFrv1Tr9LGEV2bZJOOTXNiI=;
 b=aSRFguwBr1Ow/cSRojBnPFp9j4Jjn4JrETCIGaY3le2iOWCL8LWt4C5pIzckBxGWwP
 cSgjyZZ85mBSGuKUIL4FmyRVYl8lVCcIK8EgkXJptukhtHLoi9Ug9xDXGpTzhk02SHZ2
 L8diBObziQOTXjXaTlYgF4azVzHJbLVWcHoKlBUE+xVE380B2OVH8M37zYFLGvEEqOsr
 LDiIbX5ShJBaN/4T7fPey1cCiitsa/9YFRlOQzt+vzKXsYYIKNt1coBlu3/kKTowrfFz
 MtrQZmZSsTNJi1fND7UOvmRn0CEcWHqBrW5DW2v74aQcrzeqRVaDVAQW0lQnGYkjGQGl
 kj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FJ/NneotDbdMSFVuPbzyvFrv1Tr9LGEV2bZJOOTXNiI=;
 b=i71yrWQayC7btyPCrUrx2hTYCBkNCO2gTvlWqU21Q3nyhRCMVmRGjlJfqJCG4/yIJ/
 l39ki+dsUcARBvBLgNBJ1fHGt2ed6auE6xSwOLDD9Sr1/z1rdlwT/7zhW9Yx80ZOHNKg
 GL93e/qMYy6w4KXKUXjzNaVEk7a1OkfkbAL/iUEZzl0Psr3SYJV5/MZnmkcDfOAHK/4K
 xj+TnYxb72zEofr8ArkIq+5NbQ43bJygwfKs0QymmuX8DTb7Z7qTnQunA4Br5W1DThbg
 qocTOuC3KfnqNHtjhXZxDK74m2EVZ3mcx/3m6VYo+bLoWi0erESHyhKeqpGWaJMzPjQW
 Y6Kw==
X-Gm-Message-State: APjAAAUOH4vvEyxCYP63eJ7kj/+CTGqWEBj1YWiEyuCLojLYeYghrTZ8
 4Ruq2Axzo8XaV1mv4DWN+jbjPA==
X-Google-Smtp-Source: APXvYqzcwxyXLPKp2/mLkUCoJF2oLqyfnkpCDx71XG7uQXmtyWau8qNYkclOYWq3+iv/jyRgyDE/Dg==
X-Received: by 2002:a63:604:: with SMTP id 4mr4877617pgg.406.1576695775769;
 Wed, 18 Dec 2019 11:02:55 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id b22sm4393194pfd.63.2019.12.18.11.02.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 11:02:55 -0800 (PST)
Subject: Re: [PATCH 5/6] hw/scsi/megasas: Silent GCC9 duplicated-cond warning
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-6-philmd@redhat.com>
 <b29f856a-5199-6f62-4aee-5a2cfc9f05a3@linaro.org>
 <71c58178-6bd5-bbb9-5691-77bdae7d2788@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9f861e54-946e-df71-fb8c-458399ac17bb@linaro.org>
Date: Wed, 18 Dec 2019 09:02:51 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <71c58178-6bd5-bbb9-5691-77bdae7d2788@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 Hannes Reinecke <hare@suse.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 7:52 AM, Philippe Mathieu-Daudé wrote:
>>> -    if (s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
>>> +    if (MEGASAS_MAX_SGE > 128
>>> +        && s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
>>>           s->fw_sge = MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE;
>>>       } else if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE) {
>>>           s->fw_sge = 128 - MFI_PASS_FRAME_SIZE;
>>>
>>
>> I'm not keen on this.  It looks to me like the raw 128 case should be removed
>> -- surely that's the point of the symbolic constant.  But I'll defer if a
>> maintainer disagrees.
> 
> Is that approach acceptable?
> 
> -- >8 --
> @@ -54,6 +54,9 @@
>  #define MEGASAS_FLAG_USE_QUEUE64   1
>  #define MEGASAS_MASK_USE_QUEUE64   (1 << MEGASAS_FLAG_USE_QUEUE64)
> 
> +QEMU_BUILD_BUG_MSG(MEGASAS_MAX_SGE > 128,
> +                   "Firmware limit too big for this device model");
> +
>  static const char *mfi_frame_desc[] = {
>      "MFI init", "LD Read", "LD Write", "LD SCSI", "PD SCSI",
>      "MFI Doorbell", "MFI Abort", "MFI SMP", "MFI Stop"};
> @@ -2382,9 +2385,7 @@ static void megasas_scsi_realize(PCIDevice *dev, Error
> **errp)
>      if (!s->hba_serial) {
>          s->hba_serial = g_strdup(MEGASAS_HBA_SERIAL);
>      }
> -    if (s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
> -        s->fw_sge = MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE;
> -    } else if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE) {
> +    if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE) {
>          s->fw_sge = 128 - MFI_PASS_FRAME_SIZE;
>      } else {
>          s->fw_sge = 64 - MFI_PASS_FRAME_SIZE;

Eh.  I suppose.  But what's the point of leaving the hard-coded 128?  There's
certainly something I'm missing here...


r~

