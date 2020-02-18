Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115A8C34049
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D726824649
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ej0KOjyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D726824649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46kg-0003MI-2c
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j46hi-0007jp-QU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j46hh-00006P-SI
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:30:38 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41296)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j46hh-00005J-MT
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:30:37 -0500
Received: by mail-ot1-x342.google.com with SMTP id r27so20261879otc.8
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=edIzC9gi9Dry5wuMYlBjdc9Ho8a1eVgA2bjxlKMlcIc=;
 b=ej0KOjySnTQOaLH6PUgr8Y1CHbSG7l3sMw7viwagoZ/ywDD+SGQ3D8qAR6akccW2CL
 QXt3TEKAIC53MVQJnh1pfWPrGCn+Z40kSORJUMtxY1lEr30X19NRdFOWQWLBeWLl7EU+
 vmBYrLElAg7gQ9vg4ust925WIPnTg7n8HSA5lQpzGoA2wuz0sacaRz5mrNi5ekkvJ2AV
 8kZuwQrqRO6IkqJF7MnKol0pzM0okUanq3aFS5BjkDERHiFUYI2TiiTzoWbEgdq4O2vF
 BiMU+aCajKuHMVGxegyso0BbT6Qt+CEfPMZqT31vW0QjXvhJAEDWmeUOFmo0/ydknapX
 u25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=edIzC9gi9Dry5wuMYlBjdc9Ho8a1eVgA2bjxlKMlcIc=;
 b=uOtJ6tQGkWUKMKIuTbj7rTEBVyGMyNl5Es9gJTYp5E0UH2X4BM9kZFkiVkOvt4aOpK
 AzOhfiYtZC+HMZ+dGjoqGBBix42TbG436DytJqMRVlGBbckviIgQGT9yPfoL/53k/bh2
 JmGyJ2dQCe67f3TxYAsfp9FbkXDDb+oXpVXVvq9KLOxeRTzDZO+NQil7gfUddasOewGM
 MMjNoeiNoW2Y4xc/MSjwrJ8wSMHwermZWivQzFmd5clWnBlx0LHCFFzHcF5R0+KNLcM4
 fTNEfM1ljzf6ULhdEe2orMl6LOVTw1pVpC2STk5h3UKmJDEWeP4HZlKHFdjc4ke99dn/
 EXPw==
X-Gm-Message-State: APjAAAVPqxJcsqZt/ZTqaRUL74Ehuf/RD+Z7+IWdX/xYXIbHjSKifxuV
 0XP6yHJ1ViLbCwH8PubDGiIvUkREs5hSu4WIU4YWVw==
X-Google-Smtp-Source: APXvYqxUrmSsu/fricoaO6ER8Xo9nvw1qMCQ17yK526xSEpl96aaHq2fbm7+DA7mUlzI4JFP9+wkn0up9DLx5SaUEtA=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr15823107otq.221.1582047036824; 
 Tue, 18 Feb 2020 09:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20200216194343.21331-1-richard.henderson@linaro.org>
In-Reply-To: <20200216194343.21331-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 17:30:25 +0000
Message-ID: <CAFEAcA8AgYoLj7+K4GLhkReHFMzyJBM6qP1uLw=X-v1oN6hT8Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] target/arm: Reduce aa64_va_parameter overhead
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 16 Feb 2020 at 19:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Something I noticed while developing and testing VHE.
>
> For v2, fix select as a separate patch.
> For v3, adjust pauth to use bit 55 explicitly, and remove a
> now duplicate test within get_phys_addr_lpae.
>



Applied to target-arm.next, thanks.

-- PMM

