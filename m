Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E6FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3F8208A9
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6iEtASl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3F8208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2zHz-0002WL-Us
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 11:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2zGh-0001B0-AN
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:54:24 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:36874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2zGd-0002Wy-GR
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:54:23 -0400
Received: by mail-oo1-xc42.google.com with SMTP id l10so1473775oon.4
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xoK0WiUGhLpGnrJ2vhZq1Alo3LimPJFn34EgjQ1/4EE=;
 b=n6iEtASlM5Znt1jxtgPCEs3pLJevPlrIe7U8LgzS4wvJHu/BiM6rmBcZM42KEiEkrj
 mFVtp21c34ZSYOiM79eYBUv5r4tmezSZo5qbUHSpSyvd27lhCE7YIxDVbTCWAw2Plg2y
 RjxDt1ZAWlZI3MZFI/AiVvwEhXzXCJkd4jVj1AD5J5KIzNAQ5n2ZGKtpyuammh1edyDn
 +Z8++gBURElHbp+j3+I4ZMl2MYU1rHYC4qQ64WPnMuDTCAO4RF23hKcIobRREN8l/5ub
 TXamsE3Pn9EPkU0VDIsmxq6KEkimw9FcnOtmnQgiWgrGFPtayfSbcgBvhzV8z7vxIhpV
 EkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xoK0WiUGhLpGnrJ2vhZq1Alo3LimPJFn34EgjQ1/4EE=;
 b=L6Ao63v+VkqfZ8NTLIy8HIGofrb7dL7YqW70JhMYRpgpL7/bMJzt0alQk/z1aHGkJG
 jna0rb8x0KmVlEb6BwWW1RZeJE39qTajm8JS6xX+QzC5aeSWHlZmeAEg7Lg3k9sirwwZ
 4VMKNMVkECU8A5DeSs8A61DCrzfI3ixHlqU+KxaPK6bw+LnqPjgzdBmlclWR3ho3Nh0r
 PDfLCvAKGV1Oa6VrFYRG2RWThwUEtTB8ue8Ozeo8z4PeAqEcORcjcfHhu77TrPihJK1H
 KKYIxmdT2uD58Aj5I7I4VDf3hYux+a7erwSsUAVEiGIyNApK9zhWWRg8D+B8ZWgyeuqh
 lArQ==
X-Gm-Message-State: AOAM531RF4jZeU9biGtyPHrHtzI4kwNEZX6Rox6dSBibH8f2qOBoUag5
 D5BO5ht0ZF/mixfuq+A8pK1FOM5kZKKx43C9xikg+Q==
X-Google-Smtp-Source: ABdhPJx+VaYiEDX0fjKhcsdy61qSNWl0CmBJI37nfRjUulrH989fuU4jaW4JH7B9HQFKrvLeTH4OvRn1BllT+ld6FdI=
X-Received: by 2002:a4a:8dc1:: with SMTP id a1mr19299856ool.69.1596556457357; 
 Tue, 04 Aug 2020 08:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200804002849.30268-1-pcc@google.com>
 <8d966244-acaa-5f69-5148-414fb63871d8@linaro.org>
In-Reply-To: <8d966244-acaa-5f69-5148-414fb63871d8@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Aug 2020 16:54:06 +0100
Message-ID: <CAFEAcA8JkDPNqLXx8OUDWDXdH1brkTm=Lv8Pocqkf5sLLi5SeQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Fix decode of LDRA[AB] instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Collingbourne <pcc@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Aug 2020 at 16:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/3/20 5:28 PM, Peter Collingbourne wrote:
> > These instructions use zero as the discriminator, not SP.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > ---
> > v2:
> > - fixed commit message
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

