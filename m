Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6B8C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407FA24681
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzntHbHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407FA24681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9Q4-00057P-8m
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 12:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1is9PQ-00049A-3b
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1is9PO-0000eS-VP
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:58:19 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1is9PO-0000dJ-NI
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:58:18 -0500
Received: by mail-ot1-x341.google.com with SMTP id 66so20174426otd.9
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 09:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LaGzoLaCaPaWKUIyizELR2Z8xWinEiB9Q1ve7KEjYyo=;
 b=gzntHbHN1qrvDBzVHh5HYSGkjiDVZ3inM2zCfI9W5IpztBV/7uc13he4OTqZ7BbajY
 uS2P8Zo4AT1rRNuqG9P/shyx65KGXlURlc22swsdghugBgyESX98c5nr9VRut3B/4Tmu
 xozyc/3QxLjYhXgB5tsbSpl+H0RcpHzD9nPhkIe1oUdOlCtW5DqVUFn6Rb77Q1xEMo2G
 Is5weJSGm4xE2NkTlln+5mE0EeyOY9wM5iRmfWD0xfbMw2+BoNghZNYtiBP16vFcZbVz
 B4gWt04kVLBWY64/CottCyNFAvPzokbyG7pnv/kgZNwpWfmdd4Hu+9qO7GP983xihUan
 1LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LaGzoLaCaPaWKUIyizELR2Z8xWinEiB9Q1ve7KEjYyo=;
 b=fk+3CqUx70DQxEsohsk72eF/Gg20UXxf67t3wVH8quAVdxbx2Xei7B4d4k/Oea47xq
 s14k8Yc+b3iFp5rGtpnYmmCMmCJdiHrmm5lC/nN6XCSvhX3P1DTAxyAL9npTmwVxz2ks
 3VLCGXZ0NL00OCP0m0p10AI6q1DK5keBL3no2ajqm6Wl2GTRBHXWU/mzKoo0cndrFGEz
 yihW5F+2wrIhKffbwnjBBseW3ntal47JTZ5ROEEDzt2upfivEbN9U/KJnMSljmCf+Log
 FEH+TBevnDzcMTpu1c0pS8uuaqiac5JwCrUHvQYQxQ2GGpU/mAPQRxeWscoZ7PSChbTX
 oRHA==
X-Gm-Message-State: APjAAAV6jB23Ex3vAzu49O84fgnG2WE6/wt+uxfWHRL+gK8f9X1ap8Vd
 /OmRppTXCYBVTz3b2nzeATr2sgca9y1DQcEI8uK5Bw==
X-Google-Smtp-Source: APXvYqwAXoxulwi/nvZUjVM5tPW6ohG1vKLlmQzXiblCddINrmVSyHB4QUjvSAykUl0K2vOU4IDhBajv9N75DvMgru4=
X-Received: by 2002:a05:6830:1586:: with SMTP id
 i6mr2865433otr.221.1579197497389; 
 Thu, 16 Jan 2020 09:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20191226175132.28116-1-martin@kaiser.cx>
 <20200108084604.28173-1-martin@kaiser.cx>
In-Reply-To: <20200108084604.28173-1-martin@kaiser.cx>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2020 17:58:06 +0000
Message-ID: <CAFEAcA-z7gCkowOqWQx-0=N_0hW6nm69NgDbDHLKnqwsrjmV3g@mail.gmail.com>
Subject: Re: [PATCH v2] i.MX: add an emulation for RNGC
To: Martin Kaiser <martin@kaiser.cx>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jan 2020 at 08:46, Martin Kaiser <martin@kaiser.cx> wrote:
>
> Add an emulation for the RNGC random number generator and the compatible
> RNGB variant. These peripherals are included (at least) in imx25 and
> imx35 chipsets.
>
> The emulation supports the initial self test, reseeding the prng and
> reading random numbers.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> changes in v2
>  add a VMStateDescription
>  rename __imx_rngc_reset to imx_rngc_do_reset
>  fix a typo



Applied to target-arm.next, thanks.

-- PMM

