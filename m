Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0320C55179
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265A320790
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IzhLfcwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265A320790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4z9-0000rx-3f
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 06:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY4xk-0008VH-RM
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:15:20 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:40003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY4xi-0004PB-8U
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:15:20 -0400
Received: by mail-ed1-x541.google.com with SMTP id p93so2447422edd.7
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 03:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IiFixuGwiG2pW0PrC7I+4MYn/8/9aWmQdQTY5C9RD+M=;
 b=IzhLfcwOzV/oMtezn5VxXAvMzu4P8VnMPCMKOtYU7iK1VRd830f4oiW6WwZ6lvxzoI
 F5EICEzvkBLj3RViclMaJSsdK3pUtXnEs01KLQwTw45rGH74QnbL11W5wO5V3C9vOLMB
 DiOJ+TcMRtKVnfKaeMve+5FZDGlGqiFKoetPEHcn3UyuiFogjxxg6CZEL0NvQ8ZUdI32
 5WNxlG90SjPAfSWR2Ithc+6MDb1bjj3gSNOxHu6kRdkyEGxWb+oCatJPT1Uw6c0qwsMz
 1SAo2v/UMePnwOJdakwbY9ggo0etAcMKW2Sq1Y4xmhfh9TPcnPwaJmV2fYRnNELwLiND
 aXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IiFixuGwiG2pW0PrC7I+4MYn/8/9aWmQdQTY5C9RD+M=;
 b=pqbhK6o7cFk1pjAisfj1Maka9B6orvAY/nDKeuV94UGi7K4pKYiByA+YHkO2TyUbRV
 81BUQtEWhOalBaEtMyu/1Wr/yJDHs6UnDo867DJ4JV8q0ABKR2hmGlgA1kJIEZA3F5Hk
 yqowxZ936We8DFi2Ce7DKiGQ1QfbzHxFv8pJjFendaKplyBC5TMOqqYeuVho2S1PmdCa
 3ZFevGyQcimg/pGUNKqfmeAYKO0JNlhGMOwRgDMlcGKCsTRQ0Ec0Mal5JhEqG0ELC4K6
 D2fJoKyajgQC5iPeCrjx+ovRaxaifg/2xrrsuqEgOHzHDSANi0rdeILtebnwCUBdVtBV
 t8Jg==
X-Gm-Message-State: AOAM530m8kRJg2pcwbQgaC6kzZV6n1M/nGWQpBhP1PSJb2bl9UenCCNA
 X/rMMf5PKknO8BX9U9vZtLmx6pWyRfbWKf+loJFW7w==
X-Google-Smtp-Source: ABdhPJxW00+PriUVS4129M3sSh1vulvAH70EzgQ34Zj/LFYwA+4JfNndTAGXGN494xbXhyyq6IN3CuIVDokHTf3qphE=
X-Received: by 2002:a50:f41a:: with SMTP id r26mr3018371edm.251.1603966515541; 
 Thu, 29 Oct 2020 03:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201028032703.201526-1-richard.henderson@linaro.org>
 <20201028032703.201526-6-richard.henderson@linaro.org>
 <02588cfc-3db6-b9da-82d2-807fc83307dc@linaro.org>
In-Reply-To: <02588cfc-3db6-b9da-82d2-807fc83307dc@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 10:15:04 +0000
Message-ID: <CAFEAcA-CbSAE15+QGtMLKyU5mTo0oDMAVOhJbj6eQsBOJamoFQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] target/arm: Add read/write_neon_element32
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 at 20:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/27/20 8:26 PM, Richard Henderson wrote:
> > @@ -3871,24 +3923,26 @@ static bool trans_VTRN(DisasContext *s, arg_2misc *a)
> >          return true;
> >      }
> >
> > -    if (a->size == 2) {
> > +    tmp = tcg_temp_new_i32();
> > +    tmp2 = tcg_temp_new_i32();
> > +    if (a->size == MO_32) {
> ...
> >      }
> >      return true;
>
> Bah, forgot to free these temps.  Did I configure my first round of testing
> without debug enabled?

Oops, I forgot to run the find-leak-warnings command in my setup.
As well as this one in VTRN, it also reports an issue with VREV.

thanks
-- PMM

