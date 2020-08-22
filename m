Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81351C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 21:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44258206B5
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 21:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psoQbN0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44258206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9bGj-0007oB-FM
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 17:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9bFg-00070W-53; Sat, 22 Aug 2020 17:40:41 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9bFd-00057x-Rr; Sat, 22 Aug 2020 17:40:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id c19so3542235wmd.1;
 Sat, 22 Aug 2020 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Fv5box83k12mdUQDPoBRjIvFUAI8sC/U8NXckL9zSGQ=;
 b=psoQbN0bohZPR3v3Ho5MQ1B3R82cJXugJS6dVLGnF3X/2L4tXYFcQPkg+v2iRtHDcR
 Cly2mLLety9DfmfZ9NxnkilW3W2bruaocp0F/okv2Q38r8KzQtUZoQwCCql2BJJn/GqL
 rH9dAIo9uXRXOU7AKPxiaaQoFVo64wTS4f4qttcHcuI0Eshfl7SrFKUNavOB1ED+IZt5
 Etur/s/NxiJYnPTogOEYN2Um+C6DChtvi71gN8jr/ce2upDK9B9pLoGzZKeY6pGPPHvb
 s6PUbEzt5kiTyPL4P/uHPOGPlNhbIK2j+rPKkrAjEpOyrPdFic/Jj2TT1HSmhsHtEmtC
 QtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fv5box83k12mdUQDPoBRjIvFUAI8sC/U8NXckL9zSGQ=;
 b=lQGbu9mdFn4DvhYpjgJfDYRS+gv24qvlobq26wVCujbuzY2hjjUF9B40uoXFfJ4+xa
 L+0KNHcdR769b4fXZaoJOvSGLfMCM5tMjU3VlW0J8jW+GAdzbfxtUn4I2XIAj0uf7c/9
 xQqZyvuJh2jmg/nIYMxgDhQF59G8tURzvg7RiAN69+UvqoVIj7ipufcCJ5rvf8j2OlaW
 xhV1dIXIOZgIJN3vhi8IolkxJGaz7AnLcjrQKlGxDHn6ArxcY+0pUeeoWvc2sMdRs02S
 65UvSMTmk+uvucdc4PAzDQ2mmfb2bRov2PgKwSzMDBcKmo3jgO6ba4yWNyuRB2hHXrLD
 vZaQ==
X-Gm-Message-State: AOAM530/KqBeo41o4xWUjMPo1nbvsjMIsKP0NpyxT8oLTdF9p/5HHGD4
 RU99zVXon3oocrou3LZxWFY=
X-Google-Smtp-Source: ABdhPJxBn934NvjgRNsYdxFC8KBENE93HFnlynAzYOIKEjHY3zJ/UwlACtcP/DvBXNbFEXGMZXRTKA==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr83023wmh.56.1598132435242;
 Sat, 22 Aug 2020 14:40:35 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id s2sm12830084wrr.55.2020.08.22.14.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 14:40:34 -0700 (PDT)
Subject: Re: [PATCH v7 13/13] tests/acceptance: console boot tests for
 quanta-gsj
To: Havard Skinnemoen <hskinnemoen@google.com>
References: <20200811004607.2133149-1-hskinnemoen@google.com>
 <20200811004607.2133149-14-hskinnemoen@google.com>
 <64f8cd56-306e-4961-488b-36c666894a54@amsat.org>
 <CAFQmdRbvSKYJ00tE_79Eh+gW_ge8kEco=1gqFtvMcoJGraozdw@mail.gmail.com>
 <CAFQmdRZCk5Rqb1C2TRCEUMaKmF608g2_Or8mLCTSG03nCQ1Ygg@mail.gmail.com>
 <28a30c64-7cc5-4b4f-2be2-b3d3af511cb1@amsat.org>
 <CAFQmdRYFLUdbs5mj3zHzNN1y+bvQXCrtGhY_iOLVfnydGxM0Jw@mail.gmail.com>
 <6a23375f-64ec-cfdd-10cf-272eef719dd6@amsat.org>
 <CAFQmdRY9GSqjW+wcbRzsC6dEB9KMibnxWAp+F6jpmf2_9iBEFw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9fb5dbf1-f3bb-08a0-9758-a1d2e742a3d9@amsat.org>
Date: Sat, 22 Aug 2020 23:40:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRY9GSqjW+wcbRzsC6dEB9KMibnxWAp+F6jpmf2_9iBEFw@mail.gmail.com>
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Andrew Jeffery <andrew@aj.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Joel Stanley <joel@jms.id.au>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>,
 Cleber Rosa <crosa@redhat.com>, Richard Henderson <rth@twiddle.net>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Havard,

On 8/20/20 10:30 PM, Havard Skinnemoen wrote:
> On Thu, Aug 20, 2020 at 10:46 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 8/20/20 6:24 PM, Havard Skinnemoen wrote:
>>> On Wed, Aug 19, 2020 at 10:29 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> +Eric / Richard for compiler optimizations.
>>>>
>>>> On 8/20/20 3:53 AM, Havard Skinnemoen wrote:
>>>>> On Tue, Aug 11, 2020 at 8:26 PM Havard Skinnemoen
>>>>> <hskinnemoen@google.com> wrote:
>>>>>>
>>>>>> On Tue, Aug 11, 2020 at 1:48 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>>>> INTERRUPTED: Test interrupted by SIGTERM
>>>>>>> Runner error occurred: Timeout reached
>>>>>>> (240.45 s)
>>>>>>>
>>>>>>> Is that expected?
>>>>>>
>>>>>> I'm not sure why it only happens when running direct kernel boot with
>>>>>> unoptimized qemu, but it seems a little happier if I enable a few more
>>>>>> peripherals that I have queued up (sd, ehci, ohci and rng), though not
>>>>>> enough.
>>>>>>
>>>>>> It still stalls for an awfully long time on "console: Run /init as
>>>>>> init process" though. I'm not sure what it's doing there. With -O2 it
>>>>>> only takes a couple of seconds to move on.
>>>>>
>>>>> So it turns out that the kernel gets _really_ sluggish when skipping
>>>>> the clock initialization normally done by the boot loader.
>>>>>
>>>>> I changed the reset value of CLKSEL like this:
>>>>>
>>>>> diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
>>>>> index 21ab4200d1..5e9849410f 100644
>>>>> --- a/hw/misc/npcm7xx_clk.c
>>>>> +++ b/hw/misc/npcm7xx_clk.c
>>>>> @@ -67,7 +67,7 @@ enum NPCM7xxCLKRegisters {
>>>>>   */
>>>>>  static const uint32_t cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
>>>>>      [NPCM7XX_CLK_CLKEN1]        = 0xffffffff,
>>>>> -    [NPCM7XX_CLK_CLKSEL]        = 0x004aaaaa,
>>>>> +    [NPCM7XX_CLK_CLKSEL]        = 0x004aaba9,
>>>>>      [NPCM7XX_CLK_CLKDIV1]       = 0x5413f855,
>>>>>      [NPCM7XX_CLK_PLLCON0]       = 0x00222101 | PLLCON_LOKI,
>>>>>      [NPCM7XX_CLK_PLLCON1]       = 0x00202101 | PLLCON_LOKI,
>>>>>
>>>>> which switches the CPU core and UART to run from PLL2 instead of
>>>>> CLKREF (25 MHz).
>>>>>
>>>>> With this change, the test passes without optimization:
>>>>>
>>>>>  (02/19) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_quanta_gsj_initrd:
>>>>> PASS (39.62 s)
>>>>>
>>>>> It doesn't look like this change hurts booting from the bootrom (IIUC
>>>>> the nuvoton bootblock overwrites CLKSEL anyway), but it's not super
>>>>> clean.
>>>>>
>>>>> Perhaps I should make it conditional on kernel_filename being set? Or
>>>>> would it be better to provide a write_board_setup hook for this?
>>>>
>>>> QEMU prefers to avoid ifdef'ry at all cost. However I find this
>>>> approach acceptable (anyway up to the maintainer):
>>>>
>>>> +static void npcm7xx_clk_cold_reset_fixup(NPCM7xxCLKState *s)
>>>> +{
>>>> +#ifndef __OPTIMIZE__
>>>> +    /*
>>>> +     * When built without optimization, ...
>>>> +     * so run CPU core and UART from PLL2 instead of CLKREF.
>>>> +     */
>>>> +    s->regs[NPCM7XX_CLK_CLKSEL] |= 0x103,
>>>> +#endif
>>>> +}
>>>
>>> I think this is actually a problem regardless of optimization level.
>>> Turning optimization off amplifies the problem, but the problem is
>>> still there with optimization on.
>>
>> OK, this reminds me few more details about the problem I had with the
>> raspi3 when adding the ClockPowerResetManager block.
>> Found the branch. A bit bitter/sad it was more than 1 year ago.
>>
>> So if ARM_FEATURE_GENERIC_TIMER is available, Linux polls the CNTFRQ_EL0
>> register. At that time this register were using a fixed frequency:
>>
>> #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
>>
>> Xilinx' fork does it this way:
>> https://github.com/Xilinx/qemu/commit/9e939b54e2d
>>
>> Now I see Andrew Jeffery fixed that in 96eec6b2b38
>> ("target/arm: Prepare generic timer for per-platform CNTFRQ")
>> adding a 'cntfrq' property, which he then sets in the Aspeed
>> machine in commit 058d095532d ("ast2600: Configure CNTFRQ at 1125MHz").
>>
>> Maybe your SoC is simply missing this property?
> 
> Hmm, it doesn't look like Cortex-A9 has this property...
> 
> Unexpected error in object_property_find() at
> /usr/local/google/home/hskinnemoen/qemu/upstream/qom/object.c:1254:
> qemu-system-arm: Property '.cntfrq' not found
> 
> However, I did notice there are a lot of constraints on input
> frequencies to the CPU and various peripherals, and many of these are
> not met by the power-on reset values.

Oh OK.

> 
> For example, the UART needs a 24 MHz input clock, but there's no way
> to generate this from the default 25 MHz reference clock. However,
> PLL2 is set up to run at 960 MHz by default (as soon as it's locked),
> with a fixed /2 divider. The UART uses a /20 divider by default, so it
> gets a 25 MHz / 20 = 1.25 MHz clock with power-on defaults. However,
> switching the source to PLL2 results in 960 MHz / 2 / 20 = 24 MHz.

Yes, thanks to Damien's work we can now use the Clock API to model
that correctly. This API is very recent, and very few devices use
it. We need to adapt them one by one.

I started with the serial:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg727975.html

> Similarly, the CPU is supposed to run at 800 MHz, but it runs at 25
> MHz with power-on defaults. PLL1 runs at 800 MHz by default, with a
> fixed /2 divider. The boot loader doubles the feedback divider so it
> turns into 1600 MHz / 2 = 800 MHz.

I noticed in my projects is that the Clock API lacks something
like a FixedDividerClock. qdev_init_clock_in() expects a callback,
but with fixed divisor we could have the divisor in a state and
use a generic callback, but the callback doesn't take pointer to
state.

Maybe that can be a new field in NamedClockList. I didn't had time
to write patches tests and ping Damien/Peter about it, but will do
during Sept.

> 
> Turns out I was wrong above, the patch snippet routes PLL1, not PLL2,
> to the CPU. But it will only result in half the recommended speed, so
> a patch to PLLCON1 is needed as well.
> 
> It seems like the cleanest solution would be to add a
> write_board_setup hook to fix up these registers so clocks are within
> normal ranges when bypassing the boot loader. In particular:
> 
>   - Switch UART to PLL2 for a 24 MHz input clock.
>   - Set up PLL1 to run at 1600 MHz.
>   - Switch the CPU core to PLL1 / 2 for a 800 MHz input clock.
> 
> Does that make sense? It should be just three simple register writes,
> which is doable with hand-edited machine code.

It makes sense but since (I guess) we could properly model that using
the Clock API, this hook is a temporary kludge...
I'm not against it however, since except this detail, this series is
almost perfect, and you already spent enough time.
IOW IMHO this kludge is acceptable for now, and modelling the missing
parts to use the Clock API can be done on top (or not...).

> 
> I'll add this as a separate patch (right before the acceptance test)
> so it's clear what's happening.
> 
> Unfortunately, I haven't been able to make the flash boot test pass
> without optimization. U-boot seems to have a tiny buffer for the
> command line, so I can only disable two or three systemd services
> before it gets truncated. I might try to create a reduced openbmc
> image instead.

I haven't think of that limitation. I rather prefer we test the
original OpenBMC image. Simply disable the 3 longest services,
and we'll adjust the test time.

Thanks for the detailed info you provided.

Regards,

Phil.

> 
> Havard
> 

