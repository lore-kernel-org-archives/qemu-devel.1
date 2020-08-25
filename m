Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAA2C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771B920715
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMGQv9sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771B920715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAWHZ-0008CQ-Mh
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 06:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAWH3-0007gG-IM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:33:53 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:47018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAWH1-0006bo-5O
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:33:53 -0400
Received: by mail-ej1-x643.google.com with SMTP id d11so15651905ejt.13
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P/H4UAsoboTbt0kuCesmRN4mvJj9vK//j9IhLDKcpFQ=;
 b=oMGQv9sxppoctYlqe6rus8+0zEcV0KroOZ+PmJy+p5kg9GH3S+sYH9kYID4pGloAMO
 B6Mkrc1A4TK+XgPnicoq62Hk6lsF+j/96dYKUvVPwRyzHGnziRWwkqfboJ/XlSNOno+8
 ufW4vHoASZ6PxiDGumD0G/WaB6QLocC/mBE46ejdGe8zC0XIWJfTQdGe+hI08lic61lQ
 tnxzpOQML0R+wvpTI/Hirr7Eemnbop5OsavewBq0z/tkSaY5ofY+expSNySfsuEOCh/C
 wJWD+X5Uu3iy+yncaxxfh9h1NTBtlCg1pCtW27/HJDgS2b/R5ju9h7jbYlU4iOFzwWzh
 JB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P/H4UAsoboTbt0kuCesmRN4mvJj9vK//j9IhLDKcpFQ=;
 b=AXGU/pkzo5sY3SaPl8f0RdAWKBK/OUlpC1h1Wn47IysMlINYLXxGWAm4NddvmbHdFY
 rk0/w9jpa3xbI0BVgIkqZzifVjqD+GTEJhNtdX24XRNEeCEsV0pgQH7hRt/sA0Bg/hiH
 ChPMoIr1mOPQ/++ylCVeJUlxuujagvdgdf8Q24nbp32Ol3fNcYHs+dZ9qTGBY2ZP9dTa
 pa1OtgLb7wh82DJZphl/4ECBxpcBAgv1HoTVMoRARRnhAGk8AKhiLw6m8aSIDVl8ZuSf
 qic7tqrUmeG8MdlFzTPsfYiJKAvtV1Pgdz6Ne1vFXb5xzaEdPU+lihpE4/rpsm899rCU
 8YKg==
X-Gm-Message-State: AOAM532MwxOWrLnCDoDdDBxVhRMhAaFz4ShaDzZ0sIuaDm6l+yeNGnac
 dVwN+EjIvAFOvjO+rxQoMSRhVvb1YE7J4d/6uKCVQQ==
X-Google-Smtp-Source: ABdhPJxKJo2BN3nwD1q/XY+fFY4kksc9ym+EK9FavKhfzDNIlYnnYrKeQudP/wgQckjuNiJNnLUeKn6X+olQbwoqz5U=
X-Received: by 2002:a17:907:2066:: with SMTP id
 qp6mr759376ejb.85.1598351629374; 
 Tue, 25 Aug 2020 03:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200820133201.80577-1-graeme@nuviainc.com>
 <CAFEAcA_9WRk0Dr97wpDHacsjy2qpmBBq=kp6hOQTvUOvpWF0zw@mail.gmail.com>
 <20200825100757.r54ba26kmavntqrb@xora-monster>
In-Reply-To: <20200825100757.r54ba26kmavntqrb@xora-monster>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 11:33:38 +0100
Message-ID: <CAFEAcA9XqFeMYJ=8-9usxO-Wje4PFUnKPCHHecq7Ds2ZOdY_fw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] hw/arm/sbsa-ref.c : Add a fake embedded
 controller
To: Graeme Gregory <graeme@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: Leif Lindholm <leif@nuviainc.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, rad@semihalf.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 11:08, Graeme Gregory <graeme@nuviainc.com> wrote:
>
> On Mon, Aug 24, 2020 at 03:59:38PM +0100, Peter Maydell wrote:
> > > +enum sbsa_secure_ec_powerstates {
> > > +    SBSA_SECURE_EC_CMD_NULL,
> > > +    SBSA_SECURE_EC_CMD_POWEROFF,
> > > +    SBSA_SECURE_EC_CMD_REBOOT,
> >
> > The last two are clear enough, but what's a null power state for?
> >
> My personal dislike of sending 0 to hardware as its harder to spot
> when using scopes/logic analyzers. I can remove it if you wish and
> explicitly number the states.

Yeah, just number the states 1 and 2 rather than having an
unused 0 named state, I think.

PS: when you respin make sure you're on top-of-git -- we just
landed the meson build system conversion, so the way you add
new source files is different (no more Makefile.objs, it goes
in the meson.build file in the relevant directory instead).

thanks
-- PMM

