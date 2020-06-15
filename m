Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F84C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529E520644
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4AhTXOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529E520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqSa-0006ee-KR
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkqRu-00065o-63
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:50:58 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkqRs-0002C5-EX
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:50:57 -0400
Received: by mail-ot1-x343.google.com with SMTP id g5so13302637otg.6
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+QEXQb0SuF6143ZinEXZLGNHZGJtXYHUORG6bs6ZcGY=;
 b=h4AhTXOuNCToBMVDn2PCCI6KAfxB+ieoWWvElYflaKJ9B9+cpVxLRDyb1rC+4HVPk+
 9dt+Ul8HFrPk3w36WuhjRPMXSs+CGt++UTiS/Jsd9Yr8BFHVQDs5TofNXTYrBhv4TeGR
 4tTQbYB1goJ/FBwaem0agOKk4jOyIf7KMGbH43a2xciRnIIFtr0ub53JBq46xbcn9by0
 0m+zL2ZonEWXKFZ5iKDq174m6sHK6lpkqT+sqtjCK9WFDASl42Aaf7+n2rxi2f1yYXk2
 6RG+KCSGA42xe5fkXwNOblyhcMyPW+DdACJXBoUYKucNIA3QW4A0In+fpPcavUKW5Epw
 cFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+QEXQb0SuF6143ZinEXZLGNHZGJtXYHUORG6bs6ZcGY=;
 b=Xo+izG0GAy+G+NQ0wBBb8J6NucPH9y9skr48GQLqDQ5QClJJYF8qEjpl6A4MYLDt0q
 BeI9HeReojoM8pGmxAJOlQ2jLwD8J/o0TDjQHscQEP7R49WoYHzV+Yvag+t3nB13oqBW
 iAd2t5ZKGhXgf9iaNTzxcvppucFIrV8Rkws11AGSO43BrP/v75dnP224tETqt2zk+n9N
 P4+DZKQy3uyhnENKdelr+Vqq8BWm5nDHz45nGIRbcun0ACZKg+QlBxXvGRyrfyOhxtwP
 DMzqaADwBbT9QMePpLRahhNs98QrWg1EywA+U3WdW2zba0WrmgRfkyypQsxhaeOIj9g9
 54Pw==
X-Gm-Message-State: AOAM532weYRkFzaw8zUJGieyZZC8dqXsTNk+EUXz9hpv2+B/zwUi0kRR
 Od2S9AhokM22nfzdRypQM2xD0I2ituHhGqyeYwHUrw==
X-Google-Smtp-Source: ABdhPJwgjGWtlg0wUvJqOV0XuOWLJ1BrwtzRkTJGaMzba5GyXrA+OqPU5VKxRqYD/BLkQQgbRqet2TBNfxUnEWiDyqU=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr20805114otn.221.1592232654965; 
 Mon, 15 Jun 2020 07:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591471056.git.balaton@eik.bme.hu>
 <7a818701887a77af17995aa062b37f92ffc3d2eb.1591471056.git.balaton@eik.bme.hu>
In-Reply-To: <7a818701887a77af17995aa062b37f92ffc3d2eb.1591471056.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 15:50:44 +0100
Message-ID: <CAFEAcA-Ez3dUHJsfjwFrKRh4zc3Nwp4=-7q9HjrjuGnYQHheEA@mail.gmail.com>
Subject: Re: [PATCH 2/4] sm501: Drop unneded variable
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 6 Jun 2020 at 20:22, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> We don't need a separate variable to keep track if we allocated memory
> that needs to be freed as we can test the pointer itself.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

