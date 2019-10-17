Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F7DECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E327820820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAqReE4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E327820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7Nj-0001pV-I7
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL6nU-0005fI-Si
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL6nT-0003NI-GH
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:30:36 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL6nT-0003MP-AM
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:30:35 -0400
Received: by mail-ot1-x341.google.com with SMTP id 89so2022952oth.13
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9zFqbX1Trp+6JVLcAAM9mbHykBac0O8F4pvk15u1K10=;
 b=BAqReE4KMz98xenQ9ptl7wTFO4o8VFR13UZVQEBFGgoRlRwEovRfF+Jh2ptTEMGFn/
 zTkIK/t9nJeiRppBJHrOM54VWBKsEtqJdt/nS5aBrnGlb9Nu05XEPUYGeb9F858Vr1N2
 M0IyJZ9/iKbdoW8duOssd4XkhsWE26tdWH24Se+sfeHzJPW3N8DBh2F+fs579xO5FAMw
 LeYteDfKRXmha2YZnJn/0NbQLg+q6BcCHqk2CxmeWtnlHMjALSoYTtxSZ8xSv6Iwa7aK
 gLQeVF0LXtRQmvPKirSWvdSHA/FtnCrGIRLd909Nezb2y+w1WAjaEplYa/TdXnxxJZJT
 PQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9zFqbX1Trp+6JVLcAAM9mbHykBac0O8F4pvk15u1K10=;
 b=qqR9+bES3pdUr4pbf5cIMj3WHHnlRrGCFAyG8Up4LqP1qmqeOTrXXBDSfsfvfsXNFT
 ezreg+rviKBurJQxNt1YtA3XZFPd8a954Gl0xCCpuxVA2FFwhkQvbNk664sddavA8t3E
 GB9ADCsfFnnupTBtT8lMl4eFJpZpP5hbFTxoZwHfzgCyhNcT1OJY62MhvRKuEwulLqeu
 ZrNKjiGGbXx9N957E5bl0DJzj3q4vHn7CiIEDtI51G8D7TrhiRJMUTbFe2A3xPkfDnI0
 Ry8Cz1X9m4jj9haXe7axPpshXIMbqwtIcROw8lsO2XyNXC9kCwbOLjPc62o+em71Do7J
 VaLw==
X-Gm-Message-State: APjAAAX7pwSgMMlL5Q0wBpCF/m7wH772V+cM4VSIceYjSitbr3D4VtAP
 +kTjSuH8tbEg9vR0JP2fi4ImP45eZ4wPdY+LL7mylw==
X-Google-Smtp-Source: APXvYqzy7u1ldQm0JP2rhU8LYqSf04qyFx6ERE4lHoNO6pcjymKtjZ+6l2w8yTvve8yCly7Y7cIJiIiuUrSSDlKeeO4=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr3359342otg.91.1571322633748;
 Thu, 17 Oct 2019 07:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191014150133.14318-1-ehabkost@redhat.com>
In-Reply-To: <20191014150133.14318-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 15:30:22 +0100
Message-ID: <CAFEAcA-FRU_WTh8zWLZJKVxoMWLQHYDTpzh8OiwgS465yR_BUQ@mail.gmail.com>
Subject: Re: [PATCH] sphinx: Use separate doctree directories for different
 builders
To: Eduardo Habkost <ehabkost@redhat.com>
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 at 16:01, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> sphinx-build is buggy when multiple processes are using the same
> doctree directory in parallel.  See the 3-year-old Sphinx bug
> report at: https://github.com/sphinx-doc/sphinx/issues/2946
>
> Instead of avoiding parallel builds or adding some kind of
> locking, I'm using the simplest solution: just using a different
> doctree cache for each builder.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)


Applied to master as a buildfix, thanks.

-- PMM

