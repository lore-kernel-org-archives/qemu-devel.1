Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FD2C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A1C216C4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGYu9R86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A1C216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFHOq-00059W-Qh
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 09:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFHO1-0004cF-HU; Mon, 07 Sep 2020 09:40:45 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:43565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFHNz-0001V1-Lg; Mon, 07 Sep 2020 09:40:45 -0400
Received: by mail-ej1-x643.google.com with SMTP id o8so5077238ejb.10;
 Mon, 07 Sep 2020 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mQz7J+ZjXCYnfaZAO7LPzDyU8dwXICb9lwINT022HTQ=;
 b=jGYu9R861cbjwppNeub8GtlIk7hr7h61DKDgYPAk+UF9IL5CoFoR4c08GoAYH3FA+/
 cuBJR1QHthcVhoGVPwoUTS7xzQqT38DwONsIqgIttebRRF07cd5LaKcawcixebzOu2hu
 E81iE5eXaMJsBv5s490pBwjh2RXvgoj2uOLRz1pvWVJfjsE8Hj6YnZggqZywJOAwp+Tn
 hGMFREH02Ujhv6ZFQzegBGVLc8/wS9KQTRsDU/hymSdFYRSEauGKYZCA77gEsYJXHat+
 FyB/m/rqxTqZhPnUxQogISooubWY0zY3NuGgGjzHwsImh1/ChbN5jkdpnBngbffdKlB/
 r9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mQz7J+ZjXCYnfaZAO7LPzDyU8dwXICb9lwINT022HTQ=;
 b=hGa8Bfrc96DmtqfUGDn5Wj2b2hacMdA2PRfhaml8AnPYrXrpNXnmI2nvx9YM5Cb5bz
 HaJ0Wqe16ZFtOZ69zPwoUJ2aD9Sd6E/Awh4j48GU0YvLyBFzlamIJtwgQ2TUMH0MdfLE
 J3lpY5VzDvgaqZaZqOQmdaXo1opIL7eWytkP4JWTZ3+swtar/rMGDdtkX/TVNbPJF8x1
 2v4nJF1G9Ki9hCfxvpfEI9bhJSRaYY4WBI4FEQTfj4Ulfyy40DD7HDlQRbJ8IyTRIQbX
 LMZZSCGreXXlTEwWHt1QLIrJhkItBanT3a3wa+pLNAx8JhoC9W12Fk7okkzJ29wbGMCH
 emoA==
X-Gm-Message-State: AOAM5301QM802yG2jQzaD+8K7zqHPiET7qfEswqc4roI+TNV4L3fpZEE
 6I//0mhT3/PFIogd9FvsYTM=
X-Google-Smtp-Source: ABdhPJz5Z1RAGPZxPMSsXMJt9VfUnx54t6CBeH1kN2Eaex4vkfOcdn4tK1v9DUMKWTxDI3CYq44yWA==
X-Received: by 2002:a17:906:2c44:: with SMTP id
 f4mr21355732ejh.52.1599486041953; 
 Mon, 07 Sep 2020 06:40:41 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k8sm12875827ejz.60.2020.09.07.06.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 06:40:40 -0700 (PDT)
Subject: Re: [PATCH v8 02/14] hw/misc: Add NPCM7xx Clock Controller device
 model
To: Havard Skinnemoen <hskinnemoen@google.com>
References: <20200825001711.1340443-1-hskinnemoen@google.com>
 <20200825001711.1340443-3-hskinnemoen@google.com>
 <e6187a7b-afc0-425a-de91-ea4818f7f876@amsat.org>
 <CAFQmdRbirDn4ao-B0UHHn-QFKfdeRzBR1dXTmUx_WZikfSB1tg@mail.gmail.com>
 <CAFQmdRbSgVTGgN2MV98wfxWSicrtokUCKKBU2knvVrimn2FWxA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8bd0d21c-d511-d814-da27-92114c47cfcc@amsat.org>
Date: Mon, 7 Sep 2020 15:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRbSgVTGgN2MV98wfxWSicrtokUCKKBU2knvVrimn2FWxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.825,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/5/20 12:38 AM, Havard Skinnemoen wrote:
> On Fri, Sep 4, 2020 at 3:02 PM Havard Skinnemoen <hskinnemoen@google.com> wrote:
>>
>> On Fri, Sep 4, 2020 at 2:32 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>
>>> On 8/25/20 2:16 AM, Havard Skinnemoen via wrote:
>>>> Enough functionality to boot the Linux kernel has been implemented. This
>>>> includes:
>>>>
>>>>   - Correct power-on reset values so the various clock rates can be
>>>>     accurately calculated.
>>>>   - Clock enables stick around when written.
>>>>
>>>> In addition, a best effort attempt to implement SECCNT and CNTR25M was
>>>> made even though I don't think the kernel needs them.
>>>>
>>>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>>> ---
[...]
>>>> +static void npcm7xx_clk_write(void *opaque, hwaddr offset,
>>>> +                              uint64_t v, unsigned size)
>>>> +{
>>>> +    uint32_t reg = offset / sizeof(uint32_t);
>>>> +    NPCM7xxCLKState *s = opaque;
>>>> +    uint32_t value = v;
>>>> +
>>>> +    trace_npcm7xx_clk_write(offset, value);
>>>> +
>>>> +    if (reg >= NPCM7XX_CLK_NR_REGS) {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>> +                      "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
>>>> +                      __func__, offset);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    switch (reg) {
>>>> +    case NPCM7XX_CLK_SWRSTR:
>>>> +        qemu_log_mask(LOG_UNIMP, "%s: SW reset not implemented: 0x%02x\n",
>>>> +                      __func__, value);
>>>
>>> Isn't this sufficient?
>>>
>>>            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>>
>> It's not quite that easy; this register holds 4 bits, each of which
>> maps to a separate register which defines the modules to reset. It's
>> not that hard, but a little more than I'd like to add to the series at
>> this point. I'll send a followup patch once the initial series is in.
> 
> Actually, I'm not sure if this would have any effect on being able to
> reboot. Running with -d unimp shows:
> 
> reboot: Restarting system
> npcm7xx_timer_write: WTCR write not implemented: 0x00000083
> Reboot failed -- System halted
> 
> So we need to implement watchdog support, which is something we were
> planning to do fairly soon.

Well this seems a guest implementation decision to prefer
wait the watchdog to kick (hard reset?) rather than doing
a soft reset.

Two different issues IMO. Anyway this is certainly not
blocking your series to get merged.

Regards,

Phil.

