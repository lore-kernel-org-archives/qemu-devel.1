Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F5AC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 06:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70AE206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 06:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZAtnSmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70AE206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRrEL-0006VG-MA
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 02:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRrDW-0005oC-Tc; Mon, 12 Oct 2020 02:21:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRrDP-0007tS-91; Mon, 12 Oct 2020 02:21:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id n15so17737266wrq.2;
 Sun, 11 Oct 2020 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=y/QE6Pv4AHbGqY9PnA6BLzD6fLU3S84SQne3LzqQnLI=;
 b=YZAtnSmNVe6gCz+tDggSBPKs2OW+tSp2SN6wUMZhrJ/8rEIAjiFsHGoNwDqqIMmkM4
 QGV0h6HjbDaXoeTfGybOEjmoHy51fCW2EdrS9+HgdRBSfa/gxH0aR23asGkUSPCM2tS+
 PZjzG5q2tMfrdmpuZlmrx1fWan0Akh6TG7rRRyPE08dB2hnia2CImNDLCplJJNNYdjbB
 lXWCxzd2Tg9afL9uYsQ2rqp/oOhLrNGkt9gYxVlzuQdzegebGFP1BnvmJdHmK5DB35CW
 1EA6elyYlA0rboSeraNS6pfweHRcKG3nxQskGag5IJzsJfihhLhnrZOlbPlFziXXR3oQ
 zJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y/QE6Pv4AHbGqY9PnA6BLzD6fLU3S84SQne3LzqQnLI=;
 b=lOZdMGeoay0EwEsT/feMKRiZAw/y38tgO8HRB9ZA7UA+7vbSKgBuLoSAaA0fiVM06+
 dq0EHpke389nDjTYV6wCV01YTeEnBk5owFgL7uoM6U8jdM2SsQYDGRFmsKBdOfxhs7Tv
 /yw+nS6fmbAYxjwBAenrRoPEq22N2nh4n0kc1/0juZj1d/toP3HWf+zjg41qRVJJhLxa
 +H/RDnY1We60KLy06GgpAGQOEUH8s3vfTpJJVwBOYFP8RNjauBWX7JifR0y0NZaqlf4Q
 6YyVf9aDAq0We8FeXLOwwTsMARPf3lcxoGpfrbUoN1opTvNKzy9nlEjWaM/eom2J/FON
 sxZg==
X-Gm-Message-State: AOAM532Jkll3WNt9EsE3dWwKseekmriL6RgR/0gBfZAVcO97RXm2BAZ5
 r1Veb8fAcfHiLYpGIzqC1+3QCIeXxaY=
X-Google-Smtp-Source: ABdhPJy9o5aNMBC1mLBLLRyRHE4Rte+iay+yJ31OQ4ejcgWphryaWDiLnT+hzDfT2jrywCvZQvLGYA==
X-Received: by 2002:adf:cc88:: with SMTP id p8mr30165765wrj.201.1602483702909; 
 Sun, 11 Oct 2020 23:21:42 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x3sm13493261wmi.45.2020.10.11.23.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2020 23:21:41 -0700 (PDT)
Subject: Re: [PATCH] hw/pci-host/grackle: Verify PIC link is properly set
To: David Gibson <david@gibson.dropbear.id.au>
References: <20201011190332.3189611-1-f4bug@amsat.org>
 <20201011223446.GA4787@yekko.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <369509c1-2e90-13cf-8845-892e754516d1@amsat.org>
Date: Mon, 12 Oct 2020 08:21:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201011223446.GA4787@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 12:34 AM, David Gibson wrote:
> On Sun, Oct 11, 2020 at 09:03:32PM +0200, Philippe Mathieu-Daudé wrote:
>> The Grackle PCI host model expects the interrupt controller
>> being set, but does not verify it is present. Add a check to
>> help developers using this model.
> 
> I don't think thaqt's very likely, but, sure, applied to ppc-for-5.2

Do you want I correct the description as:
"The Grackle PCI host model expects the interrupt controller
being set, but does not verify it is present.
A developer basing its implementation on the Grackle model
might hit this problem. Add a check to help future developers
using this model as reference."?

> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/pci-host/grackle.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
>> index 57c29b20afb..20361d215ca 100644
>> --- a/hw/pci-host/grackle.c
>> +++ b/hw/pci-host/grackle.c
>> @@ -76,6 +76,10 @@ static void grackle_realize(DeviceState *dev, Error **errp)
>>       GrackleState *s = GRACKLE_PCI_HOST_BRIDGE(dev);
>>       PCIHostState *phb = PCI_HOST_BRIDGE(dev);
>>   
>> +    if (!s->pic) {
>> +        error_setg(errp, TYPE_GRACKLE_PCI_HOST_BRIDGE ": 'pic' link not set");
>> +        return;
>> +    }
>>       phb->bus = pci_register_root_bus(dev, NULL,
>>                                        pci_grackle_set_irq,
>>                                        pci_grackle_map_irq,
> 

