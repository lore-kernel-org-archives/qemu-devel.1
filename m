Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2EFC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF1321D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VceoQGOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF1321D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pRd-0008VN-3c
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8pQl-0007Qc-Ku
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8pQk-0001Ao-Jy
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:04:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30625
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8pQk-0001Ah-Fa
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583172278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrOu+vdhVHFpjxG/pfbjlHgkQTWYLKfEvDuxEWVBJxs=;
 b=VceoQGOHtFVQsrYFyE+Gu5oLDPhwzcGqULTvUuhUSf2Xg4KFQ8gGlbKU33sr4BvpM0Ecbd
 lPf5VOcFFTEwTs33HMc3Pf1FTN3K6CLw2mxJ3Wjhoty4jkYMxXEKBgvkC0cLwgow9Q52Me
 HIbBA1qtMbsZ1QM+2Bx4WKBYgEZlkMU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-rPeags_uPFS1VSBbyx6Rfg-1; Mon, 02 Mar 2020 13:04:36 -0500
X-MC-Unique: rPeags_uPFS1VSBbyx6Rfg-1
Received: by mail-wr1-f72.google.com with SMTP id p5so40178wrj.17
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HrOu+vdhVHFpjxG/pfbjlHgkQTWYLKfEvDuxEWVBJxs=;
 b=YEbuBeuHCin0PyWluwGisrqHg1pcCJM3V6cJxFYfJHamOP4fR6jGMjoI4GLHiKhOUv
 tBcXe+4E63vXWtGPsqDfGyxXj4lRBJnNJFQLCp5p9amhdi0bJOQwenDXz80VMYjQty5E
 7EqbT2qv0PqsRdlu06tRfW9aApFDmMBGcTMwA3p1KXMt6w57qlNM8PgoqbaNhKE0dcqN
 P/cH9GrxLRTZdUCBEijCZgQaOU3vzr8zBdudBH40YWfwCxOGXdfuzuBLIVyARw3xofnw
 t/pAwH1cwgSKTCa7fRxTFdYH30dAFWc6fufwMO44/0kBRrJum15NnEXp9gfFrR5OFs1y
 ylCg==
X-Gm-Message-State: ANhLgQ1na0Mqjn9hCPnrQaLqj2IO/LwZhMYgr276ya2RRtPRDUFJnnDn
 /du/vJ7TPqg7nKJCsLoNv3/UNR1C0OucgeBrH//mA3QDsonNrPM52yPB9Su+jyWiW55S/F0Ytmu
 LcZb8aXHj+LjDG3Q=
X-Received: by 2002:adf:e686:: with SMTP id r6mr788797wrm.41.1583172275039;
 Mon, 02 Mar 2020 10:04:35 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtYNnu8ikAFANVaUMFkYYyDWwH197VapolA2iwx5MOF9z7VXi49sWwwppxJmTpLJtc3YSL5yA==
X-Received: by 2002:adf:e686:: with SMTP id r6mr788776wrm.41.1583172274797;
 Mon, 02 Mar 2020 10:04:34 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id v8sm28684314wrw.2.2020.03.02.10.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 10:04:34 -0800 (PST)
Subject: Re: [PATCH v1 4/4] hw/arm/cubieboard: report error when using
 unsupported -bios argument
To: Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20200227220149.6845-1-nieklinnenbank@gmail.com>
 <20200227220149.6845-5-nieklinnenbank@gmail.com>
 <CAFEAcA94U=G7Bhiayt5YyJHFUMjyKwT1m5VNOH+1rV-NMysR7Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <52400d43-3890-68cb-0e63-35c3636be19a@redhat.com>
Date: Mon, 2 Mar 2020 19:04:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA94U=G7Bhiayt5YyJHFUMjyKwT1m5VNOH+1rV-NMysR7Q@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 4:44 PM, Peter Maydell wrote:
> On Thu, 27 Feb 2020 at 22:02, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>>
>> The Cubieboard machine does not support the -bios argument.
>> Report an error when -bios is used and exit immediately.
>>
>> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>> ---
>>   hw/arm/cubieboard.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
>> index 6c55d9056f..871b1beef4 100644
>> --- a/hw/arm/cubieboard.c
>> +++ b/hw/arm/cubieboard.c
>> @@ -19,6 +19,7 @@
>>   #include "exec/address-spaces.h"
>>   #include "qapi/error.h"
>>   #include "cpu.h"
>> +#include "sysemu/sysemu.h"
>>   #include "hw/sysbus.h"
>>   #include "hw/boards.h"
>>   #include "hw/arm/allwinner-a10.h"
>> @@ -33,6 +34,12 @@ static void cubieboard_init(MachineState *machine)
>>       AwA10State *a10;
>>       Error *err = NULL;
>>
>> +    /* BIOS is not supported by this board */
>> +    if (bios_name) {
>> +        error_report("BIOS not supported for this machine");
>> +        exit(1);
>> +    }
> 
> We don't usually bother to check this, but I guess there's
> no reason not to.

I agree this is confusing to expect the machine boot from a flash when 
using -bios and having to debug until figuring out the reason.

This -bios is a generic machine option, maybe we could move this check 
to the common machine code.

> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 


