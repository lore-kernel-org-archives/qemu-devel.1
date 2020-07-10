Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC52EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99AD5206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhLJHPps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AD5206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtoKT-0001WF-Nw
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtoJx-000161-Lt
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:23:49 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtoJv-0004S9-SJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:23:49 -0400
Received: by mail-oi1-x241.google.com with SMTP id w17so4150679oie.6
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 01:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qSSkekWj7pFOiqoTaoF76QzWB4cDSE1FttsiYrPhsnU=;
 b=jhLJHPps6YB86l0j0fg/rrba2SPLRwH+BCFS7ZZmXVk8uUJZG4y8fDcL1bRX1GmdIP
 RHarFV0katwiMlWPCo+czxsL27fEiTs20aoiqGwwvovJ7sUylZrZAYTmtJEQcsc28aLv
 Pz5qdSSWr9cb49pE/sCsIvhRZyPHXjU6UDNJY+nlRvMvFP37SdRWbqBDm+bZlcMS8wJW
 70tIeF9CSJIS6srxJhtLw/Wxg+u7M1cxyBMJNaI3jDlKFl7nGnaWeOGLTrK+fEunGKsd
 jNFqwfDdDLpBFqyBuO/A/9r4iAQhxbWc/BtwKlEGU/WmeDaI+JmStZQfpRwQ1gV0PbsV
 oHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qSSkekWj7pFOiqoTaoF76QzWB4cDSE1FttsiYrPhsnU=;
 b=sPZeNQz1TMtTjA5FjCcgyK1Qqvbka3955n63UZNN64/CRJPjPlK5ewCY2QXaMROeQc
 ZFKPGLTvePdSSjx/5qbx8i+sLZLGLJ4yM8MCePsawv+PB+atRzDsdPZVkWox3S0znSfz
 6Da1xOsCVTMveHElrCJ0cbhsHJX/jEO2LxBopI4NcLdEqc0c/hwTY1W9GLbbQ5WEoWeH
 Ys3Nv8x51gAJNkrBx9jRMhRggRLjXW8U0zp7A0kHtj4B6hqaXCuPo8vFkzvdiD0h5kHl
 JPi3aaJa+xS0oAjVxbCp4QxG++XQomf4Adotyy7Qpj0B2UeKXq6vCoNvWfUjkVfrwWCX
 x8BQ==
X-Gm-Message-State: AOAM533MNfrrVq3ZOicJ+go3cVQvgTqIzsGYStTEOrLQ7/N8oPSSyWA3
 oWY40rAT5AFKFHWltQUecWdSLGsHcx/UPgRM6CQqwg==
X-Google-Smtp-Source: ABdhPJwiEQcq7HZs/RojNtpkMwQ4xoSJgqWTl6R22zos1X2GtdkEuTNM5T2uoUr70pFY/BSQkl4pzT98m3b/wgX++CI=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr3336416oib.163.1594369426448; 
 Fri, 10 Jul 2020 01:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200703185809.5896-1-f4bug@amsat.org>
 <20200703185809.5896-2-f4bug@amsat.org>
In-Reply-To: <20200703185809.5896-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 09:23:35 +0100
Message-ID: <CAFEAcA8uu8f30rhHzj_yvF2nMvP59rG4toa5N-QgR55f6erTdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/char/serial: Separate and document static
 properties
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 19:59, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Add more descriptive comments to keep a clear separation
> between static property vs runtime changeable.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/char/serial.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index 535fa23a2b..d955963ef1 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -55,9 +55,7 @@ typedef struct SerialState {
>         it can be reset while reading iir */
>      int thr_ipending;
>      qemu_irq irq;
> -    CharBackend chr;
>      int last_break_enable;
> -    uint32_t baudbase;
>      uint32_t tsr_retry;
>      guint watch_tag;
>      uint32_t wakeup;
> @@ -77,6 +75,10 @@ typedef struct SerialState {
>
>      QEMUTimer *modem_status_poll;
>      MemoryRegion io;
> +
> +    /* Properties */
> +    CharBackend chr;
> +    uint32_t baudbase;
>  } SerialState;
>
>  typedef struct SerialMM {
> @@ -84,6 +86,7 @@ typedef struct SerialMM {
>
>      SerialState serial;
>
> +    /* Properties */
>      uint8_t regshift;
>      uint8_t endianness;
>  } SerialMM;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Incidentally 'baudbase' is technically runtime updateable
via the serial_set_frequency() function, except that there
are no callers of it. We should delete that as unused code.

thanks
-- PMM

