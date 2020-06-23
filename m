Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68566C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A3120738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9U4jJQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A3120738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jncyd-00068d-CB
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jncxF-0005Bp-Fm; Tue, 23 Jun 2020 03:02:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46539)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jncxD-0002hB-RY; Tue, 23 Jun 2020 03:02:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id r12so1977735wrj.13;
 Tue, 23 Jun 2020 00:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RUnNws06hYUk7w9hNn8C3vxL99RNeOQ5CDWzKachtmM=;
 b=H9U4jJQttP6Fkalj/AawmAyQ7vge7AJpM7lSmAOKJffFJwBFsCaTjHeNqNUccZMilV
 XOFaIYNHgymzRvNF635FR+YmIXA2BAZ6/8PT8lw5ZyVMmNNS5OAZVGNS4FnbBiOZH2lA
 0jsCicqaueuUuc1aKVYUoXi/zxYBvUtXn0t3jOVQQn7P2nITe1LABPuS0hVdgZRKFt/r
 6TM80TTG7GKU40MCYRaUwB1aUCywBf3YayIuNw5TAWJ3EBn4O/CBk+sFSE21uJnpRGn8
 JeYINLLYZdC07kupjGOvWh9wTToE3CqKxd8OvO81nPWLZ/ZKXd8w8vwYk9NYxS8xHaUY
 kCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RUnNws06hYUk7w9hNn8C3vxL99RNeOQ5CDWzKachtmM=;
 b=A9+nVuk2ICkMEgOclOnFaEq+bIIMb4X822FQoYevg4RGqabzUsTIE+edflhb3HbQfU
 Zqd0jH4ah3x1BvFFQniuntA7QWNdYHjP08ZczpgE+OZTKpxhTPL8Fo+/RNA0Y616UBfW
 aU4U4Z+MvrBOFb1yhdk2+2KjMSSdlqeesLAa+9Ujq46WyXJfkluqZ35GZ470Er7Kg+a1
 KJ/wxQ+8gGIAMEGDDkmmV577VbFh9zkl4sdytmeOa8XcXXhSITsVAR+E2YzU/kI1XRML
 KhEWMAuLh5r84hgpD/qkXKeQKfS7tMEoNYgN0Iy+mnec2vTBvHCfw6mB/+Mk08d6qeXl
 o81Q==
X-Gm-Message-State: AOAM533sQSfW13f2eZOJwyQxz28krx8b4kJtMntJFWnI/dWc8NYTamHq
 E95dypSO6F3vtBFXRV6tbi/aQPC0
X-Google-Smtp-Source: ABdhPJyHLw3KIXLBOgFF5WvhMF4Ua1DOwXb9xnkmYF4AbtrJ6VtD2V2recXaYQviZK5l3SI4OFBILQ==
X-Received: by 2002:a05:6000:1cf:: with SMTP id
 t15mr7447716wrx.180.1592895764796; 
 Tue, 23 Jun 2020 00:02:44 -0700 (PDT)
Received: from [192.168.1.41] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 30sm17271129wrm.74.2020.06.23.00.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 00:02:44 -0700 (PDT)
Subject: Re: [PATCH v3 00/14] mps2: Add few more peripherals
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200617072539.32686-1-f4bug@amsat.org>
 <CAFEAcA9-RkKd0EQ=hzkt6C=ZVOaQtybmt5uVkPiK35SuQZZi0g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7c19edd4-dd45-cf7f-77a5-99bc7e449939@amsat.org>
Date: Tue, 23 Jun 2020 09:02:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9-RkKd0EQ=hzkt6C=ZVOaQtybmt5uVkPiK35SuQZZi0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 7:08 PM, Peter Maydell wrote:
> On Wed, 17 Jun 2020 at 08:25, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Few patches while playing with Zephyr on the MPS2:
>>
>> - clean 'versatile_i2c' a bit,
>> - describe it as 'ARM SBCon two-wire serial bus interface'
>>   which is common on the ARM documentation,
>> - add watchdog
>> - added fpgaio with correct prescale clk
>> - added i2c and spi
>> - added gpio/i2s as unimp
>> - dropped the fpgaio push-button patch
>>
>> Since v2:
>> - added missing Kconfig select
>> Since v1:
>> - addressed Peter review comments
> 
> 
> 
> Applied to target-arm.next, thanks.

Thanks!

