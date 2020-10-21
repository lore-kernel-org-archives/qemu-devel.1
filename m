Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19834C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593A5221FC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQ7ygtCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593A5221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVB2u-0000qh-E1
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVB2H-0000B5-32; Wed, 21 Oct 2020 06:08:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVB2E-0001zJ-MN; Wed, 21 Oct 2020 06:08:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id e17so2285296wru.12;
 Wed, 21 Oct 2020 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hLGyuiHrDp/2Z+PZgBWHYpwiNi7leOuhJtGLXUFdT08=;
 b=pQ7ygtCBiqNjRhGzroxr+76M45Sij2EhhkLkBvQuIoyAFVrlj+9U+DzbGycHMYmZxq
 hSVMwyNRq7a5szQ9CnvmaYh/m1KZOl6k6lLG2bZv+ZoTMx0g9afRXdclUQSNFd/nFB+i
 9rkTGXxr2FMYTXO8ssdHAHzRDoINimrzfLswOChRD+tpiuMmtbMUglZD6M9rsmkUzjIK
 uBiZVZJ0kM9GM85k0xvXAgHhrFyf0j6ahLrioUt2Omp1LZFIf53TMcm3GiLTXqIW3KEe
 ZjLY4mgpIrtnB92AZO+NzotA6hjz/u+wpaSOvTFHKkUcp6xjJLEb/l3KZ9Dnv8JWYf1b
 DnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hLGyuiHrDp/2Z+PZgBWHYpwiNi7leOuhJtGLXUFdT08=;
 b=OCrV6Gi2XRqiduFuMLN/LjHbRG1rxJVaQSxvEukJgpddCVR4MDarNDQEymKi091ixG
 OSleBhou9XhnqZD3i6AJ+TOyDNaCrSgAQL9dfgOgLXFnomdWX2jXTTlzp6CnUS2o/vbU
 UC+aTxva7B3JZQEgdMmdNPnoAxAeUvi4co235zR/MBYz81RPPRGSHnxWVxRrI/uBBNGs
 XiF6kZ7ABsnjDYRccEGVP0YDu7nmI1tSFe/fST6P1PAhVxYN0yIRcE38e4bqv5JcaBom
 vExWpNIfC3mzRaoOL05puwsbOvn+C8vlNo+RQYvQjS0cxEODnulNiHTqNgE+Ms7UJyqr
 ypvQ==
X-Gm-Message-State: AOAM531I2s3en8si0yYCYJNE5VEITLI04GO4ece/gOPbEISi1RxoArvG
 Zun+e9vV2fnVKgr3mR7hXFY=
X-Google-Smtp-Source: ABdhPJzl3F3WUdHiuddTWzE2ycw0wzYZUsdmnV9DSj8qhndRUNBQQ36OE3NWeBpkKe5jkQ61Qm0stw==
X-Received: by 2002:adf:e94b:: with SMTP id m11mr3722553wrn.35.1603274876391; 
 Wed, 21 Oct 2020 03:07:56 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 10sm2635331wmn.9.2020.10.21.03.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 03:07:55 -0700 (PDT)
Subject: Re: [PULL 22/23] hw/sd: Fix incorrect populated function switch
 status data structure
To: Bin Meng <bmeng.cn@gmail.com>
References: <20200821172916.1260954-1-f4bug@amsat.org>
 <20200821172916.1260954-23-f4bug@amsat.org>
 <e378932a-1de3-83c1-834f-ae6526604cb7@amsat.org>
 <CAEUhbmVFZ8aWdv48D8acdfFRp6WMYL6n=ENeo4hBZfmqE9TrDA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a0ac3805-ec48-2a0e-6511-b142bfc6f214@amsat.org>
Date: Wed, 21 Oct 2020 12:07:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAEUhbmVFZ8aWdv48D8acdfFRp6WMYL6n=ENeo4hBZfmqE9TrDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Michael Walle <michael@walle.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 11:57 AM, Bin Meng wrote:
> Hi Philippe,
> 
> On Tue, Oct 20, 2020 at 11:18 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Hi Bin,
>>
>> On 8/21/20 7:29 PM, Philippe Mathieu-Daudé wrote:
>>> From: Bin Meng <bin.meng@windriver.com>
>>>
>>> At present the function switch status data structure bit [399:376]
>>> are wrongly pupulated. These 3 bytes encode function switch status
>>> for the 6 function groups, with 4 bits per group, starting from
>>> function group 6 at bit 399, then followed by function group 5 at
>>> bit 395, and so on.
>>>
>>> However the codes mistakenly fills in the function group 1 status
>>> at bit 399. This fixes the code logic.
>>>
>>> Fixes: a1bb27b1e9 ("SD card emulation (initial implementation)")
>>> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> Tested-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>>> Message-Id: <1598021136-49525-1-git-send-email-bmeng.cn@gmail.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>    hw/sd/sd.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index 7c9d956f113..805e21fc883 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -807,11 +807,12 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
>>>        sd->data[11] = 0x43;
>>>        sd->data[12] = 0x80;    /* Supported group 1 functions */
>>>        sd->data[13] = 0x03;
>>> +
>>>        for (i = 0; i < 6; i ++) {
>>>            new_func = (arg >> (i * 4)) & 0x0f;
>>>            if (mode && new_func != 0x0f)
>>>                sd->function_group[i] = new_func;
>>> -        sd->data[14 + (i >> 1)] = new_func << ((i * 4) & 4);
>>> +        sd->data[16 - (i >> 1)] |= new_func << ((i % 2) * 4);
>>
>> This patch broke the orangepi machine, reproducible running
>> test_arm_orangepi_bionic:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg739449.html
>>
>> Can you have a look?
> 
> Yes, I can take a look. Could you please send more details on how to
> run "test_arm_orangepi_bionic"?

Looking at the previous link, I think this should work:

$ make check-venv qemu-system-arm
$ AVOCADO_ALLOW_LARGE_STORAGE=1 \
   tests/venv/bin/python -m \
     avocado --show=app,console run \
       run -t machine:orangepi-pc tests/acceptance

> 
> Regards,
> Bin
> 

