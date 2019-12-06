Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075FFC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B972245C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQ7QuYWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B972245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHQz-0003xn-R6
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idFn9-00005p-OI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idFn8-0004fL-Ch
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:45:15 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idFn8-0004ZL-6z
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:45:14 -0500
Received: by mail-oi1-x244.google.com with SMTP id v140so176687oie.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9G/Z/g8atcM9AC3m3aexcwYPfHESeCfq9edeeZo0bT8=;
 b=dQ7QuYWP3Awyi0NW4tDBfrZZ4lzDBkGR5kgJbQ2Tk6XDRVnjqs1zQDjuZM3AdWGylH
 cRXA1PHPmj/3H180rWIU4DhWi+LnOascNEfFGj8RJmKINHfaqj/JW98HxskArnaWAGJZ
 Jh1B2uZG2+teakcVpDrpuQsa/7aziH8lm5K9yl9Ini8nQIG4MxbFWvW9bQFALgrH9aVR
 9amyw5oN4mX/y+o+A4SfzUZWw8eAPJVUj3AmIqJBOi5uQCnitIDPr/fEJCts9YNAlu5/
 B99F5B5Y5/v67Ln6/ow19AnUbxEk+QqZNpGKHszTNHIiAVxS6USvPeL9Ay3RwmuQ56RU
 qnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9G/Z/g8atcM9AC3m3aexcwYPfHESeCfq9edeeZo0bT8=;
 b=MAZYe5/4dfk7tR7xTzqqP7z+qh5wQIRLZlpDdnxKxJRE6lmfq2EMxUBqjUBst2cuxP
 fdXyxSeEmlRSHIV+TDqlSlbb81IN9XikbzosohBvM+CiDT6O1nqUTls51CM/vC0KHzES
 ag8layOpYA+7sEkSyc/5Zx+3rRESMONmN53DUD6iYC5XrixgIEC6C2x6Q2uLRHF755Q6
 Mt/KrK+Eq8Ba0kX16xUVDwGLQNHJLWKz1Ig+IR09QSEjbarHkGQGzK1Jb6Y3kHOO5+NV
 h/S1d8+9XpsZTYM0bAORgfLKHbsYmMGjZWxY7I7jUwvEAoIU2kl2WF2cuok2kf7gSRHf
 TO2g==
X-Gm-Message-State: APjAAAUQZwnXH2WGKpV00qBi/gzy6xqUp6+5N6HeqM67YL53mB3L019Z
 o38+OUGdxlYXHzwL4RIPejVen8ASaYOEUVHLs7emvQ==
X-Google-Smtp-Source: APXvYqwxhfmYtCG1Y2dJ1N2q7LvsP0VeRT8+Itm9Yh+tTIIzacQRZI3rFpr/x9uIXnX1vqa2Cub+KQxjYk3LXQ3SEbk=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr12207717oic.146.1575647111805; 
 Fri, 06 Dec 2019 07:45:11 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-9-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 15:45:01 +0000
Message-ID: <CAFEAcA9Bf1F0CcbsqASemuu+CxPSEUHBWzyR1Qo1QUTE9hBkKA@mail.gmail.com>
Subject: Re: [PATCH v4 08/40] target/arm: Rename ARMMMUIdx*_S12NSE* to
 ARMMMUIdx*_E10_*
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Tue, 3 Dec 2019 at 02:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is part of a reorganization to the set of mmu_idx.
> This emphasizes that they apply to the EL1&0 regime.

It loses the important point that they are stage 1&2
translations rather than stage 1 or stage 2, though,
and also now they're out of line with the naming convention
that all the other indexes use :-(

thanks
-- PMM

