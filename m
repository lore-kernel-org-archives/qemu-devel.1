Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAEBC73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9AB2082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IctNM5TM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9AB2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hktOC-0004ji-7d
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 12:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39024)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hktAr-0005PR-72
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hktAq-0000sS-4s
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:41:01 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hktAp-0000rY-UU
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:41:00 -0400
Received: by mail-ot1-x341.google.com with SMTP id r21so5141278otq.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FSd5U/AhRoKw0D9xITYs6vnqrq5TrBfzrsxGk3E6fXY=;
 b=IctNM5TMIMIAnQmDhQYY9NaGZx9dD1NL5bLH5ydIWH9Y6xI+sqOWL0sKIOn/EQ0CnP
 vJasigen5fmpnmg6laCnxu9BI7vEhjKWQz/YzQJzkd/P8+pTqDc6lx1HoFSt4FH5N9du
 5bUfcqfVPBj7I9tunK/XemQq7PsjRMWA8EixIhF1DAJRyw+zbKk+hblmGh45l1c2N4Vd
 ElNnmv0vRKTfpaF59FMQBssbWLxEYJDHAImg5/aAOapJ1ENhPWN9gTi2DLIlrC6VWyVx
 q27L9eyKm6Vk1VOSoZgf2OnQPMgjmyrgUcl/BKYfqeFT+6BEsrj3vI4ck824lmMEDini
 KpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FSd5U/AhRoKw0D9xITYs6vnqrq5TrBfzrsxGk3E6fXY=;
 b=EjO9hyvMCaMby5yhleCTM566QCPbwVJ+wWl+T2ZN5XBj851weGu1btW7VzmNoX5qC8
 rSAYwDB4f1Oaty+htuQfiLYX7M5kOb6tKN+x9S0cXNZKg8yH27/VYd0vsIcwLrIvhQQ+
 zZAoRMMEJCo38NE9UJ6gGP95pIv1PDGHAGnRwZ6ZHptM+40BAm7tQKPrNAEby04kVvK7
 G/q/+DTYZoV9qJfq7P4yh43K0Ih1Owftt2863GDrs6bpNczK2lTcknNHxjTS4KjaETdt
 t+0OJ8lJOHEqK9MUetiDktCiSbgIriAZPDv5kzbhdEE5Rs0ZoVup4DTU0PsYUDKld6zE
 uVkA==
X-Gm-Message-State: APjAAAVJ5+RNK2fHNezNDYIiudisXtToxqwT7JCKAT8GQHdRBMW8QR4U
 bVELJEaW1xpkZRcggvm1KOj13ISXcSEdn1/jwqpMCQ==
X-Google-Smtp-Source: APXvYqyAxzmI9auaDf5KLwlsoibEefo9qkKQP9BIHgw0vEL4ikn0igD07yRBskvWFY4zfeBufOowCnxpPgc6UQ63/3M=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr19054781otk.221.1562690458835; 
 Tue, 09 Jul 2019 09:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190514011129.11330-1-richard.henderson@linaro.org>
 <20190514011129.11330-2-richard.henderson@linaro.org>
In-Reply-To: <20190514011129.11330-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2019 17:40:48 +0100
Message-ID: <CAFEAcA8k9+XW9uPujk3Zp3CxvYm6Qj6kVEig+KuNO2ywOK0tTA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 1/2] target/arm: Use extract2 for EXTR
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Beata Michalska <beata.michalska@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 at 02:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is, after all, how we implement extract2 in tcg/aarch64.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)

It turns out that we have a regression in booting at least
some Linux kernels with TCG on aarch64 hosts (the same
config works fine on x86-64 hosts). Git bisect points to
this commit (80ac954c369e7e61bd1ed0) as the cause, and
reverting this commit on top of current master also fixes
the problem.

thanks
-- PMM

