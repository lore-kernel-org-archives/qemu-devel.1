Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A79C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60522466E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFoUbUR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60522466E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGrZ-0007eV-0z
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idFpF-0002x2-92
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idFpD-0008Ib-5J
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:47:25 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idFpC-0008HI-VF
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:47:23 -0500
Received: by mail-ot1-x344.google.com with SMTP id k14so6176895otn.4
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u8QLNo07HBQdIsufmK1bLWR4Lej76l9C0bZMmYBvyRI=;
 b=VFoUbUR6sel8ID1qs3q6PxvWtmpU/D+8H916CgowFKR3fHR0K/GHcAO0XW913D9mnb
 7m5Ena/fvsiURxh8FnkD2t7nfb1aaXRWoFVOJYY+UTSuBfRAS+ApTKGqJTChXQVAesWk
 wX2XMoXG2b3q+kNvrTtCItfubXlrDBRcFHobczLZ2v8F/ka2qa5FekIwCNB5QwSX5BbI
 Gv7/fq/qPupEIcriISnDYkuokgFCflWqVedwuNDdrN2Bloej3OS9/AyEL20KObWtLtmw
 FkT7XYFM8tObBOmp+gv/axsZ3Y5pFyPLUFn6Qd196lTEu38W056s0Spo/o/qtV7Lorp8
 cPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u8QLNo07HBQdIsufmK1bLWR4Lej76l9C0bZMmYBvyRI=;
 b=hjerxmRzxjXMeI9ITU9uynNKrNdhPFj2c371XH0g8DQmNjq/P3n+F1jFISsXNQbHzH
 W2bMxPktyc5zeEqN3sP1LJQH9DoMPc2DMmryMfZk4+XnvTpm8C/WMKjnFp3pF7hOFSLY
 tIrj5e+jidzpNT3dRXwOGbhwvdoJ0VanoArMh+2LgPcKAyacDnV1FBHG/VcXDDFxC8AF
 D04918lxLIIdFCMTnfeKCVJ3AYEVNQDJBccIZ5gfaTiutsBVmjHAkaBd9IXhZsbgLfEZ
 Sr0TnrjrFCQ2dX9YKeZtRFEo00DcbF2X/0VnXpgpO+VjmAUOpitqrHFxgJk5tDkwg8OE
 hDIQ==
X-Gm-Message-State: APjAAAXqUUe/EV52doOkwU3BmkHukvqVWGso4N/60lZFg5ateLn4F6L2
 W4alJfuJhUgv46cjpyzETRS54HfQKihryPHTwITtrw==
X-Google-Smtp-Source: APXvYqyBvsW3hbA5MD2hLtUEQeFs6zAxRBjT8JQGCtuOeJQpqZHX/rWMW3oGzpPMmTQ/Z6MZu2ednyl6Bw22vsyKEIs=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr5546936otd.91.1575647242193; 
 Fri, 06 Dec 2019 07:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-11-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 15:47:11 +0000
Message-ID: <CAFEAcA_Q8foDFHbqLBCewnYPbSz8-VT2OU49tQsX2No+Yn0avw@mail.gmail.com>
Subject: Re: [PATCH v4 10/40] target/arm: Rename ARMMMUIdx_S1NSE* to
 ARMMMUIdx_Stage1_E*
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 02:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is part of a reorganization to the set of mmu_idx.
> The EL1&0 regime is the only one that uses 2-stage translation.
> Spelling out Stage avoids confusion with Secure.

If you didn't delete the 'NS' from the name then it
wouldn't be confusing...

-- PMM

