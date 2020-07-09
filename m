Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E35C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8294F2074A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko5Y2J1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8294F2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXek-0001Kt-Og
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtXe0-0000mJ-Ub; Thu, 09 Jul 2020 10:35:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtXdz-0003E3-HR; Thu, 09 Jul 2020 10:35:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id o8so2066468wmh.4;
 Thu, 09 Jul 2020 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X9oKZ/ANcQElZAIZWlP72sCmNJzLo8MYedwue9IGwIc=;
 b=Ko5Y2J1M9q6Yf0oQjXBz/lcHduCIPPskclKMsm1p70zbo+q1u4B5o3Hb6J2ePHSCo2
 WxPN1Zi4rq5hxOQM78VNtMiI8Q4BvPpC/PKVOUpbg0o6ZRDDmn2qQiA9RHrjTXBiaCoa
 OfT5wewXHx28Y3Uj1Ai9C9Xoq8KtiYiRJLXmNHVtxpOnr6wIzPDystiuLggbhU2CexaS
 1EeBlqGDehgOuEQo8o0LwrifFLbQcJWpqfzm6cPVlt6DkTN3ZoWsmGqwJbjXsAQOeawQ
 blwTF7VkiX7fN09MQo0Afkkgv4Cj7NbGMTJxgelVfIKUi20kCBAKD0QFsNxoWw6qbjOz
 k7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X9oKZ/ANcQElZAIZWlP72sCmNJzLo8MYedwue9IGwIc=;
 b=LHQYJeJA7heGCBP5Dla/jvLk5MdvMgbOV/kp2G+lsL4skXGJdSCe3cvquWLiqu2sRt
 W9OW2kMcxEBTf/LGO6iqOhSyq1mPD01DisV86CDahOJ5dKQ9RhOe5AKkF7UGlpBIOV+y
 Eti9Y+R5huyz+nqCVHQVHBKJ7C+q4T8Lm++32XuK1bWQmpJjLuJ3xhLeJ/Uqsais/t0J
 YTLqErgX2WRBYAYm9Wwxl9/O26OjspgYgenCPHQ1+t7Ufmysr9VO3G+C8NGn8cdk98VU
 nb2uPPwK51l0icrDl5wfcfZ56uraj6UYnLFpNmkrdXLbJCWDex+KyBhegkPmAPueYP0E
 5ULQ==
X-Gm-Message-State: AOAM533ld6DUpAvh9LZxpDGv1GxSC1HdNhz+8zAs9hHlBQjgkI5lTmC1
 DLZn8HM+NPze5BbtmrgyHQI=
X-Google-Smtp-Source: ABdhPJxp9bxjFkDBvt8ZEmRCb+tBC6Iy96pJJyMuz/FMM8E6QTgTxAr5f/EdLrun6hQ2+6sN2x/eng==
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr340771wmj.152.1594305321638; 
 Thu, 09 Jul 2020 07:35:21 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 69sm5279505wma.16.2020.07.09.07.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 07:35:20 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-3-f4bug@amsat.org>
 <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
 <CAFEAcA_ZXgNHMAhBVmjvstyG=PpaHOtcmo=VgvfBQ3Z9VJTk_g@mail.gmail.com>
 <3f1bf3ba-d6c3-a148-9850-076b2caa64d0@amsat.org>
 <CAPan3Wr09ZbbHWO-dhGeK3zhZQv3smrzLpUGMj71NWh0hToZDg@mail.gmail.com>
 <e87550d9-e1cc-cc15-2674-755249e9a965@amsat.org>
 <CAFEAcA8em-bgU2xd8OG+bPLDCSZCF8Y2ay9U57D8p9m1SWO=9g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f263f4aa-eb94-8760-6fc4-a1d46c15d099@amsat.org>
Date: Thu, 9 Jul 2020 16:35:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8em-bgU2xd8OG+bPLDCSZCF8Y2ay9U57D8p9m1SWO=9g@mail.gmail.com>
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 4:15 PM, Peter Maydell wrote:
> On Thu, 9 Jul 2020 at 14:56, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 7/7/20 10:29 PM, Niek Linnenbank wrote:
>>> So I manually copy & pasted the change into hw/sd/sd.c to test it.
>>> It looks like the check works, but my concern is that with this change,
>>> we will be getting this error on 'off-the-shelf' images as well.
>>> For example, the latest Raspbian image size also isn't a power of two:
>>>
>>> $ ./arm-softmmu/qemu-system-arm -M raspi2 -sd
>>> ~/Downloads/2020-05-27-raspios-buster-lite-armhf.img -nographic
>>> WARNING: Image format was not specified for
>>> '/home/me/Downloads/2020-05-27-raspios-buster-lite-armhf.img' and
>>> probing guessed raw.
>>>          Automatically detecting the format is dangerous for raw images,
>>> write operations on block 0 will be restricted.
>>>          Specify the 'raw' format explicitly to remove the restrictions.
>>> qemu-system-arm: Invalid SD card size: 1.73 GiB (expecting at least 2 GiB)
>>>
>>> If we do decide that the change is needed, I would like to propose that
>>> we also give the user some instructions
>>> on how to fix it, maybe some 'dd' command?
>>
>> On POSIX we can suggest to use 'truncate -s 2G' from coreutils.
>> This is not in the default Darwin packages.
>> On Windows I have no clue.
> 
> dd/truncate etc won't work if the image file is not raw (eg if
> it's qcow2).

Good catch...

> The only chance you have of something that's actually
> generic would probably involve "qemu-img resize". But I'm a bit
> wary of having an error message that recommends that, because
> what if we got it wrong?

I am not sure what to recommend then.

Would that work as hint?

  qemu-system-arm -M raspi2 -sd ./buster-lite-armhf.img
  qemu-system-arm: Invalid SD card size: 1.73 GiB
  SD card size has to be a power of 2, e.g. 2GiB.

