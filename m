Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8A7C4727E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865E321548
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CcGIfe0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865E321548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtgG-00013c-J5
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMtZj-0001nD-5c
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:52:19 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:45376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMtZh-00076c-D0
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:52:18 -0400
Received: by mail-ed1-x544.google.com with SMTP id l17so1390601edq.12
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=29AG1WJBq5YJWotpE/t8gSoyOlLLv8LF4Ncnfne73AU=;
 b=CcGIfe0By+9G+0WskF2ehiJG+O5GznBjO25j/oNanuamROJqZSd+y6n7XvmELNlULP
 Ft5fr3FNEaGbui05ZADuyC2SJeJtMC657NBcmVlxC1bwvwmWnpEefS/kozlOv2+pMPDB
 GdoSiSMz+nTQpBWxUCcgngpZ2N10+P/Ktud3iq+1/ctcGa0m5kI+ugoWb2nLqhU4UI8l
 NF3jtATXT8vUGcUNTGpAXTn1flMc+YPE4UpdlZWEN5mDzdr0ZRRXTwRxkE0ajfgXwMyj
 Do6gMm7EQXyjbbb164oDr0KknpnxbxYHtVQ2S6bRVdJYA/Vrey1G6u6i2xlspm5s1qZ/
 0rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=29AG1WJBq5YJWotpE/t8gSoyOlLLv8LF4Ncnfne73AU=;
 b=Nqg7fR5qhvOQ04Co3XXJuA1K9u/DDJhzVQA+azmcPMI848ydkm2AAuXI23lWhauZ8Z
 fu7SDTRze33khogI3/LYvmZtVCdyrClYtmOl9DUXx13RUwG36gE+4+4g/3S/mSIEc4z1
 qh0e5gjHPaleAJeGsUdLaK/8FgeQDhNhuR9MKcZZzJGWjsniL6mpJtdwiekWIWo6hXzB
 6uILF63YvWPx3Ve9DcvM1+yw9F3PK9W76aF7Tlywfbrqd0RcobOs2SaL0Kaa5M9rZSFB
 IlEOx3wPQWN05gQ5rLy7/M9wcyz05YVQnNBDi03CHc7BYS4JYg69E7g7H2vbbIXjZurj
 62Aw==
X-Gm-Message-State: AOAM533UoYDS2g7ufQQrAjli3ZXxiTbEjz18arwIR0bvKBNj6Dkiq0Q8
 ZQ9Z4VtWUsbdynF1OZYqIBQuGc+NSaYYb3Ehuh1mzA==
X-Google-Smtp-Source: ABdhPJy/+ohN8+LnPDqPz7G8idKm+HDZxUKUaWY8fLck/LkKRexHyn/e5naKA4JwsUPjYYHPhILe/bYRPC/2cL68Rho=
X-Received: by 2002:a05:6402:202a:: with SMTP id
 ay10mr1931407edb.36.1601301135889; 
 Mon, 28 Sep 2020 06:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200928125859.734287-1-philmd@redhat.com>
 <20200928125859.734287-4-philmd@redhat.com>
In-Reply-To: <20200928125859.734287-4-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2020 14:52:05 +0100
Message-ID: <CAFEAcA_4aff9JbjL-P+kXUXMQVbciCjJqLHmQ_DzxPiwBU3HRA@mail.gmail.com>
Subject: Re: [PATCH 3/3] accel/tcg: Remove special case for GCC < 4.6
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 14:40, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Since commit efc6c070aca ("configure: Add a test for the
> minimum compiler version") the minimum compiler version
> required for GCC is 4.8.
>
> We can safely remove the special case for GCC 4.6 introduced
> in commit 0448f5f8b81 ("cpu-exec: Fix compiler warning
> (-Werror=3Dclobbered)").
> No change for Clang as we don't know.

Looking through the git history the inclusion of "clang" in
this workaround is because a bug was noticed with the FreeBSD
clang which prompted commit 6c78f29a2424622bfc9c3 in 2013.
It's quite tempting to assume newer clangs have fixed this,
but still I guess it's safest to leave the workaround in place...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

