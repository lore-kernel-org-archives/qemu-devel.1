Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3585BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 09:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003D821924
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 09:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5IdrC3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003D821924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlqdE-0002vQ-8s
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 05:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlqca-0002Gt-3x
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 05:14:08 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlqcX-0000NE-KQ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 05:14:07 -0400
Received: by mail-oi1-x244.google.com with SMTP id p70so4413270oic.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 02:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MKQfGqhD+JTdrYQIG7Z7vR4kXfnefAbzMu1XSkQrlu8=;
 b=l5IdrC3VErnffIzCszP/zPBt7izfzrbiKKppvPdhyq9P6BWd+7fNoN46l8H8JJk+ps
 he9b/Ss9+/o0XNDxuoSyc8+2wtWdn18ZCnZH9PsBgqxY4b/adSKt6zpqu7wUdCnqFVNu
 RR+ebj2y46UoWtVFeAQUsTtxMU5KryGJ6CkX+/MClYvTLQdiN6x7i4/cgyOqgqJfv8F5
 6j3CewR/rZflZBpPF4Z2M5nCKE4fbcBBh6m6b+V5A0fypR7MHL+dWpix1zbjBVSXVOyf
 Y8FKnqAoYdD/hkslXSOxhfAj6/EL7WqXsPmJ7bKZdG6eoVdk6qt4ggxb+BU7tv+3V9a9
 eBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MKQfGqhD+JTdrYQIG7Z7vR4kXfnefAbzMu1XSkQrlu8=;
 b=ByrEdFP9MpoJlMT16ogYntnaPTDmRk1ajBXYJcfMi0y+DpggKY2U+y25M0ITKpRAjz
 pYxp39qxHhxcgGO+sfcagDSHLYh/mV9SmY+3wcjWSZH9HC2JTEp4iywNZA45ZfQVvN96
 /1PhSRJv4ylCHkDwAUjSaleBvKXabnL/xrYDDh+GScQkVuf78gjW+Cp4ubpwCrgxGf6P
 siS3kID5xrNzOmichGFDqzbNEj6ugSY0g5YS6e4s0uXdX2+ySEk8CQQsKCLVbc8NM3Ez
 uPdylsczO4SKJA+tJeEH5KugJr2Od1vaAT7EGBWFXtP2oRgyLuXYmjNyGFHuqIHMfXet
 +iAA==
X-Gm-Message-State: AOAM530AV8oZJCwsoXfbJTl3UgWBMqf+0XWM/K2iLf/2QtpzuTg9jDLn
 L/1Ztbbm4ENvIvuJcfKYAGuoh+pgN4m9qhiEkNQ9mQ==
X-Google-Smtp-Source: ABdhPJxRvpjWIOiAEfLcXIkW8HsAmf02rz5qSopnpXm5MxkHSWWVL+R/sz7KndE9BzuBdFtH4xKv6UNVz1xRMqVGQtQ=
X-Received: by 2002:aca:568c:: with SMTP id k134mr1993334oib.48.1592471644284; 
 Thu, 18 Jun 2020 02:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200615201757.16868-1-aperamak@pp1.inet.fi>
 <CAFEAcA-eKboVf3uk4iY_A9_uQ=HnGyic4fzbzJhv1gH2V+TMVw@mail.gmail.com>
 <87e628f4-6c0e-c4a2-daba-57cb1e508b77@pp1.inet.fi>
In-Reply-To: <87e628f4-6c0e-c4a2-daba-57cb1e508b77@pp1.inet.fi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 10:13:53 +0100
Message-ID: <CAFEAcA8HRnwsRsOS1xWgKz=_XCuRq4CdF9g881Bqh3REbFHmCg@mail.gmail.com>
Subject: Re: [PATCH] hw/audio/gus: Fix registers 32-bit access
To: Allan Peramaki <aperamak@pp1.inet.fi>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 at 23:26, Allan Peramaki <aperamak@pp1.inet.fi> wrote:
>
> On 17/06/2020 23:23, Peter Maydell wrote:
> >
> > This patch is quite difficult to read because it mixes some
> > whitespace only changes with some actual changes of
> > behaviour.
>
> Sorry about that. I had to put some whitespace in the two lines I
> modified because of checkpatch.pl, but then the nearby lines would have
> had inconsistent style if left unmodified. On the other hand, QEMU wiki
> said it is ok to fix style issues in the immediate area.

Thanks for the explanation.

Yeah, we usually allow that (largely with the goal of "make
the changes that keep checkpatch from complaining about a patch").
I think the changes here just ended up a bit more lost in the
style fixes than they would for some cases (eg if the style
fixup is just "add braces to an if"). One approach if the
style-fixups swamp the actual content is to split into two,
so patch 1 is purely style fixups and patch 2 the bugfix
(or the other way round); but it's certainly not worth rerolling
this patch just for that.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

