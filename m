Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8645CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CAE42071A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIFQNUAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAE42071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYTS-0003OQ-It
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYSe-0002Xk-JT
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:39:12 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYSc-0006t2-7G
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:39:12 -0400
Received: by mail-oi1-x241.google.com with SMTP id e4so4186480oib.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GZTZD0ll1HmUTAcGz2GOExCjdnrnOgYMIY200UVKlug=;
 b=CIFQNUAFR2GLGA+UKsnqwHrGRjPlajFoXT3irDZEW+Yzq9ww07q5keUzd4l5MlSfIG
 f3INTsFIoP4Y3SlZGusfWLYQbwk+ZTsnxTyjgihl6ic8DQ9xoVq6pYO31Hab2FPX0qBS
 3j7BOxGpXYyT2n+m2NoTjLSBWO58InD5RVhuUjVsESGm1JMlRt8oSbAze9F/gQWmrowb
 n8rOfC24U6GdwOEXyxR6oi67vd01X8zUQmJw58UUnHSOO61ezRM9E2Pg7Q0x1nOIJawb
 YJvO3/iUdXmYo7gzhjw3B1oxCXBDGA1HVWgMR4oijpM50YkONDblwIiRVFN0/zImaX//
 usiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GZTZD0ll1HmUTAcGz2GOExCjdnrnOgYMIY200UVKlug=;
 b=cYiO+QKdNb+0pg5SnzwCx4MKr6Vg45gFhDr9A10Bepbb6LH8W4FAhY9712EbJ82+6n
 MF9SVyKzfi0PVimZdpNKqCtybHpB9GYiaZYu4NwNTEE5ElkNt7lpyNrIB2iu2FWy5aLi
 V06tWvggHUqls78IVh9uJWaRw855IWYKYiTU74hB6Ufuob+vFLLhKoep0RHcJHMZOP6C
 5I+YZmmqUWis1VG0Gw784lukQPtuY7ykFbWaqSfPuT6PMwBrz+ttWavkqB23TohiEimN
 aM+YnJWX+Fkx3zZfqgwOADakv/9aWjGzJe3jMx2JE1cu2W7ONwGT2axR92ybaN+QKusS
 lXyg==
X-Gm-Message-State: AOAM532QF10tJ6k7kYgI72gz36LUdRxxXjBGzF2pqoXZMrrewQV5A2Mx
 IuJizc7lwc7fngayW/S8mjC8HvT5ulFFWt2GpdHsoujFKYYimw==
X-Google-Smtp-Source: ABdhPJz/ors8T2p7xdDPEHUhesneCOJUoEbFJpKBH7bq/xLntbv+lcbTObsD7hr+FAwIuzoiG/dU6/K4pkckG1j7Qg4=
X-Received: by 2002:aca:2819:: with SMTP id 25mr3603623oix.48.1593355147783;
 Sun, 28 Jun 2020 07:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20d398f5-729e-57a7-db92-2243c106d832@tribudubois.net>
In-Reply-To: <20d398f5-729e-57a7-db92-2243c106d832@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Jun 2020 15:38:57 +0100
Message-ID: <CAFEAcA8wfgQxAzr_MJ+wr6XXKAHGRx5i0SXA44XDbHhum5JEwQ@mail.gmail.com>
Subject: Re: Crash when running Qemu.
To: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 28 Jun 2020 at 11:56, Jean-Christophe DUBOIS
<jcd@tribudubois.net> wrote:
> Since the last pull I did this week end on the qemu git tree (master
> branch) I am unable to "start" qemu anymore (It was working OK from git
> master previously).
>
> Traces are provided bellow.
>
> Am I the only one to get this behavior?
>
> JC
>
> jcd@jcd-UX305CA:~/Projects/=C2=B5COS/work$
> ../../qemu/qemu/arm-softmmu/qemu-system-arm -machine mcimx6ul-evk -m
> 128M -display none -serial stdio -kernel ./OS.elf
> double free or corruption (!prev)
> Abandon (core dumped)

I can't repro using your command line but without the -kernel option,
so it's probably specific to something your guest code is doing.
I tested with git commit e7651153a8801dad6; which commit are you
using?

Can you provide either the elf file or a repro example that
doesn't need it ?

thanks
-- PMM

