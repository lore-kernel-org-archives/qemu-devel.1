Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC492C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4017320672
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwGT3dKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4017320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKPe-0000nR-9X
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOKJ6-0003X9-AG
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:37:04 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:45224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOKJ4-0006j6-MA
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:37:04 -0400
Received: by mail-ej1-x641.google.com with SMTP id i26so1724685ejb.12
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 05:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j63E2tRroDA+OMewjGQyEGOgm0+HubdVlbniVt+SiO8=;
 b=DwGT3dKT85NdwiMhqBNVmdCqd12TUJ+pLGPTI+X7jVMXvV+ubsjR1m2atq28MDguM4
 RxBlVlXem9FI3sotIIgaZ3FtJU72giVvQyPjY47I/xFpZ18i/FAglGKhHhs+9HOfGIkP
 wah/VTG1dr+4w+CuoVF+iRglVJvK/DoBB7PE/eShdgaVj0I9OLWieTGmp0UvXoxN6Fjb
 RMT9U+W2bTgAAxKZ+foG0+kN1mMY2b5f+1snWb9aOpwgi7kQofsWukC7elEx4nbM+NBM
 u+d4HpXSZu9s2rQ0D9Hrwf8vi8HOY1P1mxYjfSH7a2H2uzXYIp2GMbUBJXP/VYe4G7WT
 q2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j63E2tRroDA+OMewjGQyEGOgm0+HubdVlbniVt+SiO8=;
 b=OtKDx1wRJYkXj6M8Ia7LyUY85whKxh+v1bVaEtipMktKtSdD9rq3sNp6ahQkh1bref
 R4RvEib1OAGNAmwe/n2XDN0NkgP3sY/QhLeZIoX2aMWrUHSAIyzKGooF6pqlA4T4GPkv
 wOeSOouEfVVpOILhNrCU1j292QAyUOXb35PiM6jauxXMu8yl9cZSml6jX4J3QgkIW3J5
 raYdtflRumiIEXdHUsO4J2ayKzjF/gqVQafS+7Oh+7ycSiHstbfMHww7F0H2jrU6Tv52
 6OqyrcL4McpY+Vjy43FcyUWYfS7q37VgR3Lu88yrM69Bl3PY5DqFiZK4GvjwJ9SnsB2I
 GQOg==
X-Gm-Message-State: AOAM5327XE1lVBUV4udPFwg11cWXfGpDiNpJ2HXLJZtisL+jAj+kr4Yi
 R7Ooyrx2BsJAVdyI/kNfm0CCgQppqKVg84+KGrD/UQ==
X-Google-Smtp-Source: ABdhPJwFBiKxFL+4hjkVhHIOmkggbXzXHhiJXDxL068mS/hNLk9jPD6mn1t0pBux9mcmzuH7OE4fqzeVZcLrPerUTYU=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr2092079ejb.4.1601642220917; 
 Fri, 02 Oct 2020 05:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
In-Reply-To: <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 13:36:49 +0100
Message-ID: <CAFEAcA96sZqqSNSJT7TET8qfArLnWJr5tu1YLqFGBsnca3YoFQ@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Paolo Bonzini <pbonzini@redhat.com>
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

On Fri, 2 Oct 2020 at 13:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 2 Oct 2020 at 13:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > - the workaround: just leave things as they are and add
> > --disable-libudev to your script.
>
> There is no --disable-udev !

...and there's no --disable-libudev either :-)

-- PMM

