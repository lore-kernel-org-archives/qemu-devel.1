Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267AFC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D692080A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mumAl4PD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D692080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPiXS-0006A9-RI
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 04:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPiWF-0005ML-Ot; Tue, 06 Oct 2020 04:40:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPiWE-0002qa-2t; Tue, 06 Oct 2020 04:40:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so7022559wrp.10;
 Tue, 06 Oct 2020 01:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5R99MHvHog38JUAHK+cJI9tw/G0v91gWyeejkWSp+EU=;
 b=mumAl4PDKinRUSCHhFvuoegv1u3awm7PtIkoSeWq/8OJiSBpJRZT6OPXGcmMLZPv74
 L0/myKESO/F8sFqjicfWL1vXeDuEOIPXByY9BggyI0ujZptA3tnHMxQTQaJZk7/fW2+x
 TdTM1odXEunbNYzdmTbbg9abotLNhZWWiov9AW96Ac3bx8CqlRJfhXwJ53ElBKhlTyhi
 LtB47TnU0WfKYdft0UT+bdW+2l/4DiQzCzAB8KPlq5ZL6mvgd0wwZ90GDGGEC8yOafnS
 h0lbyLW8ALTYt+xmjsC7b/yKDe1Fr3LCsrCNf+/4bgI8ETApBlqMUZ9FgOWHvy2RnL7v
 JqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5R99MHvHog38JUAHK+cJI9tw/G0v91gWyeejkWSp+EU=;
 b=CdH0CjAZHEs8WgdiuUfSRIEyytSDTJ3mi7IkMk3V+2YiRq+AuWBONYip/9BgtpPI3v
 6Kdc6DICleBnNp9Z5eVj4cPBCJ46ytkbetMTDQn3XlVvQmj6FplyoSEGoYqIF4/eAGX5
 NO2LvtDE5MWSoL8UGBKIuXYunXDkElE44d4OE6vF3UiX5a+A7QKi1zWJ0z2ZwK4At+9C
 L1zZT5HqAXxCe3k+n12zZD+5xypQJQV/wBAAvc55M6uGU+fnrCYjszc6o3wI9F6/GuPr
 buDptjhUZczQGOpPqiadEbuuJi1lJTU0932B6Ys/QwlO3swDCEGimFYQpUr0nA4GoADh
 pHDA==
X-Gm-Message-State: AOAM530sifPeM4PswODanGJubF7CDAc0Kjdi064xZotIlZIgj7bRpYh7
 n/ywlKeSAo4R9XXAnGL8tE0=
X-Google-Smtp-Source: ABdhPJxpWudWmIVEbeyLa46pKtCPc0wheP7hhFWDzyiFju7tW8I0LepgNeP1EUuxfAvzRQ3bWUbgAw==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr3623507wrv.200.1601973619585; 
 Tue, 06 Oct 2020 01:40:19 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id s6sm3358640wrg.92.2020.10.06.01.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 01:40:18 -0700 (PDT)
Subject: Re: [PATCH v2 10/15] hw/misc/bcm2835_cprman: add a clock mux skeleton
 implementation
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20201005195612.1999165-1-luc@lmichel.fr>
 <20201005195612.1999165-11-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ea432580-114b-3f85-b4f1-0012bfb008c0@amsat.org>
Date: Tue, 6 Oct 2020 10:40:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005195612.1999165-11-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
 Havard Skinnemoen <hskinnemoen@google.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 9:56 PM, Luc Michel wrote:
> The clock multiplexers are the last clock stage in the CPRMAN. Each mux
> outputs one clock signal that goes out of the CPRMAN to the SoC
> peripherals.
> 
> Each mux has at most 10 sources. The sources 0 to 3 are common to all
> muxes. They are:
>    0. ground (no clock signal)
>    1. the main oscillator (xosc)
>    2. "test debug 0" clock
>    3. "test debug 1" clock
> 
> Test debug 0 and 1 are actual clock muxes that can be used as sources to
> other muxes (for debug purpose).
> 
> Sources 4 to 9 are mux specific and can be unpopulated (grounded). Those
> sources are fed by the PLL channels outputs.
> 
> One corner case exists for DSI0E and DSI0P muxes. They have their source
> number 4 connected to an intermediate multiplexer that can select
> between PLLA-DSI0 and PLLD-DSI0 channel. This multiplexer is called
> DSI0HSCK and is not a clock mux as such. It is really a simple mux from
> the hardware point of view (see https://elinux.org/The_Undocumented_Pi).
> This mux is not implemented in this commit.
> 
> Note that there is some muxes for which sources are unknown (because of
> a lack of documentation). For those cases all the sources are connected
> to ground in this implementation.
> 
> Each clock mux output is exported by the CPRMAN at the qdev level,
> adding the suffix '-out' to the mux name to form the output clock name.
> (E.g. the 'uart' mux sees its output exported as 'uart-out' at the
> CPRMAN level.)
> 
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>  include/hw/misc/bcm2835_cprman.h           |  84 ++++
>  include/hw/misc/bcm2835_cprman_internals.h | 421 +++++++++++++++++++++
>  hw/misc/bcm2835_cprman.c                   | 150 ++++++++
>  3 files changed, 655 insertions(+)
[...]

> +#define FILL_CLOCK_MUX_INIT_INFO(clock_, kind_) \
> +    .cm_offset = R_CM_ ## clock_ ## CTL,        \
> +    FILL_CLOCK_MUX_SRC_MAPPING_INIT_INFO(kind_)
> +
> +static ClockMuxInitInfo CLOCK_MUX_INIT_INFO[] = {
> +    [CPRMAN_CLOCK_GNRIC] = {
> +        .name = "gnric",
> +        FILL_CLOCK_MUX_INIT_INFO(GNRIC, unknown),
> +    },
[...]

> +static inline void update_mux_from_cm(BCM2835CprmanState *s, size_t idx)
> +{
> +    size_t i;
> +
> +    for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
> +        if ((CLOCK_MUX_INIT_INFO[i].cm_offset == idx) ||
> +            (CLOCK_MUX_INIT_INFO[i].cm_offset == idx + 4)) {

Maybe add a /* Matches DIV or CTL */ comment. Anyway
FILL_CLOCK_MUX_INIT_INFO() only uses CTL, not DIV, so
+4 check is not necessary.

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +            clock_mux_update(&s->clock_muxes[i]);
> +            return;
> +        }
> +    }
> +}
> +
>  #define CASE_PLL_A2W_REGS(pll_) \
>      case R_A2W_ ## pll_ ## _CTRL: \
>      case R_A2W_ ## pll_ ## _ANA0: \
>      case R_A2W_ ## pll_ ## _ANA1: \
>      case R_A2W_ ## pll_ ## _ANA2: \
> @@ -363,10 +438,19 @@ static void cprman_write(void *opaque, hwaddr offset,
>      case R_A2W_PLLH_RCAL:
>      case R_A2W_PLLH_PIX:
>      case R_A2W_PLLB_ARM:
>          update_channel_from_a2w(s, idx);
>          break;
> +
> +    case R_CM_GNRICCTL ... R_CM_SMIDIV:
> +    case R_CM_TCNTCNT ... R_CM_VECDIV:
> +    case R_CM_PULSECTL ... R_CM_PULSEDIV:
> +    case R_CM_SDCCTL ... R_CM_ARMCTL:
> +    case R_CM_AVEOCTL ... R_CM_EMMCDIV:
> +    case R_CM_EMMC2CTL ... R_CM_EMMC2DIV:
> +        update_mux_from_cm(s, idx);
> +        break;
>      }
>  }
[...]

