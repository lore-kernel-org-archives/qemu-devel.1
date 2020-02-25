Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621E6C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3D220726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gr4tsRla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3D220726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aa8-00085W-9k
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6aEw-0004wG-OQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:27:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6aEu-0007Lk-Kd
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:27:10 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6aEt-0007LK-U5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:27:08 -0500
Received: by mail-oi1-x243.google.com with SMTP id v19so12495396oic.12
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 05:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L+h6FndeHZ0z/+mTP+fkgUNIqtivlDuVFNytp9MZnm0=;
 b=Gr4tsRla+EzQPetOwGKNFOFVL1nHKdk1UGKX7hMIIwPWfVvmrI2Xh248tq+UC7RFIX
 4+4Hvfz0mzrWXsGSUMdix7yyFzgYsQkSQmoq0u/sAZF2C5t7EUWSNysxMw1Zka6pmh5Q
 yMDaaMCcItGH7OI0lcdBLDTZpUr2EpNiNh7tAlcYOE1ec/RxdCftV9rgGfkOo43umNlp
 oubJqTO0ew77bmlJQratM7ALnYR0SFfKuAxqYycAv4sfu+rLtJu0dT2ddbJHkjtEaEXE
 C6yMfu1FTVdOjbbvtmaSEJydOdKgBkqT3Xm3c9LfE6EDnY7oQYMJj4YGNsW1x4Th9gv6
 Wsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L+h6FndeHZ0z/+mTP+fkgUNIqtivlDuVFNytp9MZnm0=;
 b=VpVfAHDqHcfipLQmqD87exegwwLMpmM3RwFLlhA/lvwepCMZUeDaUDBXFpnytDMoL7
 lC1kd91vOrV+hZqLgx/Qo+0uoSiSJqLUWrDHer05jECGhzfutx1/2POoC9aEEfx38X4u
 PCNauFIJUtgy+mtTVGBiBhW1UeZXpE/WY1WbPUIiNFhg8C97GFJEAe/KMJFt5/SrkApP
 6giPMf2ITtL1ra5kwvB/8qEkh50lHISUWaFiE5QCIOGXtPv7LcROoCqLeOTOlFO7kgwo
 tRiZnkFgN0fbAMkTLAB4oPQZhNJ5qpaLffNeSVOwAJqIJRmXHx0jjwFxxIsMWeVyFnnG
 AJfQ==
X-Gm-Message-State: APjAAAVrfcoqky3sVHboWIlabacnf4XZOHP673t8Krk9vsysMciLw7Dh
 KjM1vpSjoANFu1TG2EEtKsGTJCH27sGpnyxalXquhw==
X-Google-Smtp-Source: APXvYqxjkh3gms2Rmxzxs6bcHhKQH6iKotSLSYFe7W2fOFhm2F4lWuROQADYwHObnjlgEAugNajMASOTAF6uldr8UWo=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr3689565oiy.170.1582637226920; 
 Tue, 25 Feb 2020 05:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20200224222232.13807-1-richard.henderson@linaro.org>
 <20200224222232.13807-12-richard.henderson@linaro.org>
In-Reply-To: <20200224222232.13807-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 13:26:55 +0000
Message-ID: <CAFEAcA8MBdGAh3PptJBNE=m25CuYMJjfkiUBhGQ=6Yh-bEaBrg@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] target/arm: Move VLLDM and VLSTM to vfp.decode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Feb 2020 at 22:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Now that we no longer have an early check for ARM_FEATURE_VFP,
> we can use the proper ISA check in trans_VLLDM_VLSTM.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Fix !secure (pmm)
> ---
>  target/arm/vfp.decode          |  2 ++
>  target/arm/translate-vfp.inc.c | 39 +++++++++++++++++++++++++
>  target/arm/translate.c         | 53 ++++++----------------------------
>  3 files changed, 50 insertions(+), 44 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

