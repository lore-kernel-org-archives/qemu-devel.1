Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC76C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EE620753
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3nrP+zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EE620753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvL4-0000Q7-Cn
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jDvIx-0004mz-Qc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jDvIw-0002kr-Il
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:21:39 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38691)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jDvIw-0002gg-BT; Mon, 16 Mar 2020 15:21:38 -0400
Received: by mail-pl1-x641.google.com with SMTP id w3so8450540plz.5;
 Mon, 16 Mar 2020 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4WTgQWykesiX5dxOOjMQMiBAenYPTdVVpfDS494TJyA=;
 b=h3nrP+zneNwfN9tYr/dKk61MvQl0f7j8GkgReD2jGutUD8sTIk2t/qaDxVwKcS41V0
 cEydwE6qrJe0H1rlKUTej8NTEt8gOZCj1rH9y63st/u+7FU3Oh7hpjodUlwSFVe5/bVh
 lTUaC7Dz5AD3rC7QL3jCJqt4xhh+2kW2PUgsvv4vp5Yy2MoHh3NIjWnvaKAtl7ZrVNI6
 7rw39TbOQJ9sHiBIvv8rXb/qQOYtxSvDd3k6+AoABt3lpzcj7Vgu+MpvciQVP83V5Trh
 sNlVOhp3RjcSmkeuwe9HP8mo6PkhXa2ToljHy8j9U0+U1+R+X6Vl7NXxcUjvIUpca+ql
 MwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4WTgQWykesiX5dxOOjMQMiBAenYPTdVVpfDS494TJyA=;
 b=nxGeFYrwGOdZ0oCsMeZrk0G00I7XEG1sAqZmK3b1CxdHPjzB8H/vK0PzAOyVxlNAUI
 Trdv2mn93azUE8ALzMxfZqh1yWXgquRdjUMI035JIfuV+DLRVV3ZRLj13u5KMlZIjMmS
 3TzqWQEYXpYazG2j0oQRo2pdUB85faFPzdUdgYySAlZ1InAfCruCuX1uOO0evV8oGJA9
 EMGWN4OxahlAIEuRZm4DfYhInPcvB3+w3aFTtN/sVk5YIJoRF+2A+JcX9WzTShGHBcB4
 RvOQGcCiLrgFehv4aCW56d/osHD998mPUhO4JSqWWxvp15lqtA3Nq+Vr8ki4X9wAICwm
 lFOw==
X-Gm-Message-State: ANhLgQ1izwWbqnJbf8IPR3BYQdJM6QBjszTlQinE4azX7F+tZIBk+wJq
 Zy9XxSOhDXKGI/fJGc34vx1vhTy7
X-Google-Smtp-Source: ADFU+vvph2Jo/zwkPEFMm6rnxVps0m4mgQIw1fksx0Wk52tk0z/YK8U5KuR85s04XWVfitQ4Qz72aQ==
X-Received: by 2002:a17:90a:218e:: with SMTP id
 q14mr1026338pjc.37.1584386496675; 
 Mon, 16 Mar 2020 12:21:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 n4sm284341pgc.11.2020.03.16.12.21.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 12:21:35 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/fsl-imx7: Instantiate apbh_dma and ocotp as
 unimplemented devices
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200313161506.8834-1-linux@roeck-us.net>
 <CAFEAcA-63OJfcnjE0V4W5a0R2tq_t0oRL7dre_WY_We0Jz9KoA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <2b2b9886-33fe-5b76-4789-a42d61caf6da@roeck-us.net>
Date: Mon, 16 Mar 2020 12:21:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-63OJfcnjE0V4W5a0R2tq_t0oRL7dre_WY_We0Jz9KoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 8:39 AM, Peter Maydell wrote:
> On Fri, 13 Mar 2020 at 16:15, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Instantiating apbh_dma and ocotp as unimplemented devices prevents crashes
>> when booting Linux.
>>
>> apbh_dma:
>>
>> [   14.046518] Unhandled fault: external abort on non-linefetch (0x808) at 0xd0852008
>> [   14.047287] pgd = (ptrval)
>> [   14.047607] [d0852008] *pgd=8b028811, *pte=33000653, *ppte=33000453
>> [   14.050074] Internal error: : 808 [#1] SMP ARM
>> ...
>> [   14.077029] [<c0856530>] (stmp_clear_poll_bit) from [<c0856580>] (stmp_reset_block+0x10/0xb8)
>> [   14.077642] [<c0856580>] (stmp_reset_block) from [<c1a9655c>] (mxs_dma_probe+0x1f4/0x370)
>> [   14.078158] [<c1a9655c>] (mxs_dma_probe) from [<c0b6a7e8>] (platform_drv_probe+0x48/0x98)
>> [   14.078641] [<c0b6a7e8>] (platform_drv_probe) from [<c0b685c4>] (really_probe+0x228/0x2d0)
>>
>> ocotp:
>>
>> [   71.286109] Unhandled fault: external abort on non-linefetch (0x008) at 0xd0ff0000
>> [   71.287891] pgd = (ptrval)
>> [   71.288449] [d0ff0000] *pgd=8b497811, *pte=30350653, *ppte=30350453
>> [   71.291389] Internal error: : 8 [#1] SMP ARM
>> [   71.292302] Modules linked in:
>> [   71.293583] CPU: 0 PID: 112 Comm: kworker/0:3 Not tainted 5.0.0-10153-g065b6c4c913d-dirty #2
>> [   71.294148] Hardware name: Freescale i.MX7 Dual (Device Tree)
>> [   71.296728] Workqueue: events deferred_probe_work_func
>> [   71.297740] PC is at imx_ocotp_read+0x68/0x180
>> [   71.298154] LR is at mark_held_locks+0x48/0x74
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  hw/arm/fsl-imx7.c         | 11 +++++++++++
>>  include/hw/arm/fsl-imx7.h |  6 ++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
>> index 119b281a50..a17136f83c 100644
>> --- a/hw/arm/fsl-imx7.c
>> +++ b/hw/arm/fsl-imx7.c
>> @@ -459,6 +459,17 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>>       */
>>      create_unimplemented_device("sdma", FSL_IMX7_SDMA_ADDR, FSL_IMX7_SDMA_SIZE);
>>
>> +    /*
>> +     * OCOTP
>> +     */
>> +    create_unimplemented_device("octop", FSL_IMX7_OCOTP_ADDR,
>> +                                FSL_IMX7_OCOTP_SIZE);
> 
> "octop" or "ocotp" ?
> 

Oops. Well, "octop" sounds way better, don't you think ?

Anyway, I later folded this patch into "hw/arm/fsl-imx7: Instantiate various
unimplemented devices" (https://patchwork.kernel.org/patch/11438371/) after
it turned out that ocotp alone was insufficient, and that apbh_dma had already
been added with another patch.

Thanks,
Guenter

