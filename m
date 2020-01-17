Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168B8C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D589E2072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iOzeS/mJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D589E2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isWUr-0003J3-0L
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:37:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isWTv-0002OS-Mz
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:36:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isWTu-0006WC-PD
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:36:31 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isWTu-0006Vk-KT
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:36:30 -0500
Received: by mail-ot1-x343.google.com with SMTP id w21so23347271otj.7
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j/F+uXSpXJTQnKmXw9qAp6TayRDJj1PO516WtDoWNn0=;
 b=iOzeS/mJ2FZEbsjHJNcrdwIfOr5grHxmKnordN/hVMFNVSkIK2ztxo576tBK1sSB5w
 HH5qQ7yoqA3oKQS5jTcfSD64+39AZui5xmaStU9Rv/eiU7FGpvVc5CfPJEUKEeRvreug
 tt5ordui4t6x4XGrxtMuS0S9QX2W2AXGJwJx1S9GULsSwZ+EFLxtTHxeV67Lp9exkS9E
 KoRUIZc/s7HY9TlCirNvFVR3zPuPS/+tlwSGoC3audu0uRG9Kz+0CxZhsQZuemmWzuES
 mJaZanMkaiO/VsKkajR8MlFK7fyTVSUvDtxF9dmy4/ce8XqiDv7qVWN3aPN8d7esDtM3
 AGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j/F+uXSpXJTQnKmXw9qAp6TayRDJj1PO516WtDoWNn0=;
 b=VF/XMOPVdBn4KuPQUEdUdSWpxCGmxTmYzuARuyTrB5fGfZ4ng+bWjLXxXEOUbSNJXD
 g2pq64Lsy3NDOXY43s4NSlat2P4cGI1vycrjtguVgEnNFPOLD1w7ORaDurRiVO1Dskt/
 1t2Vvp1QtCX/qhAGxhumMx97G/JN4aarLu5ymcv3pf9xurP0EtQWTh54FWRZ/Jadiq4v
 ZUZbg8k2xWnITQcJPO5bAAASV8B69VYZATwdpE1IvyICMlpkTrfeAdw3DONkl3DbZHIa
 BoNjv4Fz7Z10BsBgVcesSH1zVEDFBQ8CNEU7ROcW8OqM/qmodj1UiUgenEq1lHGSFqug
 Tv1Q==
X-Gm-Message-State: APjAAAWApmPtoKiwFGSr0lGQrIZX9AwTybGM/hOuJ/YaXPvbo3KnjqrV
 nlpq9HNDyn0+O6n94e0sAt1uRNZAtVJKG5dWpjd1uQ==
X-Google-Smtp-Source: APXvYqwlTXnYv4zGY4sIHmAJhj9B9k8Y53MJMdfmkT/FL38EXCRrMri7BUA8Bw56Xbsc7V/O74dEuVN7rl7J/iuEBE4=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr7200236ota.232.1579286189978; 
 Fri, 17 Jan 2020 10:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-5-linux@roeck-us.net>
 <CAFEAcA81V46N8eqTtBo7YZE0kDaqVNz=iAjbqdv8m=GPRsaewg@mail.gmail.com>
 <20200117182129.GB13396@roeck-us.net>
In-Reply-To: <20200117182129.GB13396@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 18:36:19 +0000
Message-ID: <CAFEAcA-GRmu6nT9jQLWBMbXBu=ehSTVO=MX2xV_sDN4RxtrZCA@mail.gmail.com>
Subject: Re: [PATCH 4/6] hw/char/exynos4210_uart: Implement receive FIFO
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 at 18:21, Guenter Roeck <linux@roeck-us.net> wrote:
> Doesn't that mean that the .post_load function is missing even today,
> and that it should call exynos4210_uart_update_parameters() ?

Yes, it should, so that's an existing bug. (I think you'll only
notice an ill effect from that if you have wired the QEMU emulated
serial port through to a real host hardware serial port, though.)

thanks
-- PMM

