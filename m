Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0814BC54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4BFB206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwnggoSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BFB206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYP7A-0004p5-V4
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYP6M-0003q5-Vh
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:13:18 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYP6M-0001NI-7U
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:13:18 -0400
Received: by mail-wm1-x343.google.com with SMTP id m12so15596890wmc.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 00:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8Tpjpzqsyr0qnvQFIMx9eflKHn9l+Kxq50/tB7dHrTg=;
 b=UwnggoSXopm0slcQ66mn2rJHPdMVI542+9XGiQ4+guI3UzJKLpjNBGSXketXgfGecF
 K65u//awtkxzeqJBlrvecHLvvGQnQ3wGKFkueMyGY5tf9+3Pbw03a6SP4C/NkdGonBve
 lCXLtS11qtKuE2T7Buy3enCpGGQkNwBC08v6HdqLeaImV9VzzwVAmT21dsxeaWOTJ7Y0
 obfnq+Wy3K9kK67ydBO7nbpXkCmGZyaJT2MWPcnBuXFzlRpSRAgqmwJ9Hs9/J7kcyYS6
 pzq5ZNhdBQcPMyFtDIqROC3JCZlMxEYirV20Nfjdq958JMzhh8Nrv1RFaD+LTJ1DaYWl
 gHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8Tpjpzqsyr0qnvQFIMx9eflKHn9l+Kxq50/tB7dHrTg=;
 b=M6Tmghm0FaQNbEqjE9Quuo4uwoX6CM0lzbxu1nbfVAqARDuG2ah/jYR2CS7zjbvrXG
 66QjGNnu+NoGqwKDwGGdSiu4n+EYin9GLW9qvm2VCcyToe8YW3Vb4V378Bgnnc57RArI
 T73xJmPggwGWGeF4hwZJOWiNhTJ4pbsn51t3PqeKYY9OSVZDjyLFQj8/Xq+V/DWFbtD/
 y8vQdsi8viEtbDORMIrFgR1cEigcjYkDVJpif4yvEzkRwUTLeuqdYMgClspX3S4KKJ9O
 PQuzl93vUAB27HPaBUXq9yz0dWbQr2fWGERHyUWrAvPqf/UGpr0E7STLjxEZ0uGbsi7F
 BxfQ==
X-Gm-Message-State: AGi0PubUne/8MkGQblDoc6ywsosvHxnfx6LGie8P0S9hTuzP7MTN52ED
 ckwz00l3qpjJHcDomnlccCVSA+QONkg=
X-Google-Smtp-Source: APiQypJ0R7LinfLKwQwZZUUHp3v5H+bSlrwxfHBah+/XXSy1n5eyKcWoHuGPCC5ENRjLN6wGDmbT1g==
X-Received: by 2002:a05:600c:290d:: with SMTP id
 i13mr20435004wmd.81.1589267594422; 
 Tue, 12 May 2020 00:13:14 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a24sm29999339wmb.24.2020.05.12.00.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 00:13:13 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] hw/net/tulip: Fix LP#1874539
To: Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200423231644.15786-1-f4bug@amsat.org>
 <20200424152722.GA14573@ls3530.fritz.box>
 <1f04b513-eece-baa7-5556-4665afe1f637@redhat.com>
 <CAFEAcA-vJXRcjNPnyB5t4UOrmH5wnUoZsx-JAwDYNavQ_L64XQ@mail.gmail.com>
 <24b9c9a3-a0b6-2d9b-eade-dbc43bd71ff4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ed40763d-93c7-643d-51aa-4b36396c7c58@amsat.org>
Date: Tue, 12 May 2020 09:13:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <24b9c9a3-a0b6-2d9b-eade-dbc43bd71ff4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason,

On 4/27/20 5:32 AM, Jason Wang wrote:
> On 2020/4/26 下午3:57, Peter Maydell wrote:
>> On Sun, 26 Apr 2020 at 03:50, Jason Wang<jasowang@redhat.com>  wrote:
>>
>>> Looks good to me.
>>>
>>> Would you please send a formal patch and cc Peter.
>>>
>>> Consider we are about to release 5.0, it's better for him to apply the
>>> patch directly.
>> I am not applying any further patches for 5.0 unless they come
>> with an attached rock-solid justification for why we should
>> delay the release again for them.
>>
>> thanks
>> -- PMM
> 
> 
> Ok.
> 
> I will queue that patch for 5.1.

Can you queue patches #1 and #2?

> 
> Thanks
> 
> 
>>
> 
> 

