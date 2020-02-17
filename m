Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC8FC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0698020801
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uVlBVGgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0698020801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3hv1-0003cA-6A
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3huP-0003Ax-CV
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3huO-00074W-51
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:02:05 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:34260)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3huN-000741-Vz
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:02:04 -0500
Received: by mail-oi1-x230.google.com with SMTP id l136so16949983oig.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 07:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SGhXCO4bevvCNq1HjHzCDL9n69v8hfELRrb5dRYXZT0=;
 b=uVlBVGgui4jl1XvuyrDKXVi9pb0RFoujQDUNLVWO7NxBLilNVn7LXAZQQk+ibjEYFZ
 yskrRDqZtkDsi8oJ0hpze8JWaRfYNmYlV2+DoLdwJ9vlG4JPcYCHROQszseUIIVuW2jA
 ZbM8zCdP7t8EtpJPwD4JPp5zz6Xxse3mfzUamzMdp+x15bZ/pAl1KdPbsd70Lqg4DvFO
 4r6ZLlJusTrbPi3USgIwNZSJFkPvCK2S9kkn00g//oQOB3+MOqvKfFhJYqo14FxTrAH4
 Ho7y9AIRUj8WGWJPqy2OrKtz0x8QWsE5Tl/+O8uVk9tyehdUfKAugTZZdWxZj9gxtZ3b
 hqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SGhXCO4bevvCNq1HjHzCDL9n69v8hfELRrb5dRYXZT0=;
 b=Cxyj1Rlb7fnrf5PbSzIu6mBI2xisyC7nhTtGyHLt35l1yNDqX2nCci2965z0QheCYD
 zOIfLuBL6zuHFD8cCTVJz3lOwiod+8/eyaJ64JPFsyc+/B0kzwUWqta05ATa3KGRXms+
 WDwXyhuOLCNf2qTRPblIrRcdjkm7B0YM2+uiCrkkGBZ+D9Qb2h3uOskvDAShTCbtZbZT
 U4TA8S9NnKUafv7rVQiZeFRM8b0hGzjpl+O8D3T5bNwPQIUUTOalNKD/VD+t2FjInr9b
 ol5eG/EqbwqA8cFzb2Oq6JDRaGmydTUqFo3P8+3eTS5KCyrZDgHCOUU/Oh/7A1+iz4FV
 rkJQ==
X-Gm-Message-State: APjAAAWYnnHjv8MWJlb4X/69+6ToeOCBTlsX464/V+RKN8JILjyaJz8p
 yWFWOqbP6oXYp0g3s1Rw5tl/zjfMBluOaSbW5trf0Q==
X-Google-Smtp-Source: APXvYqw7riNCqGy8PctKX9sKIoMymRUGe6T1e5iaP3vsGfX1N2LDKGPrV7DdqMNtj2ivQN4If6ExbrY0606LFobxY5w=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr9838756oie.146.1581951722934; 
 Mon, 17 Feb 2020 07:02:02 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
 <CAFEAcA-RnKYfJRaGDSFFx=O17mdvsPMEwbfQ1prTrhmrosAGHQ@mail.gmail.com>
 <CAL1e-=gN65hjRYvxPpsvo0TLLKAY80UGq0mhPPXMAXg+Oo8MGQ@mail.gmail.com>
In-Reply-To: <CAL1e-=gN65hjRYvxPpsvo0TLLKAY80UGq0mhPPXMAXg+Oo8MGQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 15:01:52 +0000
Message-ID: <CAFEAcA904m0A9tOyn7AhjeCtX7xFqiGMSRBaR0HkaTe2xmRubQ@mail.gmail.com>
Subject: Re: should we have a new 'tools' manual?
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 14:49, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> But, we also should create some sort of action item lists for appropriate people about completing existing and/or creating missing documentation parts.

https://wiki.qemu.org/Features/Documentation is where I've
been tracking progress on this.

thanks
-- PMM

