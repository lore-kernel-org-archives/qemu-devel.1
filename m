Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6709C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BAD207DA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jR1yLgpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BAD207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKrz-0007xY-Te
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrKrQ-0007KX-Hy
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:32:08 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:46407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrKrP-0006X2-2H
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:32:08 -0400
Received: by mail-oo1-xc44.google.com with SMTP id s190so2658226ooa.13
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4LYj2IpcKfLEM+Tm2CvHejgXs8Z6KM3nB1VLEXqYuPc=;
 b=jR1yLgpRZKc3F/cOOmsf1j2iC9fYDfbUKqlfD/HXS92DnaItGimGbAYt4/Gj888ajm
 /mm1kxpcVS4oOr51q58Tl1fuD1fHdIhvkXiu+4ahUjTIc5A1BxRQXnlFLZavRIL0BjO9
 3ggnV5vZnKVzrqI0Hj7OV5UYyRGKj/kNpyEz2fvTjbEF9Lw74JavilzWY6hKus+Sd2o+
 kRE0KtqBmiUhgZiDD0hhLhsv7G0hHqELjdGed5ItVE3PPdZf/57ymiBCqCOlKcIKB6Xb
 QyVt27D/tG9CcUD1w3353MQruVwW0uPvhXLIxvAXFXTemHPpy79DCXrvZdvYTUPWmK2b
 ckMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4LYj2IpcKfLEM+Tm2CvHejgXs8Z6KM3nB1VLEXqYuPc=;
 b=CE2Yxiw2atbhQVVtPhbf/LcdifZAM0J+JV1yHeIFsifeGwFL3CMxPz2WikZjuuKxQh
 VVG+cGsxc8qjbCWKL1S56Z/3c2xr1ew0dFCtiI5A8NogwL+55NtEkF+DJBWssih9Prfr
 HJ92V/jfe+hznzkU8hzhEqNOmKEfxrQYNs7AKXxIRSTU35uzJ5tY9sTgKJoIY7p0B7Eq
 pB2thRVkdEU9Va2jKC+155943SOAwlY//Sn8wjkh+xBiURvXqyxI4t+Vyc9/bn8H6iVi
 u+rE+wFacoa/rJ4tbIY4Ygj5Ua0cXYKXhyJT7zdtzp5MVvZkf6IY04mdC/nVPBKpGToO
 hY/g==
X-Gm-Message-State: AOAM532HjCffJvUup7R4IrWFzzZUmkGnrak0kHc9UurNqA+Ouxp1/Uv9
 83/GVKd8qUdluBxsC5DdnJLxEHnzflDGoB5I/WH2jw==
X-Google-Smtp-Source: ABdhPJwbq9EY+8+PtrwKh4Bjbv85CVhC03en5y4znuF++UslPNX11MbNuwp+fjsMGW9+iLvuG7k77PzlzzQy5kzKK34=
X-Received: by 2002:a05:6820:172:: with SMTP id
 k18mr23415619ood.69.1593779525614; 
 Fri, 03 Jul 2020 05:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593296112.git.jcd@tribudubois.net>
In-Reply-To: <cover.1593296112.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 13:31:54 +0100
Message-ID: <CAFEAcA9spJnH--sb9qQeFy-L0KO8T5E3gjCEO-aqaJ_SxtP=Gg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Allow to specify the PHY number to use with a
 specific i.MX FEC/ENET Ethernet device
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 28 Jun 2020 at 21:21, Jean-Christophe Dubois
<jcd@tribudubois.net> wrote:
>
> The PHY device associated to a specific i.MX Ethernet device is not
> necessarily at address 0 on the MDIO bus.
>
> This patch series adds the ability to set the PHY number on the MDIO bus
> for any i.MX6UL based board.
>
> Jean-Christophe Dubois (3):
>   Add a phy-num property to the i.MX FEC emulator
>   Add the ability to select a different PHY for each i.MX6UL FEC
>     interface
>   Select MDIO device 2 and 1 as PHY devices for i.MW6UL EVK board.



Applied to target-arm.next, thanks.

-- PMM

