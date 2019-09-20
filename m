Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79208C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE6A2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="g6U1VwNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE6A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBBJk-00082y-7Y
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 01:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iBAwm-0006zD-4g
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iBAmv-0006Qh-GX
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:44:58 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:43863)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iBAmu-0006Pa-De; Fri, 20 Sep 2019 00:44:56 -0400
Received: by mail-qt1-x843.google.com with SMTP id c3so7177069qtv.10;
 Thu, 19 Sep 2019 21:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SBXBgq7k+0blPWtx+vOMmXRogds3kQRYSgQ9OrBjYNQ=;
 b=g6U1VwNZEa9h+qMbypfUFpvOAET3injZXn2mcfW+RGIoAT7ths3m9cCeR521mRjjdG
 6WWuSV/gOEqa2guttePlG2MhAfjGoxcfb5WgyioLSwIPNQ2uyaYG2FHL7fRtXqatTkrc
 tSyoXCuOSbP8mvbObIOACUNc0PqPzZMMx8X6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SBXBgq7k+0blPWtx+vOMmXRogds3kQRYSgQ9OrBjYNQ=;
 b=jtlgfCjh2HcoZ3uD4tEFZchXPFNugE/AqU80+pe+DMf35hXgHURImTmEGD2glMkiGm
 0i89nGY+kNFsMtD9NH0t9rZOoVJAusUDa8y+scr9G/ZLF5eVntCXraszqWPMMF5VUHN0
 P2WCtreNw8VFuc50k0vlT7hpEO3/kr45vUsz4F1DfLS0sFLVOQdfitO0b2YFihHJHHfS
 796b4nWmo5ZUpNNWS/9nDk2i1HR8Qy4Ks9/oVxiYbJ9mnUfZJGh2GF6A2nzp9ehwQjVo
 gyltL9xluEkSa1Q6zqDuodQaQyfoZce4bmnkpIyFVmXAnE2sk1iIK2N3lovUT1OHJRdY
 XM1Q==
X-Gm-Message-State: APjAAAVSBR7S/nNeiLBkWIHH9KElvz+yuAohu0mgo5LizogpWGB4p6VR
 BbMuFJQ5yNiLNOiqVmT9Wa34q6mZyGV1C1Gk/SU=
X-Google-Smtp-Source: APXvYqzV+5GB4Oos1UyBJWR8e6gG6OhmV4zQL37CLDLGfP7gp4m+heVkYvxhG+IwAfqrxIdzHDhzwQO4pBzcSoCuXvY=
X-Received: by 2002:aed:2ce7:: with SMTP id g94mr1197084qtd.255.1568954695792; 
 Thu, 19 Sep 2019 21:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-11-clg@kaod.org>
In-Reply-To: <20190919055002.6729-11-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 20 Sep 2019 04:44:44 +0000
Message-ID: <CACPK8Xe3HNbHj76o+=hujNQFvdU418+xG-gWcmUi8ouh82DGnA@mail.gmail.com>
Subject: Re: [PATCH 10/21] watchdog/aspeed: Introduce an object class per SoC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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

On Thu, 19 Sep 2019 at 05:51, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> It cleanups the current models for the Aspeed AST2400 and AST2500 SoCs
> and prepares ground for future SoCs. It removes the need of the
> 'silicon_rev' property.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

