Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D661C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 20:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D435B208C4
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 20:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgbaHLgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D435B208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilJ3A-0007RN-0O
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 15:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilJ2U-0006vv-Tv
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 15:50:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilJ2T-0006bb-Tc
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 15:50:22 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:50332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilJ2T-0006VY-Mg
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 15:50:21 -0500
Received: by mail-pj1-x102e.google.com with SMTP id r67so6224792pjb.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 12:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=+93YvV+eq/AqU2LErNGAAJdaJ5YIZQTq8Wk7bqKMP9w=;
 b=EgbaHLgjD/R27poOWarJ5poxifk0VsrWpBsTw/tZde5RAEAl0hAkS0tykj8kDuyDxM
 beH1N93iCGOv85HrxgJLJN3RURzhN59NB8oOtRucad9s9VO8ZLjF2HLQfWe5lpO4+dKq
 zLQl2tyw2YoMn0F+Q5PZ7Xzq2IWP+rfKJ6Ugdl1QdYejXKa9c1Du3HaBhr0fWWNF2skf
 n46Vm9nrRJa6Ym+noe1bGjJ5KfEHOdoJY1V5bh/0tsqDYEmHzo0gxT/HDNo96v0QOxsH
 d830VBPLg/md/QpnaXUsWRyT3j9rYmoEigwYVnRG3qKzkQJPbgVjMlHIX6pxTGkd7Vud
 5vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+93YvV+eq/AqU2LErNGAAJdaJ5YIZQTq8Wk7bqKMP9w=;
 b=ldrh/ro4OQyEDEsiDwj91JUEGBVh7+I/jlsfiz1E41IGq3KaHLPkKs5JgzRMDcL/lL
 F2Go+tqP8cePM/+XoisxlxOVduCj2wrPCHvr0Bcs0hkOw2ifVDLn77Ijc1qM+St14Xqw
 M30SMsNjx0OufESc6tZUagTKKtOcwe+oFAD+B8nhlBIPhZuwB12EwCbu6Z7y5At0XZrE
 5jXZwGTNVh3wXoS/GQekH0YGHfYLcq+oqD9LgVvGYSAA57/5wkZZuL+i6jdNVwA9PbOX
 gb2xZZMlATPL6jTFr2IM6+om2RIQTE4RCKG+Vb18O/eYto+p6TypRwQopCdlKXsUvbvv
 bbkQ==
X-Gm-Message-State: APjAAAU6X3Mz+D4okKjOg2p4iD/pqJ/rhjmf1IJ05B4J09uN7aUI0Ud4
 ZQUvlz7jKMawKxRp8IsfLt9g8KUocphC5Q==
X-Google-Smtp-Source: APXvYqwIfTWrjQmSyCPvlDpOlLTVASURGvF2xBLyhuRvH4gjaBhSwEJQ7apFtODgv6FsbbcmonfiLQ==
X-Received: by 2002:a17:90a:1785:: with SMTP id
 q5mr35322403pja.143.1577566220073; 
 Sat, 28 Dec 2019 12:50:20 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id hg11sm18680332pjb.14.2019.12.28.12.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 12:50:19 -0800 (PST)
Subject: Re: [PATCH v2 04/28] cputlb: Move body of cpu_ldst_template.h out of
 line
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-5-richard.henderson@linaro.org>
 <87k16qc09g.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e74e91e5-2690-3a23-4d12-aa34c8609988@linaro.org>
Date: Sun, 29 Dec 2019 07:50:14 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87k16qc09g.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/21/19 5:36 AM, Alex Bennée wrote:
>> -#if !defined(SOFTMMU_CODE_ACCESS)
>> -#include "trace-root.h"
>> -#endif
>> -
>> -#include "qemu/plugin.h"
>> -#include "trace/mem.h"
> 
> I think api.c needs to include trace/mem.h

Yep, thanks.  I'll enable travis for my local branches for next time, which I
believe would have caught this.


r~

