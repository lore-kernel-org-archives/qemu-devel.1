Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0A2C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626E623719
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 21:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hozG6S8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626E623719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMHql-0000yT-Ea
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 17:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMHq1-0000ZB-8U
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 17:34:37 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:38660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMHpz-00085D-NM
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 17:34:36 -0400
Received: by mail-ed1-x52c.google.com with SMTP id c8so6089967edv.5
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5pj6pBQcL4Jpdg+oVSgAY4VLWJgnIXrPxPGRtYwd0jc=;
 b=hozG6S8MEa859r4GYHrjDOCj0BoNtmbjKRN6sNdyrhz+5+L90CzmjksyZ5NWmPS8fN
 ZB6pHF5e9kYb8fRhGLOxrvd1nRJudybmzw+Hhu/Z2T37o70tAOu5Fb3T2STCnSi6FRGQ
 6rpa8o9F0QxKZEl5ZfTfjHl9t1JhFMT8H8ZVnVtNPSlWHl02v29xXp4oZQEB3hZzr+Gg
 md4lktedXaEIbF75DMB7xCk2h+9jNET0W+QEp7Jd81s30aiM0DC8PNvfVrjylgORVK4W
 t4lR3v/Tb8sVEQaYaxO4CMxD9lqHuBVkjBoq21IZOkEWirCgVEE3RnNMuCU3+ZhasE3K
 Uizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5pj6pBQcL4Jpdg+oVSgAY4VLWJgnIXrPxPGRtYwd0jc=;
 b=WA16xaldvSRXZSzPgdHWPDwy+4ambr8Qpwt62sfn9e2vyuJ00zMzhOnyfvIDygEXlf
 NMzNvRjDukj/BFwYsnAyyruVet3yljTtaEwrPVtmI6OKaLD9tTexNzuS4G1wUcClGkHr
 DAAWm/fowEiASwD85P4Qx6cVdVWeKzBZnAHbXgL5+i7cY/ZSjM/2Uj29ljMbV1XPnvlb
 3/3+GeVce13TnOZmr/MaWQZYARNVkKm8jx1cP+1Gmw3Gz3ljhm4jLrhsfjie2V92WGqi
 a6VEJxZMZTbScHBbz0lqXbhailcDfh2RdQ31ZTxCVKx9Wpn1rEPFM0+CdOt+X0aB/VQG
 DSvQ==
X-Gm-Message-State: AOAM530LgP8uLRym/CspoMaNtS7dajW4Ka4iE6Cn/itvlIq3wryqeQqN
 T8ZLcFsu8s49OgyWMlf2VU5vczqWh0Afz2tPLW28ug==
X-Google-Smtp-Source: ABdhPJyR/wust6Jf9R6K/+eOPcJ09oobOkoChZqQTotoavnQcZVEJMFJsm4Hu5y6ji0EffHJQUq0mtkgwxcvNrjyeIw=
X-Received: by 2002:a50:f28b:: with SMTP id f11mr8226636edm.44.1601156073489; 
 Sat, 26 Sep 2020 14:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200925024143.26492-1-maxim.cournoyer@gmail.com>
 <CAFEAcA_wU73U6eaHU0mwccr-E0EHSKzFJ1yiR++YEKv=1LneJQ@mail.gmail.com>
 <87mu1dtao6.fsf@gmail.com>
In-Reply-To: <87mu1dtao6.fsf@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 26 Sep 2020 22:34:22 +0100
Message-ID: <CAFEAcA_4wXqGeOgsY2GbY1mk==DCz--j-jhs+OdGQnOHEf+D_A@mail.gmail.com>
Subject: Re: [PATCH] build: Build and install the info manual.
To: Maxim Cournoyer <maxim.cournoyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sat, 26 Sep 2020 at 05:36, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:
> > This isn't the right thing. You should be pointing sphinx-build
> > at each of the individual manuals (system, interop, etc) and
> > generating one info file for each. This is because we generate
> > manuals for each of these including the 'devel' manual, but
> > we don't want to install 'devel', because it's developer-facing
> > and not needed by end-users of QEMU.
>
> Is this the only reason individual manuals are being generated?  It
> makes sense for the manpages (which have their own macros), but
> otherwise (for HTML and info) introduces a lot of complexity for not
> much gain, in my opinion.  Users not wanting to know about devel
> internals can simply skip that section; no harm done.

It is the best way we found for getting Sphinx to do what we wanted.
I agree that it would be nicer to have one manual with all the user
facing parts in it, but it is apparently not possible to do that without
shipping the devel docs to users, which we didn't want to do.

thanks
-- PMM

