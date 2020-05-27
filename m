Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4618C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E672073B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAic9lNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E672073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdqaO-0005Ch-MK
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 03:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdqZp-0004eV-DV; Wed, 27 May 2020 03:34:13 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdqZo-00008g-Io; Wed, 27 May 2020 03:34:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id r9so2058751wmh.2;
 Wed, 27 May 2020 00:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HayDOPIbH9zCrw7A7S1WZCdFRGhQuFsovnn0qGB3c+s=;
 b=SAic9lNaD0N7YWyr01oEM2vI6GpGL6XI3eVSzbL94DdTo8h8sktnIlTZdrmbrxHaKv
 ET/SRmOLAD/GVLDp0dmognrhBtzr6FsjpKCYoUXSk1ydYd/ggJTDBAPdOdyPH4TFmQ7R
 GzSzPRv7fvZ3uXDKTaxm7vykH+lhNJzI8KF1huQTXDpb5WqeORQk3w2pZX3DKAbDcmtC
 HB3bYZoEi6VgETOo+dQXjGxg5cRQwawL9KRszQcMmNfO17yVS8MdOlS5tT/W8WOnscqB
 IpUbKgEU/UUfITb+XaXb8zWKZKj8Ff1Byse3R0gREyBfJtgxt7leEQOisS20C8d1WF1q
 c3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HayDOPIbH9zCrw7A7S1WZCdFRGhQuFsovnn0qGB3c+s=;
 b=llk4SzD+vCFx8P8bKhPhTBCUlFnc3opNb5oXeRvauYFbk81zLM2FAOLvxMXAX/rlCL
 iOTFMxqwT0wwU80/a28+lfzOEnQPqwSyMJ4nFcm8CQxDsPz/pxNYVgi1rVgwkOvH/kaD
 p0Bj3z1vbVKCGqtLa9pwBRExbyzGRhvWP5qSoJa9T4nZqvwzZAQRntwpkMgGggDdao9U
 gKyiahxUr3m8lV5DSjukR48FGLcbxlvdaBUgbulBJUjq4G0ll3AOEjRF6PgcnNlx+/m6
 vi+BILPtdwQa2Fv05/GDw+BXu88Fn4jPXdoX9Y78FHM9HC9x8XGStubxXDMy58BpL3Ih
 L2Tg==
X-Gm-Message-State: AOAM533YTfxlzNs9KSmOQrC5wcCEDvYaGHwfsX4rnXVgtYPfqwNVHhb2
 6dxWa1Q746JGnYJi8k/7Lwh6Iv26
X-Google-Smtp-Source: ABdhPJz58Hi5rlQF/dH17u+V4ZAWsEawI9zI4v2/C0X23Aw9SkZk9A0bOCb23lTBKdGkxIKTaxVfzQ==
X-Received: by 2002:a1c:b7d5:: with SMTP id h204mr3126162wmf.39.1590564850174; 
 Wed, 27 May 2020 00:34:10 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id l17sm1877446wmi.3.2020.05.27.00.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 00:34:09 -0700 (PDT)
Subject: Re: [PATCH] hw/registerfields: Prefix local variables with underscore
 in macros
To: Alistair Francis <alistair23@gmail.com>
References: <20200510203457.10546-1-f4bug@amsat.org>
 <7bdb49c1-5396-0bf4-5f83-3849910e5d68@amsat.org>
 <CAKmqyKOXjNTgUtvwBnm-=fY-i8zX=k23TkoWSM=3WuWAHioXAQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <23ff7662-6dd9-1bee-6004-c89aaa7308dd@amsat.org>
Date: Wed, 27 May 2020 09:34:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOXjNTgUtvwBnm-=fY-i8zX=k23TkoWSM=3WuWAHioXAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On 5/27/20 12:49 AM, Alistair Francis wrote:
> On Tue, May 26, 2020 at 9:50 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> ping?
> 
> I'll send a PR with this.

Well, this was only a "friendly ping", there is no hurry, I can wait for
the next qemu-trivial pull request.

Thanks!

Phil.

> 
> Alistair
> 
>>
>> On 5/10/20 10:34 PM, Philippe Mathieu-Daudé wrote:
>>> One can name a local variable holding a value as 'v', but it
>>> currently clashes with the registerfields macros. To save others
>>> to debug the same mistake, prefix the macro's local variables
>>> with an underscore.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  include/hw/registerfields.h | 40 ++++++++++++++++++-------------------
>>>  1 file changed, 20 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
>>> index 0407edb7ec..93fa4a84c2 100644
>>> --- a/include/hw/registerfields.h
>>> +++ b/include/hw/registerfields.h
>>> @@ -66,35 +66,35 @@
>>>  #define FIELD_DP8(storage, reg, field, val) ({                            \
>>>      struct {                                                              \
>>>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
>>> -    } v = { .v = val };                                                   \
>>> -    uint8_t d;                                                            \
>>> -    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
>>> -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
>>> -    d; })
>>> +    } _v = { .v = val };                                                  \
>>> +    uint8_t _d;                                                           \
>>> +    _d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
>>> +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
>>> +    _d; })
>>>  #define FIELD_DP16(storage, reg, field, val) ({                           \
>>>      struct {                                                              \
>>>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
>>> -    } v = { .v = val };                                                   \
>>> -    uint16_t d;                                                           \
>>> -    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
>>> -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
>>> -    d; })
>>> +    } _v = { .v = val };                                                  \
>>> +    uint16_t _d;                                                          \
>>> +    _d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
>>> +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
>>> +    _d; })
>>>  #define FIELD_DP32(storage, reg, field, val) ({                           \
>>>      struct {                                                              \
>>>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
>>> -    } v = { .v = val };                                                   \
>>> -    uint32_t d;                                                           \
>>> -    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
>>> -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
>>> -    d; })
>>> +    } _v = { .v = val };                                                  \
>>> +    uint32_t _d;                                                          \
>>> +    _d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
>>> +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
>>> +    _d; })
>>>  #define FIELD_DP64(storage, reg, field, val) ({                           \
>>>      struct {                                                              \
>>>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
>>> -    } v = { .v = val };                                                   \
>>> -    uint64_t d;                                                           \
>>> -    d = deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
>>> -                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
>>> -    d; })
>>> +    } _v = { .v = val };                                                  \
>>> +    uint64_t _d;                                                          \
>>> +    _d = deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
>>> +                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
>>> +    _d; })
>>>
>>>  /* Deposit a field to array of registers.  */
>>>  #define ARRAY_FIELD_DP32(regs, reg, field, val)                           \
>>>
>>
> 

