Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6E4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4213421D81
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBfzClM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4213421D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWNQs-0000GE-CM
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 13:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWNQI-0008GJ-DD; Sat, 24 Oct 2020 13:33:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWNQG-0000i8-OI; Sat, 24 Oct 2020 13:33:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id e17so6497976wru.12;
 Sat, 24 Oct 2020 10:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LvGGTFWsyQjDX5+PrYR7huE/ykamm8i7tc7sFW0RZts=;
 b=JBfzClM2DhuZjra0NgovW3TFh5NqTTpjAJpgeHst4jfovebI3doZJnA94/0HrFFzRq
 W6jwOuHkoqmNgXbWr5DchSCqBBAAlQvE3Ra0hhxHowc6bba6ymiwXWXyiiyRK1JG34hV
 RH8U/VJAM4dXKo0U7K+qN12LBt+im/KrBlxDi/2I/6NMlLDOD7wHh9hOiyXjll+SO8Yp
 3mzbjxmuXI/q8pUyCg8S/weZ7zT4dDNKHa5T5RgZKBPeYh6CnrZradBa83RVbbmKaZUb
 W3FLDwyj0tPIe1vPYk/Sf4zu0b8GDZb5zKBJStT6DwbBR37KqVTVLQjOH75n46uFv/FS
 jZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LvGGTFWsyQjDX5+PrYR7huE/ykamm8i7tc7sFW0RZts=;
 b=BAQ1irsbNdOEffl3PCRVTJcWZzTSME949Yjjw75EFoz3Y/ubo0PM5BBLLzoptFTePs
 q1VFt3plP+cvEtkazozwJvNRFJfDmQReIa9GJu+4jBUtzszX8eCvqczb6wNo/36jSTpv
 WqLXS7EJqcPCGj3G/jhNxgC4pG2raD+uQIlvOS4/SP93QhNI1ZBfG8sNUCA/yXGT8z2k
 E2KbrwuD8zzIpNuHAozkXlyjiuYo5ZnHIzxT03HqGxMIFG8/bp/fGfuP7tAdC2FMPmbb
 fRCJ/8miX4uAI/W01zkhPWU8lxdQYIUQeV27t88eHCMe34ku6IHXv4F5j5dV4mz1ucR7
 nO8Q==
X-Gm-Message-State: AOAM531PuxC609CUZi1cg4PnBP9q0+D4BBap8T3AdCLtYCXJ0bQxuH90
 owvX2xeMLqC4ZAZJQolPVI4seDmRwiA=
X-Google-Smtp-Source: ABdhPJzthD8/zHsKTi9K90+mZgpVH3pSBu6uWFyulQgz4Lg19Hf/Hofgkb0dNsA4A9y5/OlhNYrnZg==
X-Received: by 2002:adf:e881:: with SMTP id d1mr8649457wrm.395.1603560821927; 
 Sat, 24 Oct 2020 10:33:41 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e20sm11104149wme.35.2020.10.24.10.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 10:33:41 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] hw/misc: add an EMC141{3,4} device model
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 John Wang <wangzhiqiang.bj@bytedance.com>, xuxiaohan@bytednace.com,
 yulei.sh@bytedance.com, joel@jms.id.au
References: <20201008090244.3770-1-wangzhiqiang.bj@bytedance.com>
 <19801c31-77e3-f51f-24ce-124ae65cd698@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ef53dba9-431e-bd9e-df92-cedb6a75e4c6@amsat.org>
Date: Sat, 24 Oct 2020 19:33:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <19801c31-77e3-f51f-24ce-124ae65cd698@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 7:19 PM, Cédric Le Goater wrote:
> On 10/8/20 11:02 AM, John Wang wrote:
>> Largely inspired by the TMP421 temperature sensor, here is a model for
>> the EMC1413 temperature sensors.
>>
>> Specs can be found here :
>>    https://pdf1.alldatasheet.com/datasheet-pdf/view/533713/SMSC/EMC1413.html
>>
>> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
>> ---
>> v2:
>>    - Remove DeviceInfo
> 
> I will look at doing the same in TMP421. All the temperature devices
> have a lot in common.
> 
> Philippe,
> 
> Did you have a patchset introducing a common framework ?

Yes, based on this (but probably using QOM path instead of ID):
https://www.mail-archive.com/qemu-devel@nongnu.org/msg697031.html

I plan to respin once the 5.2 is released.

> 
> Thanks,
> 
> C.

