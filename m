Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285EFC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E354121835
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miOFCoWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E354121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihFK0-0003mg-Uz
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihFJ6-0002yF-Nc
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihFJ5-00076P-D9
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:02:44 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:41115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihFJ5-00071M-6H
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:02:43 -0500
Received: by mail-ed1-x544.google.com with SMTP id c26so8427432eds.8
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 08:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mhgCXR0RlBMimws/8kYwml/G5AJF/CxRXmyzmxV/rEo=;
 b=miOFCoWACa1t7Ub1bcvz0Ej4/d+taBjjZPa5gSWdGYACB64UtIIBcZ8HsmEhazR7dz
 1YflF0CxhZzTavgbIsjX2XnYddaum3mO+R08PN5Fpd+a53wSlw01FdriBUzuhPDmuptJ
 GKGb4M1cVG/qmrJF7Fq8V9A3nHrZOeJCKcRA3oVKG/1RNs5TEmrLmcXRqqPc+9/lH/hc
 16MF55XHvtVq3PgP38LtuqHLPzw3grO7fk+PybO00zYm4k3SYC2XSD+s2Tw6SrmOLhUO
 AH9e7UH0kQ2YR/pbX2rjOxJKhMLFDw7Kc+263U643KUGPWzME94yTTAUUxT9EM+hDDhI
 t6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mhgCXR0RlBMimws/8kYwml/G5AJF/CxRXmyzmxV/rEo=;
 b=AETyho+0yTszUYn1px6WnaP+3bm4Jjf6xdQDVugQSbvmmGdTbSXfICOdzAFuqK22DB
 WT52FJpOGLNnTubuLoBZXdJLM9o3ZYBKC8QcKdZEpBMoqk6wFrGsk/lPxTkdcFI2Mu60
 w2sxzGBz+aY98ZFwRfy9NfqVqAhWY4Mo6h71eTKkcOIlUGVt3RxAzb6/5BO91vRPYYyF
 qmOnnVBr+klaotjDmx1G+uZxfAPq8xcrsn60scjorWkHmigeT18jDYnYoqSfSMWSX869
 648wCKlnqEZ/T4bXPQ7pQixvQO/0+mRq3x5SZRC6ghcaPtD6yWlZMm5MILROr/JluCi/
 5Beg==
X-Gm-Message-State: APjAAAUURNz+f/MRi8M3Vy8LF8coci7cK5vSUTadqHvQ0A9FZYjFt8qZ
 TppmCe8PSL89Wrsn+k5qdMPL5pdTwDC33P116gImag==
X-Google-Smtp-Source: APXvYqxBSSOhLFpaeMebz38V3lBaKHQf3pf4H3iwBzUFZPINt86gunvL/UTw+4C6IJE+i946iOVQPJQ/OROSIXwUbug=
X-Received: by 2002:a05:6402:149a:: with SMTP id
 e26mr6197507edv.198.1576598561770; 
 Tue, 17 Dec 2019 08:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20191209134552.27733-1-philmd@redhat.com>
In-Reply-To: <20191209134552.27733-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 17 Dec 2019 06:02:30 -1000
Message-ID: <CAFXwXrmi=AqO9djosRt7vEGm5XDmnBt7KhHn9AQAWbVPLp+QkA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Display helpful message when hflags mismatch
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Dec 2019 at 03:46, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Instead of crashing in a confuse way, give some hint to the user
> about why we aborted. He might report the issue without having
> to use a debugger.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/arm/helper.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

