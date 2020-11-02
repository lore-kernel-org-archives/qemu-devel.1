Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B84AC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24BA2227F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKvHIJjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24BA2227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZaDt-0006xo-On
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 08:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZaBz-0005Fi-R5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:48:15 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:43648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZaBx-0001cA-W8
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:48:15 -0500
Received: by mail-ej1-x633.google.com with SMTP id k3so18930803ejj.10
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 05:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4SBAfjimVv5u9bHmXWBQ4ngF2s4v8D6Bz/wbVL3Cgy8=;
 b=IKvHIJjp7DmIYP5MPg879p+7j+KejkQsbFIhPgHGphCgNus5vF8caJGvX39dLdtRZc
 O5aeINqUVsjjc29tbnPZuYGsQFxPvFw4qUvuaxKLOPvnS9Fy4ci1frAhxfCnw23uacpW
 k2IiNCrvs5QJp60JgWNGFpwxJUTBhSG3mOzyZMdVnPAnqgOHlQ5n3cfiQSrgjKvREcAS
 6fTM9nBl+CveBiRndEOTvF2mXELdXeXKvf4OTuwRYiWh+WharQBcBcK4M2YDEbyWAI7m
 gXtMiblvXL6GcI2EFTVwtWtsYjwdx8Q65OGzJEJDps3MCCZwoW37GRzCQzEKa5W6h2F+
 x1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4SBAfjimVv5u9bHmXWBQ4ngF2s4v8D6Bz/wbVL3Cgy8=;
 b=CQiuv54AwdfxbahhTNj43uEJpOJI6wboN3+h/o0pW3KYpE+YA7x5slQP4kc3atLiEm
 /Ak+YNol73MEpmN74K2flIP2Rty4+VvB1MvwmZ8rfXaSplltpU+AZ4rHyIWUzIouguWT
 bpBJLO/5qxcNXKgV2v1Of+Y0fxbpfcxV7siEnWZSPf+ux3msd9D072hHPpNEvExc6ZPO
 D07eYrPbgxd389ACYJrYEp+bFRg48LoDRG2Lc3jCR/ZSrw1p3KbnL1L6rhw3D0Gd2chB
 WSbm8wW4Iy3c15ghBs4YGyGI6Z6n2N85xGA21j0kL6qdsyAQQMVtFszNYvTz8D90jJhw
 o02A==
X-Gm-Message-State: AOAM5334b70fFne1WTAuJ4ZadSsVCvcGYzpcpm5U3WnJdWaXVw6xcWGX
 rjTInw9KmMqQhToXTCYeZHX+ilOPJTnNOQucpzcQ5g==
X-Google-Smtp-Source: ABdhPJzdfsN9K4kKT18kfbvY5VbEcaJyP9BVztlhGcnVi4PexEqJ6oU2Ii+I/REi3igoaG9z6Zsy7bUjWRsw5ZshKSw=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr14892369ejb.85.1604324891250; 
 Mon, 02 Nov 2020 05:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20201102130926.161183-1-berrange@redhat.com>
 <20201102130926.161183-4-berrange@redhat.com>
In-Reply-To: <20201102130926.161183-4-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 13:48:00 +0000
Message-ID: <CAFEAcA-Qn17C5E4ABsay=Anq8pmopisu87eD0vS50XDa7jYnwQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] docs: show stdout/stderr when meson fails build test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 13:09, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> It is hard to diagnose why Sphinx fails in a CI environment, as we
> discard the stdout/err and just print a generic error message.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

This kind of detailed-diagnostics should go into whatever
meson's equivalent of config.log is. There's an argument
for printing it if the user asked for --enable-docs specifically,
but if we're doing the usual "see if it works, use it if it does"
logic then we shouldn't be printing diagnostic logging from
Sphinx (which can be pretty ugly and longwinded) in the middle
of the meson output, IMHO.

thanks
-- PMM

