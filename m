Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E6CC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A40222BF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PCCtXR35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A40222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPBx-0007cP-E1
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iDP5h-0003B2-89
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iDP5g-0006Ft-Ac
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:25:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iDP5e-000695-Ez; Thu, 26 Sep 2019 04:25:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id m15so1837471qtq.2;
 Thu, 26 Sep 2019 01:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D6Mx/VpyHufy8B0XMwB5HfzvyGWw2IgWI1L7L02xe6w=;
 b=PCCtXR35cTDUcjZKZbUnNzeTeJ76Ji4glmcU3g6p9OoB5IKNOKiDK/dz5YvkzRe7RS
 mbldH6sKk/eF5n1rmqAsIBu37M2TdsOpKdcA5i6ZU7yzjmbgLKz/WRU7Q4XI4q6lpi3k
 nlfyH+ZDMMTQ4YKzuJVXolYU6vhqFoUQ+Joos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D6Mx/VpyHufy8B0XMwB5HfzvyGWw2IgWI1L7L02xe6w=;
 b=LwZswgceNMx1vOD+xfrcAzwxeH0jL1KRNxy12riSu603xbElVMHeqshszHpWh1I73U
 BunAA6RASSa+YoIGdFbAl4MSaA7IyCSFehzHuw14N9iYckb3ww138pfoKY63iRLARzAG
 XqjynLwsFEmg0UXCb7YQxTt523WkxwsJV3vd9mGePcXOLt/MiVq8uaf3c2LJjalv5t2l
 +0HehSl1KuCxnt4LnQNYUbcuT5/88SIwuqIiVrbujX6j3zjkf89bxCxFwkEjaiyd0L+c
 yrHHmQ7GRxV52JuxBwhRrR2S9F/mhmQYxha4Qwwx+JOshi1zF6tFMDHJFTMqrbPI3F6s
 QxuA==
X-Gm-Message-State: APjAAAUQXIKOvuO+t6JEDHAB1TLgXTLEULGWWzaVxzYFyLXQhiGsqnSg
 hZzhdHTmAekD4kN2aNpe9GFkYAxIA2+mwJurP/EBkQ==
X-Google-Smtp-Source: APXvYqxUFnxVd5UqdlvZYZGpV/i2iMpEODZY4fQwMWdfqTRcGAlrFzu5nS15wqFetE6CklJj4YuYDywDDLgbGlwq0Z8=
X-Received: by 2002:ac8:2d8b:: with SMTP id p11mr2679264qta.220.1569486269825; 
 Thu, 26 Sep 2019 01:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190925143248.10000-1-clg@kaod.org>
 <20190925143248.10000-14-clg@kaod.org>
In-Reply-To: <20190925143248.10000-14-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Sep 2019 08:24:18 +0000
Message-ID: <CACPK8XcoXmFqBWN2jwAb2SYkwY4Tn7qwo_Q=+OaNS7FrSQ1DQQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/23] aspeed/smc: Add AST2600 support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.193
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 at 14:34, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The AST2600 SoC SMC controller is a SPI only controller now and has a
> few extensions which we will need to take into account when SW
> requires it. This is enough to support u-boot and Linux.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Acked-by: Joel Stanley <joel@jms.id.au>

