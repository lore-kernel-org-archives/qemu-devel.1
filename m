Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE2DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B58206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuIq5zXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B58206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCovQ-0004xm-UK
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kCorh-0008WN-2f
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:49:14 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:45933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kCord-0008FA-Hp
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:49:12 -0400
Received: by mail-ej1-x643.google.com with SMTP id i26so9534117ejb.12
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n1jwkFyW9h3AtmoqCXYSOa+7vMcpTI1AJwDVXU7pJqw=;
 b=MuIq5zXgh1CbKJTRr8gOU5uIABld8fxAbQsYZehWujpqFGfebX9DRYiVGELbBbQHYn
 FORbUeXakFJmQ0jC7HCHKkFKFjTUfyXgHI7oi6swrnCjV91HCT7D6CRL3Hm7hr4XzC05
 L5ybYp7xMR52OxRRm1gVxyS3ZLjsa4W9VtD6gjze+U7DZZX3BgohACZhUrZXwWjdn9Lw
 yDWHSGWCPJZeWxo+Q13q/parkdiclBZvPFEcCOpYaKUFljddw5jNVi5BhzWP07l2r1za
 +IcI/h7yQhSGQNXq6eSnAI78Vj6bBkoRaSOOW4V3V5MvYp44nrQmDXDHQoQYsJ/dPadn
 JoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n1jwkFyW9h3AtmoqCXYSOa+7vMcpTI1AJwDVXU7pJqw=;
 b=q7QCrHn15xIX7ghUjlN/oXhXuYgrX7FW6qV0hBvh3R3YjU8aF/H+pGieMrHHwv5rLt
 r2u3vXWm96cB1hypc8zj+q0JsRpnCPxh0NYKJs/vX+zLIK5m7UsrLkF45wvMLPLTXmBh
 24li/NQ53fQh3SZ/2CvjEOl7wjhTSLaJ1uoOA4uXXi2NHXfYrB7G/FwyHAbNnz8AwdLc
 CHxhZ4Dt0HY04WoxYH/IpLsK/RNls5K4HlkM6wuHyr+EyJjp9PgyfX6QzmTF9vspWXO+
 u+d7Epywphd4kF2a3ZwSgLeag/Zp21UMVFhk0AlkVJ/7bH0DjBql+Cp/2T1vjXHTN6J4
 7NZw==
X-Gm-Message-State: AOAM531px8ZZ4Pj6lX5GFjZprtJ+IZc2b5P6WMVb9+Yc2KjlLVS3poXH
 qfjAsRwWeIx2h0Re+b1HFQs4vLvDSetk/IgvzX/pEg==
X-Google-Smtp-Source: ABdhPJyM6Je1zAp9qPdydvZhh3M4pj8X8PI7RUvu0uUlP0fTTkJhB8L2QlVioNGSoY7Rq/TAt8rVcpFuu3IG+V6W4O8=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr2412465ejn.56.1598899748106; 
 Mon, 31 Aug 2020 11:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200825192110.3528606-54-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-54-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Aug 2020 19:48:57 +0100
Message-ID: <CAFEAcA_ETZB=TDX8O0hQD_9G=030fiuJ2KYCQCO-_94SL_OJ+g@mail.gmail.com>
Subject: Re: [PATCH v3 53/74] rx: Move typedef RXCPU to cpu-qom.h
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 20:46, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Move the typedef closer to the QOM type checking macros.
> This will make future conversion to OBJECT_DECLARE* easier.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes series v2 -> v3: new patch added to series v3
>
> ---
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: qemu-devel@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

