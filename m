Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE34C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B08D20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hh2Vc7Pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B08D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bgc-0006kD-V3
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7bfO-0005XW-78
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7bfN-0003yR-1S
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:38:26 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:41106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7bfM-0003xM-QP
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:38:24 -0400
Received: by mail-ot1-x332.google.com with SMTP id g16so2069360otp.8
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=n3EdLZ/I+9KgAyrX3nxszcZrA5OOqP42Y3tI2lwoT8Q=;
 b=Hh2Vc7Pv9uFaSRK3z8ll1rZZU5FlGVkvIafMQp68JyjRkEir64gn8GAA6wav+Nn3ni
 rwGYmSjqAKHiTcWfIyYQJ2zwVyvZxxeplCiIIVqymC5toqRIj4wVftWvXNTJAjaiAXj0
 x+V0NCLGHgJ2bZc7docEkvzQcleLCurBzHLos6BUeqthvkR5Qd9Bj02RLmNaWt1lukr8
 3LCoGjc7Xvm0hkUJoNXqw+7e4xElQBIgFVQ9QqsX0nWw8U3Mm5QQwNTLz9t4CI8BmFOR
 GLHSvE3gWERr1UcWswPF2+5197+2Tg0f3cgpUTcGEhGkLlua+Nt1LWtx/TJ5yZS5OcAX
 GRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=n3EdLZ/I+9KgAyrX3nxszcZrA5OOqP42Y3tI2lwoT8Q=;
 b=X6T+Y9Jl0uUdR5Ax36mkCfLxCnWLm89ErHGqEeOFB8ar2+yyHkfLCHQ3/VqcyhFog4
 O3P13velTg1Xa5X3WhryLOuvkdaS23CiNkqaZPrdbHl9I5lPP1zBWDUAyIKjHpeFe5r/
 M3pq5TRDik+HPqbC1dn08JzyV4WcsBQh1FN/6vpdtQALEV8hvWZDUQtZjXSCUr2TeDbY
 9RLA00UVbiKXftw+G59kx7Ssqk3NhzBYtIKbOYPZrWi36AsU8QwzyLWAZguMFag3ieHZ
 ELCJNSeszDLaQ0T0a1yhAhO4TvpYRusIufvi3VHsljiF7kD8f19ZW0I6GNbegO3LjJPB
 aL7w==
X-Gm-Message-State: APjAAAVzoHFKSydJCcVmon7smnjT8JWqu2kpv+MPnoXpTVj2oekgnYt9
 ftqqzJuk5TpxGUp16XAupdWj+Rifo6GlGfkjCvWgSlE/w/A=
X-Google-Smtp-Source: APXvYqx2QCjn9T8il6e5esMVWZwDclM+C0oF+5iBhCVx2pgvnJCQpi6B0aq76E669LFwlQzQWSLYLLrSx1iZN3i5U+A=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr25207209oti.91.1568104703388; 
 Tue, 10 Sep 2019 01:38:23 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2019 09:38:12 +0100
Message-ID: <CAFEAcA-14O3vYbUzCP7stDPffvHKaLrA-=apPXvGzRWoD1SXuw@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Qemu-block <qemu-block@nongnu.org>, qemu-discuss <qemu-discuss@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, "open list:RISC-V" <qemu-riscv@nongnu.org>, 
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, 
 QEMU Trivial <qemu-trivial@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
Subject: [Qemu-devel] ANNOUNCE: emails from this mailing list will soon drop
 the [qemu-*] subject tag
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi; this is an announcement to let you know that in future
emails to all QEMU project mailing lists (including this one)
will no longer have the [qemu-*] tag in their Subject line.

We need to make this config change because having the mailing
list server edit subject lines like this conflicts with the
increasingly common DKIM/DMARC anti-email-forgery system. We
used to work around this by having the list server rewrite
email From addresses instead, but this has proven to have
bad consequences (notably that patches applied from emails
to QEMU can end up with incorrect authorship by accident).

If you were using the Subject line tag to filter QEMU emails,
you'll need to change your mail client's config to instead
look at the "List-Id:" message header to identify list traffic
(you can do this now without waiting for us to change the
list config to drop the subject tags).

Apologies for any inconvenience that this upcoming config
change might cause you.

thanks
-- PMM

