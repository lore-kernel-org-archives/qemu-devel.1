Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6642CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358E320658
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHhM9X/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358E320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDXm-00023o-Fp
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtDUs-0006nO-Bc; Wed, 08 Jul 2020 13:04:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtDUp-0002W9-KE; Wed, 08 Jul 2020 13:04:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id f2so21783498wrp.7;
 Wed, 08 Jul 2020 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=28xmeV7ZAOYj3fpAKsLQllw49ybje9ue2ZT4nZIZPxM=;
 b=qHhM9X/hQrFlhPE9Z2SdOFOGYQgNnAuHP3icxu16Ie89xWC7vHERJgZxx2+m0imha6
 D1YRkdzkbNvqVR8J+tCnTjTKJDJYDRRJbtfllVNDh6h2dP/nQL2DwZwMcahVc+tzC+z/
 BFsBedRBi2yPKx4xdh5gkCnL7621lZJw8QbPsKsw/V/QMBDkqeUaqneQWqJCyQmiBCye
 ItRvLIR8voqF6xtZgBMI116FntwvVNiT16BXlJ7I14zmMYlgIFulHOukzYENqFGrWYdR
 Q8FKTdNnYCjsrG7bEf9J4au4iDcRRT72lipIMawj0u4iPTVbpiYPZC3QgvbP6WWKxOl9
 wkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=28xmeV7ZAOYj3fpAKsLQllw49ybje9ue2ZT4nZIZPxM=;
 b=Kn6JiIGuL7z1y5Bgdm/uQJub3c9LNRJRxO7cO7/Qp/GHFE5KmU0fuXRHoNGFzX6xfI
 rnJteT5YL0bL8UYhIEZe9v5OV35Skl+NPLMZ5h2EeFdwrWObCcur56YJmTiuQ0RmOt7f
 MUB124nLlKRM2WLbRuSEUVtk0GKvutaB8XwouUKMNWyNAAEKdQkLJpZrQftVjbudfVbo
 3J0swtjvGQd5Is9VvXCi7Xth+4HCJKu1RQCIz5vZ2ynOu2Y9Zpctl8Fg1Oa14//MlbIG
 oJBLnGf2kzSjmj300M7qcpsUNzxfqxdR+TjL40G50izLavsxFSVrNnnpS5DdcIcb6LOE
 c+dg==
X-Gm-Message-State: AOAM5324UA+se8k23Icz5ECdwM+uk4KDaC5uEyNgMGyIUBRtjBqs1V2n
 TnUTUlntsUS+IT1yWpNf8aM=
X-Google-Smtp-Source: ABdhPJz/F1UaR12rcu8AI+TfJ38kcryt7VwMuyLURzbkpKMbO9NNeuB6rPuL2h/3IwrsyLsYYEdvGw==
X-Received: by 2002:a5d:5341:: with SMTP id t1mr63053536wrv.207.1594227873779; 
 Wed, 08 Jul 2020 10:04:33 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v9sm1020677wri.3.2020.07.08.10.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 10:04:33 -0700 (PDT)
Subject: Re: [PATCH v4 01/12] npcm7xx: Add config symbol
To: Havard Skinnemoen <hskinnemoen@google.com>
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-2-hskinnemoen@google.com>
 <9b824a33-13d4-445d-4986-0c5a135c4bb8@amsat.org>
 <CAFQmdRbbDf9bSpO9djfOhXhFUjr4HwxAm=q-n44D1ATb4V=iDg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b4ef2002-e266-1a16-39d5-e57abdafe8a4@amsat.org>
Date: Wed, 8 Jul 2020 19:04:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRbbDf9bSpO9djfOhXhFUjr4HwxAm=q-n44D1ATb4V=iDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 6:58 PM, Havard Skinnemoen wrote:
> On Wed, Jul 8, 2020 at 9:56 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>> +config NPCM7XX
>>> +    bool
>>> +    select A9MPCORE
>>> +    select ARM_GIC
>>> +    select PL310  # cache controller
>>> +    select SERIAL
>>> +    select UNIMP
>>
>> And this in patch 5: "Add NPCM730 and NPCM750 SoC models"
> 
> Is it still OK for earlier patches to use $(CONFIG_NPCM7XX) in Makefiles?
> 

I haven't reviewed them yet, so no.

I'd do this way:

- Add to the first peripheral that requires $(CONFIG_NPCM7XX):

    config NPCM7XX
        bool

- Then when you add the SoC, complete with:

    select A9MPCORE
    select ARM_GIC
    select PL310  # cache controller
    select SERIAL
    select UNIMP

