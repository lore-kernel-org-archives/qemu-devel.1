Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07E5C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866AC2080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="BoEDMyif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866AC2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBBEc-0002UR-SI
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 01:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iBAwl-000719-UV
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iBAoT-0006xc-Tr
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:46:35 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:37475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iBAoS-0006x2-8H; Fri, 20 Sep 2019 00:46:32 -0400
Received: by mail-qt1-x843.google.com with SMTP id d2so7233193qtr.4;
 Thu, 19 Sep 2019 21:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=g0qEXed5iOU4JinfxUM2U+9IdAViVG2LZAwSzlIGZDo=;
 b=BoEDMyifvs3cFsADrs6qHOaqBaoF706geX3KrwzVygQ3p7hll/G7g+73EP9DOeGQp+
 +7GyYuPW/VKg1yrYS1y7Lq7n86pQeFnQ9owD0F6Cml4rR0FfH9sbTkbw+EUXQPl1Iyun
 Sjq8JQai6rWHjZamUt9zkLqiEjBw8FIrfwZ/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=g0qEXed5iOU4JinfxUM2U+9IdAViVG2LZAwSzlIGZDo=;
 b=VmJeA/EmS3jKQfQGMwQUMCopz/tZfvHpffPfC59zpZ5R8cvJZPf39R4F+8/7A9IKSs
 lnM1Ez8JeVm0YU4otvKE270LaLKGoRXEh7BiJ81XAH/v6R5pISzKxdTClGJpgIAdtDXr
 rK17LTVL/XH0VwFpvWgT4I6e92QWk4hGTwtjlC9QwSqQnaxNI7Z+L+9oGs2u17NBzK5k
 of2+jVagGwfHO+/qx5gYERL09qOBUpib7mgFLzQK9XFuBdcF9bwO85h8+bSraUX4DVIR
 tIqvFjhBq2mogEaEKquRZ/Wq5c2dkfdEkf+hKtEfardI7oM5mWaKt/5v/aa16RU1daBX
 fgGg==
X-Gm-Message-State: APjAAAVkFK1F7xnn9gpBDLyGW/EBmZRZ7VDi1tVB7kKSXDRqBPnQTRVf
 EaDqQWziU2zuY0PXjEHr8jmXplb1l2aSYfGnLKs=
X-Google-Smtp-Source: APXvYqzR0cJ2TQtwpbn0yaAp0Wip2e/tbWudodZPqQ+TdWant/88e+SDdrtjhUKw3NNDzBpnwhqUyCD4rfuqg85pZIs=
X-Received: by 2002:a0c:e48b:: with SMTP id n11mr11678939qvl.38.1568954791622; 
 Thu, 19 Sep 2019 21:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-13-clg@kaod.org>
In-Reply-To: <20190919055002.6729-13-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 20 Sep 2019 04:46:19 +0000
Message-ID: <CACPK8XcJRT8fa81vp7aC8f+yfOxaHMFd9+tijq7j1D68DGbFcQ@mail.gmail.com>
Subject: Re: [PATCH 12/21] aspeed/smc: Add AST2600 support
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
> The AST2600 SoC SMC controller is a SPI only controller now and has a
> few extensions which we will need to take into account when SW
> requires it.
>
>  - 4BYTE mode
>  - HCLK divider has changed (SPI Training)
>  - CE0-2 Read Timing Compensation registers
>
> This is enough to support u-boot.

As easy as that! I hope the Linux driver is as simple :)


> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

