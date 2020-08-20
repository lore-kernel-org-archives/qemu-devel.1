Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0063C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2CE20885
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7s8F4AQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2CE20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8of0-0000KD-1Q
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8oeQ-0008C5-0l; Thu, 20 Aug 2020 13:46:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8oeO-0004AM-8T; Thu, 20 Aug 2020 13:46:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id k8so2443526wma.2;
 Thu, 20 Aug 2020 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=t9Dp645C08U5Ww6R62ktOgkmynXD/UDWfeGpGhS9brk=;
 b=j7s8F4AQMuSZag+cEj2nRJHDsPMhahzu4YK2Wkar1SInSdFsTSM67AQH18DGceQGIJ
 uE1+7oPASAAVUAtIV2es5QUcGcKdWRiJ6FLziCXbN6eZYfymuGrPuv/RUWKQahYfV0Su
 DcUux0V1//2YoEW9Z/i6nj7OYIm4qMIDGn9rgd2j7y8PacmZjzpT9IPBr2J9n8WWl6X/
 vTCgcjXrUI0PtoTxHM0NqneiR4s49MQbaEWHIjceuJPE0UH3RHHJiFS/nOqaNXKDeBa1
 7nUtmbaaDgfLm6vMP9aFgYYdz0gIjjN1CpjuogMBmDkTuNQtBBBrWSVOhDgfnFralLBx
 S1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t9Dp645C08U5Ww6R62ktOgkmynXD/UDWfeGpGhS9brk=;
 b=Dunn8XgJbDFrN5B6DfyRF94Ql+fjIIlqIYla8JWTUhOGOV2d7BhR8C6KXQV7DTExse
 EtWpF2CZ6J77CDm6DWquGu62e5ejmrxVu7wAv+inI0/Tz+KvkEZ2Y3dzWql4497n73V+
 9W1r2aM2vlxgLOV3GouOa9I/goXootJciiA6rGfoLoJNgJEkoPvP86fmm92+y7OCUrNi
 cEObzjWh2d44CSM0fNI/8Z2nKEc0djeG97kULn5FzNwoVEK0FoHJ6nks0s2hkO0+l1ss
 +WiII0xfmSF07ZdSapvGcN3VKTOOsk7Y1IA322HmBOUy9J4Au9t4uspy62yd/oI3ihls
 DOCw==
X-Gm-Message-State: AOAM533u+ubhbwWqq9OVAfU9qVvZTnnMFX/mpDj/qAqUG+JDLr/4EHvn
 w3Sm4H6A8vWh3FGvtyuKH0w=
X-Google-Smtp-Source: ABdhPJxZkgQ16oaTGNB86BJ82pGV8gzNNa2AdfFNYJuvNL+W4C7UFIAFADq1V2bSak3HFLZS7n4FRw==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr4477007wmh.20.1597945613708;
 Thu, 20 Aug 2020 10:46:53 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id f16sm5415387wro.34.2020.08.20.10.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 10:46:53 -0700 (PDT)
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6a23375f-64ec-cfdd-10cf-272eef719dd6@amsat.org>
Date: Thu, 20 Aug 2020 19:46:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRYFLUdbs5mj3zHzNN1y+bvQXCrtGhY_iOLVfnydGxM0Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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

On 8/20/20 6:24 PM, Havard Skinnemoen wrote:
> On Wed, Aug 19, 2020 at 10:29 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> +Eric / Richard for compiler optimizations.
>>
>> On 8/20/20 3:53 AM, Havard Skinnemoen wrote:
>>> On Tue, Aug 11, 2020 at 8:26 PM Havard Skinnemoen
>>> <hskinnemoen@google.com> wrote:
>>>>
>>>> On Tue, Aug 11, 2020 at 1:48 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>> INTERRUPTED: Test interrupted by SIGTERM
>>>>> Runner error occurred: Timeout reached
>>>>> (240.45 s)
>>>>>
>>>>> Is that expected?
>>>>
>>>> I'm not sure why it only happens when running direct kernel boot with
>>>> unoptimized qemu, but it seems a little happier if I enable a few more
>>>> peripherals that I have queued up (sd, ehci, ohci and rng), though not
>>>> enough.
>>>>
>>>> It still stalls for an awfully long time on "console: Run /init as
>>>> init process" though. I'm not sure what it's doing there. With -O2 it
>>>> only takes a couple of seconds to move on.
>>>
>>> So it turns out that the kernel gets _really_ sluggish when skipping
>>> the clock initialization normally done by the boot loader.
>>>
>>> I changed the reset value of CLKSEL like this:
>>>
>>> diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
>>> index 21ab4200d1..5e9849410f 100644
>>> --- a/hw/misc/npcm7xx_clk.c
>>> +++ b/hw/misc/npcm7xx_clk.c
>>> @@ -67,7 +67,7 @@ enum NPCM7xxCLKRegisters {
>>>   */
>>>  static const uint32_t cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
>>>      [NPCM7XX_CLK_CLKEN1]        = 0xffffffff,
>>> -    [NPCM7XX_CLK_CLKSEL]        = 0x004aaaaa,
>>> +    [NPCM7XX_CLK_CLKSEL]        = 0x004aaba9,
>>>      [NPCM7XX_CLK_CLKDIV1]       = 0x5413f855,
>>>      [NPCM7XX_CLK_PLLCON0]       = 0x00222101 | PLLCON_LOKI,
>>>      [NPCM7XX_CLK_PLLCON1]       = 0x00202101 | PLLCON_LOKI,
>>>
>>> which switches the CPU core and UART to run from PLL2 instead of
>>> CLKREF (25 MHz).
>>>
>>> With this change, the test passes without optimization:
>>>
>>>  (02/19) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_quanta_gsj_initrd:
>>> PASS (39.62 s)
>>>
>>> It doesn't look like this change hurts booting from the bootrom (IIUC
>>> the nuvoton bootblock overwrites CLKSEL anyway), but it's not super
>>> clean.
>>>
>>> Perhaps I should make it conditional on kernel_filename being set? Or
>>> would it be better to provide a write_board_setup hook for this?
>>
>> QEMU prefers to avoid ifdef'ry at all cost. However I find this
>> approach acceptable (anyway up to the maintainer):
>>
>> +static void npcm7xx_clk_cold_reset_fixup(NPCM7xxCLKState *s)
>> +{
>> +#ifndef __OPTIMIZE__
>> +    /*
>> +     * When built without optimization, ...
>> +     * so run CPU core and UART from PLL2 instead of CLKREF.
>> +     */
>> +    s->regs[NPCM7XX_CLK_CLKSEL] |= 0x103,
>> +#endif
>> +}
> 
> I think this is actually a problem regardless of optimization level.
> Turning optimization off amplifies the problem, but the problem is
> still there with optimization on.

OK, this reminds me few more details about the problem I had with the
raspi3 when adding the ClockPowerResetManager block.
Found the branch. A bit bitter/sad it was more than 1 year ago.

So if ARM_FEATURE_GENERIC_TIMER is available, Linux polls the CNTFRQ_EL0
register. At that time this register were using a fixed frequency:

#define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */

Xilinx' fork does it this way:
https://github.com/Xilinx/qemu/commit/9e939b54e2d

Now I see Andrew Jeffery fixed that in 96eec6b2b38
("target/arm: Prepare generic timer for per-platform CNTFRQ")
adding a 'cntfrq' property, which he then sets in the Aspeed
machine in commit 058d095532d ("ast2600: Configure CNTFRQ at 1125MHz").

Maybe your SoC is simply missing this property?

> 
> This does not affect booting a full flash image, as these fixups (and
> more) are done by the boot loader in that case.
> 
> Havard
> 

