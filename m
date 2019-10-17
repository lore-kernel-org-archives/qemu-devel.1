Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469F0FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D27C205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+QdpjK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D27C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7Br-0002kH-35
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL6Ep-0003u2-G3
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL6Eo-00040I-7a
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:54:47 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:42629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL6Eo-000408-38
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:54:46 -0400
Received: by mail-io1-xd43.google.com with SMTP id n197so3058347iod.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IX1tG7Jw/XnjQLIGLFO1DNvERo7K99yeCr4zuiNJ0l8=;
 b=E+QdpjK+mwsXOh5Q+wX7L3eXaC2nKtqQ5FiwJw6RF9YIX/FLhGUhoTYEPMrHrAIF+p
 37KlnnrFPnB+bvAj+WheNq0YaoBbI50rCVoSa7BdJwSuH93iQOc3abPt00F2+TPgcy7J
 6gPJYRVoX1yV1OOCz0A5XCsXyoZYhcA5eSalm1EPwGACQ4SGJo77N74mBrdl8lYqo7hf
 3AysTukaiav3Fdm8qRPYmeHTjS0fphMJOlC1MPz3AB3YQfWXw2yn4+INmMJnasGotqNp
 xtOi7p74kHgw4UPrXhGEwLY4o2t9w5ePEcJ2Vb2xo8IRnmDa61sSwlPLk0MsbEfmxjPT
 us+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IX1tG7Jw/XnjQLIGLFO1DNvERo7K99yeCr4zuiNJ0l8=;
 b=oqIeNB+lk/xHThXmldXH+7bJ0+lZwA9b5jMPf23xvhAUx6LS8Jmzqz841YRWtWxY1N
 46I/819ONXRJ0m3crv44uMc4cqSWJnfG1pt5CxMF6tpm3QK+ykVH5SmQVWh/quQrUAhL
 Ae4TNKXWCLySEh92MK3+uq5J/P0gepXa/03zHRtBTSeACa2HjErQuvZBuuY8ubeAwMdn
 kVxPkpJHHcIX1EaeWv3r9X4ZDKau5BunME7O0Gudv+fhxNETnYzV+OjES40xpxVsr6k7
 /uexsx/LJh2rVl/1cVGYjV+tQ6rpUdApldE1fZZSsGeTFUL2sryI9mf/xF0bKcws4Pbo
 E4tw==
X-Gm-Message-State: APjAAAWTF3+jobXilbaP7JHY4koXJZVbf1WWhsh9uC4chiclw0nB/NnK
 7OdvFvFLryTQufaJ6XxnwDI7aqkYE4C2c9Ve0d+o/Q==
X-Google-Smtp-Source: APXvYqxSaa6u5SOgB1shCtNtCkfPMrC4MmCDcO56RHZ73jqOKS6gH2m/adhrIfxHkcNbh7VTPk8mncD6NTx38qjxV7Q=
X-Received: by 2002:a6b:6405:: with SMTP id t5mr2939472iog.93.1571320485481;
 Thu, 17 Oct 2019 06:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191016090745.15334-1-clg@kaod.org>
 <CACPK8XdT0_JCxzfxd4dCafK0Ae9+18ZWcusuXV+d4eEmwwBnkA@mail.gmail.com>
In-Reply-To: <CACPK8XdT0_JCxzfxd4dCafK0Ae9+18ZWcusuXV+d4eEmwwBnkA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 14:54:34 +0100
Message-ID: <CAFEAcA_6yxaanT2N6Twos_FxjJNgvVKShwgq=pR4fqmcZUsQFA@mail.gmail.com>
Subject: Re: [PATCH] aspeed: Add an AST2600 eval board
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 07:33, Joel Stanley <joel@jms.id.au> wrote:
>
> On Wed, 16 Oct 2019 at 09:08, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >
> > Define the board with 1 GiB of RAM but some boards can have up to 2
> > GiB.
> >
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > ---
> >
> >  Changes since AST2600 patchset:
> >
> >  - lowered the RAM size to 1 GiB as it was breaking the tests on some
> >    hosts.
>
> Peter,
>
> After chatting with C=C3=A9dric I agree we should merge this patch.
>
> As it turns out the EVBs have differing amounts of RAM; his has 1GB
> while mine has 2GB. So we are not being inaccurate by setting 1GB as
> the default here.

That's convenient, means we don't have to figure out how to
special-case the test infrastructure for it :-)



Applied to target-arm.next, thanks.

-- PMM

