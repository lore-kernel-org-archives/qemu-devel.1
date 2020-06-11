Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7796AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0231B20792
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kU7C5jTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0231B20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOaB-0003jx-22
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOWj-0008JY-OV
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:50:01 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33498)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOWi-0004we-RZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:49:57 -0400
Received: by mail-oi1-x242.google.com with SMTP id i74so5666168oib.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Vqu5v+04xAmiY3GyqEWU8iIcy1yQMMBtbQG4kjPVxCk=;
 b=kU7C5jTIEsayvv275hKBHZ3hoTFTEfjoITHwHBkSXlmej14vYlYYJhpfriz420ewxF
 HgPGr88BLybCkUhjPuZFbN0myrnIkzsEA+/3LI6aH04y+7ke69njg/Cm/793SW0LUtch
 c3CVgedhNLKVGtocMbaSQzEOgcqlXlF4CAGE1KVFohiEmL6xt2IMZtQSNUYRllmECfJC
 cLcICv6KEKehDcQBO5YoQgq2xVPEQgjyuYEvMxHIncd2NnpTlv5ub/7Ttlyl47PPzeuA
 bYPFJ9gDGMwL0OAoEpuZ4CZNdcaavdSOka56mNJeDdVwy0dfv3w8khzByKHw5Fh3/Ulw
 Er2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Vqu5v+04xAmiY3GyqEWU8iIcy1yQMMBtbQG4kjPVxCk=;
 b=qavr032PvaI7J9cbJHxxtpLKJd59GIt7O1YWAblvU0VlnjbJKNVKB4ZGBArcLA70bQ
 9/zY8WJMnxw589n45D5j528/9G1nmz9MZi3Bjgx74uXK4u9QXE5qSP52uv93cBHcnQlv
 35Tdpp0s9JdLiva6U+fRRFBlXgjR/d1XqRlIsFMcmcMFRYXi3Zsq3DQRaOI4JA2/wdun
 V02yxRdMboaofrQBe36pqDdiFEkJoaMllp/U63VOqE4mVO3OwOl+F48WRBTRdjNORugL
 YFid26vjeXLfb9ibpyBZYVbLViE6xvZndgB9KA0dszeD/PWIhBZyC8AF6vbJrT1Ui6gB
 FC0g==
X-Gm-Message-State: AOAM530nF9EYZitvke3DtPqmgJ/vMhjM9zlJiSw1BxWwSiechI3xPfoY
 XbhOuTjiaFOv/vaFH+vt337W44aHT/7TwwbB14GogA==
X-Google-Smtp-Source: ABdhPJxuLudISs4rrHP7yLlLe6AJgIPLOIqePPvZ19jLiqHpc5NbLhCcgB08BcAc0Xh/4plybblKUap7lLWVMJTj7vI=
X-Received: by 2002:aca:568c:: with SMTP id k134mr6126532oib.48.1591886987634; 
 Thu, 11 Jun 2020 07:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200611144531.20142-1-alex.bennee@linaro.org>
In-Reply-To: <20200611144531.20142-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jun 2020 15:49:36 +0100
Message-ID: <CAFEAcA_joU24OSa8fwbNFb1XMb-FKfcaY4xpjV9EHUdCbWZzwg@mail.gmail.com>
Subject: Re: [RFC PATCH] logging: add a LOG_TCG_WARN for temp leaks
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jun 2020 at 15:45, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Pretty much all calls to qemu_log are either wrapped in some other
> enabling check or only enabled with debug defines. Add a specific flag
> for TCG warnings and expand the documentation of the qemu_log
> function.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---

> -/* main logging function */
> +/**
> + * qemu_log: main logging function
> + *
> + * Most users shouldn't be calling qemu_log unconditionally as it adds
> + * noise to logging output. Either use qemu_log_mask() or wrap
> + * successive log calls a qemu_loglevel_mask() check and
"inside a"

> + * qemu_log_lock/unlock(). The tracing infrastructure does similar wrapp=
ing.
> + */
>  int GCC_FMT_ATTR(1, 2) qemu_log(const char *fmt, ...);

> +/* Additional TCG warnings */
> +#define LOG_TCG_WARN       (1 << 20)

I don't object to the new log group in principle, but it has exactly
one warning in it. I feel we'd be better to check for all the current
places that use qemu_log not inside a loglevel_mask condition (or
which use fprintf, if we still have those) and then see what the
most reasonable categorization is.

thanks
-- PMM

