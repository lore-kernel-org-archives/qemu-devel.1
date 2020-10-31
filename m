Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660DAC388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 15:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D9422284
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 15:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8aslCTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D9422284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYt6V-00053x-LN
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 11:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYt5j-0004dL-RH
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 11:46:55 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:37690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYt5i-0001nK-AC
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 11:46:55 -0400
Received: by mail-ej1-x629.google.com with SMTP id p9so12730367eji.4
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hrkgyVYWkf7xwImM81lZ+9UVWszEekPKcpOIVchJ2do=;
 b=W8aslCTMCRPo+KTWaRDmbOm9xM+dorBTcW3tYiuAM1GN2R0ph5wWY4XDYr3U/o6yBy
 /LiAVx1Nrr3O72CtP/x2J6rnx3W9YGNHVGwtROAELuDRuvL6vSzh5sImeA6oHWAfIShR
 TIskB7faVbH0s4wP1iuYT5UWVXZxSjpspByFyAkUOStErb4ety47y9zCXaes6jyA35tS
 7ZvDK5a1vC1KNF1gmZJNWJAid/EW0KfuRrvc0QrwypFkZXJ3+R93RzbFIq9CJCkpQVNa
 lEC4UAOy6xKlzOJ9P5b66FuSeq3oMS1dRlKsYUHUl9KYmGYexo3gMm8OpUH0zSbHr4lN
 F9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hrkgyVYWkf7xwImM81lZ+9UVWszEekPKcpOIVchJ2do=;
 b=hKLi4zF9Pn4r/0yopesRF/UZFyXTPe1HvlAkVeKLk4IAMijE+xip7qNnjk2cF/IFX5
 rN8vZzzF9B0wXMdoOxUuZl3FXv481EmMwCEQgGIV+oXEpwy1/2wUHhBEeYD4kKQpVpiu
 bpiUQMaHihXM+0X+66YDT48vQt1q00lial3LE5+oedSkHEFdKf3oi9FFA7wKJQz2Tj57
 xsbOA6hcea1QgXE0QCTT7Hf2OBPdmeauMgSZRuVbcVNY2Q2Ls/TrF2iPoD+njrRSxx6+
 30A3sJE93LxANvuMhsdXPlZYZTJ6/56pr97cvt8e6wHivs+JpwaxPsxWzxsxu34nYcCy
 raPg==
X-Gm-Message-State: AOAM531JDRLr7hCD4cbNcXXmUVSOJyBU1nnLCW0R/1FMNeCdesX5K2nS
 Lmt0frjtrPDx4HHr5IsikgJPI81V56o+fLgJUBALbg==
X-Google-Smtp-Source: ABdhPJwta+ttihQZXFYP+PPk0G37ItEKmd7VnJUcCI/ZnPwCfw35coZvNHJSH48tYQ0N/6mkjN39CWZ7AR+AOI4At9Y=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr7650319ejd.250.1604159212828; 
 Sat, 31 Oct 2020 08:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201017144805.1641371-1-pbonzini@redhat.com>
In-Reply-To: <20201017144805.1641371-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 31 Oct 2020 15:46:41 +0000
Message-ID: <CAFEAcA8CEDe6yinvaTMqbho7i_ZBWOSYG8_J_R5Xx56VxXD=uQ@mail.gmail.com>
Subject: Re: [PULL v3 00/22] Build system + misc changes for 2020-10-16
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

On Sat, 17 Oct 2020 at 15:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
> ----------------------------------------------------------------
> * Drop ninjatool and just require ninja (Paolo)
> * Fix docs build under msys2 (Yonggang)
> * HAX snafu fix (Claudio)
> * Disable signal handlers during fuzzing (Alex)
> * Miscellaneous fixes (Bruce, Greg)
>
> Yonggang Luo (3):
>       docs: Fix Sphinx configuration for msys2/mingw
>       meson: Move the detection logic for sphinx to meson
>       cirrus: Enable doc build on msys2/mingw

I've just noticed that there seems to be a minor bug with
the new sphinx detection logic: if the Sphinx is the
wrong version then it prints:

Program sphinx-build found: YES
../../docs/meson.build:30: WARNING:  exists but it is either too old
or uses too old a Python version

ie it hasn't actually managed to substitute in the
program name, so there's just a double-space after
WARNING: instead...

thanks
-- PMM

