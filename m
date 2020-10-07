Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A3CC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820222080A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0gcj4a/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820222080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6xG-0007v0-93
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ6wD-0006z2-62; Wed, 07 Oct 2020 06:44:49 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ6wB-0000ik-9D; Wed, 07 Oct 2020 06:44:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id f21so1783366wml.3;
 Wed, 07 Oct 2020 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kpVc9C4AeW7sbHK0c5eNsIiL1L6BDV5PlQzKrOR20vo=;
 b=A0gcj4a/v31bgIM2R2k0mHXV8HJ2vIJxRUEYLwZZMusNwT+r60Dfr+q7DojR9Yg3T9
 lIVi/M1lm5TPyFYaRr4PIwgY+rZ+EMh7gYl58qzOfUTjXVJHwkbBQeC2r+6BUUpvkVtQ
 6faaNEVFVaN2XzMhaDoxzMNsNPm1Ik3dP5mwzYQDa0OP8WT17Ndqa5MCROQk+ebcyyX8
 amzYoZYeelgNgX7DLh579tsDjzJnATDLoWr/Wy+e0V17jLRBQ1lvRYP0m7n3JumhNYRa
 0gTp+Gal4j8rUs4d8rNVcDUgoUDtO/g6R1mavxuYZGArUO9JFnmbnhenjPIlUZU0ECdf
 +VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kpVc9C4AeW7sbHK0c5eNsIiL1L6BDV5PlQzKrOR20vo=;
 b=qyp3XRzJi6Yn0RQMjXSQJyh8U2E34pxtySG/W7M2SUMZhLd5Il/d+3h+VUBlux5/Lq
 8Le+WLAwz5bhOL/YeOWkQYgQ3iui66ssd77PSwp2yWSyeg/OPyR3NFirFRiQkBSg+s8v
 cjcQ6WFQjfLYVFfQSK+MkXSpGaWV4iz4RMMRSHCaRDnEVQe0QRcG0wrvym74I9wxw1uj
 BbO3dq/tApNQhKkSv1RWTO5eOPv5m7g5xiGeWYn3p3mZTjB2Mqei6srZ4OVRozDAYCcB
 VYxZSjqy6oJf4XF56bTtERy4SzLeItu55cLyaPQAc9P0DEOUxupCVZS8XlymbL0WQukR
 ZWYw==
X-Gm-Message-State: AOAM533EeCpSDMKzGo0/vQSkQtQQq3d4CiJgPeOsiGmLLxwVrYFYA/P2
 oy4Z4MoChcwGrgOIGERfiv0=
X-Google-Smtp-Source: ABdhPJxRcTIVeNtJAsLAbDYOrKXIGRfX8Jg00dS8U+Qxgta71pthf7vgPz0byTt2IG05tEWEXzq0hQ==
X-Received: by 2002:a1c:495:: with SMTP id 143mr2477077wme.63.1602067485162;
 Wed, 07 Oct 2020 03:44:45 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y7sm2149510wmg.40.2020.10.07.03.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 03:44:44 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
To: Graeme Gregory <graeme@nuviainc.com>
References: <20201007100732.4103790-1-graeme@nuviainc.com>
 <20201007100732.4103790-2-graeme@nuviainc.com>
 <c518a446-94ca-f21a-2e49-e2cd8171e581@amsat.org>
 <20201007103220.z5pc5qjoyxbowyrb@xora-monster>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aafcbb37-dc5a-e608-21fe-6e65e36df5e4@amsat.org>
Date: Wed, 7 Oct 2020 12:44:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007103220.z5pc5qjoyxbowyrb@xora-monster>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: peter.maydell@linaro.org, leif@nuviainc.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, rad@semihalf.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 12:32 PM, Graeme Gregory wrote:
> On Wed, Oct 07, 2020 at 12:24:32PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
>> On 10/7/20 12:07 PM, Graeme Gregory wrote:
>>> SMMUv3 has an error in a previous patch where an i was transposed to a 1
>>> meaning interrupts would not have been correctly assigned to the SMMUv3
>>> instance.
>>>
>>> Fixes: 48ba18e6d3f3 ("hw/arm/sbsa-ref: Simplify by moving the gic in the machine state")
>>> Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
>>
>> Again, this fix is already in Peter's queue:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg732819.html
>>
>> But if you repost, please collect the reviewer tags,
>> so we don't have to review it again. This one has:
>> Reviewed-by: Philippe Mathieu-DaudÃƒÂ© <f4bug@amsat.org>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>
> 
> Ah I thought splitting the patch invalidated Eric's reviewed by?
> 
> This is a different fix to the one you are referring to, previous one
> was in PCIe.
> 
> Apologies if I have missed an email from you but I have not received a
> Reviewed by from you for the SMMUv3 IRQ fix.

Oops sorry my bad, I thought this was a repost of the PCIe fix.

So:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Looking at 48ba18e6d3f3 I messed create_smmu() and
create_pcie() but you now fixed both cases.

And you are right, this patch isn't reviewed by Eric.

> 
> Thanks
> 
> Graeme
> 
>> Thanks,
>>
>> Phil.
>>
>>> ---
>>>  hw/arm/sbsa-ref.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>>> index 9c3a893bed..65e64883b5 100644
>>> --- a/hw/arm/sbsa-ref.c
>>> +++ b/hw/arm/sbsa-ref.c
>>> @@ -525,7 +525,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
>>>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>>>      for (i = 0; i < NUM_SMMU_IRQS; i++) {
>>>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
>>> -                           qdev_get_gpio_in(sms->gic, irq + 1));
>>> +                           qdev_get_gpio_in(sms->gic, irq + i));
>>>      }
>>>  }
>>>  
>>>
> 

