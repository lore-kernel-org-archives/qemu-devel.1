Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BB7C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D0D206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGggeLTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D0D206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLto-0006eg-5z
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOLs6-0005aR-45
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:17:18 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:44775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOLs3-0001Tu-Df
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:17:17 -0400
Received: by mail-ej1-x641.google.com with SMTP id a3so2191311ejy.11
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JzF260npFDfcZ9JASf9Kvb/IM6bbY7fKtyDop8EwStI=;
 b=CGggeLTQz7l2zsGH2CsPH53lOjJtEC2h29DFQjPZ6aCVpv3gzqHoyHZC6bkgfQH1ib
 WO2bzxkJ2ztOeoag5FiCvE2dbugfwF+s+REPEHbEfC3tsFaJ38yCBU43cnKLjNypGhNl
 cMto0UkJPEDoOQMuZ92gVuYsJ3inUiL6KbrOs3R5fQ1Lhw+X9z9QmexSQwpSplHc9tpM
 UOS/yTeYWiAhwsyYx5h8CjjrM1KG2I7+7FcDc1vwIioxV+xPxEbKKvGfzUueJR3mG+CX
 Jmov51vkpAE9u9LMjM8vQ95miyzi3QZQ+eOqNXV+UAbDmCwvtGJNRZELEQJPEDupAqL4
 aG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JzF260npFDfcZ9JASf9Kvb/IM6bbY7fKtyDop8EwStI=;
 b=NfCa62LW8IisijM434+ALt5lGkMDmjLQ1y+yNEgjoYd7NA7kSKe6a1psiCTF+4Jkb/
 NSHrcBtClUtfQqroFr5tycyuvD+D5rsj5E1WtKzYxejuMwg/Gtvv0BcECy9SlNNEYEQG
 zIHfiPjFSNiZcRqPt4AKZzTAzUTuVx+vQM2gyOe5Pp+8u/pAId8bAm3cyP1UOjRR+16h
 Z5xe9062f/VnMIzuhoiUd5mxp3xOB8xI0YcNOVz2wkZpwIP9jpImLwiJ5son+C5wLo3x
 M8OgLFOF4hILd/gzmBKyazOMr2dL7anrjJuoS/ko6MhuqdL2WiUMIvhrIJeiNr7wBLa2
 7ZPw==
X-Gm-Message-State: AOAM532hukPbahGRjQWO0/qj7irLwIqDXv5L+5Vd3ff6/+MaxFEoWhfe
 kHoB1pvvp4UbWllJc2La15+Wqh6gHRyDTNjVj4yx/w==
X-Google-Smtp-Source: ABdhPJxW+JUu5AzxXeAD43FK+HAqEFgJVkPcajSUVCzQ7ZqdB2Al8uErp8dMSGp1WfrCp92aZS0bgBwshimrcpJXRTk=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr2552663ejb.4.1601648233570; 
 Fri, 02 Oct 2020 07:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201001193659.21685-1-maxim.uvarov@linaro.org>
 <CAFEAcA_76y5DoNw3tirFFaC9FfE6NnxwAkdgV5eSv9NUeBxdhw@mail.gmail.com>
 <CAD8XO3ZWW87Ze+gX9xWtrZ=XaETvE63WqzobQamoGM2_tb-4Zw@mail.gmail.com>
In-Reply-To: <CAD8XO3ZWW87Ze+gX9xWtrZ=XaETvE63WqzobQamoGM2_tb-4Zw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 15:17:01 +0100
Message-ID: <CAFEAcA9U=hrGZQ=1ZVHsFVJc1Ghygcueq0caE2U9nk29aBGCwA@mail.gmail.com>
Subject: Re: [PATCH] hw: wdt: implement sbsa watchdog
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>,
 Shashi Mallela <shashi.mallela@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 15:06, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> On Thu, 1 Oct 2020 at 23:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Hi; what's the relationship between this SBSA watchdog
> > device model and the one that Shashi posted recently?
> > https://patchew.org/QEMU/20200929180410.33058-1-shashi.mallela@linaro.org/

> Nice it's the same driver written a little bit differently. I did not
> see his patch before. 2 things missing in Sashis driver which are
> useful for me:
> 1. Add sbsa watchdog to machine virt also. That helped me to reboot a
> virtual machine with secure payload.
> 2. I specially did not disable timer on driver close. I.e. "reboot"
> linux path reboots with that watchdog.  And make timeout lower to not
> wait for a long period.

You should get together and figure out a single version of
the patchset that you want to upstream...

> Can this driver also be considered for virt machine?

Maybe, but you'd need to explain why it's useful (ie why
you can't just plug in the wdt_i6300esb, which I think
is a PCI watchdog device). We try not to add devices to
virt unless we have to, because they increase the security
attack surface.

thanks
-- PMM

