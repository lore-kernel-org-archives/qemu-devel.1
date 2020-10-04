Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC4DC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 20:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA3B2068E
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 20:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHH2NnRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA3B2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPATI-00064B-Ld
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 16:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPAS2-0005BD-B1; Sun, 04 Oct 2020 16:17:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPAS0-0006BM-Ht; Sun, 04 Oct 2020 16:17:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id t10so7308471wrv.1;
 Sun, 04 Oct 2020 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lNBlfs3DDUcJBQHUwmk1uWRH7eQlwOERdywbZr/j6HE=;
 b=EHH2NnRSlIBs6zCNj2uGTzSwMsCKnfzYZuZw9sfOusbQw0Cq/2fV0BOCQ+K87ePP5Q
 G+A9RoNNcM40AG8s/jrnrwdXuUTTsQVYsUZXq9wg6BWJQ3RMZ6z19efNeIhICW4xEVYa
 2FXfoE6iWi9RKWf7EHX90YVufVNhCIjtYOV66TZqUr304/xAuOJG9C5XJRNhIkYyma24
 w05WFVSgFQQlOwS2AmkQb3D357FTNE8usiC2TOAdptRsnitoukqZdi58QKVGLaTlkmFB
 S1VD7l264AwHvSPMXoFkgKtP2Hc/2qt3XE1NSpYlCuFI46jsidBAHTHdOs8qcj9QSKK2
 q7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lNBlfs3DDUcJBQHUwmk1uWRH7eQlwOERdywbZr/j6HE=;
 b=VQoZ4EVsW4jKlte8MvjUrR8qwYRQHqS5joAXEzDvG9HvCm8+Z/K1g3SUFASMBwNm4p
 lnaMnFoP/kCUwsBYROUcAI4to2T4bgn6wCrYiw1wxoxZZlD7El3Ryp8b/3TPsg5vleKq
 Awj6RstMqUZ/58Wf6IdNPkdDxFvawqLp34uuy7z1tAXDFv6YSjp/e7Srd6YJHvHv6gJQ
 kM1JeiuLj8SAPbHC0iXepOFmAaHfhhxkVAo4K/m/FlnVMP/KML1aOBofqXKV4Y5Tcblz
 AREvfR0d0ahjiNZymBWZp939vL7I7PSUcUvHg9dUu+xr+bia7EE0Ilqzr9NVn9pmClEv
 ENGw==
X-Gm-Message-State: AOAM533UpYp4AsDIUS5jnUwKMGfLEkYa4d/7CNhcnI6EFf0/i7Empm+V
 ZU5kZh55OBtcWnlhZblhuwk=
X-Google-Smtp-Source: ABdhPJxfrLmGV0+65+4j/2/5zFTL8A+2ysHnGlGLoBPD9mo5TiBwkeYHZToZ9+gVezjdQp1Il7mA0A==
X-Received: by 2002:adf:94e6:: with SMTP id 93mr207633wrr.190.1601842662676;
 Sun, 04 Oct 2020 13:17:42 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z203sm10225377wmg.17.2020.10.04.13.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Oct 2020 13:17:41 -0700 (PDT)
Subject: Re: [PATCH 09/14] hw/misc/bcm2835_cprman: add a clock mux skeleton
 implementation
To: Luc Michel <luc@lmichel.fr>
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-10-luc@lmichel.fr>
 <2a18bb94-1e6c-d853-3e6e-f6874b617a2b@amsat.org>
 <20201004193421.2a2znqtgwaoslvm3@sekoia-pc.home.lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0d76c36c-b5a1-bd4e-3825-945ea323a01c@amsat.org>
Date: Sun, 4 Oct 2020 22:17:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201004193421.2a2znqtgwaoslvm3@sekoia-pc.home.lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/20 9:34 PM, Luc Michel wrote:
> On 16:42 Fri 02 Oct     , Philippe Mathieu-Daudé wrote:
>> On 9/25/20 12:17 PM, Luc Michel wrote:
>>> The clock multiplexers are the last clock stage in the cprman. Each mux
>>> outputs one clock signal that goes out of the cprman to the SoC
>>> peripherals.
>>>
>>> Each mux has at most 10 sources. The sources 0 to 3 are common to all
>>> muxes. They are:
>>>    0. ground (no clock signal)
>>>    1. the main oscillator (xosc)
>>>    2. "test debug 0" clock
>>>    3. "test debug 1" clock
>>>
>>> Test debug 0 and 1 are actual clock muxes that can be used as sources to
>>> other muxes (for debug purpose).
>>>
>>> Sources 4 to 9 are mux specific and can be unpopulated (grounded). Those
>>> sources are fed by the PLL channels outputs.
>>>
>>> One corner case exists for DSI0E and DSI0P muxes. They have their source
>>> number 4 connected to an intermediate multiplexer that can select
>>> between PLLA-DSI0 and PLLD-DSI0 channel. This multiplexer is called
>>> DSI0HSCK and is not a clock mux as such. It is really a simple mux from
>>> the hardware point of view (see https://elinux.org/The_Undocumented_Pi).
>>> This mux is not implemented in this commit.
>>>
>>> Note that there is some muxes for which sources are unknown (because of
>>> a lack of documentation). For those cases all the sources are connected
>>> to ground in this implementation.
>>>
>>> Each clock mux output is exported by the cprman at the qdev level,
>>> adding the suffix '-out' to the mux name to form the output clock name.
>>> (E.g. the 'uart' mux sees its output exported as 'uart-out' at the
>>> cprman level.)
>>>
>>> Signed-off-by: Luc Michel <luc@lmichel.fr>
>>> ---
>>>  include/hw/misc/bcm2835_cprman.h           |  84 ++++
>>>  include/hw/misc/bcm2835_cprman_internals.h | 421 +++++++++++++++++++++
>>>  hw/misc/bcm2835_cprman.c                   | 151 ++++++++
>>>  3 files changed, 656 insertions(+)
>>>
>>> diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
>>> index aaf15fb20c..c2a89e8e90 100644
>>> --- a/include/hw/misc/bcm2835_cprman.h
>>> +++ b/include/hw/misc/bcm2835_cprman.h
>>> @@ -52,12 +52,73 @@ typedef enum CprmanPLLChannel {
>>>      CPRMAN_PLLH_CHANNEL_PIX,
>>>
>>>      CPRMAN_PLLB_CHANNEL_ARM,
>>>
>>>      CPRMAN_NUM_PLL_CHANNEL,
>>> +
>>> +    /* Special values used when connecting clock sources to clocks */
>>> +    CPRMAN_CLOCK_SRC_NORMAL = -1,
>>> +    CPRMAN_CLOCK_SRC_FORCE_GROUND = -2,
>>> +    CPRMAN_CLOCK_SRC_DSI0HSCK = -3,
>>
>> Why not use CPRMAN_NORMAL_CHANNEL,
>> CPRMAN_FORCED_GROUND_CHANNEL and CPRMAN_DSI0HSCK_CHANNEL?
> Well, those are special values used when connecting the clock sources to
> the muxes in connect_mux_sources(). They are not channels hence the
> name. To keep the code simple, I reused the CprmanPLLChannel type for
> mux sources (it is used in bcm2835_cprman_internals.h to describe what
> source connects to what mux input).
> 
> Ideally this type should be named something like ClockMuxSources (and
> CprmanPLLChannel should be a sub-set of this type). But doing so
> complicates the code quite a bit so I chose to simply have those three
> constants here instead.

Understood, OK.

