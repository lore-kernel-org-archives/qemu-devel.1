Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CEEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129EA207FC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+cCUkGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129EA207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2z3o-0002x4-8r
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 11:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2z3D-0002Ug-Hr
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:40:27 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:38465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2z3B-0000Wj-IQ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:40:27 -0400
Received: by mail-oo1-xc43.google.com with SMTP id z11so1309397oon.5
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jDBv0Jazb4FO6293xQUfr5ACmAOr8+tzLLK6YTsO308=;
 b=a+cCUkGU7v2vGdcnq3yRnhvV+3aGHJILGvt//kSKxXSCYoEwf297VpPp0RqfDWijcE
 JKbLfL6wM4c5SS4kxFUQRUMmTduggf+uhNx+iyggElObVuaWGmg6aFz0tAz64+hD1ipo
 b5zOpw76RJCCuw0l72/gydPUwPWbjYmeDTMqfA3gelXgcCvqJJDRNtpcYIlTq3tU3+xK
 tZ4kl3rj5bhlT7WnGSx9KI58LdSZ7wjze4UXBJ38njzSdzQLyV4hZtewBQedI/mE1RIF
 0WzA4ZoXhWI3OJ5Bq5L7zzFS4Mw3OttvTlOwribBDHC73KepcXQO7WtqECh2Y1pgta8T
 Ozag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jDBv0Jazb4FO6293xQUfr5ACmAOr8+tzLLK6YTsO308=;
 b=hci6t/CX3jR7RqwFqcEI3hcm29dX08QUtz0ntnVNBlPIDQ9lxMSMyFv4rIcfe83AWr
 Er0dgZ9H7eUjKe+AkAZ77SAsUNhEXFTBtNlYA7hXmAlNWNq5L44ndkGGScUrXdG1KN9/
 yCFEpKKqzfO3AlQ4OhKlRt5Xo7lTCabngzT3cAYb59Z7uEINcqOLwbocXFHiHdY+r+aM
 RExpLrJSQ6BMi/y8DWTZ4HSWUD5yhxOx6Sbo+2Faj09xhl6rU5gt6nFU/g00yFwJSJo9
 NPTKEqQsr+ohDC0tehxFX5gv1gV9U6ONuv3ww7R9aXjWhjctcyE+nHasAWprQXV14pp5
 +mXg==
X-Gm-Message-State: AOAM532RcNoPL1cEg/TWabxd4o0EGIwAJPDrUjSdis1HszC8hVpPgcQc
 xek5qjeBjr79Uh1qhZXZNjasUWaNsqImDRPmIMrh7g==
X-Google-Smtp-Source: ABdhPJzM0OoRI67QXPluQasx+Vy6ERosxZBEeLXHUbLMLeygkzQ88FPaF+aMAT09/mbtMvqGcpHFYzsyLhaHm9RCaao=
X-Received: by 2002:a4a:4949:: with SMTP id z70mr19228103ooa.85.1596555623845; 
 Tue, 04 Aug 2020 08:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200803205708.315829-1-richard.henderson@linaro.org>
 <CAFEAcA9tuO-3EMGk1Yggi_bRE75+0ro=g2r11VKUR9SNAvaPUw@mail.gmail.com>
In-Reply-To: <CAFEAcA9tuO-3EMGk1Yggi_bRE75+0ro=g2r11VKUR9SNAvaPUw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Aug 2020 16:40:11 +0100
Message-ID: <CAFEAcA9DyCn0Mq7Jbo57RpSE0aH8Gpq1G9tWA=JbeWjOQzU_zQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1] docs/devel: Document decodetree no-overlap groups
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Tue, 4 Aug 2020 at 10:38, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 3 Aug 2020 at 21:57, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > When support for this feature went in, the update to the
> > documentation was forgotten.
> >
> > Fixes: 067e8b0f45d6
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  docs/devel/decodetree.rst | 29 ++++++++++++++++++-----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
>
> > @@ -200,7 +207,7 @@ instruction::
> >  When the *cf* field is zero, the instruction has no side effects,
> >  and may be specialized.  When the *rt* field is zero, the output
> >  is discarded and so the instruction has no effect.  When the *rt2*
> > -field is zero, the operation is ``reg[rt] | 0`` and so encodes
> > +field is zero, the operation is ``reg[r1] | 0`` and so encodes
> >  the canonical register copy operation.
>
> Technically a separate change, but a very small one...
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I'll take this via target-arm.next since I have something else
to go into rc3 as well.

-- PMM

