Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A153C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081AE20848
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDhoyU6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081AE20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fpZ-00006R-7d
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2foy-00089O-Pm
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:36:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2fox-0002gU-Dj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:36:12 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2fox-0002em-8Q
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:36:11 -0500
Received: by mail-oi1-x242.google.com with SMTP id a142so10322761oii.7
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O3+FGRTBaC8y4eI4b1ao9nuO2/H4lpmgw1fZrR5tJ+c=;
 b=DDhoyU6voqw+gt3j0kp5hWBe0wFmTlAySl6iLN4XFs/wGKZqcgoiGSnpM/2Q8Ja0YT
 f/5LCw+SCjWxq228RjYFl9EbXgeLbUcesV3kJoMYoi9RlMAuHmtkzhq+V6bPJaQLuOOl
 F5xBuy2o0gUdza4JR/SRDfs9cbX/q7Wn49PrT+fxy8UuRIYmzG0QPjeGA64w+RSyuahp
 WsKwi6uANK9nguJ9+57TmKEuKexWupWosJSJTw71ovUYC7A/b/TvWVB+EdUw/bqJnHID
 QavLZOIKenEtB3KcAkFx1aATJoJeCsOBrMqEbcOlndUJ9UvLD+kJmeJC+mqlUs/K3ImR
 Jmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O3+FGRTBaC8y4eI4b1ao9nuO2/H4lpmgw1fZrR5tJ+c=;
 b=TmRBsQ47jezmG8f1+nMYULSN7ECLynsMdD45UiEVb/OdoeX3oa6Krs1cEzhEtMWnxN
 xuWB+7IrlPMdMQj2T9wjdsLZZj9zI8TAXn+N5lhG7sxs9eDJ5aSZ7kWGTJuPOPPyS5YK
 qyJE86KWdwbgDla4c1Qe4ENvI3pL1AyOXuayuvw5kHia1j6K2bkdkBcihTBV9bq1rNQC
 m3FwGO2psfVpuzqe4OOUetMf7nNwir1p0e3xK48cEaPqerg7nvzDjIDP7OBJp4mBPoEL
 61sKcAIv55fedParz/3wTkM8xXwFUAoAuPx/3PqzlNVcg78xVKgLCKEk3sSLt/SkzAA4
 V4wg==
X-Gm-Message-State: APjAAAXtY/aYVigpgEm9AXkX0Wn2nfM+NwH0B+cO/WNGvMfObbp+ScsQ
 Fjy7mJkXXPxh3Icw+/wZxViFcFLS9tHJt2RlPec/Dg==
X-Google-Smtp-Source: APXvYqwm1bN8rmkt7XXfoN9nQnLZumWBUTeqxkZQ5plFZD9yjCA5frckWvoA2pyAriE0Ips7ZgMGe5rn4zbtzw/A6iI=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr2834204oid.98.1581705370265;
 Fri, 14 Feb 2020 10:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-2-richard.henderson@linaro.org>
In-Reply-To: <20200214181547.21408-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 18:35:59 +0000
Message-ID: <CAFEAcA9NvZXHcWNx1euOjSK_cwau31ER0_DHtbzef52pqbttrg@mail.gmail.com>
Subject: Re: [PATCH 01/19] target/arm: Fix field extract from MVFR[0-2]
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 18:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These registers are 32-bits wide.  Cut and paste used FIELD_EX64
> instead of the more proper FIELD_EX32.  In practice all this did
> was use an unnecessary 64-bit operation, producing correct results.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This is a duplicate with:

https://patchew.org/QEMU/20200214175116.9164-1-peter.maydell@linaro.org/20200214175116.9164-21-peter.maydell@linaro.org/

which I got out the door very slightly before your series
hit my mailbox :-)

-- PMM

