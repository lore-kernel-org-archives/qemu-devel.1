Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D486BC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D19204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zNL2fWc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D19204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Yn3-0004ZE-O8
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 06:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Ym8-00040R-UM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Ym7-0005yc-EN
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:32:32 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2Ym7-0005yL-7e
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:32:31 -0400
Received: by mail-oi1-x244.google.com with SMTP id t24so14498410oij.13
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 03:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vT3d7AuVTTfgsWgJoaC/s1PMk9aEkWdIuX/gBrUMJIc=;
 b=zNL2fWc/b4bySUqp6yqzsYVAL2jRKMGzJ60vtkfrtHsSJ03Fv8x9nMrEW/CZ0+FN6q
 8ODuWUcyUhAnLlOtWPm2qnVb8JIg9rGe+JfI3uAg4z3wENTvYEqXHmE4oKurowmywbgR
 cMePVp77sBfnuFdOTLXyUjuy4J1A1Rs1ul6j2g4fNG+lO/iND71ujT/B2s7qAzWcZpkD
 UxMLyffw6SMQWjs6n+XXi8A4zfswZDBTd4y8DvOaOVZxRgOSi9cr0whBzQJtqFmlKXt+
 teM9vnFO6upNJmv0xP4fYpPqRw0g2z7YpvcI3RGdD6YOr8zBi+Jng9YC4NMEB5Qp9sE/
 /GjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vT3d7AuVTTfgsWgJoaC/s1PMk9aEkWdIuX/gBrUMJIc=;
 b=As/vQ9peCLRTybAZMkNURk7XI8xsxpExdfETlOuoQbqZgiSrqdAJu6iGwOsblFkJRV
 ZrZMugQCFvEPG396AIqgaDGDPtZETzQ+zNaQERX1ek+zcemfNIVwb2D7K8AOLYzM0tv9
 DQZ2+TPlJpB2b2R0VscHwnfdloZIRZLDZDyEThkVOELl3SS5IGlifG3djKd5TCcQpmfX
 9eKXRDK4CVCd6YrPyWEhsg+h/1xPteFlj2oQ7iZwBfAZQ1kr2ZD6Mkal4LhvfFbHXSAY
 6tzgOv1ycUFBCs2nHhXrcCBmJHYaTafWS39IIhaPnMeridZmhGn6Th2paP1nvYzwIpvt
 KKRw==
X-Gm-Message-State: APjAAAXZ54dw5jjfm3mloqwKHZrwajC3sPseiK0T5WUbNEeADN3EXx7z
 rMA4R48iO8NXVLBJ4pdIRqVrPoL9YAfwx2TxUygPEQ==
X-Google-Smtp-Source: APXvYqyB/33IZk52En1q3oIDKyIMS3PlgFyfaEIyjmH9PoXnviWKK/g97/Bpa1fXefdEwOKQH1aahoSDR05iah/E1ko=
X-Received: by 2002:a54:4718:: with SMTP id k24mr220746oik.146.1566901950375; 
 Tue, 27 Aug 2019 03:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-19-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 11:32:19 +0100
Message-ID: <CAFEAcA9qN47t8zXJ7X3TmhkigSEjf+esxVNwQ0m9X=qa2KF_bg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 18/68] target/arm: Convert the rest of
 A32 Miscelaneous instructions
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
> This fixes an exiting bug with the T5 encoding of SUBS PC, LR, #IMM,
> in that it may be executed from user mode as with any other encoding
> of SUBS, not as ERET.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 119 +++++++++++++----------------------------
>  target/arm/a32.decode  |   8 +++
>  target/arm/t32.decode  |   5 ++
>  3 files changed, 50 insertions(+), 82 deletions(-)


> +static bool trans_HVC(DisasContext *s, arg_HVC *a)
> +{
> +    if (!ENABLE_ARCH_7 || IS_USER(s) || arm_dc_feature(s, ARM_FEATURE_M)) {
> +        return false;
> +    }
> +    gen_hvc(s, a->imm);
> +    return true;
> +}

I was wondering about for these trans_ functions the
difference between returning 'false' and calling
unallocated_encoding() and then returning 'true'.
If I understand the decodetree right this will only
make a difference when the pattern is inside a {} group.
So for instance here we have

{
  [...]
  {
    HVC          1111 0111 1110 ....  1000 .... .... ....     \
                 &i imm=%imm16_16_0
    CPS          1111 0011 1010 1111 1000 0 imod:2 M:1 A:1 I:1 F:1 mode:5 \
                 &cps
    UDF          1111 0111 1111 ----  1010 ---- ---- ----
  }
  B_cond_thumb   1111 0. cond:4 ...... 10.0 ............      &ci imm=%imm21
}

which means that if the HVC returns 'false' we'll end up
trying the insn as a B_cond_thumb. In this case the
trans function for the B_cond_thumb pattern will correctly
return false itself for a->cond >= 0xe, so it makes no
difference. But maybe it would be more robust for a pattern
like HVC to be self-contained so it doesn't fall through
for cases that really do belong to it but happen to be
required to UNDEF (like IS_USER() == true) ?

OTOH I suppose you could say that when you're writing patterns
like the B_cond_thumb one you know you've underdecoded and must
catch all the theoretical overlaps by writing checks in the trans
function, so as long as you do that correctly you're fine.

I guess this isn't a request for a change, just wondering
if there is a general principle for how we should structure
this sort of thing. I didn't run into it with the VFP stuff
because none of the decode needed groups.

thanks
-- PMM

