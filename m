Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A090C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3752173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaSTU1iL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3752173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i18wf-0000pP-MX
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i18c4-00035G-Gx
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i18c2-0004sS-CA
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:24:16 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i18c0-0004r8-Ck
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:24:12 -0400
Received: by mail-ot1-x341.google.com with SMTP id r20so8551435ota.5
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 05:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=42EKvDIWkWoed2EM/Y3x4rwe8lyvrb42SbWTSMlOlDA=;
 b=gaSTU1iLA3pUkXzNZgaDRqbc8RwKG28YzhW+uGmfcwiFL8cxwezdF0IjiTCF3miIJa
 VUNYwPzBXeVgT+gc4CJ6Dmn+6hINLKXckfSdcZH8qrrHm8KOLgIjpx+PlpnS3EYb61fI
 QNy2a7kPU4Ev+3GVvjMJLcnV763Lb2vnJaXPXMBNY79en0UVWVJC5hwk9dH438q0Bf0i
 ZpId29xTDOwT8JtZvCKYpqm0vptWBuiroQfb/snice1e08i/FGOrJyWsc31gD9aOCqNe
 Cr04JD31IVsoA1eRFL23eOoAmzmwZ7Yh2z0YwptRmHMiwBNyWqykqmUnuEAmnw+h37Kc
 Jmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=42EKvDIWkWoed2EM/Y3x4rwe8lyvrb42SbWTSMlOlDA=;
 b=HWjJ6lJDdUcVgF/UZINxfflMdPlTYAykshZGH1GOW//hmr0QdOzk1z2FU1/SMR7UIM
 hJp7qPDpDnoIGmbcvelno8J+R69Fwtm4u/6eRIn/fkX9Gtj/AXbJi4g003AFSZwKoMS+
 d50btbl7S2kSLSFOV+4P8no951VieAL4JV2Gj+RHIaB5tfTGWyMC2T3GFt0BFYo0IahK
 Qca2EXiPWRvgmRIFUiIRECOjcK/BX2Cvu2YvbeC7KinhOe3cvlw/mBPQO44Fi2cR3sJM
 xuDle6aJvkLmA1cAxN6/dNVcDsYIRSGXAqXhqaR99fhk7smcidhtI/ZcsgDbrjyb8VrU
 uFzQ==
X-Gm-Message-State: APjAAAVClbD9gGAYVWBLZoVMADu5/nUZxoCA0P2bamRbiIPnyO/tbBO7
 g0ScbPfeoA32ovxU3kfxkaDDlIqV32jLGfSzHQFkDyqN
X-Google-Smtp-Source: APXvYqx5qLvY2FLbnG6XRCeiubEEk/KaiA1Pu6AbE9aN8EfkpQogyfqWySyH7I4oYJPo2lBZuwfsni3MxpbSXEagkcM=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr1046023otf.97.1566563050457; 
 Fri, 23 Aug 2019 05:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-15-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 13:23:59 +0100
Message-ID: <CAFEAcA9bWyYKF0LsfR9E+rG8v39ZP861v21DX8do6eyby2+JOA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 14/68] target/arm: Convert Cyclic
 Redundancy Check
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

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 121 +++++++++++++++++++----------------------
>  target/arm/a32.decode  |   9 +++
>  target/arm/t32.decode  |   7 +++
>  3 files changed, 72 insertions(+), 65 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

