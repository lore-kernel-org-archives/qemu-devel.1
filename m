Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8C1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 05:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D0C2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 05:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCVQpbRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D0C2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8d9F-0006QT-E5
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 01:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8d8b-0005ty-CG; Thu, 20 Aug 2020 01:29:21 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8d8Z-0000Ov-QK; Thu, 20 Aug 2020 01:29:21 -0400
Received: by mail-wm1-x343.google.com with SMTP id k20so492018wmi.5;
 Wed, 19 Aug 2020 22:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bZMYDU3bN9MTRIT/lUf7fiDWoggXE5c6pzgwRUkTJD4=;
 b=qCVQpbRRy2Pk2uENfSkTU6o9RggdlydBukF7qULoHNFahTjj38GzCE+k7duUw9GeUO
 zBO/4QRv+ZOZHn0fedKuhv69Atc63hyuUt32BhUMxduPjYsVbnqRaxzYe08MICE/QJ2P
 KbqAvmBnTDw3Hc1XsIBN3xsLX9OBFpTX9VuJDgUz2O/s/AOhX9Vl8+WOz1Kd4aIrKdNt
 RE9hdf25tMp3bEuiOnhozc1ajvYeKGTeeVfnr4TxkdUi+ZsOK7HtitNuE71QYtmLbuSN
 agZxtzerxT8Qyj0xwNimfl590W2xqkT+k9kjmzUjIPoyLulFjDh9OgkZGY+jn+JHJZSA
 UplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bZMYDU3bN9MTRIT/lUf7fiDWoggXE5c6pzgwRUkTJD4=;
 b=gvWfNtKXhk7KnmEl+PHgPiKBtSc+HuQfZRz+Muw6Tkef95V89qVnTFnswjdVIYg4MW
 0xTjGOrxkIwC4Br+DUpEsOv/y3MtpjjoJ1/cUB3BLMryFIDHCwiYwyLPSjPj7GdXeXKz
 G0OJHRB6qmFbsEtk6wNfvDV6YNmKPDNIGH4vQNM/Z6lkVmXKLE98JFt66ZUKd6ghD4UW
 d/GC5IedI9jOObNObEXi4kJCNAs3G51dwC2vB5J0jPvyz3ic/mdPwOonkQHs0RX36Xey
 0Wder0EQmVg7L3D7BOKv8jZT+ntrdXZGoe6Ir+ZQeXxvd9YohWx4xN5WInXZjrypMKKH
 nZew==
X-Gm-Message-State: AOAM5337Zqx22I3bC5Ca8V1s6RcgYSr8t7ZV5dulLcxpBb4Om+t1G5cp
 C5RzpFVNIOU2sAbcJGgWuvk=
X-Google-Smtp-Source: ABdhPJy8CfukeyZbogReU+PaYbTrfYKhheHJfHlmhPt57OoMHu2HaVssInLOsA+8yJlIIG8QWSkUAw==
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr1637916wmj.124.1597901357470; 
 Wed, 19 Aug 2020 22:29:17 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id p22sm1889782wmc.38.2020.08.19.22.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 22:29:16 -0700 (PDT)
Subject: Re: [PATCH v7 13/13] tests/acceptance: console boot tests for
 quanta-gsj
To: Havard Skinnemoen <hskinnemoen@google.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200811004607.2133149-1-hskinnemoen@google.com>
 <20200811004607.2133149-14-hskinnemoen@google.com>
 <64f8cd56-306e-4961-488b-36c666894a54@amsat.org>
 <CAFQmdRbvSKYJ00tE_79Eh+gW_ge8kEco=1gqFtvMcoJGraozdw@mail.gmail.com>
 <CAFQmdRZCk5Rqb1C2TRCEUMaKmF608g2_Or8mLCTSG03nCQ1Ygg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <28a30c64-7cc5-4b4f-2be2-b3d3af511cb1@amsat.org>
Date: Thu, 20 Aug 2020 07:29:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRZCk5Rqb1C2TRCEUMaKmF608g2_Or8mLCTSG03nCQ1Ygg@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Joel Stanley <joel@jms.id.au>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Cleber Rosa <crosa@redhat.com>, Richard Henderson <rth@twiddle.net>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Eric / Richard for compiler optimizations.

On 8/20/20 3:53 AM, Havard Skinnemoen wrote:
> On Tue, Aug 11, 2020 at 8:26 PM Havard Skinnemoen
> <hskinnemoen@google.com> wrote:
>>
>> On Tue, Aug 11, 2020 at 1:48 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>> INTERRUPTED: Test interrupted by SIGTERM
>>> Runner error occurred: Timeout reached
>>> (240.45 s)
>>>
>>> Is that expected?
>>
>> I'm not sure why it only happens when running direct kernel boot with
>> unoptimized qemu, but it seems a little happier if I enable a few more
>> peripherals that I have queued up (sd, ehci, ohci and rng), though not
>> enough.
>>
>> It still stalls for an awfully long time on "console: Run /init as
>> init process" though. I'm not sure what it's doing there. With -O2 it
>> only takes a couple of seconds to move on.
> 
> So it turns out that the kernel gets _really_ sluggish when skipping
> the clock initialization normally done by the boot loader.
> 
> I changed the reset value of CLKSEL like this:
> 
> diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
> index 21ab4200d1..5e9849410f 100644
> --- a/hw/misc/npcm7xx_clk.c
> +++ b/hw/misc/npcm7xx_clk.c
> @@ -67,7 +67,7 @@ enum NPCM7xxCLKRegisters {
>   */
>  static const uint32_t cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
>      [NPCM7XX_CLK_CLKEN1]        = 0xffffffff,
> -    [NPCM7XX_CLK_CLKSEL]        = 0x004aaaaa,
> +    [NPCM7XX_CLK_CLKSEL]        = 0x004aaba9,
>      [NPCM7XX_CLK_CLKDIV1]       = 0x5413f855,
>      [NPCM7XX_CLK_PLLCON0]       = 0x00222101 | PLLCON_LOKI,
>      [NPCM7XX_CLK_PLLCON1]       = 0x00202101 | PLLCON_LOKI,
> 
> which switches the CPU core and UART to run from PLL2 instead of
> CLKREF (25 MHz).
> 
> With this change, the test passes without optimization:
> 
>  (02/19) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_quanta_gsj_initrd:
> PASS (39.62 s)
> 
> It doesn't look like this change hurts booting from the bootrom (IIUC
> the nuvoton bootblock overwrites CLKSEL anyway), but it's not super
> clean.
> 
> Perhaps I should make it conditional on kernel_filename being set? Or
> would it be better to provide a write_board_setup hook for this?

QEMU prefers to avoid ifdef'ry at all cost. However I find this
approach acceptable (anyway up to the maintainer):

+static void npcm7xx_clk_cold_reset_fixup(NPCM7xxCLKState *s)
+{
+#ifndef __OPTIMIZE__
+    /*
+     * When built without optimization, ...
+     * so run CPU core and UART from PLL2 instead of CLKREF.
+     */
+    s->regs[NPCM7XX_CLK_CLKSEL] |= 0x103,
+#endif
+}

 static void npcm7xx_clk_enter_reset(Object *obj, ResetType type)
 {
     NPCM7xxCLKState *s = NPCM7XX_CLK(obj);

     QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));

     switch (type) {
     case RESET_TYPE_COLD:
         memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
+        npcm7xx_clk_cold_reset_fixup(s);
         s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         return;
     }
     ...

Regards,

Phil.

