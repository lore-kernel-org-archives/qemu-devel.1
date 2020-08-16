Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D8BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 11:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC8A206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 11:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUwlOXlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC8A206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7GVd-0007xg-1X
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 07:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7GUp-0007SV-4h; Sun, 16 Aug 2020 07:06:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7GUn-0000uw-Ji; Sun, 16 Aug 2020 07:06:38 -0400
Received: by mail-wm1-x343.google.com with SMTP id c19so11376078wmd.1;
 Sun, 16 Aug 2020 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=det3t9oAnuJ25K3LTQIcY4dkTmYqFsbbh+hQ5vFM0Jw=;
 b=XUwlOXlK5LHrveGk6ZGFkGj5qUgBRwDOYhn2ANNk8d/06gKBcW4Tmje8aNzOIYjeUo
 Q3TXR5owfKTcmEM8bBKoHVDG+H4TqUF2DIoBpRV0qmJdyD4ncqVjFDqdpKA5jLHMPVdF
 iA0TJdT/PxTuKB9/tJovlAPUk4EhLTElC7CGSofT7SQigSEZAwyUhz5aUWhtddtdzBUd
 DPgRCzU05Cl/knakiUcceNpD6fCii39R1wuFnF2ZyVO9WqauUrRIh66q0Aw8XdQL45lS
 C2eEpRDKmOjl13HyU0yZzcARydA9z9tUejJTHL2Wpw8nSTbys3GCeIqcWFJyUAr8BgfF
 u81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=det3t9oAnuJ25K3LTQIcY4dkTmYqFsbbh+hQ5vFM0Jw=;
 b=Wz/fsEsxx2nQHh0C/80jn2uFbghb1BH1sfgmbFfnUr2VqoT7X+cbrzWqYbwVm3arn2
 9yyhrKUfB7soH5oRySqoyB4lFAI3BLijnxOfTX8YwvImPKvW5V6v/c35/CduPALLfVRN
 7Suyxj69i4lUnhq2dsfupKAcWFUC/4ItLXJm5UnOV/eefKQ/zHRamwA5P4ZF7+hZZNpc
 EjPzCrm4LMUbmgPbC577eDOGK/lfe4gzToYXgVWZSmvj0+DzKa2+BYlrDR3jfdPViT3Q
 3XbdQRBwSTk4HcyRtW56HAf7x+y4OuZu0mLLUtcOgpa21IdD8Lkpr1/ugoROhivrFn8U
 6QrQ==
X-Gm-Message-State: AOAM533xBC/pEMAAQvCorqT/PIPGpF4AYUWbfG3fwcMzdQFvcFKmKbZF
 Q6FiLb8BZH90xk9v/8Oql3k=
X-Google-Smtp-Source: ABdhPJz0jV93SgwNlVgDUTnkntDKDqB7u3Ruq30mZoN2JQzZdjgIVem4IHfWwucZ7vcydjMmMOLa4A==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr9870851wmk.125.1597575995481; 
 Sun, 16 Aug 2020 04:06:35 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id a188sm26521198wmc.31.2020.08.16.04.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2020 04:06:34 -0700 (PDT)
Subject: Re: [PATCH 09/18] hw/sd: sdhci: Make sdhci_poweron_reset() internal
 visible
To: Bin Meng <bmeng.cn@gmail.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-10-git-send-email-bmeng.cn@gmail.com>
 <e68381fd-e4cd-a56a-ab44-ff603242e1cc@amsat.org>
 <CAEUhbmUtD2miWZk8uYvB6VkM8bu9rqr32J29WJADoNy9JethRg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0b150e6d-1221-ef3b-4692-11d18fef9b52@amsat.org>
Date: Sun, 16 Aug 2020 13:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEUhbmUtD2miWZk8uYvB6VkM8bu9rqr32J29WJADoNy9JethRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, qemu-block@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/20 10:50 AM, Bin Meng wrote:
> Hi Philippe,
> 
> On Sat, Aug 15, 2020 at 3:51 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 8/14/20 6:40 PM, Bin Meng wrote:
>>> From: Bin Meng <bin.meng@windriver.com>
>>>
>>> sdhci_poweron_reset() might be needed for any SDHCI compatible
>>> device that is built on top of the generic SDHCI device.
>>
>> NAck. Please use device_legacy_reset() instead.
>>
>> In next patch:
>>
>>   device_legacy_reset(DEVICE(&sdhci->slot));
>>
> 
> The function comments say this API is deprecated.
> 
> /**
>  * device_legacy_reset:
>  *
>  * Reset a single device (by calling the reset method).
>  * Note: This function is deprecated and will be removed when it becomes unused.
>  * Please use device_cold_reset() now.
>  */
> 
> Should we use device_cold_reset() here?

Oops yes, certainly.

> 
> Regards,
> Bin
> 

