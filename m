Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1E1C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7066720708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cuE6bT5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7066720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1a2r-0006rz-L5
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZyK-0002vt-0E
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZyJ-00025f-3G
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:09:19 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZyI-00023C-Ub
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:09:19 -0500
Received: by mail-oi1-x244.google.com with SMTP id v19so13650493oic.12
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G/D0REur26CWbr5McK5rwGGMDKLAAq3Ye5zTDeiOTLc=;
 b=cuE6bT5v5StRQ22EjdukEg/B1ip7dpvzTXSbD6tZRlhqa00h8tnc+yrDhS9sdEzPoA
 nk44lAXlmpSR/ePkbNMkX+1Z9TWPdZ7xRAFfeLy64ewtehU78HgdR3ipNOBuKl0oUqum
 jEDsv5tNsCU3R97sWyQYCUqK2xFMmtVaHgvndJROBfCmNk8Maxk1agJFpLUF2dswIRze
 XTuNh8+YFislxtDcjAA1wgwPWWv8V0UwITDXIA892P8n+HaNx+Ggh0JhOytbLJdSSaDW
 BjK68UQjjWdLenLJ4RITsnkRvsFjxFjCkt+7tVwi82ROP+JgbyXQI7bewX+zJREw1Ga2
 m/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G/D0REur26CWbr5McK5rwGGMDKLAAq3Ye5zTDeiOTLc=;
 b=IDgsRdtFw/nr7zT6IMbHaIQFzkpGzNZ0410frDHogTkbF4dNm8ztCkk3hHNA6YCpyP
 +kfTyGiD3iCMZjHMxXD20qzZEEvoaBBOCPaSdy4Y8urNgjrlIvSENbtS9jYfs5YU15hF
 FykxyU6AWtv1077o9xoH1NxW9X/OtTBnLa96pnvpB/IUb6GpsXVMhYBbe/pqluAk28AI
 77J6QC+lTtd/AJSbO92k0KrS/OVzWS7u4CtexQHWhgPbNy0NeoOqnux8j4uVg5RqVUoY
 n2QHZCxE2xlyLx0mEYjkI5CPMw3Og3Q0ETDwndEqoF9gjnqGSdNFOSHLbzoS5pZuh/HB
 utGQ==
X-Gm-Message-State: APjAAAWvORNWZ2Nrs4u1i9Ocyq/j9y9qV9CtNvp3z9EGQBL74RxweClw
 EppPwIPAIQXY7xbT6INcWdXCgc053pIRUZc70OJ09Q==
X-Google-Smtp-Source: APXvYqzHYKgxYcCHjNd/JNB+WLDCgR269emrY1nqOpH6IQQmvhmYFUPJN6O0piyoyIgYV+9BTkdLjMKTUpBV1niA/Ao=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr3775177oiy.170.1581444555111; 
 Tue, 11 Feb 2020 10:09:15 -0800 (PST)
MIME-Version: 1.0
References: <20200208125816.14954-1-richard.henderson@linaro.org>
 <20200208125816.14954-15-richard.henderson@linaro.org>
In-Reply-To: <20200208125816.14954-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 18:09:04 +0000
Message-ID: <CAFEAcA9KscdbbCwO12BfCT=Jo-LZgpbHBp6XPnypbA36sR5amQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/20] target/arm: Set PAN bit as required on exception
 entry
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Sat, 8 Feb 2020 at 12:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The PAN bit is preserved, or set as per SCTLR_ELx.SPAN,
> plus several other conditions listed in the ARM ARM.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Tidy preservation of CPSR_PAN in take_aarch32_exception (pmm).
> v4: Fix exception entry to EL3.
> ---
>  target/arm/helper.c | 53 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 3 deletions(-

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

