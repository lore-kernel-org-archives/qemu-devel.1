Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F53C43218
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 18:44:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6100420820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 18:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0jJM/Zh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6100420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48900 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haPHF-0006qi-Mu
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 14:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43658)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1haPFz-0005zs-Iu
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 14:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1haPDF-0007QF-74
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 14:40:10 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1haPDE-0007OG-VA
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 14:40:09 -0400
Received: by mail-pg1-x541.google.com with SMTP id s27so5498204pgl.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x302XDK82B+4hwZDzLu0wtz7XgG5rL/XX5wh3BskLBE=;
 b=N0jJM/ZhJa1HfvzKP7dCdi0dvU2KpfHPznfVGt1L3AViJCOLtbUkFTHhTo78o51JQ/
 0C3W+J4mha+2EGJUNdwyfZvC98C2yE7et/lYMh9NLEqys9iziSdrbzhkmlpsxvfPetSd
 vIiC3i8WwomthpIElvBQymEDiJxmoZndAdcDeEUGCU1KsyX/lwA5dceDPgUUX46j7yY3
 mhdKFK4P9r0LOfVRj9sFLcGVhab0lClhRozjQYHK8B2TpsMcbNK69LSvzuKZ1WthO1sK
 2Rpp0mIQigQx6Lj8d7O+cN4JTh/UnaI0NwHkp3qgiwNUDGfel2fT2lMvRBIclQY4ea/5
 xELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x302XDK82B+4hwZDzLu0wtz7XgG5rL/XX5wh3BskLBE=;
 b=jbC7oHtKqyHq06X5iDfZBNBqsHV+i0E6Xye3rP60pkOwnQ/pvm5S9jpGbPPq3peLW/
 6o4EnhG7ahKlOfflX1Am6RS2F0PHEZAs2o7HT7vFbifqMdd8b8/rlR1dLXh7RxoXtPw0
 11anawsagzq17YW+fiM2jzhwIvk/8Dd4+9HrZzwruo6NJLksmpXY23qUuoOx8s2nt8rD
 CmLZ5aolG1luwcwLl3SuOu2xDx9F331kSqIIlX67OigJ6UWIor9Iag7fAQZUxkQLHuzt
 6DFowSMnZjKhiaFZ/4t9mRQ3cQ6ui7//sBihnSn3yJCzD5bP55bUMIEU5hgtu6oNaHJi
 kDFw==
X-Gm-Message-State: APjAAAWf/RUyJUbAhboyeWY0wiGOQjujqlQbKsT8NwG/Sm65bvZqbkWv
 kyL3Uv7SWgcnihCeZH5d7ZCcxshoH4I=
X-Google-Smtp-Source: APXvYqxJ+cWyE0MJh8Rojpk8wJDlnbZktJb6OzB+oiccBh2KPjH7l1MuBTOcUKjASFUDCuZtL+8qdw==
X-Received: by 2002:a17:90a:8c82:: with SMTP id
 b2mr22249152pjo.97.1560192006378; 
 Mon, 10 Jun 2019 11:40:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 a192sm665715pfa.84.2019.06.10.11.40.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 11:40:05 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-29-peter.maydell@linaro.org>
 <da80c3ea-5a33-e7e0-209e-89a8413c8f06@linaro.org>
 <CAFEAcA8etr7_rmQsQcUY+cPHZEZna-An+r5TPJtMb4OQO-6Dsg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b9ac8354-6bb2-0080-f597-706b4b94009d@linaro.org>
Date: Mon, 10 Jun 2019 11:40:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8etr7_rmQsQcUY+cPHZEZna-An+r5TPJtMb4OQO-6Dsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 28/42] target/arm: Convert VMOV (imm) to
 decodetree
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/19 10:12 AM, Peter Maydell wrote:
> On Sat, 8 Jun 2019 at 20:29, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 6/6/19 12:45 PM, Peter Maydell wrote:
>>> +    n = (a->imm4h << 28) & 0x80000000;
>>> +    i = ((a->imm4h << 4) & 0x70) | a->imm4l;
>>> +    if (i & 0x40) {
>>> +        i |= 0x780;
>>> +    } else {
>>> +        i |= 0x800;
>>> +    }
>>> +    n |= i << 19;
>>
>> Can we reuse vfp_expand_imm here?  Given that you don't have pure code motion
>> from the old code (due to field extraction) it doesn't feel wrong to go ahead
>> and fix this wart now.
> 
> I dunno, I'd kind of prefer to do it later. We're already
> drifting away from the old code as you say, and going
> straight to vfp_expand_imm() makes it even less clear that
> we're doing the same thing the old code was...

Fair enough.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

