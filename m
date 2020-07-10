Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46186C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A4C2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6XyLm/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A4C2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvUy-0001aB-74
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtvRz-0005H9-Av
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:00:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:50184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtvRx-00029s-IE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:00:34 -0400
Received: by mail-wm1-x32c.google.com with SMTP id l17so6701993wmj.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Nk0N8/syv090ATitR/yKV1V2b6HO1Qj5NKc++I826YU=;
 b=R6XyLm/LzINwOFvV/WopXBwDO0I+FrWIbsTRyvGPo6vmGqMllYBIn0c65UAtbv+5XJ
 c9CWPi7hv/R/DE9193OYQBJH0Q6iOPY5Y9+OP4Bf6htaWE+RmY4Pf5izhJ5Evl/1PBp3
 D02Mr+Skik8Lu+HGb0HXq8fTIAPeciaUStXYmeJ8NBmtQ/txz8Vzt4tyLHr1b3oY3DEJ
 7hcjlCZaBkwfXc1e9GQDooyMHUIlPq4C17MAitKyZfssAJiW1RF4iKt1vv3/dUSKQlQk
 SLE3Ceuu7OOGec/dP1gYe6qxSFC1ai8rECvz6H3bcSe+tEHXAZTaDolcrikUxbsJL1yK
 3KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nk0N8/syv090ATitR/yKV1V2b6HO1Qj5NKc++I826YU=;
 b=ipMG8gnGHwyLFJrCDPsZjnHtLv3o9KGYtMC1X04QLC2BR3mb3bJqWNzyhzuIJnQxfo
 PQ6svwkCqqUtlW/QnRRUyk+dJ6rwOopWEmL9pLIdZ8h6dduK9NCaM+r+wx2XTH+tc8OA
 Ig98M5QxoUwBVouvhp7KbZvu2J2+jhTc0f5iweeyg57f6vZP7YI0ZKtzz3kIeHd/ymum
 rFpX6t6HPOVv6uy2/f+FvN45GphtSzwsCM74qcIX75p+EhCBYF6utCCOx9rWMxhigiti
 ppu94pKOeVrbeJN1TWqXrp+ZWUre46Zg1+9yGWZhaWUnFh3LkBHEXYZ+Se4lBGtdgNyo
 +S4A==
X-Gm-Message-State: AOAM5330DiElhXFzQ4WZAbNDyc4UYyCh/pVob+qK2n7DRVe2rrHpYz8T
 2aBLfc/+v2+H0yL9xBO2AlI=
X-Google-Smtp-Source: ABdhPJyQOXmA8tZoKhib1ZgFirccLEp8L4wMlsUPcy6vy5aAGWx/GPZOgZSjVQ/+tJ145IUmKGKMRg==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr5581095wma.7.1594396832008; 
 Fri, 10 Jul 2020 09:00:32 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 207sm11327256wme.13.2020.07.10.09.00.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 09:00:31 -0700 (PDT)
Subject: Re: [PULL 00/32] AVR port
To: Richard Henderson <rth@twiddle.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20200707181710.30950-1-f4bug@amsat.org>
 <CAFEAcA85TE+W39fphhm77hNKmAJyEMmaTseDkL1t4gTkzzcbJQ@mail.gmail.com>
 <47ca6b92-cedb-a6c4-754b-b7cd5da597e7@redhat.com>
 <CAFEAcA_wBT+Yfsn+DFZkcRxYWKmF04U2JHNVz5mNuXabeDcN5g@mail.gmail.com>
 <544208da-9dad-5fab-ab43-b2537a1f2f90@amsat.org>
 <d2dd51b4-2f10-a33a-66be-6357c52d8564@amsat.org>
 <ce597c43-43c5-9484-c807-4bc89f733fc7@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9afbc600-f590-680e-b2f0-2c2f6a739475@amsat.org>
Date: Fri, 10 Jul 2020 18:00:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ce597c43-43c5-9484-c807-4bc89f733fc7@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 5:54 PM, Richard Henderson wrote:
> On 7/10/20 8:32 AM, Philippe Mathieu-Daudé wrote:
>>      if (addr < NUMBER_OF_CPU_REGISTERS) {
>>          /* CPU registers */
>> -        data = env->r[addr];
>> +        data = cpu_to_le32(env->r[addr]);
> 
> This doesn't look right.  Why?

Sorry guys, false alarm, leftover from previous test but this
is definitively not in the pull request :D

