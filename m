Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807A4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4460E20CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uujlv505"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4460E20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixWFN-0006mK-Gt
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 08:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixWEi-0006JY-Er
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:21:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixWEh-0003Nn-Bx
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:21:28 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixWEh-0003N7-7G
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:21:27 -0500
Received: by mail-oi1-x243.google.com with SMTP id b18so7233222oie.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 05:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dusxz+04QuZR5OXBojLh5qk6LyvSz9C3gmA7w2i57iM=;
 b=Uujlv5058I8NlX0hDzM1pbfQkeLdYWPmDoDO3liXccug//klIab8NPFn3otF57Jr4H
 SsAqisGTDLs1g92fVnlCVbRBuYQwCi87w1Wra+iYxXkUsBtX0TF5RPyp84edLkNqHid0
 10xBHkjiKwXPO20vFaq6vsNTPYAFaLMWlTrNSU283P76kk3GkwlZmBGI8h7yohdBkb7D
 1mcygkQ93L7eRX246K466YAiLvzxttt2aB3vAQwOt9r/kXClZFxWGDdZ1DVHsOsX+14N
 wnpBE8SA01CCU4MGPQ4Y+HZmqKXUXk56PUd1bW9QfNghhtoOT90LqB1eRSUUVBWIu23S
 Q81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dusxz+04QuZR5OXBojLh5qk6LyvSz9C3gmA7w2i57iM=;
 b=cUlK60cr4cJJ72Y54UzcuF9xLTr2UNhcGtxionplqqKzaMKwkCHE/vug+JgzFKJZ78
 bE5D6rgwVBh4vSY5cZ03nIC1JIhxYZoh8RdXBYnW9C2SyIw+LaPckQ8DtjBnU62d2N9p
 PaeiFaTKPkenlCb5nsvbGRMoaJ+z+CEkM2ADHpk5nLXw28Zh3Z25ldc4JioPGSmSSAgR
 Ddvv2IJANxPza79JWXHX5rRa9jdF6OpB5aeyQ7/V538gdojrldDTA63rvDF9dvS9g3e/
 elZ2GaLqSwZhDcja3JRdYA/EgzPEu9vFYkFjzOJ3vNZdY1AC0NiwC6ll+TWuWiWTtNcf
 ol3g==
X-Gm-Message-State: APjAAAXkuCqKM4pIYfK083GqDyeOIQG6p7HepI8WwcNs0xsBPnsUsHG+
 sUx0Ln59UqvEim2AMB6ZX3fqLHuGWtQgSm9oaqTRhQ==
X-Google-Smtp-Source: APXvYqwEtuQ7dBz7fQ0NfmbcFvovvBXCAHdEiD5S8gZdOfsPumol308gpdpOL7cgK+Obg7X0ziCdgKKn6fpr5sptSWY=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr6345688oif.163.1580476886301; 
 Fri, 31 Jan 2020 05:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20200129235614.29829-1-richard.henderson@linaro.org>
 <20200129235614.29829-32-richard.henderson@linaro.org>
In-Reply-To: <20200129235614.29829-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 13:21:15 +0000
Message-ID: <CAFEAcA8RyRncxQd0dER2jRxs9RqsHcAfQmYimPJ9BGONKQ3FGA@mail.gmail.com>
Subject: Re: [PATCH v5 31/41] target/arm: Flush tlbs for E2&0 translation
 regime
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

On Wed, 29 Jan 2020 at 23:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v5: Flush all EL2 regimes with TLBI ALLE2 (pmm).
> ---
>  target/arm/helper.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

