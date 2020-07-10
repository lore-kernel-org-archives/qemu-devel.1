Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89BFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9658120725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klfEIH8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9658120725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpOY-0001mV-SL
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtpNk-0000iw-Nw; Fri, 10 Jul 2020 05:31:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtpNi-0004fJ-Id; Fri, 10 Jul 2020 05:31:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id z15so5215194wrl.8;
 Fri, 10 Jul 2020 02:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jbwK77+qQUrpJFsJfpQv7PNojt2bhaOZlYuEm6uiWHU=;
 b=klfEIH8xeoUccOeFTaCGJJQneb+E1lhw8TA4MZS6LmSZ0hHG44tTo5yN5/c6a90j51
 PtYz24ERUs2/9JiUd+PDQ9YsM2I5qzjBEvQ11lQi5sajg4TCa89OJAF30FZ5UuLgrt20
 RiDsZjKL53n81N2pEH1/rpuRnPcNTiDxPYK8olN85W+soiDqcZDoWP5iTSxNqRkM4dqM
 Xl/VhiHCLlTpsgMkyzTWuTExG4eSnwOv0HwOU/7t8vCeop376ZZpHo28VzZhfke5iomW
 5P5BtX94BK4f6uJ3sapb8jGAjy8NDq8oOwl5wEJyBrpg7u01MtjWSHJPuMOqJbzdoJ8p
 q7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jbwK77+qQUrpJFsJfpQv7PNojt2bhaOZlYuEm6uiWHU=;
 b=WqFLIaAvrE2YavVZyespiVprXxhPKtNd6rFFt6gLtMGqWTll7Pm3DWMyxaukiu3B9g
 skzlkvQynyu8PeBpLGrVhRtHglGz3zhH+KZl5RYpOW0b8Cn95nlUfyoJyGSdM3UU0Txs
 jBt/dJTpN4cpAsu1otyGy1DmZSfxpEViHJl+urAEdl/j7gwG/lv3B0JFFIxfg1oKx8iO
 JzZNzWoFnZEXy/VYQWhVarwump0eFwrIu2j/rx57rQEv4O3ksepAKZTeMzzqpVN2Y8AX
 Pyu/sdG7G+V6JiawMg5l9ngj7oYXf+z75UtN7YKqag3/jvGA4fTLojoMTCtTcXXRU6I0
 GmZA==
X-Gm-Message-State: AOAM530r83PakQAGPfHPKXRdISvsM+k3CXXKCvdBB74Yz034eIe2D6u+
 fziy3v3GyRk4hswLVHkBLBs=
X-Google-Smtp-Source: ABdhPJwv4RHQaHvpNEIep14e3fAenF1ee/EkzdeCz+mLivfTk13n9d2i1R+GE6VX5Ysq/zAmeEeg6A==
X-Received: by 2002:a05:6000:1190:: with SMTP id
 g16mr64209932wrx.286.1594373504322; 
 Fri, 10 Jul 2020 02:31:44 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id n5sm8391612wmi.34.2020.07.10.02.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 02:31:43 -0700 (PDT)
Subject: Re: [PATCH v5 01/11] hw/misc: Add NPCM7xx System Global Control
 Registers device model
To: Havard Skinnemoen <hskinnemoen@google.com>
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-2-hskinnemoen@google.com>
 <2fe8ea5e-56de-f57f-6146-8355125daa7f@amsat.org>
 <CAFQmdRYx99PpWz6bftCvBR7=YRftD_WNex_A9aoDaeRg=4tsCw@mail.gmail.com>
 <bd2972b0-0684-e379-6d66-16ceb62deade@amsat.org>
 <CAFQmdRbHXhd9-HUQP5ET=JQEnQ3FMCQBHajwZrP5d7=iCc0tzA@mail.gmail.com>
 <ee8bc620-6d58-98ef-1c53-a8687282af50@amsat.org>
 <CAFQmdRa3u_Sst0i6e2whoJcYau15gVQubhZHmm+z26SD8G8uCQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c19401c1-f629-a95f-c8a5-60df78e41061@amsat.org>
Date: Fri, 10 Jul 2020 11:31:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRa3u_Sst0i6e2whoJcYau15gVQubhZHmm+z26SD8G8uCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, PDS_OTHER_BAD_TLD=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 7:42 PM, Havard Skinnemoen wrote:
> On Thu, Jul 9, 2020 at 10:24 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 7/9/20 7:09 PM, Havard Skinnemoen wrote:
>>> On Thu, Jul 9, 2020 at 9:23 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>> On 7/9/20 8:43 AM, Havard Skinnemoen wrote:
>>>>> On Wed, Jul 8, 2020 at 11:04 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>>> On 7/9/20 2:35 AM, Havard Skinnemoen wrote:
>>>>>>> Implement a device model for the System Global Control Registers in the
>>>>>>> NPCM730 and NPCM750 BMC SoCs.
>>>>>>>
>>>>>>> This is primarily used to enable SMP boot (the boot ROM spins reading
>>>>>>> the SCRPAD register) and DDR memory initialization; other registers are
>>>>>>> best effort for now.
>>>>>>>
>>>>>>> The reset values of the MDLR and PWRON registers are determined by the
>>>>>>> SoC variant (730 vs 750) and board straps respectively.
>>>>>>>
>>>>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>>>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>>>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>>>>>> ---
[...]
>>>>>> Maybe use HWADDR_PRIx instead of casting to int?
>>>>>
>>>>> Will do, thanks!
>>>>
>>>> Glad you are not annoyed by my review comments.
>>>>
>>>> FYI your series quality is in my top-4 "adding new machine to QEMU".
>>>> I'd like to use it as example to follow.
>>>>
>>>> I am slowly reviewing because this is not part of my work duties,
>>>> so I do that in my free time before/after work, which is why I can
>>>> barely do more that 2 per day, as I have to learn the SoC and
>>>> cross check documentation (or in this case, existing firmware code
>>>> since there is no public doc).
>>>
>>> Your feedback is super valuable, thanks a lot. I really appreciate it.
>>
>> OK I'll continue, but might not have time until next week.
>> After I plan to test too.
> 
> OK, I'll try to post a v6 before the weekend, unless you prefer that I
> hold off until you've reviewed the whole series.

I don't mind, if it is not too much overhead on your side.

What I noticed on the QEMU community is:

- If a series reviewed the same day and is almost done except
  a single bugfix, it is OK to repost the same day, so the
  maintainer is likely to queue it directly.

- If there are various reviews, and you do gradual improvements,
  it is OK to repost every 3 days. Else reviewers tend to skip/
  postpone your series for later.

- Pinging for review before 1 week passed is stressing reviewers,
  except in case of critical security bug (CVE) or during freeze.

- Series with integrated test provided are usually reviewed first.

>> What would be useful is an acceptance test (see examples in
>> tests/acceptance/), using the artefacts from the link you shared
>> elsewhere:
>> https://openpower.xyz/job/run-meta-ci/distro=ubuntu,label=builder,target=gsj/lastSuccessfulBuild/artifact/openbmc/build/tmp/deploy/images/gsj/
> 
> Yes, tests are definitely on my radar. I'm working on SPI flash
> qtests. I haven't had much success with avocado yet, but I'll keep
> trying (perhaps using docker to control the environment more tightly).

This might help:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg704907.html

> Since the 5.1 release is frozen now, I might post some followup
> patches before this series is merged, e.g. tests, bootrom
> submodule+blob, more peripherals, etc. Is it preferable to keep this
> series frozen (modulo API updates) since you spent a lot of time
> reviewing it, and post the new stuff separately, or is it better to
> add new patches to the end of the series and resend the whole thing?

If you rework a peripheral, you need to reset the Reviewed-by/Tested-by
tags. If you add new peripherals, you only need to reset these tags on
the SoC patch. I'm fine either way, I use git-backport-diff to see the
SoC changes easily:

https://github.com/codyprime/git-scripts/blob/master/git-backport-diff

> 
>> But these are apparently not stable links (expire after 30 days?).
> 
> Sorry, I'm too ignorant about Jenkins to know. I'll see if I can
> figure something out.

What I do in that case is take the binary used for the test,
write a comment and push it in a stable branch to my own repo:
https://github.com/philmd/qemu-testing-blob/ and use the stable
url in the test.

We know QEMU emulation worked with this particular binary at some
point. We want to avoid regressions in QEMU, so let's keep testing
what we know worked. We don't want to track 2 bugs at a time (one
in the updated guest and one in QEMU).

Regards,

Phil.

