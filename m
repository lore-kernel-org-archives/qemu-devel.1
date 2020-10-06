Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13143C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3832078E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRwvXple"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3832078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPiuQ-0008WK-03
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPitY-0007vZ-VW; Tue, 06 Oct 2020 05:04:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPitX-0005rp-EN; Tue, 06 Oct 2020 05:04:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id e18so6640865wrw.9;
 Tue, 06 Oct 2020 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nIWAxLqrKAbGNoBod0ssufydW4+pTVAQe4xA+k3/wqI=;
 b=GRwvXpledPrjxJkwM8s3W7AccYm2qzGc17cm26gu+RTrsvOrdZCNetuIfWNtcIamsx
 93YPwAfC7NUr6YOa4En7hMJfSA/iJt9F1/zQwhaDBSR0atXaDjh3QTvAsskl03KRYpf0
 HAqK2REsXlRLogn9gSeOo4zmBm6TgtixAyiAM2fHod5Ty+W3kEpqwuZ8okt6NdffpU4U
 MDoZy/J/bvyYp+NUzCzWBJtIYNEmtlgiiPdqpRQouafPn7NLwX58cuN0kIluv8otusow
 ybpiNOf4eE6Wk7i1z365blyTOHk9Cp21UJcd7Ueda8B1Nlwbqspy6UUjoSYtA8BHsSm6
 5F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nIWAxLqrKAbGNoBod0ssufydW4+pTVAQe4xA+k3/wqI=;
 b=XCz8ULX5C4iWAMBo7EuOvdNrys/1u1BkQckioD6WTs/q9tNy5Vdd5hVhet41wDagVH
 zzhLAGQzRMgeMOnWePcVFwba4Gz62lxhM9xpfIGu5gHLE+Hrj/IPuAzx4CmZCXEXIhu4
 HXW4stwWo2icO05XqDkAfmZpnueMsMr/pmbMf9CT9y8tzvoRBjYI8xoydQpkc0zLYv0z
 EUQLErplv9wXkMJDZwEfpP6aAesqO1/c0YyReSyYhNRVbFwIzhou9yvnZeDyPMdIKOoI
 FcRlMRtnqh+XXSfVWXJm/eZw3eE0gIzLcwWey0vZ5cJ5v+KE3anV1uMR38UL5JBVV5iO
 j1QA==
X-Gm-Message-State: AOAM5306Jk9xgLxvZdzurJGGaQ7pdMqMpULvGQ1nAOGaGhuFuckwbpx6
 3MS2Yc8kRz0k4qWknFXYZaA=
X-Google-Smtp-Source: ABdhPJxeArFc6qd9j5N2zZoU+Hl1iXwKnDqGj9iD37YCDE4vquv9xVGR19tJyqaI6RjCea5Rxa+i6Q==
X-Received: by 2002:adf:f207:: with SMTP id p7mr4059181wro.152.1601975064995; 
 Tue, 06 Oct 2020 02:04:24 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l5sm956734wrq.14.2020.10.06.02.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 02:04:23 -0700 (PDT)
Subject: Re: [PATCH v2 11/15] hw/misc/bcm2835_cprman: implement clock mux
 behaviour
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20201005195612.1999165-1-luc@lmichel.fr>
 <20201005195612.1999165-12-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d304e1f9-a1ea-17a1-e830-8be1f7671a53@amsat.org>
Date: Tue, 6 Oct 2020 11:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005195612.1999165-12-luc@lmichel.fr>
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
> A clock mux can be configured to select one of its 10 sources through
> the CM_CTL register. It also embeds yet another clock divider, composed
> of an integer part and a fractional part. The number of bits of each
> part is mux dependent.
> 
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>  hw/misc/bcm2835_cprman.c | 44 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index a470ce2026..7d59423367 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -229,19 +229,61 @@ static const TypeInfo cprman_pll_channel_info = {
>  };
>  
>  
>  /* clock mux */
>  
> +static bool clock_mux_is_enabled(CprmanClockMuxState *mux)
> +{
> +    return FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, ENABLE);
> +}
> +
>  static void clock_mux_update(CprmanClockMuxState *mux)
>  {
> -    clock_update(mux->out, 0);
> +    uint64_t freq;
> +    uint32_t div, src = FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, SRC);
> +    bool enabled = clock_mux_is_enabled(mux);
> +
> +    *mux->reg_cm = FIELD_DP32(*mux->reg_cm, CM_CLOCKx_CTL, BUSY, enabled);
> +
> +    if (!enabled) {
> +        clock_update(mux->out, 0);
> +        return;
> +    }
> +
> +    freq = clock_get_hz(mux->srcs[src]);
> +
> +    if (mux->int_bits == 0 && mux->frac_bits == 0) {
> +        clock_update_hz(mux->out, freq);
> +        return;
> +    }
> +
> +    /*
> +     * The divider has an integer and a fractional part. The size of each part
> +     * varies with the muxes (int_bits and frac_bits). Both parts are
> +     * concatenated, with the integer part always starting at bit 12.
> +     */
> +    div = mux->reg_cm[1] >> (R_CM_CLOCKx_DIV_FRAC_LENGTH - mux->frac_bits);
> +    div &= (1 << (mux->int_bits + mux->frac_bits)) - 1;

I understand the description as:

                   0
                  [     12-bit    ][     12-bit    ][   reserved...   ]
 CM_CLOCKx_DIV    [      FRAC     ][      INT      ][                 ]
                  [         <frac>][<int>          ][                 ]
                            ^^^^^^^^^^^^^

What about:

       div = extract32(mux->reg_cm[1],
                       R_CM_CLOCKx_DIV_FRAC_LENGTH - mux->frac_bits,
                       mux->frac_bits, mux->int_bits);

Also consider adding the register visual representation if it is
correct.

> +
> +    if (!div) {
> +        clock_update(mux->out, 0);
> +    }
> +
> +    freq = muldiv64(freq, 1 << mux->frac_bits, div);
> +
> +    clock_update_hz(mux->out, freq);
>  }
>  
>  static void clock_mux_src_update(void *opaque)
>  {
>      CprmanClockMuxState **backref = opaque;
>      CprmanClockMuxState *s = *backref;
> +    CprmanClockMuxSource src = backref - s->backref;
> +
> +    if (FIELD_EX32(*s->reg_cm, CM_CLOCKx_CTL, SRC) != src) {
> +        return;
> +    }
>  
>      clock_mux_update(s);
>  }
>  
>  static void clock_mux_init(Object *obj)
> 

