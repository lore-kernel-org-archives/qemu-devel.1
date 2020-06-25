Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D57EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC1720578
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ND8o/ZHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC1720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joO9E-0005BM-2b
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joO8U-0004Wl-ER
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:25:34 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:35475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joO8S-00037H-Km
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:25:34 -0400
Received: by mail-ot1-x332.google.com with SMTP id d4so4646567otk.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YwgKgNbndjnUVL3lRNgZKJY2lgy0r8IgfpsjNHArQJw=;
 b=ND8o/ZHfD2OUNVQrsI0/Gd/qcpEtCSPHJ1ZI/auIDcqujE9KCYA7PUbDXFeLNqDaiP
 xBJ4OSmz3HaIIQAm8SGo6WcNjIeFD2Q0SDQc98NvWs0t6IuxOjqFTkfQeZ/NJfAoo+95
 mQTyoMImHKwF2+CFRo3RxzbyeZ1XlwIb31n8U7+mN2Wc7YbBtS9aF6P/+oDnOKE3O+kJ
 NcfkxJF5WEuZZHOSb49Llaw2VLQ4Ak7mxEcibONy6byU0Ts0UXVx7z3r/7emdvI1stk9
 06295+oRbCdAfACOSDqUvb3t1aO6GdsGet6jWYvG0NIeqSmQPOsinhBFalFum2UbUopv
 Beow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YwgKgNbndjnUVL3lRNgZKJY2lgy0r8IgfpsjNHArQJw=;
 b=P0kldeov3YfHUALv0ZtHJY6zJYxrYekvNk0RKRGItwOhNmE1JjZnWiU3QAc2M+sDGk
 oLYZODTlbjunXbMd1vJBPfNPDk6iTTq9fENRZicbpeGKEcF6KtAOZvm+imepTDqd/ken
 9kmwutNreSehxZBCRE5C7icxJZ27HiHophfF6ap+K0dweE3Ni5BpUjhphOfZF4MLhY09
 y8Obe//qPTFJABr1WmzkOIDUmUR3Owv/kT+LpyJy5yMCOf70x6P8vModBkHLekNSNBeW
 2V5cprpenYI9C0eubzwnG4vS70b5pBtL61Srb/KYBbzA69Ya229WPeNGhLfjQI6tGPiL
 w7IA==
X-Gm-Message-State: AOAM533ju633gzEtdNT/EsvAp4ET224GLDKlAegVjrPA3ah7HIjfJmB0
 1P7szo6nC6jBsm70qYq8wi3i7/yjPYbSQ+hUf+V9ew==
X-Google-Smtp-Source: ABdhPJxVYMHUz6epTmQ1Hyvl6bD0SsTfUlYDdkm/s1vlK4GDzRkZTSiTB5aRI7igsvO1risKn4nzqHymzTtz1Uh1eTQ=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr25841904oto.91.1593077131255; 
 Thu, 25 Jun 2020 02:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200621124807.17226-1-f4bug@amsat.org>
 <20200621124807.17226-8-f4bug@amsat.org>
In-Reply-To: <20200621124807.17226-8-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 10:25:20 +0100
Message-ID: <CAFEAcA8c2dywr=Zxz1ExAV-48JwFU5vbBDDfA=_KE98XamnXiA@mail.gmail.com>
Subject: Re: [PULL 07/15] hw/timer: RX62N 8-Bit timer (TMR)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 21 Jun 2020 at 13:54, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> From: Yoshinori Sato <ysato@users.sourceforge.jp>
>
> renesas_tmr: 8bit timer modules.

Hi; the recent Coverity run reports a potential bug in this
code: (CID 1429976)


> +static uint16_t read_tcnt(RTMRState *tmr, unsigned size, int ch)
> +{
> +    int64_t delta, now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    int elapsed, ovf =3D 0;
> +    uint16_t tcnt[2];

Here we declare tcnt[] but do not initialize its contents...

> +    uint32_t ret;
> +
> +    delta =3D (now - tmr->tick) * NANOSECONDS_PER_SECOND / tmr->input_fr=
eq;
> +    if (delta > 0) {
> +        tmr->tick =3D now;
> +
> +        if (FIELD_EX8(tmr->tccr[1], TCCR, CSS) =3D=3D INTERNAL) {
> +            /* timer1 count update */
> +            elapsed =3D elapsed_time(tmr, 1, delta);
> +            if (elapsed >=3D 0x100) {
> +                ovf =3D elapsed >> 8;
> +            }
> +            tcnt[1] =3D tmr->tcnt[1] + (elapsed & 0xff);
> +        }
> +        switch (FIELD_EX8(tmr->tccr[0], TCCR, CSS)) {
> +        case INTERNAL:
> +            elapsed =3D elapsed_time(tmr, 0, delta);
> +            tcnt[0] =3D tmr->tcnt[0] + elapsed;
> +            break;
> +        case CASCADING:
> +            if (ovf > 0) {
> +                tcnt[0] =3D tmr->tcnt[0] + ovf;
> +            }
> +            break;
> +        }

...but not all cases here set both tcnt[0] and tcnt[1]
(for instance in the "case CASCADING:" if ovf <=3D0 we
won't set either of them)...

> +    } else {
> +        tcnt[0] =3D tmr->tcnt[0];
> +        tcnt[1] =3D tmr->tcnt[1];
> +    }
> +    if (size =3D=3D 1) {
> +        return tcnt[ch];
> +    } else {
> +        ret =3D 0;
> +        ret =3D deposit32(ret, 0, 8, tcnt[1]);
> +        ret =3D deposit32(ret, 8, 8, tcnt[0]);
> +        return ret;

...and so here we will end up returning uninitialized
data. Presumably the spec says what value is actually
supposed to be returned in these cases?

PS: the "else" branch with the deposit32() calls could be
rewritten more simply as
  return lduw_be_p(tcnt);

> +static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
> +{

In this function Coverity reports a missing "break" (CID 1429977):

> +    case A_TCORA:
> +        if (size =3D=3D 1) {
> +            return tmr->tcora[ch];
> +        } else if (ch =3D=3D 0) {
> +            return concat_reg(tmr->tcora);
> +        }

Here execution can fall through but there is no 'break' or '/* fallthrough =
*/'.

> +    case A_TCORB:
> +        if (size =3D=3D 1) {
> +            return tmr->tcorb[ch];
> +        } else {
> +            return concat_reg(tmr->tcorb);
> +        }

Is it correct that the A_TCORA and A_TCORB code is different?
It looks odd, so if this is intentional then a comment describing
why it is so might be helpful to readers.

thanks
-- PMM

