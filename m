Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AA5C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D799C206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWs5clq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D799C206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMc4-0001mS-1B
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOMP9-0003V0-KK; Fri, 02 Oct 2020 10:51:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOMP7-0005VZ-O7; Fri, 02 Oct 2020 10:51:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id g4so2141485wrs.5;
 Fri, 02 Oct 2020 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1Qv7lZXTUX4YgEJVoDxTSAbbt05YOrcXEI/iCwJvaDE=;
 b=CWs5clq0pwGaV5VKySbyHE+z3tRarVGBXj4JWgIcv8RFDj+oil7hQcjx4XIIQIz9Qt
 +HCpOG6KjW5yH0JbaVciRPpPbsJUaGmdPyKvZ+axnIvzPqWT48fv0yIlvPt7jQm42iHz
 uqt6CZ27mwYvHVS9fLose9see5Z/2h32jlciv1zn9SEqYg+mba91Tuv7XhwxdSa+fXDT
 TsHyLdA48mU2zAG9gFz5LI7HD8nMSLH4nAz4Widmb14DuUf3XhxFFqYSoCE0kfOuWiwZ
 3/n/lyrnxX9BjygTEout9YwAQ1Bdb7a4JFHwwci5Zi+HUnW78ZYTDGqXLa0WubpfbWlD
 3FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1Qv7lZXTUX4YgEJVoDxTSAbbt05YOrcXEI/iCwJvaDE=;
 b=DvYgPvRCFv/yp3xJN8tdB/39suFnbNqkPgT4TwC3CLhBw453i8riiMgo6bV6lIX3JV
 QDbdvyHoUjsd6hGf+EzCMlj47MFuXwVhpCMgAyXojkxTyEqMwIbOrXZ20gNwh6LS6rlH
 2OgDocsYiCpcsRcCkbeC2w4y68Z7VH+hlA73rb9FkNUhlTMxTA1d9mECuQaiktbOcMlI
 pTqVp/2BBgVaB76a1s4qYJLHxqDBfMpPscZjJ1p6jkmVhbrzFX+JIdqdrQC8uF6pxITd
 SNS8mozL4uXt876Ockaz22iIhdzZFX36onG7Kzz6BdcH8uyahoz/pMFj/wpv60XAKoMw
 5XAA==
X-Gm-Message-State: AOAM530PXttKKREd4IjqHPdXOcVf1dakyVbbSUpjbHE9bZPzry2tctOb
 l8z1Mfpj2E0ItVIDAquKJPo=
X-Google-Smtp-Source: ABdhPJz3leHHOkIZJ/tjSri/C1ryDN1A4LE25vWE0dLbu8WasQyol9tHPRXVORNi1EpxWjJEKPB//w==
X-Received: by 2002:adf:91c2:: with SMTP id 60mr3795018wri.292.1601650283167; 
 Fri, 02 Oct 2020 07:51:23 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id n2sm2265268wma.29.2020.10.02.07.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 07:51:22 -0700 (PDT)
Subject: Re: [PATCH 10/14] hw/misc/bcm2835_cprman: implement clock mux
 behaviour
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-11-luc@lmichel.fr>
 <76aae8af-dff0-b76f-cf04-0e3231eaf2bb@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <2ca8802e-3295-bd22-e705-931ae8dbbd1d@amsat.org>
Date: Fri, 2 Oct 2020 16:51:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <76aae8af-dff0-b76f-cf04-0e3231eaf2bb@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.256,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/20 11:40 PM, Philippe Mathieu-Daudé wrote:
> On 9/25/20 12:17 PM, Luc Michel wrote:
>> A clock mux can be configured to select one of its 10 sources through
>> the cm_ctl register. It also embeds yet another clock divider, composed
>> of an integer part and a fractionnal part. The number of bits of each
> 
> Typo "fractional".
> 
>> part is mux dependant.
> 
> Typo "dependent"?
> 
>>
>> Signed-off-by: Luc Michel <luc@lmichel.fr>
>> ---
>>  hw/misc/bcm2835_cprman.c | 43 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
>> index 8df2db0fd9..75bc11939b 100644
>> --- a/hw/misc/bcm2835_cprman.c
>> +++ b/hw/misc/bcm2835_cprman.c
>> @@ -229,19 +229,60 @@ static const TypeInfo cprman_pll_channel_info = {
>>  };
>>  
>>  
>>  /* clock mux */
>>  
>> +static bool clock_mux_is_enabled(CprmanClockMuxState *mux)
>> +{
>> +    return FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, ENABLE);
>> +}
>> +
>>  static void clock_mux_update(CprmanClockMuxState *mux)
>>  {
>> -    clock_update(mux->out, 0);
>> +    uint64_t freq, div;
>> +    uint32_t src = FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, SRC);
>> +    bool enabled = clock_mux_is_enabled(mux);
>> +
>> +    *mux->reg_cm = FIELD_DP32(*mux->reg_cm, CM_CLOCKx_CTL, BUSY, enabled);
>> +
>> +    if (!enabled) {
>> +        clock_update(mux->out, 0);
>> +        return;
>> +    }
>> +
>> +    freq = clock_get_hz(mux->srcs[src]);
>> +
>> +    if (mux->int_bits == 0 && mux->frac_bits == 0) {
>> +        clock_update_hz(mux->out, freq);
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * The divider has an integer and a fractional part. The size of each part
>> +     * varies with the muxes (int_bits and frac_bits). Both parts are
>> +     * concatenated, with the integer part always starting at bit 12.
>> +     */
>> +    div = mux->reg_cm[1] >> (R_CM_CLOCKx_DIV_FRAC_LENGTH - mux->frac_bits);
>> +    div &= (1 << (mux->int_bits + mux->frac_bits)) - 1;

Eventually:

    div &= MAKE_64BIT_MASK(mux->int_bits + mux->frac_bits, 64);

>> +
>> +    freq = (freq << mux->frac_bits) / div;

Maybe:

    freq = muldiv64(freq, 1 << mux->frac_bits, div);

>> +
>> +    clock_update_hz(mux->out, freq);
>>  }
>>  
>>  static void clock_mux_src_update(void *opaque)
>>  {
>>      CprmanClockMuxState **backref = opaque;
>>      CprmanClockMuxState *s = *backref;
>> +    CprmanClockMuxSource src = backref - s->backref;
>> +    uint32_t current_src;

Maybe avoid current_src and use in place.

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>> +
>> +    current_src = FIELD_EX32(*s->reg_cm, CM_CLOCKx_CTL, SRC);
>> +
>> +    if (current_src != src) {
>> +        return;
>> +    }
>>  
>>      clock_mux_update(s);
>>  }
>>  
>>  static void clock_mux_init(Object *obj)
>>
> 

