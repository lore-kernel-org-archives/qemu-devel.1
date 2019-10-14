Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626E5C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C80320873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdv26wwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C80320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2ev-0003MQ-0z
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2Yh-0005FR-8R
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2Yf-00084a-5s
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:55 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2Yd-000835-6o
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:52 -0400
Received: by mail-oi1-x243.google.com with SMTP id w6so14083675oie.11
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rCb7D5gkeVaSwddOI1LsIISMT/+XwM/ydhEjVq54D/I=;
 b=hdv26wwpptnVy/gkVYCbFhooTIAP+apKZzNcOKvOLDDrOCYAcP3nRXxqqW3askA9l9
 jdAhF2O6Lb/eV8Hmn+oM2wGsbCvw70HmZagb6R/CO4uryHBaAxmafdLeOtppxqXpLhqa
 9IsWdMuZFtEN3izdwVJ4QlPlZPa26AL1yr3T30LcLjTMMwNRFlyzcRdviDE6EZPtom2a
 YHy+Mq58Bq0vP/h0+YpASbY/yKMeMiuYwU+NmZiqy9Pu0V/pWqeDWAzl08qr1xe9NN5X
 8TfOPXtZSFC3wFKv88G0+Tm9cd0XP/5DkTTYGnqK8Zj01OY6yRQkNeogDkqZuzapkvxT
 py0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rCb7D5gkeVaSwddOI1LsIISMT/+XwM/ydhEjVq54D/I=;
 b=kzlf4I0Rq/A0re+5W5qdt1940l/BM0iTa8pcZ8K+KyiUNRdk/cteqCKcDZ+UZ16nao
 5SkRzKEaT8tAChu0v30LL62ZhoVt60Si8NlslBiDwcfIiOzP7eKYzHlMx2YZ1ssriHhb
 V4+PkhUJiPTkQU0mffgSLfI7ek4OqpYZTmtEq7xpFCwW+Y1xJpenxUfEdmYVo9APcZtP
 VMBC1sMblxsajLPJJ99FFnikjx40vkftqgww7FBkf1RSkfc4IaEIC4K9GArrJ2+Hu4TM
 Ok+BINfKBXQpuLp2Phnk2lftGkU7OTUf+f4ZZUrHPBQtATXDoBk1x7zQ0MZAd42tCgvu
 lZNw==
X-Gm-Message-State: APjAAAUqkujeY6iBg9WtobIi2LVCc1xiZh1rQG/I6rNHVTJH/uhRz+eM
 1Ay1jVO1M/DRCPjjAmaupIGjKaJSXg9xTTXXzIGGgg==
X-Google-Smtp-Source: APXvYqxAmc4kOhkZBYAdQCcowmiVdbgSJzMXCU7fwu6j6CHdRAyNXP9o2qOcxOlSuHV8BogH97n3dSFnh3P41tyGzeU=
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr25460529oic.98.1571068009994; 
 Mon, 14 Oct 2019 08:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190925143248.10000-1-clg@kaod.org>
In-Reply-To: <20190925143248.10000-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 16:46:39 +0100
Message-ID: <CAFEAcA_i_3p8AJKWCVA4VcxBj9g1y_atid1Di4eLhWKkfY00Vw@mail.gmail.com>
Subject: Re: [PATCH v2 00/23] aspeed: Add support for the AST2600 SoC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 at 15:33, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> The series starts with a watchdog fix and a new model for the SDHCI
> controller. Follows the code for the AST2600 SoC.
>
> Most of the Aspeed models are reworked with an object class to
> introduce the AST2600 variant. A model for the AST2600 SoC and a
> simple AST2600 EVB machine is proposed at the end of the series. It
> can boot the OpenBMC firmware image which is currently used for HW
> bringup.



Applied to target-arm.next, thanks.

-- PMM

