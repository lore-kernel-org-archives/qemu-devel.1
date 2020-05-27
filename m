Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A14C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 21:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5F52075A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 21:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oK3Pr/eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5F52075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je3nJ-0002Cq-Am
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 17:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1je3mj-0001jS-S4
 for qemu-devel@nongnu.org; Wed, 27 May 2020 17:40:25 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34]:36671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1je3mi-0004Ey-2J
 for qemu-devel@nongnu.org; Wed, 27 May 2020 17:40:25 -0400
Received: by mail-oo1-xc34.google.com with SMTP id 18so574366ooy.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hOp9Kek0xMpWMgbiq6UzR9ruf5brIKfzYIbtnNJJ8a0=;
 b=oK3Pr/eh5TC1uNSVvMWqm+8eAVv32C4lF57gvwKDSdRLsWvuRQ4onhgy7C+xeJUcyC
 07tVM6Iugfd6hAYZecZuq0SgWNuzRHUvlYHNlNS7qcRWFgXRflXz7ViDGBU15sgSSmwx
 A6k4j23+iLBBrRF44u7Axkb9CKvmKVdf8smh7thjz75KIusWVulrTfK4cB0tJW06SlwB
 327DvYHPaLkzWadJb7qLtiwHDhx6CeYVYBKbhjg3ZQCsOm8OqqRcQadoQvPRpi20t6IP
 vKQVvHmPgIL0lt9B4025Ux0YgTa5Yl79+KwfPxDm66KO+6iAoa+R06m632WiFTvV0QmK
 jc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hOp9Kek0xMpWMgbiq6UzR9ruf5brIKfzYIbtnNJJ8a0=;
 b=g/aN6R/WRQZvRa0KV4wY7SU959gOKXmEdFRy0HUTNEkBMpzzp5Gv+au6dV0WLyHckn
 QmzxAa7GiO6RlGf3kyTpxBMvCAMtQkrth2BPxo+T3epugiAd/IeduWLRBvjBHySIIEMz
 TnunVWCDwQ6CvKs657aEB2ZqlF1IoKDRXBWA7z4yHPOmWTZi5TWDD9YErM7M+kpnkiGm
 C752gn3mN1kdrske0MkdEtizAOMEhSVctXDTjQL3o9Qow5uwVBqbjP81diD73V13yIoO
 oK2YfMgKR6LJUjtCjlXnppTAxP1QeN/kig5hlnwnRc9xcw0itcVu6TG0ayJiTwpsHD2X
 7TKQ==
X-Gm-Message-State: AOAM532+3RPS6TCQ1AWdBwR1zR0gmREKMMCjiNM0vnHWsqYVxQU74E+u
 WDGAar21egCsErH8JU3p2ig715QK3WuCvlNCtOswyJ7CcvE=
X-Google-Smtp-Source: ABdhPJw+BcQMCBDmvfgoRCVJr/aZdHyYTinAFpL8wpkLAQsZJrTl5sf3qbepH/jg0QcPq65Ixdcp/MkBrR+EMfk7gPA=
X-Received: by 2002:a05:6820:5b:: with SMTP id v27mr147945oob.85.1590615622473; 
 Wed, 27 May 2020 14:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <159060681483.5838.13632051970488338647.malonedeb@wampee.canonical.com>
In-Reply-To: <159060681483.5838.13632051970488338647.malonedeb@wampee.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 May 2020 22:40:10 +0100
Message-ID: <CAFEAcA_NTEUoWfqpG9uhPY0pE697F-_MDLNexq75k0tYdEuuYg@mail.gmail.com>
Subject: Re: [Bug 1881004] [NEW] fpu/softfloat.c: error: bitwise negation of a
 boolean expression
To: Bug 1881004 <1881004@bugs.launchpad.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc34.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Wed, 27 May 2020 at 20:21, Philippe Mathieu-Daud=C3=A9
<1881004@bugs.launchpad.net> wrote:
>
> Public bug reported:
>
> Last time I built QEMU was on commit d5c75ec500d96f1d93447f990cd5a4ef5ba2=
7fae,
> I just pulled to fea8f3ed739536fca027cf56af7f5576f37ef9cd and now get:
>
>   CC      lm32-softmmu/fpu/softfloat.o
> fpu/softfloat.c:3365:13: error: bitwise negation of a boolean expression;=
 did you mean logical negation? [-Werror,-Wbool-operation]
>     absZ &=3D ~ ( ( ( roundBits ^ 0x40 ) =3D=3D 0 ) & roundNearestEven );
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             !


"(x & y)" is not a boolean expression, so we should report this to clang
as a bug (I assume what they actually are trying to complain about is
bitwise AND with a boolean expression).

thanks
-- PMM

