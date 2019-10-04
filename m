Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A93C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66CE207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZCDym94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66CE207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGNGh-0003ha-V6
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 09:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGN8n-0007Fu-Gn
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGN8m-00081i-5q
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:57:01 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:47053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGN8l-00081F-WE
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:57:00 -0400
Received: by mail-oi1-x241.google.com with SMTP id k25so5610682oiw.13
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lzFLDutDd3xKc+joycTl8Y9n3aqwAHpCYR6FyyAFLh0=;
 b=pZCDym94Ecm2FIf9CF6PVwvIqQ7Bz8KUORI5G1H1Si5V0ZZ7FvrNBRYt5IGrqLMdvT
 0hdDWfR4acBgCPyB41+uGWxJTcgCdp24aajdISb7ami3799seMGr9BUDsnY4jWjQNGWh
 mfwOF47oLQd67ZO5whttc8biowucdgKOzHfY+sik62slGMjK0fGdP6wWaWJiXHSvLqfO
 K2Q4cJyL+EwyHEgTolfEKc0JT+uRwrP2ZGu305KKlB213LXzVxpReZvB9mROJRSkkxeV
 YSD8afu/dQQKpF7iyLgG6tRN6Kjn2TvlRB+IEGU0wNzVtDD6ThXHQ0rxePWRL0RVkVG2
 FsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lzFLDutDd3xKc+joycTl8Y9n3aqwAHpCYR6FyyAFLh0=;
 b=HrdAeN2Brtq/PnrHuE6tg/qYf6Q9AnqBfguZdguuRkGEGnxyXxt5Mh5ahNACft/Phw
 bnNo1sxY+aRoS6d6Elp9d2exYC4Y8fE+SvddWZ6VzivTP+sPBe0aCMCHSlFrpK+cwZiH
 Fk/dFudZVTwW75yMxljCAv69KIshOUEzt1kUmOGsNDirTf28/MLdNfvPJ2TVI3ITxbX+
 NM0d/MAPRtb2rYZzBIMwfFOUvrU5r7uRPuY+3FJeQBCWXXXLs90k7hrqdXAmxDSHHtpx
 VZtO8Yq0+IfnkSHL+IhM5qFmtWyPIdGt8hZeLSul3uPKEdZkGt4V3WXW+VT80CSh3Okh
 PjPg==
X-Gm-Message-State: APjAAAURf/x69lgNV16KuGgi6cysA/4eLYXARNCWVqclJWZ7eR+DDUZ4
 34pp8tRsq609SdqeZ+les43ZroLqG8GTl3J6ZmOEAQ==
X-Google-Smtp-Source: APXvYqwEZjzGMm6J4OvQLMrfJwg2BzBluWSWAC1Y7a6wqSLcMt7e+4Yask3dtHWqAIr7TFcjjz/rTx9P6rg6XXrakxQ=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr7212586oif.98.1570193818860; 
 Fri, 04 Oct 2019 05:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191004114848.16831-1-peter.maydell@linaro.org>
 <20191004114848.16831-4-peter.maydell@linaro.org>
In-Reply-To: <20191004114848.16831-4-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2019 13:56:48 +0100
Message-ID: <CAFEAcA97dyR2_A72OgfJ6M68jC7Qv+zat74AobPUGNi12RWxLQ@mail.gmail.com>
Subject: Re: [RFC 3/4] ptimer: Provide new transaction-based API
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 at 12:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Provide the new transaction-based API.


> +void ptimer_transaction_begin(ptimer_state *s)
> +{
> +    assert(!s->in_transaction && s->callback);
> +    s->in_transaction = true;

As I was working on converting the ptimer tests to the new
API I noticed a silly bug here -- we should set
       s->need_reload = false;
in ptimer_transaction_begin(). Otherwise one transaction has
decided to do a reload, we'll do a reload in commit every time,
including when that's bogus (eg when the timer is disabled)...

thanks
-- PMM

