Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CA8C433E6
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:52:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D87C20657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XABnGFXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D87C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvgto-0008Va-A5
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 08:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvgt4-0007b9-9U
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 08:51:50 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:38234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvgt2-0000fH-P2
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 08:51:50 -0400
Received: by mail-oi1-x231.google.com with SMTP id r8so2096884oij.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QKasudNVDdFlE/Ts9MtdBH2YKVFTS/zcDfsokbtYwqo=;
 b=XABnGFXTo+pXh0/M2zf0cUXrzVGSxxMOpo4bySHb3MN7EywdO9jwxfJUm2U5/J2GC/
 iVIgxxWcDKmAnsdyFFdDnTMgX86EM9cD3QdY2W8eyeaB8qjTODwiW/vjCVvKUU0KUqTi
 DoNb7bNw9eyhQO3pHaIW6B+rYf5VIoQLP7hy32CXIPAIH0nKxfxdjbk+tWptMjbaoLK1
 SOZHVqzh2bqqm6dOkyz/BVPL/wSzgWQsFdLHDq7jl5w9jnid7IvM/GI80jRrEsbIOCNv
 BqOtYPf2pZiD30PnFPNv+uBA/we6oewcZtTJwP1XbyZcsn0uulHCBbk9Fr72EJfEc0rD
 sLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QKasudNVDdFlE/Ts9MtdBH2YKVFTS/zcDfsokbtYwqo=;
 b=lvxHcPxCeB7P06vNb1yoKPBnAvsl1qTeJybtxdPxHOh+i/8u7gsSin6R0uce0FY+1z
 6Kp6pl2VcBuT02SPQ7jViJvl+4o9Z7oJsOJP44a7WmwJV7w8EK0R9nLwVWT5QIctp7iD
 wH2pHwRvyqPikW5YPQhYzH+UP/9fHk2FsVhtbi1TCWWGj0qfkONptWwRTBdBigwbZEVn
 BlTnsXG7eb0iRtVXoDLJAAkYAKdrh3++Q7nKDOWuBGlVj01baSqgndyrjObOrve8Je9k
 OFDQpUlIhH7MZvPtqOedbHF714jaogDifWrE0N7JNxhKeSqLhMEujLl3IzJo+cgbOOS4
 zTNw==
X-Gm-Message-State: AOAM532N+FNQS4lUYXgQaeXjrWU5Zd43zQfsto2yrmdNmS7tUSRKZm9t
 Xpa0Sj89cr+QwYnj83ilQRLZtUe+FUMjVTMW2m8D2g==
X-Google-Smtp-Source: ABdhPJzd3KGCmDqdYvDHfOfSwlCz6hdaYQSMHPEkgMcSZfwe1aYcHDoh8pBPYs+N7ytjPEi/BgfhiZd/ndos+8E6g/E=
X-Received: by 2002:aca:2819:: with SMTP id 25mr7087476oix.48.1594817507449;
 Wed, 15 Jul 2020 05:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200714095247.19573-1-alex.bennee@linaro.org>
 <CAFEAcA-4U-LAjcBPWQNrtfk=Kr2zsejHGYCzLWSoYq97_o9j8g@mail.gmail.com>
 <89543ebb-4c8d-64f6-f15a-e1736e683e22@amsat.org>
In-Reply-To: <89543ebb-4c8d-64f6-f15a-e1736e683e22@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jul 2020 13:51:36 +0100
Message-ID: <CAFEAcA9j7GDkKyChCsDo7=Qa8CGj7wRA_csSfV_nijs-bYV-gw@mail.gmail.com>
Subject: Re: [PULL 0/9] final misc fixes for 5.1-rc0
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x231.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jul 2020 at 13:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> What host/distrib are you using?
>
> I can not reproduce on aarch64 (Ubuntu 20.04 LTS) using:
> gcc (Ubuntu 9.3.0-10ubuntu2) 9.3.0

Ubuntu 20.04 LTS (this is the aarch64.ci.qemu.org packet.net box
you have access to). Also Ubuntu 18.04.4 LTS aarch32 chroot on
an aarch64 system.

> Any config in particular?

Nope, stock "configure" with no arguments. Incremental build, not
from-clean.

thanks
-- PMM

