Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E0CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 13:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E54207CD
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 13:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sV4KhXk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E54207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jriba-0008Ax-Gk
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 09:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jriaq-0007hl-EV
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 09:52:36 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:44223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jriao-0000Mx-Gg
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 09:52:36 -0400
Received: by mail-ot1-x332.google.com with SMTP id 5so26504049oty.11
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IfA4rz4odTlD24BG83gXtZF21STVQ07kszBBxsnUIAs=;
 b=sV4KhXk3MZMIbvcrGtu3fK9jSLDbMJK4H3Ss4YXAvmXP+rlNmMv1EcvjBaAm8tE3zu
 V+6rDFHCAGHjOMsGjClkVvIhr22HPBzppbp0Awo05Rx6hYG1YaisB1eEMs8B77IFsrAt
 tJTgDATWem10nQTH7M6uUhXyfVz1frX1l3nm9HJUxyMgnDQfr1wKls+IMii+fsMK+lof
 9oOpM7zwKcEH03mRQ32QenlL2p3+kbiDY4gRK+tBP0DCLaYyGruUiZgG0A6YUIRavRB5
 gcHWhA/LPjoW4AHhJxXNOnOY0xzqbqV2uDx4qmaWhG/Dt1Zk8lNNVP7pQ8YnfDZJ2SBd
 mYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IfA4rz4odTlD24BG83gXtZF21STVQ07kszBBxsnUIAs=;
 b=hthcqIY1yp2GAn8mI21Gs+jQ24+ojZTepL6czJcdWy0/8pMo1I/yiTUMPOvN51h3Dd
 4zxXSGAzrvgQdhughnVPbJcKXKAYntObYKQk1HCLD9GCO2x771t1KaHYkveE1Haes6GU
 4Bq5B6NF7g2E4QSOE+EFpDXTyHmuZ5UrGopGL5Y4JBUAh9qsT+uaqOj90MBf5v+tspXt
 M1k+pAEwSriwaouDi0noE7xVkXCYbdGjmj3+bjKgW9xEiEROkriwZ9GM7HpTtONBnuWO
 SoN8kCcwzmWV3/Ygp+HgT8Vw4qDI6p31jXT3J2TrRYfIQ7l2xeRvrxGKEsV8bM05f3RI
 vaBw==
X-Gm-Message-State: AOAM531CX1lL1hkJaoz2eladTdl5AX9jYHCzbM2iqFgkLIN5JbAGOuV9
 tOBJ+dWhGY6tzyOQN6WG8S6+yM+WdgBSQ9uN1ihaPg==
X-Google-Smtp-Source: ABdhPJxSTI3F7AgVdB4LbTplsx9Y5jpDQQ1vtQ8TpG1tl0F17Udp1I1DN8T1OKQemx0dj6DY/rRzeVIvNEBffTtISsU=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr32169866ota.91.1593870753182; 
 Sat, 04 Jul 2020 06:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
 <5EFF5DFC.2060006@mindspring.com>
 <CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com>
 <5EFF7DD7.1000605@mindspring.com> <5EFFA499.7050008@mindspring.com>
 <601a18a7-d564-b9d7-7187-53a05d819551@amsat.org>
 <CAFEAcA8-ECTRrFayHYP1wnf19pn05UXwuxvWobBy9V6qUVJ9aw@mail.gmail.com>
 <e689a79b-0c49-2779-6fc9-24b46a22587b@amsat.org>
In-Reply-To: <e689a79b-0c49-2779-6fc9-24b46a22587b@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Jul 2020 14:52:22 +0100
Message-ID: <CAFEAcA-F7zN9EkiuPVz3pOgLiS0QiShtms4EgquktyTSrBt_AQ@mail.gmail.com>
Subject: Re: gmake in Solaris 11.4: TFR missing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x332.google.com
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
Cc: Peter Tribble <peter.tribble@gmail.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michele Denber <denber@mindspring.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 4 Jul 2020 at 12:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Any idea what means TFR? I understand it keeps retrying while
> interrupted, but can't find the origin of that abbreviation.

Probably it stands for "temporary failure retry" -- glibc provides
essentially the same primitive in unistd.h as TEMP_FAILURE_RETRY:
https://www.gnu.org/software/libc/manual/html_node/Interrupted-Primitives.h=
tml

TFR is pretty old as QEMU code goes: added in commit aeb30be60a92148e38d
in 2007.

> I'm not sure what we gain by using this macro, it seems dangerous
> as there is no guaranty we 'expr' is a single libc call updating
> errno.

Well, the design of the macro is that it is for use to wrap
expressions which are a single thing that update errno...

The gain overall is that "we need to retry practically everything
to handle EINTR" results in lots of awkward open-coded loops,
and in theory putting them behind macros makes the normal-case
handling more obvious. But this only works if the codebase is
going to consistently adopt TFR() as its EINTR-handling strategy.

(EINTR is one of the big failures of the Unix/POSIX API, in my view.)

thanks
-- PMM

