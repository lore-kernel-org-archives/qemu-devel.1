Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ED6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A392083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3ujJDUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A392083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwLiq-0006ZL-85
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 04:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwLiD-0005x7-Ge; Fri, 17 Jul 2020 04:27:21 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:36620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwLiB-0001Rn-VX; Fri, 17 Jul 2020 04:27:21 -0400
Received: by mail-ej1-x642.google.com with SMTP id n22so6950024ejy.3;
 Fri, 17 Jul 2020 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=31FMNeh6BHvUST7xbBvZJ64tRJukvmRk0Pr7iI3IG5A=;
 b=f3ujJDUuodO+TtJUHUAspNsBLk1O+vOaE3nZED4g/gJ7j9PEJMvhm4jqjMHpARdQZ7
 90rk8+zhX8D9GJzUaUA5Ty8VP6smq0MFjTOK3SdU6CVVU2M6sLu6/cJ8xNGEu9uaYrGZ
 SrV5F685e1+lRPEtVvcd7/N9uX/XAQoStjoxXRb7PhwOnbPVdMxST/XuoG9SBUl3xg6M
 wopXcmIQ7DySaUanZZfWjuP671jVuC8DQWcyKI8GDlKXsc1fwm6CvCQJR1IzQaunYNTP
 Z9hkKjfhl6/WptPJpvk/LY5S9je3QifabaHVoJYJfsJphwh8SnJTJkJZIJU06peXeSLw
 +jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=31FMNeh6BHvUST7xbBvZJ64tRJukvmRk0Pr7iI3IG5A=;
 b=s5PRs8ttJEUtQ8K5y7AdsZFtuXWR7M3LfaY6YUz4+Y+D5pOyeD1YhlIUrl/HmaUGuV
 ilwG6sIqr3LCH8QLnhQnnP5pyrinXy4gsAoKkQFR9F9+1DALvDPDwkprW3e68KttZd/R
 esvG78h6s9h+0TB8W8Paq+1el+7D8NLetrPLMW7noDeJgPfBEY+DuKzGXZ2tSfIxAoVA
 MLJcUz4hqad0cML8OI0KoWLU/MttJc1A5Hn8H19WYjRPnBHPf6JNMhU0ZsCwhRKEydcZ
 R0d34DQ6KwuulgBjvLxBor8LlZby6dsYEqn4BanAU1fREeliYpnBjQCRCIHXABGp0gPX
 yLGw==
X-Gm-Message-State: AOAM530N0IYI5cBFszlccAI0RNpQbMw6wS1SqPt356KNjXD2ra1JMDbW
 Kw6hucM+Ot/tY/SFfFFloHc=
X-Google-Smtp-Source: ABdhPJz1lZRzDoZHE92Waz9vMVG9BX1+uEtPQ3SldyWH3F5STgNsxOlDdYeJssLto0QVlvqj7Ea2Bg==
X-Received: by 2002:a17:906:594c:: with SMTP id
 g12mr7520791ejr.255.1594974437813; 
 Fri, 17 Jul 2020 01:27:17 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u2sm7757156edq.29.2020.07.17.01.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 01:27:17 -0700 (PDT)
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: Thomas Huth <thuth@redhat.com>, Havard Skinnemoen
 <hskinnemoen@google.com>, Markus Armbruster <armbru@redhat.com>
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-11-hskinnemoen@google.com>
 <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
 <CAFQmdRZcygskP3iwss01-Jz67yjAP_JENXjWM2Bp8U=DRzxR0Q@mail.gmail.com>
 <875zaq78xq.fsf@dusky.pond.sub.org>
 <19733456-a672-595d-e721-e0ef26d7f665@amsat.org>
 <87v9iq2hkv.fsf@dusky.pond.sub.org>
 <e87663cf-7cb2-ca6c-a751-e5c1cebc5440@amsat.org>
 <87pn8xywz2.fsf@dusky.pond.sub.org>
 <b3bc658f-a865-8e6b-c904-01c7724e89cc@amsat.org>
 <CAFQmdRa9FiP6yX=XDrJy5KpjifQyVkQiY6DXtSoJSvfoq7Vm6w@mail.gmail.com>
 <CAFQmdRac6tsZafN3PsnLhPA_Ny032ZAjOFuXkmYvJ-ubjcpPPw@mail.gmail.com>
 <5345d70f-3041-ed13-12e9-9a8e3d803805@amsat.org>
 <416d5243-dc8e-37c6-197f-96dec1c9f5cc@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d66bf4fe-7349-a90f-c4fb-a80de7597819@amsat.org>
Date: Fri, 17 Jul 2020 10:27:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <416d5243-dc8e-37c6-197f-96dec1c9f5cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 10:03 AM, Thomas Huth wrote:
> On 17/07/2020 09.48, Philippe Mathieu-Daudé wrote:
>> +Thomas
> 
>> On 7/16/20 10:56 PM, Havard Skinnemoen wrote:
>>> On Wed, Jul 15, 2020 at 1:54 PM Havard Skinnemoen
>>> <hskinnemoen@google.com> wrote:
>>>>
>>>> On Wed, Jul 15, 2020 at 3:57 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>>
>>>>> On 7/15/20 11:00 AM, Markus Armbruster wrote:
>>>>>> Now my point.  Why first make up user configuration, then use that to
>>>>>> create a BlockBackend, when you could just go ahead and create the
>>>>>> BlockBackend?
>>>>>
>>>>> CLI issue mostly.
>>>>>
>>>>> We can solve it similarly to the recent "sdcard: Do not allow invalid SD
>>>>> card sizes" patch:
>>>>>
>>>>>  if (!dinfo) {
>>>>>      error_setg(errp, "Missing SPI flash drive");
>>>>>      error_append_hint(errp, "You can use a dummy drive using:\n");
>>>>>      error_append_hint(errp, "-drive if=mtd,driver=null-co,"
>>>>>                              "read-ones=on,size=64M\n);
>>>>>      return;
>>>>>  }
>>>>>
>>>>> having npcm7xx_connect_flash() taking an Error* argument,
>>>>> and MachineClass::init() call it with &error_fatal.
>>>>
>>>> Erroring out if the user specifies a configuration that can't possibly
>>>> boot sounds good to me. Better than trying to come up with defaults
>>>> that are still not going to result in a bootable system.
>>>>
>>>> For testing recovery paths, I think it makes sense to explicitly
>>>> specify a null device as you suggest.
>>>
>>> Hmm, one problem. qom-test fails with
>>>
>>> qemu-system-aarch64: Missing SPI flash drive
>>> You can add a dummy drive using:
>>> -drive if=mtd,driver=null-co,read-zeroes=on,size=32M
>>> Broken pipe
>>> /usr/local/google/home/hskinnemoen/qemu/for-upstream/tests/qtest/libqtest.c:166:
>>> kill_qemu() tried to terminate QEMU process but encountered exit
>>> status 1 (expected 0)
>>> ERROR qom-test - too few tests run (expected 68, got 7)
>>>
>>> So it looks like we might need a different solution to this, unless we
>>> want to make generic tests more machine-aware...
> 
> I didn't follow the other mails in this thread, but what we usually do
> in such a case: Add a "if (qtest_enabled())" check to the device or the
> machine to ignore the error if it is running in qtest mode.

Hmm I'm not sure it works in this case. We could do:

  if (!dinfo) {
     if (qtest) {
        /* create null drive for qtest */
        opts = ...;
        dinfo = drive_new(opts, IF_MTD, &error_abort);
     } else {
        /* teach user to use proper CLI */
        error_setg(errp, "Missing SPI flash drive");
        error_append_hint(errp, "You can use a dummy drive using:\n");
        error_append_hint(errp, "-drive if=mtd,driver=null-co,"
                                "read-ones=on,size=64M\n);
     }
  }

But I'm not sure Markus will enjoy it :)

Markus, any better idea about how to handle that with automatic qtests?

Thanks :)

Phil.

> 
>  Thomas
> 
> 

