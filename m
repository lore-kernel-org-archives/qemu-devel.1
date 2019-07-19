Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297CBC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E682621849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hoV9zD1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E682621849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoRRM-0007KE-7k
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 07:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42815)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hoRRC-0006tw-53
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hoRRB-0005tm-2B
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:52:34 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:46325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hoRRA-0005sX-S0
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:52:32 -0400
Received: by mail-oi1-x22e.google.com with SMTP id 65so24024379oid.13
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 04:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o5oCCfZrt6E6bO9/Ub2USoUcchi6gyvx8eQLK2EhB1w=;
 b=hoV9zD1US0p4DjRaeQ0ZyVxR7CMscjuH4IT45GMAvFjGlfrH/zM8U54hQ7XmQKc4x0
 eiKILp3V1Vt7vHdlQNNd15M8Q42m//d9ePEjCGSe9u3m6YYR7HnGjCNBgbHtF65RH7Jy
 TWdxCwb/kVzDRlsqBkJKdSyCI1LiT1vYZV/ICX4gC/4iRCM9377AavQnpkmrR7Zy0ZVF
 uHQmARBdQeZwCaHX6Ooo50+kseM+ueO5Zcm517RiZae3mY7hRhRjDPFSkPlnfEdJa6j6
 EaugxPI34eN27BTXVlF8vXxkn/ENtyRO4fD5Uqplm8jdV3tkK2MNUBVlCJfnZO+RGmGa
 cGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o5oCCfZrt6E6bO9/Ub2USoUcchi6gyvx8eQLK2EhB1w=;
 b=nQX+dw2KfavHw+Dl/UkCn0OSLLxcmWuISfRGKfNGiyuCXTfrzF0Hy3g0XXn1TlHguO
 ZUwaxrHgfTKcPxaJDzzuqYUtUPwsFOuuP5FmXAzKEIp5XA3h25A49amAEVWLmxnPJDqY
 l/yliPH9Eqor4wWaX3DEqSNgHip+eejO+zxAUq30WbFCmEg4UXFnFCvkgQOIhkUCWrGz
 44UA38mbVhY6vqC5B1Jpmh3nyq9wKBTpK0VPYI5cnLvhTG1jIh82fSSOcFD/E2hztEIp
 hvDrEymvfJrZI6b5dERKvn6qtPHlN1Y5y1p3V8a5FP1t9yLQA9AN9uRMinoQZP5FIcI1
 5LcA==
X-Gm-Message-State: APjAAAWiBt+8Zvj2rm5OJoroN8XCK+BEX6uRl34G1Ts9AljDv1ws1riF
 P22ZZOcXbs0k9DNMTm9WSUhQjJyKUqP91RU04e1F3g==
X-Google-Smtp-Source: APXvYqyWKV+5bz28TO4uOqRtf4ZPw0vY6qwV1EjE88O3D8gvPmPA6bYKBB6Vu8kIaYMCwfixkYTHaVXMZr16gMcMdcg=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr5926754oic.170.1563537151899; 
 Fri, 19 Jul 2019 04:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190719015811.14776-1-palmer@sifive.com>
 <CAFEAcA_MGz=EvH67twNoM-SMXZ8_pE6FhO+JuLN=0Z1H6sfRnw@mail.gmail.com>
 <CAFEAcA9mR5XxV9ghSzt4PbANKZJW1xKMGF1a9+ak+m6OyZ-YZQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9mR5XxV9ghSzt4PbANKZJW1xKMGF1a9+ak+m6OyZ-YZQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jul 2019 12:52:21 +0100
Message-ID: <CAFEAcA_tJk1q1A=niWojabO2Dy6vAuiHSDDhw19wT9GXHXBikQ@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] [PULL] RISC-V Patches for 4.2-rc2
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 at 12:11, Peter Maydell <peter.maydell@linaro.org> wrote>
> Since this pullreq does pass the tests, and rc2 is not far off
> now (Tuesday), I think my suggestion is that I'll apply this
> as-is, and we should fix up the issues with the warning messages
> as a followup patch. I think that's better than holding this
> out of master and making it risk missing rc2.

...and so I have applied it to master.
Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes, and please also submit a patch to
fix up the warning issues.

thanks
-- PMM

