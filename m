Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889C2C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42D720EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzyXkEL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42D720EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0zC-0000hm-Nq
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kW0yK-0007sR-Az; Fri, 23 Oct 2020 13:35:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kW0yI-0001is-GS; Fri, 23 Oct 2020 13:35:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id t9so2922173wrq.11;
 Fri, 23 Oct 2020 10:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fNj5eXTv9uSww8Em5BotaPpbN3t9ohV8mupF1oepGKc=;
 b=YzyXkEL1uJSfxjHsFprrnb1g503YnEWB83y/X7TVe39JUd3O2jKMwJGnFRJ8BxFEDF
 ObQlesC8ZqmGwKYlDzug0dD48M0vlD7APoUO1X6///NwffVXZL/TnMtv/4CftYBz8Eos
 73VgBMTNoD8i5YSp3YweZugN7StYD/lw0mLt1lMOlDAvLriyhPVTs4JCvEqSlG/+pSA0
 Qar/ZuCc/1Sc3MgU3+N42YJbGjkauRZhtYThyvI83S5oxbrGtksjiCG/v6a1NXe5U9of
 JJUDFrHg9lmrMqUdctOnHEB6gi3QVi7oAog+oIhHudStGETydmzCy4l7OPKFBmdRR7vl
 ESyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fNj5eXTv9uSww8Em5BotaPpbN3t9ohV8mupF1oepGKc=;
 b=kFJou2d/BiN9PVR0SP1zE1Mf3BOtb1DEikiOn3qLSsNhKP1mBhj4zUmBRpzM59/LlK
 N98x0iXFH0OmFTFIs5QKtIP4dpov3nL1GIAR0lnab08aeS0JnCNteGzdD3C4Xpqbr9wM
 1RBhA/75Uq8vpxYzODq0EBGVAdmDwfExctOxGGN3b/glFKuwPjN4H+bLI94EB3krdiR3
 cfLO51XZUjy2AOd/KPDTuik0xhi8A07sSofCG/o3dfK7gIPHsQzWrjjzzimK8H7UVSRy
 09osVXMBjk9s21gM6NBS5i8ywLItKkwpLEHUAbC89MDmJqVdRex3cVHY4p0KAjeZ3sBz
 GxnA==
X-Gm-Message-State: AOAM531fETJMvdc4FIvPQOKxNqSdkiEY51kRyrBL3nAhimSfXXZkAZeE
 irD03GEng0qVwBWFGyCsDXg=
X-Google-Smtp-Source: ABdhPJwQ5N5grPnj9pPCPNUAwQYjFkwEzBJk0i2l1wzre8AwfA3c7goaKPCOm3njjP4uydU5tFO6ug==
X-Received: by 2002:adf:e447:: with SMTP id t7mr3749423wrm.384.1603474520619; 
 Fri, 23 Oct 2020 10:35:20 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id g8sm5498228wma.36.2020.10.23.10.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 10:35:19 -0700 (PDT)
Subject: Re: [PATCH v3 8/9] hw/arm/raspi: Add the Raspberry Pi Zero machine
To: Igor Mammedov <imammedo@redhat.com>
References: <20201018203358.1530378-1-f4bug@amsat.org>
 <20201018203358.1530378-9-f4bug@amsat.org>
 <20201023175130.50a379bd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <af02ebea-0aeb-9e6a-5f79-95aeb10b1bb4@amsat.org>
Date: Fri, 23 Oct 2020 19:35:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023175130.50a379bd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.108,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>,
 qemu-arm@nongnu.org, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 10/23/20 5:51 PM, Igor Mammedov wrote:
> On Sun, 18 Oct 2020 22:33:57 +0200
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>> Similarly to the Pi A, the Pi Zero uses a BCM2835 SoC (ARMv6Z core).
>>
>> Example booting the machine using content from [*]:
>>
>>    $ qemu-system-arm -M raspi0 -serial stdio \
>>        -kernel raspberrypi/firmware/boot/kernel.img \
>>        -dtb raspberrypi/firmware/boot/bcm2708-rpi-zero.dtb \
>>        -append 'printk.time=0 earlycon=pl011,0x20201000 console=ttyAMA0'
>>    [    0.000000] Booting Linux on physical CPU 0x0
>>    [    0.000000] Linux version 4.19.118+ (dom@buildbot) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1311 Mon Apr 27 14:16:15 BST 2020
>>    [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
>>    [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
>>    [    0.000000] OF: fdt: Machine model: Raspberry Pi Zero
>>    ...
>>
>> [*] http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/raspberrypi-kernel_1.20200512-2_armhf.deb
>>
>> Reviewed-by: Luc Michel <luc.michel@greensocs.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/arm/raspi.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>> index 91a59d1d489..1510ca01afe 100644
>> --- a/hw/arm/raspi.c
>> +++ b/hw/arm/raspi.c
>> @@ -319,6 +319,15 @@ static void raspi_machine_class_common_init(MachineClass *mc,
>>       mc->default_ram_id = "ram";
>>   };
>>   
>> +static void raspi0_machine_class_init(ObjectClass *oc, void *data)
>> +{
>> +    MachineClass *mc = MACHINE_CLASS(oc);
>> +    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
>> +
>> +    rmc->board_rev = 0x900092;
> 
> shouldn't it be
> 920092	Zero	1.2	512MB	Embest
> or
> 920093  Zero	1.3	512MB	Embest

I took the value from the "New-style revision codes"
table listed in hw/arm/raspi.c before the REV_CODE
register definitions:

https://www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes/README.md

90009x's manufacturer is "Sony UK", 92009x is "Embest".
I guess we don't care much the manufacturer :)

The Revision 1.3 exposed the MIPI camera interface.
As we don't model it, I prefer to use the 1.2 revision
which matches better.

I'll add this information in the commit description.

Thanks for reviewing!

> 
>> +    raspi_machine_class_common_init(mc, rmc->board_rev);
>> +};
>> +
>>   static void raspi1ap_machine_class_init(ObjectClass *oc, void *data)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -352,6 +361,10 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
>>   
>>   static const TypeInfo raspi_machine_types[] = {
>>       {
>> +        .name           = MACHINE_TYPE_NAME("raspi0"),
>> +        .parent         = TYPE_RASPI_MACHINE,
>> +        .class_init     = raspi0_machine_class_init,
>> +    }, {
>>           .name           = MACHINE_TYPE_NAME("raspi1ap"),
>>           .parent         = TYPE_RASPI_MACHINE,
>>           .class_init     = raspi1ap_machine_class_init,
> 
> 

