Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53109C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177FB2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZUko1Ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177FB2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jborR-0003Oc-8u
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbobj-00088R-AY
 for qemu-devel@nongnu.org; Thu, 21 May 2020 13:03:47 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbobh-0002SF-S3
 for qemu-devel@nongnu.org; Thu, 21 May 2020 13:03:46 -0400
Received: by mail-ot1-x341.google.com with SMTP id v17so6102117ote.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RRVNm8yyLwG+jWu/U7zrvE67aC9THe5XI6GoogL1M/M=;
 b=JZUko1EwucyUqV1BeC+Onn7zX0mWd5uLsM8zMmv03bZdYvPhbSel0e33ZXc4LbGDNf
 WiLyz3HBtU1nfwtH6HpNEAimVrtA65l3JeObCGcLtzuWDywGf8VwB9xqKTMixqSzrP0p
 ifAbKLBFklQpIzO29lc6zzYJS43T0cNHvNhueFxtgW6psSOWrb47v5/f1QeVB0tR8Fz9
 7FpX+G7xYS3qccDhYcf3i0ASgX4o1rNUIsxjvLyU0Xe5UQpjHW44MUil4Y1vWx7DBt02
 zjuG3dfNHOpCctevFWvlS+IsyMxhfnmhhHNi37GCLZMvIbRlbHCtBRTIheWzHE6VDETB
 TyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RRVNm8yyLwG+jWu/U7zrvE67aC9THe5XI6GoogL1M/M=;
 b=ldr3Ks2S/Bs5ixHf6sWRK5JKHloW0eNOsabutJSW5VhhB/Fsb9i8/ygoM5pG0Rxlt2
 SRQTQx9SaMkMvRdKdclO0PEcpYO5tlpNVUtvKadKna9Ny0XwtRFiQT3Loe6WNxdyGsUz
 J4DBEnMlnihEjxcekMEgicQ8wz6XrJTliOuQcuSY1pR7t1zWZmXFfeX/WpxVlVJY+GP6
 V1MDss8WJkISoYHm1SqOanM5+E8juMVBpwHJOmWLI/ktuZg7AglKvySCAxY8YM6D8J1y
 vorZkffvxEilVHFv2MFYojqGKlcPCWtntKO3V18vujIfYJdCMfr/j/P/Joyb3ALdVIG7
 jtng==
X-Gm-Message-State: AOAM531PgcVokq5sACQkK072D8/pqDHxtAAaQ+y276vvtOxzsM2H/3Wh
 BdnsWUc/3K1eCpkLIZV90Bcz/yUFsQtm+lROBokFGQ==
X-Google-Smtp-Source: ABdhPJwNthFsCUdSZq9385eXPz36/O1higQAQONSfCmrM7ZEYNjTeP1vhdvB7UNIxbBgUJqZKKka+dwuyl4SNX+F0VY=
X-Received: by 2002:a05:6830:158b:: with SMTP id
 i11mr8034778otr.135.1590080624595; 
 Thu, 21 May 2020 10:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200511131117.2486486-1-amanieu@gmail.com>
 <CAFEAcA_2X2CY3Z6Pwcd=p-vboPuYZPJOfx4smoQCoWtjo5sABQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_2X2CY3Z6Pwcd=p-vboPuYZPJOfx4smoQCoWtjo5sABQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 18:03:33 +0100
Message-ID: <CAFEAcA_C6Xv=-Lqq2xsgXWCUYvzCLiM9ZtZvV6q4kO8g-ugUFw@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user/arm: Reset CPSR_E when entering a signal
 handler
To: "Amanieu d'Antras" <amanieu@gmail.com>
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 at 14:23, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 11 May 2020 at 14:11, Amanieu d'Antras <amanieu@gmail.com> wrote:
> >
> > This fixes signal handlers running with the wrong endianness if the
> > interrupted code used SETEND to dynamically switch endianness.
> >
> > Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
> > ---
> >  linux-user/arm/signal.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

