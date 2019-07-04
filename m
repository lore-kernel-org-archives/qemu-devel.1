Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51626C06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264162189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264162189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiyy4-0007PE-GX
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 06:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45268)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiywA-0005Cf-Nr
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiyw8-0008M9-3o
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:25:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiyw2-00080F-CH
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:25:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id a10so4933770wrp.9
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 03:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l6C3bU41/+4wwctuitgFpVuvKZkrCFZ89RMBKzl4UD4=;
 b=e/GcCduWSdn6+vcjgKj5GLUfMyoGuQvRnCPNSOBnoeJVqsL6kJAuoqzlzVpMm4UyRb
 Ch1oj0DsA6nqZbNlZkcpPoHZkTGMFMW4xsSs5nqmwXHbvqmYceAUuslQ3FKBJBq1tWsd
 HVB7c+t4a3zW/rtv28gm9BiHn5WOKCaYGaM7vESOxycttqXSGpwBmqqEkCwapAy9hchV
 aO+SY7f3exJcSDMNDRCGJP3tLPD58xNUbdG0dt9uyVfLx4rC9/4MCU38hqktlKrzpXvj
 FxJQdJgrruGv7JourUTV3FYJal1Fl9fqBPJxKKUZlEbwIDj1ogwRiXviaJ32oR6O5ZPE
 mnpw==
X-Gm-Message-State: APjAAAVDgbImOzVxdNuSpXg1L0IO8JdfgJYNObKcWaAY7eogia4rhheW
 vdYYj5/x6K2f32iIG1kyx+R9mGnUF88=
X-Google-Smtp-Source: APXvYqwPbZ4LIBTWKg+W0MaiPCBQFI7pHaZP1LeEO1emcA1NJbhb9EJ6JS7MxzXNtM6Pgd/I4xLAeQ==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr23703124wru.311.1562235924365; 
 Thu, 04 Jul 2019 03:25:24 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id t14sm3953225wrr.33.2019.07.04.03.25.23
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 03:25:23 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20190703155244.28166-1-alex.bennee@linaro.org>
 <20190703155244.28166-2-alex.bennee@linaro.org>
 <927219a5-a56d-bbbe-26ed-ffb8be12f006@linaro.org>
 <87ef36w14t.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e7dcd75f-8897-1939-caf6-c879371a2f84@redhat.com>
Date: Thu, 4 Jul 2019 12:25:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87ef36w14t.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v1 1/4] target/arm: handle M-profile
 semihosting at translate time
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/4/19 12:21 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 7/3/19 5:52 PM, Alex Bennée wrote:
>>> +static inline void gen_thumb_bkpt(DisasContext *s, int imm8)
>>> +{
>>> +    if (arm_dc_feature(s, ARM_FEATURE_M) &&
>>> +        semihosting_enabled() &&
>>> +#ifndef CONFIG_USER_ONLY
>>> +        s->current_el != 0 &&
>>> +#endif
>>> +        (imm8 == 0xab)) {
>>
>> Extra parenthesis.
> 
> The wrapping on imm8 == 0xab? Do you want that cleaned up on the other
> patches as well?

I understood this comment for "(s->current_el != 0) &&"

