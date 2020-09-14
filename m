Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F32C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F5C2192A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXcMOSHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F5C2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHjEu-00028z-3K
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHjEI-0001Tj-Fs; Mon, 14 Sep 2020 03:48:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHjEG-0005uo-R2; Mon, 14 Sep 2020 03:48:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id s12so17521459wrw.11;
 Mon, 14 Sep 2020 00:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NwrQ0DkGFEgGK9nc67nxSYlOD26Hr7H8K1EFI4yupTs=;
 b=hXcMOSHbrnauO6UQnAFW1UEK1JgUQ1PYk3JwdscZtOi0i6ns1OTG/IL6ULeHOBA1Vz
 2/sxEM3eZEqvMZHaTT3kjtzzA1b0hgRErlcxB6wGAZLcB2xLu3MT0TMyLivds2EEO+Sf
 jTx6I2aJAqF2tRt0nag8rI9IyrXJNNfoTchoodsVc8Ay7PM+UMnHzoU3HHQ+wkU29+OO
 MzF+0BTBCKRlLjvlJu1Dw5ttFquU3RDILFYN8H8eLbZ33gMsAHCtJlnePoSjGhjAUrrb
 x4fq8DnfVbAJR1sxWICD7XXutM3HFRH0ze7ui2Eo7Ynl6bzb+Npzgh4pU9B3yiXHnbsO
 U8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NwrQ0DkGFEgGK9nc67nxSYlOD26Hr7H8K1EFI4yupTs=;
 b=HO/TpyFA8yXWuriKewVhbE6C1iLuxzHwzNGCbj6+mjiotBkve26xQGJVimOFpsBF3K
 /lrFe97KxxOGMHZHX/b/i2tpsI3D63x7Pcqp6s/jMM3OWzgREckJieP0TWOhKUAg7U3e
 OEVbfNRyIvvFgHr+WpMjRgdKnzHRACeSSgViJ6lL3qwUWrOg0gS7nLcwN/gFw0/1OIGj
 ozI2n0TrjKytroFdHk66jbbxHHtCgSkEoIdyytA7E3uZ4qntHoikOZagDLgSQ0WkFRrZ
 Qu4o7fJhRZcDdsJ3KmnxvitZSLlqga8fjChbFPhqvmE4lwernzWhrLlcNU3KNgVaDbNX
 mltQ==
X-Gm-Message-State: AOAM530XHSmtUyc1/Ipp/qUGI4ptLeSrxarrn4BqilpXoM1kyX5rGRLt
 tuePJrhQzojtliJ2tRn56ig=
X-Google-Smtp-Source: ABdhPJwcVR+ddCVxCqjQtY9jLthQIZwhXafigdiRi1pg8KyaEEjUsajInV32uI7rNVHlyc3qJW8qrw==
X-Received: by 2002:adf:e488:: with SMTP id i8mr15357815wrm.116.1600069727027; 
 Mon, 14 Sep 2020 00:48:47 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v6sm19153944wrt.90.2020.09.14.00.48.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 00:48:46 -0700 (PDT)
Subject: Re: [PATCH v5 2/7] hw/misc/led: Allow connecting from GPIO output
To: Markus Armbruster <armbru@redhat.com>
References: <20200910205429.727766-1-f4bug@amsat.org>
 <20200910205429.727766-3-f4bug@amsat.org>
 <071b68a6-58e4-0d68-e056-ee7ae19e2227@linaro.org>
 <db55f80e-ca2d-d432-134b-a05333a7e124@amsat.org>
 <87imcg4y3l.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f451861f-fa21-6465-865e-9d5e42e165b5@amsat.org>
Date: Mon, 14 Sep 2020 09:48:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87imcg4y3l.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 9:27 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Eduardo is already in Cc, adding Markus.
>>
>> On 9/12/20 12:44 AM, Richard Henderson wrote:
>>> On 9/10/20 1:54 PM, Philippe Mathieu-Daudé wrote:
>>>> Some devices expose GPIO lines.
>>>>
>>>> Add a GPIO qdev input to our LED device, so we can
>>>> connect a GPIO output using qdev_connect_gpio_out().
>>>>
>>>> When used with GPIOs, the intensity can only be either
>>>> minium or maximum. This depends of the polarity of the
>>>> GPIO (which can be inverted).
>>>> Declare the GpioPolarity type to model the polarity.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>  include/hw/misc/led.h  |  8 ++++++++
>>>>  include/hw/qdev-core.h |  8 ++++++++
>>>>  hw/misc/led.c          | 17 ++++++++++++++++-
>>>>  3 files changed, 32 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
>>>> index f5afaa34bfb..71c9b8c59bf 100644
>>>> --- a/include/hw/misc/led.h
>>>> +++ b/include/hw/misc/led.h
>>>> @@ -38,10 +38,16 @@ typedef struct LEDState {
>>>>      /* Public */
>>>>  
>>>>      uint8_t intensity_percent;
>>>> +    qemu_irq irq;
>>>>  
>>>>      /* Properties */
>>>>      char *description;
>>>>      char *color;
>>>> +    /*
>>>> +     * When used with GPIO, the intensity at reset is related
>>>> +     * to the GPIO polarity.
>>>> +     */
>>>> +    bool inverted_polarity;
>>>
>>> Why are you not using the GpioPolarity enum that you added?
>>
>> Because it is migrated...
>>
>> Using DEFINE_PROP_BOOL() is simpler that adding hardware specific
>> enum visitor in hw/core/qdev-properties.c (which is included in
>> user-mode builds because pulled by the CPU type).
> 
> Yes.
> 
> You could also use DEFINE_PROP_UINT8(), and use it with your enumeration
> constants.
> 
> I'd be tempted to ditch the enum entirely.  Matter of taste, no big deal
> either way.

Done in v6!

> 
>> A sane cleanup would be to make get_enum(), set_enum()
>> and set_default_value_enum() public (prefixed with 'qdev_')
>> in include/hw/qdev-properties.h.
> 
> Purpose?  To be able to define enum properties outside
> qdev-properties.c?

Yes, to avoid pulling in PCI and MAC address properties
into qemu-storage-daemon and linux-user binaries...

