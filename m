Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D4BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4384A20706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVEuzR7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4384A20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAWzF-0003EK-FR
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 07:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAWy8-0001XW-5b
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 07:18:24 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:40231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAWy1-0005Io-QI
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 07:18:21 -0400
Received: by mail-ej1-x641.google.com with SMTP id o18so16019434eje.7
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 04:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=udVOhtccTRnf8ZkLvWGf4nZ8cCCKzpc0C5LgJy/IobU=;
 b=SVEuzR7nBRgKi0DRTNyvUD6t4IvGsBcmgxQP8I/fakSVzIjO66c3m7cHGF9ohGgdV/
 mFPfcmNQh+sDaOPAjO40JHlY9SB52sLKP2V8nKJs5Pi8G0nVXCsgmRkRur9XG87rFVh1
 z2+x8PdI+hOpwRAGqrfPeywp3KC3UK0rAAGQ2yS5jp0fnUN9tHsSWlO8P4d3R8jZHkJa
 H67gwNbfchfe5eKupmj/WsaQeQsmtUSxjWnuhh9ZhP3RMXwHBm/ICbsrVh3HgR4ITYW8
 qrRuXobbH1S8W1v1/YUJBPtdvSpTx3tEUe4s1p93mWJNdiewxSih1bDLRphaMoDhpHki
 Xexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=udVOhtccTRnf8ZkLvWGf4nZ8cCCKzpc0C5LgJy/IobU=;
 b=Sfhht+yIIus0O7xBeAsz764vbsNkGfSNUUQFJA5nZtLeaexrxRUtceYjaf0MHmmBh5
 oAchL7CGmgQd0pKmdr4XzhvDKEgY1aFOtizLZ+ck56nVT0VwLnCuWbiHCtaX+9O6dymS
 V+duEq1QQLWFM+Nt1BecPC7qliMkp8Ea/Wo58UUQ8JqS2oKvorBjfUzYYSZBVFKbjv+c
 A3PCYfl/TvE+b10WxjMzd3y68i4a0v4C06XFGn3FJwom22rgMBSYy4bUs5+rr6muHj8h
 evqzam98aayiM6zcMxxKdbI144awd+wQE/M/X2Vxku4L8sLjmosEsN2Zi93nauPM0QmS
 SQ+w==
X-Gm-Message-State: AOAM531AwGPs5QLfT4MPOqE3aQyA/Az+e4DrU8P3f3EJ5Ctm5JJHirlA
 f9qq67UVuRG972Fde5PgiFJSAECw4huT3hokBbCzzg==
X-Google-Smtp-Source: ABdhPJzaRgnZNMMmg9IpEhx+zAU83z84MpdhiWhvfvosK7qkl3wWaRZ2PGH0sd1TfR3Jk0dQQg6QE/Kf/oO6/7rrsZw=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr9675173ejb.407.1598354295777; 
 Tue, 25 Aug 2020 04:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-14-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 12:18:04 +0100
Message-ID: <CAFEAcA8gsdU0FVsRnu3cBx4KGaetJDPr63KBaZXh42eCehsQfQ@mail.gmail.com>
Subject: Re: [PATCH 13/20] target/arm: Tidy SVE tszimm shift formats
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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

On Sat, 15 Aug 2020 at 02:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rather than require the user to fill in the immediate (shl or shr),
> create full formats that include the immediate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/sve.decode | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

