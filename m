Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350A2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 21:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF4E20738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 21:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5JPbpvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF4E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAK6r-0007gw-2D
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 17:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAK5u-0007E0-8R
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 17:33:35 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:37372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAK5q-0005a3-Gg
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 17:33:33 -0400
Received: by mail-ej1-x634.google.com with SMTP id dp2so8497441ejc.4
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 14:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+1iIOyHvKiBVVGoei2jfvGUfehVaK5vXfMBJIT8LUCQ=;
 b=W5JPbpvZn6D0n1rupfH++iYjiG2ewQ34hmgzqSWV0oYZyvB6pHHVDb0NaE5V8FIlFv
 AfLakLm/zGWcgEggKA/8xvn1Cc/+XxRWY9toYCyEut+7a/DO4gCCvk51x/21OvGwh4Ud
 NlOpm8kotETmDL3MvtfnXVIWM6LTGZCQodJkX7jSudJg0VtxEefVO5I1hAHmRNv7e9jI
 r52jPEO75fTGT86e1wzUCAha1Nw3prTwjMBdy+Aje4z4GyZGlWwZ5vPfH7AUVWMvvkpB
 pGaU4SAUq9kSAUwV1bXz9fouk7zeNCLQtGI5AntwYBOJN8xI8NriLfHgcXkCaLkdB5ox
 wr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+1iIOyHvKiBVVGoei2jfvGUfehVaK5vXfMBJIT8LUCQ=;
 b=WONC/2yQI6Y0Z8bh2VJf/ghVJrsq8a5whmRMhrzhzXQAiKpxDmDrnyYgCVIhEPoslX
 blUoobMXK4s9z5vtypxjh8KnIoy57XUxigR7MfBErq/Amzdn51TSZm/P2SNgs0+essfL
 BG2O5jqIh6qtJQ9M5NfTOJkEATnCgBQv6j/YMqjQ0WVU3txSicjFKp/WghVnNTJY2DuV
 c1XZv0MTRXoZ3fmbS4qwkszUmqBnZ6s8VaALOaBrK4EXpE7AWg3pcXMbSP6FtzPieRD3
 G9/C9yNFOw/hB5M1q/q1v77guNh5qdvJQlWAehBSWAsyQsT4A/d802AzzyiS4xj+RI4V
 LsoA==
X-Gm-Message-State: AOAM531+TYMDTGK4MXQJRUbJ5yvPYnK+lSLtgbsyHfJr+yvOW+WloFaU
 XOe84LcDmGdPu7134XOG56xbKrZA17QBIzrL2aZ6Og==
X-Google-Smtp-Source: ABdhPJwZvtWcv24+DYfwxZZIm04mGi1Tar3dewH2mI2Uu1+HvBof9YWqt47k87R0zGY/r5VQ59+HaDt3nmmPn/cXtPM=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr7232384ejb.407.1598304808848; 
 Mon, 24 Aug 2020 14:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200821205050.29066-1-jcmvbkbc@gmail.com>
 <8b20adcd-97e9-0f8f-1854-b9809060d6cd@amsat.org>
 <CAMo8BfKnW7oEe76akdszPh46R1GVU2kuGfTg3T7ypVHQnzDzTQ@mail.gmail.com>
In-Reply-To: <CAMo8BfKnW7oEe76akdszPh46R1GVU2kuGfTg3T7ypVHQnzDzTQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 22:33:17 +0100
Message-ID: <CAFEAcA8sY720+g9ms4EyrGEfHnZaDK-W81Jb=RS0J+V9kCc68g@mail.gmail.com>
Subject: Re: [PULL v2 00/24] target/xtensa updates for 5.2
To: Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 22 Aug 2020 at 20:48, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Sat, Aug 22, 2020 at 3:20 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> > On 8/21/20 10:50 PM, Max Filippov wrote:
> > > please pull the following batch of updates for target/xtensa.
> >
> > 3.12MiB of generated data...
> >
> > Where does that come from?
>
> Generated by xtensa processor generator, as one of many output artifacts.

Is there anything different with the source for these cores
compared to the ones we already have in the tree, or are
these just "more cores, generated the same way as the old ones" ?

thanks
-- PMM

