Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E95AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0051A20791
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAgrLy7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0051A20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBLne-0006d1-26
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 13:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBLn4-0005tV-Md
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:34:22 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:43242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBLn3-0001nN-1Q
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:34:22 -0400
Received: by mail-ej1-x641.google.com with SMTP id m22so8728717eje.10
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T7fK22tp3p3eKHS2qaLsa0rgJLT/yJ+AgYmQhe9igMc=;
 b=iAgrLy7ckXzaVOwmtvoSlUFqmUE8O1hSui0HnaU5/h8bh0IvQ2izamJAxXRic5N3jH
 1AnLmCERQvWIhwv5L9fSP7KTV/+hRgpuiSZl8FSfXZnyu6n9x1k9g6XMfNDEatU4g6Z8
 pFJpBP4HO7j3wN2jY0Mvil0883O6CayUIf3+xSlA/P6mjrAnC4ub8Q1FXgyyqgJ2Qk8m
 Pfir+rSo+LsDl7HzQ34dMerKLF9WR+e+pT/oyjROYE9FaQWxmxai0NTjbD0it8HABruL
 B9BZXrzHKyzl5CsNJKQSS14l+wauGAT1QsHzbntVD64H6fGCSjIl/UudUcnlqPvdJHpw
 s5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T7fK22tp3p3eKHS2qaLsa0rgJLT/yJ+AgYmQhe9igMc=;
 b=pHI1GItaKEVsx4Xx1ncjkeyB2fYkU5IVi51BwnnI9j+W3U8dZxvicIyKdhdV+TkzLQ
 3Ig+e61ZLKp4QFi++YYPBnharM20zTZ+TaT4pZ/eblWFJxnFwgzXDc+BYFAoT592rN9D
 50SBabnZ1G9Up1rWv1C64MAINU99Qaz3iNGuxT3V/Y6g9LwkfTomhEwOauv634BTd3Vm
 VFLTRfE8To6pRJlZAYlBq0dLHPArPtd/b7NHN48CZUzZAXfTnYlBNdG6t6c0olPr0p7r
 lKbilAkbEtSWK5aVbyrtp90/7wStpt9v9DA+05Zo7QPBzcQ6+KrQ/3TdRoMHyLEiDTzy
 87Dw==
X-Gm-Message-State: AOAM530B/xDf4zeJJIrZvNhTk+HaztcU+6XQZvbUq/feti2f+kB2vgHd
 /3XrPEwKmtD0YSTcEbkl/0lPRrFiSn56If+8S9aobA==
X-Google-Smtp-Source: ABdhPJwrKRR0wPI+2xnFw5uWPTP1BxwbFqewjKXBdeQN5vlTS4jsGYUYC9T/kc9Dq0lwKj6ra+qaqQJPxJmW2IkpohE=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr21789893ejr.482.1598549659207; 
 Thu, 27 Aug 2020 10:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200827173051.31050-1-sw@weilnetz.de>
In-Reply-To: <20200827173051.31050-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 18:34:08 +0100
Message-ID: <CAFEAcA_+OJAzvM8HxRoUPqt-rVLs75V=D7LuqP9ipD4Evyd0Hg@mail.gmail.com>
Subject: Re: [PATCH] docs/system: Fix grammar in documentation
To: Stefan Weil <sw@weilnetz.de>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 18:32, Stefan Weil <sw@weilnetz.de> wrote:
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  docs/system/build-platforms.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

