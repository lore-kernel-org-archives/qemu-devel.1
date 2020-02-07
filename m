Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ACEC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A267C2082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eh5l/LWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A267C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07W6-0005wB-SQ
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j07VI-000584-QO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j07VH-0005z4-Vd
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:33:20 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j07VH-0005ys-R7
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:33:19 -0500
Received: by mail-oi1-x243.google.com with SMTP id l9so2742538oii.5
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 09:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eDJ9bhuHxJBtYjaZ3FqHcObB5l8OxLAgXVCk1Ko6sM4=;
 b=Eh5l/LWDBtS7JFCbYvR3W4dXqKZ9428kqwyZPml4Agum+CtezvfYytznHQ7X/EmR8f
 lfMbV82N26W/Ew3uYxYqNuR6LtwHVAjvMUd4K+RHmm3egSLgo2FgtpBVX9+HvecqfH0W
 IARIMawVo0qUitKAq3i9Ps4g6eZLPQ9q3wq/nPqDufjTlu5lY0ii95Dmm7j0c2IvdH7W
 3hyaKqjGOTMcigGcnseMY/bRV6tLLsB0nkfmRoqNCpr5t0lYOtB2KTcxp0bGt8y7zRcP
 P/1LeoN3pELo4DL64kebd5X+dEj6GxZqXtWqhmu8+hlg1UHnYuoBqGiXji2xfLjVNuMb
 J7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eDJ9bhuHxJBtYjaZ3FqHcObB5l8OxLAgXVCk1Ko6sM4=;
 b=QrHJ3CFI/jWmYbRIJgFl8VW00inP0EaQdjIOrlL5f5lqxuxlmbpPDaTXB+jaOWZgTK
 lXA/2cG5k5/HBlFx2IIPBD2bduy9+61Qc+GbDnVr2rAwBeOj9P7411HRduMQn5+abA1P
 RfYHNd2GlK8Tjf6uP/u6XZ1eS+AVVDjuK+bb78s7kvWfLCaLfsLVLheg+W6NvuGI9Kly
 vaDlSkfWrpLcieGz4buE/OwqkbMmCbA+4NLcZy//gA4oXTcD4CeZTmnciVWly2MVLMMe
 qfHzExzE9Hl9Sno9uOBc9A1PiFMOo711ItDC4GuGSvuia3zqAWaQ3Ux7t3zD/Ab/fCKx
 lC8Q==
X-Gm-Message-State: APjAAAVENqxqmykISZJQenvCuIUh/Lh5guqA4g/lJ8Xpk//DbglCOG15
 I0E13WAilYbRP3x3XxZa+hNb5sOMHUn5S2N76GfqIg==
X-Google-Smtp-Source: APXvYqyBWMEqmumuELTIcfnu76WfoQ9FhiriGkrRApxguRARix6omrgtshCuDZ9kldAXweCulLOnNke77Fm3p3Enx6I=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2904488oiy.170.1581096799069; 
 Fri, 07 Feb 2020 09:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20200203144716.32204-1-richard.henderson@linaro.org>
 <20200203144716.32204-8-richard.henderson@linaro.org>
In-Reply-To: <20200203144716.32204-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 17:33:08 +0000
Message-ID: <CAFEAcA8Rvaw1YJWFtPUi441isD3-F2cPqw3o=ymH0YNS-LtXJA@mail.gmail.com>
Subject: Re: [PATCH v3 07/20] target/arm: Use aarch32_cpsr_valid_mask in
 helper_exception_return
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 14:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Using ~0 as the mask on the aarch64->aarch32 exception return
> was not even as correct as the CPSR_ERET_MASK that we had used
> on the aarch32->aarch32 exception return.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

