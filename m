Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C087C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90BF233FE
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wVnYSTU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90BF233FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0pcu-00071g-0z
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 12:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0pVt-0000d5-Gx
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0pVq-0008Ce-82
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:00:35 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0pVp-0008BO-Dz
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:00:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id f17so5937838otq.4
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7B3CvyEYOu+pNQ8AYNCbT+h5aS1c7aM+mXvf9WiQoR8=;
 b=wVnYSTU+VhYQHl9PmxnSBtDOTPBiHcxzCix/rjiLflA5oYCtlJ5wIEPoO3XJU1muby
 NBNDoJwTFWMflaIceXXKoM/94akMYlmKHIBDSKz8skV5Igk0Yug4JHzggcJTzwaHkoxf
 1DBZNJfct9VVe9nlwFwZ/EV/spEyEZqbzxEG3xpgeltsbf5ljy0O1PRe0XKJYAZhlY1B
 RLBb3h1vaxi6E0H8CyVBCv7WP7RgFMs68HsNy/f9cLiACOqUexfaIt2+uqJY7xm3loKN
 FDw1JPsnE/ICffSIWdmBnj3s+jjW0TuCNOmCajdDo6xXibUgFKn3HpxaBlXffYA44WFG
 YkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7B3CvyEYOu+pNQ8AYNCbT+h5aS1c7aM+mXvf9WiQoR8=;
 b=ugJX8l+7hBKY+sDibtpa9lMMa52xhg3rgz1c9Dd6AF7ErlyqQ5nNmfxkvk+cviNgy6
 FjqAtcYDg8OfAwgjXILN6fBPd9uH+E5l57Rsmh+KMOmf2FQaOGbyKnAEOmFWVFmt62dJ
 pc1h3SRDDJZM+mEjTcP1sMACb/cNHiwnNJa6IPdheBgDhyWMaz8H1qt7lfz+64bA6WuL
 FyWQpaSpI+3Ua2xzah5+UbgQCDNFAKnFjQVIiSCC8OcD90ZoNCTQqw5opaBg7EIHH4te
 8OK4aV9La/o4l7FwEzwHueApnuLZ1D8JmhDZr7l4V5dQuKVT6RIFvWGfjxeGZ2ZVDDtT
 k3ZA==
X-Gm-Message-State: APjAAAU1nIKDcvjKp2TpUCsELdKbljUuUAaNE5vpmAdsKlSH51E9UaKs
 ml2iSy21kTMy+NbxQjOZiO0qQHAjD0p5lRr63EVrNg==
X-Google-Smtp-Source: APXvYqwKNYFvc06JYO7iYgOjtIfIavR+jN+nScAqJWJIY/MCgcmi7xmh9TZ0LPP2b+xhLksuY94HL0FhVrhzD9hVxpo=
X-Received: by 2002:a9d:6a94:: with SMTP id l20mr208768otq.221.1566489630622; 
 Thu, 22 Aug 2019 09:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-4-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 17:00:19 +0100
Message-ID: <CAFEAcA9abuRJXTXkEE+2M4tHQuKc+VwsqfJqEmw-w_+Fcwh0rw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 03/68] target/arm: Convert Data
 Processing (register)
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Convert the register shifted by immediate form of the data
> processing insns.  For A32, we cannot yet remove any code
> because the legacy decoder intertwines the reg-shifted-reg
> and immediate forms.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 229 ++++++++++++++++++++++++++++++++++-------
>  target/arm/a32.decode  |  28 +++++
>  target/arm/t32.decode  |  43 ++++++++
>  3 files changed, 264 insertions(+), 36 deletions(-)


> +#define DO_ANY3(NAME, OP, L, K)                                         \
> +    static bool trans_##NAME##_rrri(DisasContext *s, arg_s_rrr_shi *a)  \
> +    { StoreRegKind k = (K); return op_s_rrr_shi(s, a, OP, L, k); }

It's a bit non-obvious that we can return early via the expression K
here (for the "trying to do an old-style exception return in usermode"
case for SUB and MOV), but it does put the check early where we need it.

> +DO_ANY3(SUB, a->s ? gen_sub_CC : tcg_gen_sub_i32, false,
> +        ({
> +            StoreRegKind ret = STREG_NORMAL;
> +            if (a->rd == 15 && a->s) {
> +                /*
> +                 * See ALUExceptionReturn:
> +                 * In User mode, UNPREDICTABLE; we choose UNDEF.
> +                 * In Hyp mode, UNDEFINED.
> +                 */
> +                if (IS_USER(s) || s->current_el == 2) {
> +                    return false;
> +                }
> +                /* There is no writeback of nzcv to PSTATE.  */
> +                a->s = 0;
> +                ret = STREG_EXC_RET;
> +            } else if (a->rd == 13 && a->rn == 13) {
> +                ret = STREG_SP_CHECK;
> +            }
> +            ret;
> +        }))

It turns out that the decode for Thumb means that we don't
need to specifically check that this is Arm mode before allowing
the ALUExceptionReturn handling.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

