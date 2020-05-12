Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9881AC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C39F206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPOvp/u6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C39F206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVMC-0006rI-Im
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVK5-0003Y8-5j
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:51:53 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:35344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVK3-0005SC-5y
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:51:52 -0400
Received: by mail-oo1-xc41.google.com with SMTP id c187so1329387ooc.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8XIWQlMgALi/z6ky6qpf55zbyCznsNcFKHapaknfCOo=;
 b=wPOvp/u6yYYOtJjnCHLsoyhVTF8HyRgbOVMlK9UZu4iPtBwrUa9TdLS4IZ+cfuYuno
 pxNvE4hZoN3UBvFeHFCYSzfWpn4qSdTRVayNIovDqub6+31nfyHlwvDEUjvSVkXE0H52
 ySgucybHvnW3rcYwcmaGUkMagximQJUDy5rf/rHFWWWIXgoF8BMxzNEA61+P9ljglPMZ
 RraZglxW9yhdRAtv22sEj+04IBKVF/pb/3MpHOkW478c2ssKyuaNPkzRDxLLfh8lb8M4
 OcDBj1SV2nYkOmQ5pWZZ90L2tp9obI9+JJEIL8F/HXrCtshb8U4uhkoCcTAuFCNaoBkY
 l8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8XIWQlMgALi/z6ky6qpf55zbyCznsNcFKHapaknfCOo=;
 b=a8OU+dsugOmoW0ybKtWiStPXF39D6UgdrCzKCFwAtmcD397zMMyn7fydKecbEnMbvN
 53kMkI092pIRKgzradGIABQfo1uuOEJdrqiTugrLp42+AQRCwxZz1rYV7rQxSnXlKt6h
 TDKcChgkznXN5yULSJagKBUA4+qW46h8w4eWwV2em1t1zTfY9k22GQXWYO8xRpu9rFCH
 kAjbJvAqAFeoHRsccV+J5eiXg2reJoGROqNBKPzO+V0D6/folt+CEZP5gwf27x9B0kLI
 0PGZhlnjGHqqGA9m92dfSZW7bH9nwulZ6PU8uzW00wLztLvdbJjtFRlzjIzZYdK03rXC
 UVjw==
X-Gm-Message-State: AGi0PubRugA/d3LzIV/tM7XIYQKPirVF9Sd+onloYMefQJak9NpQkTr8
 vBFEzmuwqUhCasDPcIyWKaMWK16shBP3pAXkmxoLUg==
X-Google-Smtp-Source: APiQypJpbb66D+0iH1GxhFULjRXGOLC6FTtu/7qTXcjyyhvHpzgvLqUVkBR2k1IWKZrOgfdVnjGdBn7vW8diJ1ObTMY=
X-Received: by 2002:a4a:d136:: with SMTP id n22mr17968005oor.85.1589291509574; 
 Tue, 12 May 2020 06:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-3-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 14:51:38 +0100
Message-ID: <CAFEAcA-JOwTRz1ZHEBrH5iLG3Qwf-7FvWUFvWvhP769aK-iEiQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] target/arm: Create gen_gvec_{u,s}{rshr,rsra}
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Create vectorized versions of handle_shri_with_rndacc
> for shift+round and shift+round+accumulate.  Add out-of-line
> helpers in preparation for longer vector lengths from SVE.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> +    /* tszimm encoding produces immediates in the range [1..esize] */
> +    tcg_debug_assert(shift > 0);
> +    tcg_debug_assert(shift <= (8 << vece));
> +
> +    if (shift == (8 << vece)) {
> +        /*
> +         * Shifts larger than the element size are architecturally valid.
> +         * Signed results in all sign bits.  With rounding, this produces
> +         *   (-1 + 1) >> 1 == 0, or (0 + 1) >> 1 == 0.
> +         * I.e. always zero.
> +         */
> +        tcg_gen_gvec_dup_imm(vece, rd_ofs, opr_sz, max_sz, 0);

Knew I'd forgotten a review comment -- should this "dup_imm to clear
to zeroes" be using a fixed element size rather than 'vece' to avoid
the "dup_imm doesn't handle 128 bits" issue? (Similarly elsewhere.)

> +    } else {
> +        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
> +    }
> +}

thanks
-- PMM

