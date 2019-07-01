Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9015BC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6F720665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRiu0vdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6F720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwzK-0005PG-8A
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43466)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhwTi-0002k7-V6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhwTh-0000FI-UQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:36:18 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhwTh-0000Ei-PV
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:36:17 -0400
Received: by mail-ot1-x343.google.com with SMTP id d17so13516527oth.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 06:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PVjMmpPwdek8frF6rNFPjF6DDS9IuYy6pojPPHcGSgk=;
 b=bRiu0vddosM8bldq04r9MnXHYz7aNQFTu7Us063tbrs0G1OoJCFoRJ7UhlZqNiXcPS
 XyBTtv42i/ZYbH8lgbWDRxWUe6jWlvS5j1j6JJHlVNqS9URovAB0axAWqSZRYHkXaNVh
 dtmIC2QM4NA0pzSabKtWrmqZ1P/ZdxrW1HB9+x7EQQSZCyFAMuPpC4KCuZ0af/uZVRhy
 8LFp0tgnILW/otCwdZrL2kKoC1xFj7crSQUAtuOa8rb2+gwO14Jd39/Hu7seEJOx2Nmp
 sRN6u/pbNJ4VFAAJbM6Pm495WpV72pzDHrm+iY1I4kEdqqA2GfkYZwIqiX7Zn2o/B2PR
 FF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PVjMmpPwdek8frF6rNFPjF6DDS9IuYy6pojPPHcGSgk=;
 b=AWfMXP2hH+yZA280OTuZWZwU8XNL6gEKo0ZGL13TyEe9t2qtq1efE3hV8uV8SH77k2
 OvzdihVe/OSfIHkkoxIx0sNRSeZCk2fTYfjnA5mA3IST+y0bs7Em5japr9x4STJZO3qv
 QF1F2fb6MpM88URmQc1tkUlPFXWKzDfablMwRBFLrgaD46TbbmEQfGoEBUHZA2jIXNy1
 77KuxwfPTnDdtDE5n19TMXHcOKY+bUg85+57pd+z8MrOOn9R6Yim8TkkGtTK6Lhs2EOs
 wcOkkfFXU2bpP1zbiLKnW4R9kRtzkm7zfvjcdRM4wC8w8NonSaH8Z2SqMD9jnfpCm6ue
 buPg==
X-Gm-Message-State: APjAAAX14ap1YG+WaSrISfDTb+DR6a71yr6sv4Pmybp/RO6WKQ0WVCwn
 whcomu+7H8V75A6gwirZZgcww4iEp7J4Io3bxS9GTwynDrY=
X-Google-Smtp-Source: APXvYqzqoVuuToGpqIVVnN1xo1sRZuYwWWRKYL0LEDRP1aEX50UcslOCJtTtDkGh8d2hAIG3PfVkGyBOBkeu6OXCYjU=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr20589831otk.232.1561988176854; 
 Mon, 01 Jul 2019 06:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190621065242.32535-1-joel@jms.id.au>
In-Reply-To: <20190621065242.32535-1-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 14:36:06 +0100
Message-ID: <CAFEAcA93PEEsp-6Ko_ELU+0QYPuYQFJLzX1LT+5+LdPjh-jq+A@mail.gmail.com>
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2] aspeed: Link SCU to the watchdog
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Jun 2019 at 07:52, Joel Stanley <joel@jms.id.au> wrote:
>
> The ast2500 uses the watchdog to reset the SDRAM controller. This
> operation is usually performed by u-boot's memory training procedure,
> and it is enabled by setting a bit in the SCU and then causing the
> watchdog to expire. Therefore, we need the watchdog to be able to
> access the SCU's register space.
>
> This causes the watchdog to not perform a system reset when the bit is
> set. In the future it could perform a reset of the SDMC model.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
> v2: rebase on upstream, rework commit message



Applied to target-arm.next, thanks.

-- PMM

