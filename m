Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1117C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1AE221835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wACfxTUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AE221835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idJ2R-0001HI-MF
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idIVY-0006BA-MP
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idIVV-00005A-7h
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:39:14 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idIVT-0008T0-6g
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:39:11 -0500
Received: by mail-ot1-x344.google.com with SMTP id d17so6690892otc.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 10:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eh9xvqGv160fKMlLUwlPlM7qfEP0isz5KYXYGxgyu8c=;
 b=wACfxTUlczOZsG7CCDJ5ZRZYorQx6HmmA6N/te+cyrzutNJJ4HsJmfbIIB4BL1vyNd
 iLK5kQ80Gm7RqGznez8vHvqZgraxshgcUHXJug7YhOAGeKXFw8SNnZdchqrPs0MhCqnD
 ihIiy2Up0ULk9ZRK5L6nnec60KSVt5Hi2nmzCl2yNIhA2uVg7nM8LJc7HH9HMc4SyXx3
 LPDARTMnGfjmSrVIriqZV/RwYk0XPcKxPLm15jAAQ7734HLgbIeroaqpv/XS0odRLhUD
 mf7u4RWQuWsGBn4WH7I4hJLhHHtGn0AalxhM3Lq1YQAoi9lJHxWvbqyHpt4EEHlNMTCl
 irFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eh9xvqGv160fKMlLUwlPlM7qfEP0isz5KYXYGxgyu8c=;
 b=lh4ElFr+BHLzVTuDPrKbobV4S6Oz+PPuABecOvqNpoxENDnwUyFt1q4QDwVVmztYMj
 vhZWBeGAScYQTZHoz3SrQVLmyD7tXhgxQQzbal/f0FLP8hDTTyoMXrUdPMaWOWhtyFLU
 /eG0cHKp5Ud1AflM+ejf9kiCv20cKM9FTaRzWTZRDOZF2GnYavJ1vID+ZpywjXl6z5dB
 RAlrWEVMbUd3JQlqn5Ax1cC9UY5oh3Uc9SELRK6HlOcUlnp+cMC+/6eF1uD89Ts64mm6
 XFKt4gA3IKSnwHaFxNY5bJ63gP/jcP384rfD/B0jJYnDbu7mZRivs3vj+xAuB5x4mwt3
 WWsA==
X-Gm-Message-State: APjAAAWiyIQ7VZrTSVxLbVtS2gjaIeW3h4tPeflLrAjgNwH4+cY9JSqX
 M4vzobUYeoNyCYzadD2QuWMWNfU3MWgWLqoMAYjF3g==
X-Google-Smtp-Source: APXvYqyLyH4WzoktiVZ8ekTSUBK5nOb267oJQ6YQGWI6LORU5SMake6vRYUt6QE5llPM+YQQzs+xKVAufpDOlOiVvrQ=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr12398993otq.135.1575657544333; 
 Fri, 06 Dec 2019 10:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20191206162303.30338-1-philmd@redhat.com>
In-Reply-To: <20191206162303.30338-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 18:38:53 +0000
Message-ID: <CAFEAcA8npEnhYJoiTTJ=o4xFuPmEtW_Ga1e3Ka4KOpbuph5Cpg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/sbsa-ref: Simplify by moving the gic in the
 machine state
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Dec 2019 at 16:23, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Make the gic a field in the machine state, and instead of filling
> an array of qemu_irq and passing it around, directly call
> qdev_get_gpio_in() on the gic field.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Applied to target-arm.next, thanks.

-- PMM

