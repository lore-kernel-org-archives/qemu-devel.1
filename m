Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68647C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A3B20672
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZrpkloZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A3B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFkZ-0005ML-3x
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 09:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVFjk-0004oO-MV
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVFjj-0006hS-1C
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:04:40 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVFji-0006gM-Qr
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:04:38 -0500
Received: by mail-ot1-x343.google.com with SMTP id f10so4927934oto.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 06:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gAHuiqYzriXcWQl6W1mUt0tVDpXt9KikOjxABSOQxIY=;
 b=lZrpkloZvxksKyOyT4xO8APksXz1nN7ue7BD3OPbFV0a9t1X5bTjCl2KOoUsJwzdS2
 BxMEH27xM5o8T+7Dop28+pxYzZ7sU7SFjm9i1oueqprZruvZum0ZcWiIieNCUuQnPQVE
 O5AbEY8udX122P86VuS0vswUgh3+5j0ylMmRxPn153SF2oZiyQokCyHkmDcOkQZWVyIn
 m6sMohZ8UM8ZahXIvbFBNG84UGwTG7V02X17U5TRLvTtjO6SnOdq0aWnORyQs3y1Cvtg
 EtRtz0M2Cl/HH6PgdodOaMwL4ZOvVCyAWtNx+xRQ20WRkyP+ogIAgcD9Ae0EvNHk18RH
 +c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gAHuiqYzriXcWQl6W1mUt0tVDpXt9KikOjxABSOQxIY=;
 b=XpvG0+g8kzBEmta64miB1eA+VrBLVCMgjBQKq8qAGvqIz1JvllcmMJBuEYfsAU8Rw8
 VyS+EYwhrNli7qCNv9051LyJ0jOU1TznsoQUnnesHMLCfHZyDhbmbF15EDtdaIikyHSz
 NFmQg7L0txqbv62co4hIt++yY+1NcQ7/MfL2LiE9Nv2FJfigsyUZm1ipY5JX/X8kWK16
 vZaZUjkk2Fut36CBg1Sax8LOBBvjLtO2frJhNnsNJbj8hgp0WASHzpqi6H5oiJ2ilIAt
 dEA+ZzRc8Fwz3DJB3oCEZhngo+NkXuysWVm/t4dThSjZtj+7yQ6LJjPvstWi6RR3iXFM
 VVvw==
X-Gm-Message-State: APjAAAV4ukwXVkaINAG5iSPgZ+ubroL8W5Vo9OI79UQaNbTJ04gmbQpz
 fd4vVnjQHzxWVaYZm1nFOHci/tn/WEqdhdQTCgsfDg==
X-Google-Smtp-Source: APXvYqzgRYBLyEECUugJsXRqdWSWbpF0y6DO3fKtsXTD436ZgAXCqNmqnIbpdXG8X2OS9upbFKezrA6rDseRVi/X49A=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr7937645otg.232.1573740277247; 
 Thu, 14 Nov 2019 06:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20191113221301.8768-1-joel@jms.id.au>
In-Reply-To: <20191113221301.8768-1-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2019 14:04:26 +0000
Message-ID: <CAFEAcA8AL6865u8KaY3HjRH19mTP=JUJ3FAgf9VezJYPOEbmBg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] arm/aspeed: Watchdog and SDRAM fixes
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 Nov 2019 at 22:13, Joel Stanley <joel@jms.id.au> wrote:
>
> Three of these are fixes for ast2600 models that I found when testing
> master. The forth is a usability improvement that is helpful when
> diagnosing why a watchdog is biting.
>
> v3 adds some comments and fixes whitespace, and r-b from Alex. Thanks
> for the review Alex.
>
> v2 fixes some review comments from C=C3=A9dric and adds his r-b.
>
> Joel Stanley (4):
>   aspeed/sdmc: Make ast2600 default 1G
>   aspeed/scu: Fix W1C behavior
>   watchdog/aspeed: Improve watchdog timeout message
>   watchdog/aspeed: Fix AST2600 frequency behaviour

Were you wanting any of these (or any of the other aspeed
patches currently on the list) to go into 4.2? None of them
are specifically marked as for-4.2 bugfixes, and I don't
know enough about aspeed to be able to judge their importance.

thanks
-- PMM

