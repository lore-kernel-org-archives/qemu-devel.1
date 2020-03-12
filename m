Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B5DC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F44206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zeOL0FXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F44206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMYa-0005Ca-5W
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMXY-0004UE-CP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMXT-0006Xp-Kr
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:02:16 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCMXT-0006Wa-DZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:02:11 -0400
Received: by mail-ot1-x341.google.com with SMTP id f21so5843294otp.12
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 05:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IRb3q7xJfL5+vXHXGwz8U5inAv46mTYP07kXeoTT3xQ=;
 b=zeOL0FXbVXcL2wnXdHkObOO7QEulmXlsS6auZ4AzZJ0s6rfZKL2Z/u4gRbt4d6yauG
 NR68rho52kqizcGXqPCrKJqQk7oQK+LqLMdoeocgXNFtAQ7ES3KgeD+TLhmb7l3Kj+xs
 WHygSLgwEULn0QExHU+CF93Z7C37tLVtLQWVIO+kcE0awuyCA83uVFCvB6sgvJL1GUsT
 TCuKMlwS6p34e/hjxkpmooY6kSqvz0loU/3VFqIgk1NQur08fSTRQBJrzm1BProdBhAd
 4YWD1wWuXDQOI2ACcPFk7LwJphXnsHX0ZBNbr9ZHcwdR7yXhRWC415Y8aXJr2FPCerc7
 cwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IRb3q7xJfL5+vXHXGwz8U5inAv46mTYP07kXeoTT3xQ=;
 b=XbDR6nqJvyhLiPluKiFNIX9bO2oGWetGWKZrsyu9jJo7Nv6YbI48SM+Ss3uGuGGLl1
 pNwgFoJWEFA5TfikUZyYcvbFTH6+H+Uv3xvPC/+OKUb6Iy5ginZk8qcPrI91FVmk8VEq
 o0A6Fvn/xkbf26fcj44O8u3EiE9eiZhEwALDqrwjVYTkQtYCcUCIAup94nt6ZHvHR0Mk
 wE9hEsBhxLbuYRpiRd0ZEbnS8jJKQhpndFY63nIneI+lpKZRoSFy+sCGkK4gCo857soG
 yA2uivHpwyd/i+EhTIQcxoa9YNP8BKKVoKZN70TXHoe5Yj03f8FSp92bEOQciDmQg0Wv
 uDPQ==
X-Gm-Message-State: ANhLgQ1lo0wbCjRHuQ6CrZPWm4lmx7C63rtHaajvUNRQ3AKxdqhGbBjo
 NtSVd2XKHhlx80dM3k1XU8AP+1Y4Fp0J+RN19mu9kfmpV5M=
X-Google-Smtp-Source: ADFU+vv1SrNrc+K9FzEnEr6qRuIAdjZkie4lovoNZgT8HRuPDP4qrqVjU24y8u2u7+LqiaW9+gR8QTBsCykHtt+zVVc=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr6047003otl.135.1584014528828; 
 Thu, 12 Mar 2020 05:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200303091254.22373-1-imammedo@redhat.com>
In-Reply-To: <20200303091254.22373-1-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 12:01:57 +0000
Message-ID: <CAFEAcA9wwa_y5fhpj=qjgp4RV3gx=7AuWa6QGE0m815UQwDmFQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/cubieboard: make sure SOC object isn't leaked
To: Igor Mammedov <imammedo@redhat.com>
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, Andrew Jones <drjones@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Mar 2020 at 09:13, Igor Mammedov <imammedo@redhat.com> wrote:
>
> SOC object returned by object_new() is leaked in current code.
> Set SOC parent explicitly to board and then unref to SOC object
> to make sure that refererence returned by object_new() is taken
> care of.
>
> The SOC object will be kept alive by its parent (machine) and
> will be automatically freed when MachineState is destroyed.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reported-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/cubieboard.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>



Applied to target-arm.next, thanks.

-- PMM

