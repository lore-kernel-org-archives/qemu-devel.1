Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E73C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4472088E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+G+LAqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4472088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jow7z-0001NU-RA
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jow5j-0007Hz-Ji
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:40:59 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jow5h-0004OU-SE
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:40:59 -0400
Received: by mail-oi1-x243.google.com with SMTP id l63so9245181oih.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OonjJjqVdhCWklfLRYzsIcJOt3ledBb4lvdwgj9eqcw=;
 b=V+G+LAqIsRzSpKX8lle4D/FSD88mCl63QC0y9bFvci6sUi1svc/izahcTdfM5DwXfK
 h4QWFA9HzuwEvbY1CaENtGJAmsQVtQmztFEeRtMuEzr02MqnJf2e5SKVDHJcxyRYAmXN
 1uq16Es2Ip9zKsplVg6/4/+m4x0+AcsdoBM3ztW2/x1o1JGqeKA9TtOsFnSz9NPKfxlv
 ue+VDRw2QfvLfv0unPT12JcOGOkrhv1eDiDtGTOoG1fbEKxptiT1O50w4hUfxAIgs7YT
 gHPEOYlo8qREL7/uOXpCtIgolvsPuzjGNqw6iVdsj0FDh013fxpMXDgl9S91vB4eFh0Q
 vSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OonjJjqVdhCWklfLRYzsIcJOt3ledBb4lvdwgj9eqcw=;
 b=etNzXrX8SBOpzIvh9SH3D5n8WM/eecOxLbPgf32AVClR9E6HXVaIWL2tm7raIGLOQg
 NWLkmiGzuJTg6GAXaW3w5PoPu6ILkgF+aewOna0l0ELlGoMG1LQBHwkpQ4WPkMRBkulH
 WOLArwK2PA/doeoAww3oA6G/rGdI7RCTQDtXtfAvtFaMbYSpc0BYLgAFR+V4JphPTWr6
 JmvcVlQmbu2RIdBWlriklamQXV6qht0FrYBY2hYHdfbhcUJKeSO38wioOcgmhKUFPEsR
 4z9fD2Z4tNtkX0EJt/igmnS8D8YUFmABo2CNudewTmrma1JjVcSwg+L9paQw8GwRoucu
 /rfw==
X-Gm-Message-State: AOAM530sv25Tp8vH+ApKk6Pcm26qIV6FgHS1VxPSVqWLvnu2MwXvEP87
 8B5JUr2VQZcEWObe77hWpdH4XVlATXu/B/hKQvkrqQ==
X-Google-Smtp-Source: ABdhPJwnHurYpgxpr/CN9AeeCXRz91jiSRvm0VWzZKrDiXC7UPru0XeYgxqNJkAnp8GP5GN2U3vCGTnZX0V8TZGd3yU=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr4092816oia.163.1593207656006; 
 Fri, 26 Jun 2020 14:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200625230740.549114-1-keithp@keithp.com>
 <CAFEAcA9ut5CVAgRTP-_BK3WpiDSmitFowZMe549TvgSAjj+Kfg@mail.gmail.com>
 <87imfdixv9.fsf@keithp.com>
 <CAFEAcA_ZRMpqAhR7BL05a+O_C54fhXZn8-+kC_KUU5n3BpzoCw@mail.gmail.com>
 <CAMo8Bf+57b=u12nMp4EWaza3WdOQpx_L_O=HvdouM99wW-Xe=A@mail.gmail.com>
 <877dvtinyx.fsf@keithp.com>
In-Reply-To: <877dvtinyx.fsf@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 22:40:44 +0100
Message-ID: <CAFEAcA_E3MUbfgf11j=FdpeNbCr622g3WoNhWdMD0ONUAynM-w@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Add 'virtm' hardware
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 21:14, Keith Packard <keithp@keithp.com> wrote:
>
> Max Filippov <jcmvbkbc@gmail.com> writes:
>
> > Most of them are due to unsupported/differently implemented
> > syscalls.
>
> Yeah, I think that was the basis of my confusion -- qemu-arm is not a
> bare metal environment, and my work is focused on enabling application
> development in that environment.

Yes, but for certain cases of bare-metal code that doesn't need to
touch devices or use any privileged-only instructions it may be
a usable environment. (This is more side-effect than intentional:
as you say the primary use case is Linux userspace binaries.)

thanks
-- PMM

