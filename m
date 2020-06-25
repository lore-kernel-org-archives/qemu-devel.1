Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCABC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3F52053B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ubx9fhzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3F52053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPkn-000472-B2
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joPjS-0002k3-Td
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:07:51 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joPjR-0005Sh-E8
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:07:50 -0400
Received: by mail-oi1-x241.google.com with SMTP id a21so4580567oic.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 04:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J3wbqJep8gHiXx2HxZz4ctfBh3m5wAf+QVL3Jo1vi9Q=;
 b=ubx9fhzsnw07ZVDr2q8BHMzDcmTvNjydOzFwquXbjyOPl+ta08A95qAq5+ykNo42TN
 OFlCrEmc/Z8IDHDs2XERuRPbjcQDcu1UIS8YPwPXqxJrMcXTaqcEZrZ6lhQckoL1UOyK
 ADEp9Df/+N534TuIhWFNwM6rrvIUGoJcoWqnYtWa5B7z1KZrZ+Yc7eXo/1B1vcqZEiI9
 u5z5/KYzS6vC0PC5FpRGGclGH68e6C3oZw1IIY8fVbHYDMmcJDXthhAUVhcGrAkiG+p/
 cPIugWAJZYduxxbyws/Xk+4T2nSeCycaFJlbYDPtCURsf7kzuM+plT6KF3yDDop8OXoa
 LX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J3wbqJep8gHiXx2HxZz4ctfBh3m5wAf+QVL3Jo1vi9Q=;
 b=GKK8JEjjc617z4IKO/Gqen3WIBNJkqLu3kitecA0EKOi6vr3S4EIjkfAHRDbKUnZKI
 GLMXJZEjXB5b2qGOS9E/r3UIw0BZFJFs8VEAYGqZZLhQyx3WJ08Llr99SFL3gTXpGXuJ
 DvwqJXezt3epVjEPXnjYMvzdAFjEGrT3R9f60Gn/iKsDwbY2MYCoH29/ceZzQD+1UFXN
 gOuQx9KRKHp5myeQ8/Zep/70asATYq+1GkmqM97DRa377w8PbaJi2jLLjXttGx4xmANu
 h1FR0bTsLQoL23/IholU0pFQ2SEByfyk9Rtp/lo4YAKFaRjDEXrATQ9STRJD/u+6pFKy
 7R+Q==
X-Gm-Message-State: AOAM530fcvp61hVWOBaDn85zToVsHkOZsO9bdBE4YC8ChtXW5Ex7vMlR
 NPHo5+RKIWZWy900hBlt4yBVJw4LorPI3/GbiyVGQQ==
X-Google-Smtp-Source: ABdhPJyVgWYxtAzSdhjuQA3H4CCi4BtuLsoedsjvJU8LZkIE9/MnnqQJ230e6RTy3AVlL58thVw/7GcoUDr2/WqcDRs=
X-Received: by 2002:a54:4694:: with SMTP id k20mr1635876oic.146.1593083266822; 
 Thu, 25 Jun 2020 04:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-30-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 12:07:35 +0100
Message-ID: <CAFEAcA972PpX2CR1iFzmEc0XEsOgjLs8JhFC-J=CgwU4nRUruQ@mail.gmail.com>
Subject: Re: [PATCH v8 29/45] target/arm: Use mte_checkN for sve unpredicated
 stores
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v8: Drop the out-of-line helper (pmm).
> ---
>  target/arm/translate-sve.c | 61 +++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 28 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

