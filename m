Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D622FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8F1206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWQMGCwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8F1206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDgX-0008Lc-Rm
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhDfa-0007gY-SQ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:50:06 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhDfZ-0005sV-Kz
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:50:06 -0400
Received: by mail-ot1-x341.google.com with SMTP id m2so7779469otr.12
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JDCA0K4XBTkPfG5Tn//wBpkNB82Cg03QNPI1nDXfSEY=;
 b=qWQMGCwZNxoluBGNf9Ow4LsK3nnkWqO66YvOSrEUkNT3ypOIusrSvvpiqi1knwscht
 HntrhrZI8lLUitY3f3CqdZuW6xOuZqwdRKj0KPJpOGwB72o7b2EbHvCyZnqUL+SjsNTN
 RZDjPg4Pj7f3soySHLlK71DOmBbuUiAHPAyCpFikxPcfSA9KM2MpVRrVa/q2yURwJjGu
 yQovb8jVEdrh3wXkdLUdReUx3rFPmg61L5yPGpn5nLL2k5x2YDgKJFXZSR5PdBRdPSd3
 UNPedbELYoSD7xLCgzR37NRQ1DTFVVwoOrYDQ67P1n7hfs53Piy6CLjKbthARhZkKlPj
 iEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JDCA0K4XBTkPfG5Tn//wBpkNB82Cg03QNPI1nDXfSEY=;
 b=uKaKTGD47+6mikCwlXG3TQb9hKS4BQa6HMoVpdnsZN/LVeCJM8l6fvd+zt7a8wUO+j
 7wgVt+yNadpbGngMku9T1A6md9HkqWWhQMEf+dZ+fnV8k2pTVWlmwi8pv1R7oBaZ08E6
 vxqpHf2S1V4pWOH6hl2h2FB/yA0aPOAK/P+3HwVwGvIRV6xK2mJ5F5Xk8eo9gtim6bG3
 tYwRLZVCQaEf1BjhoCu5fThWjmPxt4K6l1FoL2RESjRwjCTrB0QzBKfF4y/dkAwuQboa
 oM9iBfkNHJdNWP4N3RtQv87uXmQBp6czTFVYH06lUZobcELsGemCLAi5wu6YMjIhPxNO
 HINQ==
X-Gm-Message-State: AOAM532pHT947mXOTnirKtfQMhb1+jPTs9ZPoeC99lbULeIxlgKnWYTy
 adk8jCBX/rDXCyKDTkpYHNa7VpiMi69HvAz6J43DnA==
X-Google-Smtp-Source: ABdhPJzLxP1lXUFeWqr/EZvOmUzkFlSg7zlezdiJES2rZaif6oc1ypiw8CGwEMFHR3xBC7KdT0fo7ZKlxZkYQxA5iNI=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr7502622oth.221.1591368604178;
 Fri, 05 Jun 2020 07:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200529180005.169036-1-jcd@tribudubois.net>
In-Reply-To: <20200529180005.169036-1-jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jun 2020 15:49:53 +0100
Message-ID: <CAFEAcA9Q9f4ocZSrgXK8DRz8ro1Yv4bRbTmpWw_wtoqyUO9K7w@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/imx6ul_ccm.c: Implement non writable bits in CCM
 registers
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 May 2020 at 19:00, Jean-Christophe Dubois
<jcd@tribudubois.net> wrote:
>
> Some bits of the CCM registers are non writable.
>
> This was left undone in the initial commit (all bits of registers were
> writable).
>
> This patch add the required code to protect non writable bits.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
>  static uint64_t imx6ul_analog_read(void *opaque, hwaddr offset, unsigned size)
> @@ -737,7 +790,8 @@ static void imx6ul_analog_write(void *opaque, hwaddr offset, uint64_t value,
>           * the REG_NAME register. So we change the value of the
>           * REG_NAME register, setting bits passed in the value.
>           */
> -        s->analog[index - 1] |= value;
> +        s->analog[index - 1] = s->analog[index - 1] |
> +                               (value & ~analog_mask[index - 1]);

Not sure why you didn't retain the use of the |= operator here?

>          break;
>      case CCM_ANALOG_PLL_ARM_CLR:
>      case CCM_ANALOG_PLL_USB1_CLR:
> @@ -762,7 +816,8 @@ static void imx6ul_analog_write(void *opaque, hwaddr offset, uint64_t value,
>           * the REG_NAME register. So we change the value of the
>           * REG_NAME register, unsetting bits passed in the value.
>           */
> -        s->analog[index - 2] &= ~value;
> +        s->analog[index - 2] = s->analog[index - 2] &
> +                               ~(value & ~analog_mask[index - 2]);

Similarly here with &=.

>          break;
>      case CCM_ANALOG_PLL_ARM_TOG:
>      case CCM_ANALOG_PLL_USB1_TOG:
> @@ -787,14 +842,14 @@ static void imx6ul_analog_write(void *opaque, hwaddr offset, uint64_t value,
>           * the REG_NAME register. So we change the value of the
>           * REG_NAME register, toggling bits passed in the value.
>           */
> -        s->analog[index - 3] ^= value;
> +        s->analog[index - 3] = (s->analog[index - 3] &
> +                                analog_mask[index - 3]) |
> +                               ((value ^ s->analog[index - 3]) &
> +                                ~analog_mask[index - 3]);

I think this does the right thing (toggle bits which are set in
value as long as they're not read-only), but isn't this a simpler
way to write it?

     s->analog[index - 3] ^= (value & ~analog_mask[index - 3]);

That is, we toggle the bits that are set in 'value' and not set
in the mask of read-only bits.

>          break;
>      default:
> -        /*
> -         * We will do a better implementation later. In particular some bits
> -         * cannot be written to.
> -         */
> -        s->analog[index] = value;
> +        s->analog[index] = (s->analog[index] & analog_mask[index]) |
> +                           (value & ~analog_mask[index]);
>          break;
>      }
>  }

thanks
-- PMM

