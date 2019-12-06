Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6EDC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9942821835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="My/CsGmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9942821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHH2-0001vF-6t
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idFV8-0003r9-5j
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idFV6-00033L-2j
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:26:38 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idFV5-0002zv-P9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:26:35 -0500
Received: by mail-ot1-x341.google.com with SMTP id i4so6124837otr.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a9GurE1xd2LNGVPndpjcP+v/5quQXvNZhRnmB4KANks=;
 b=My/CsGmoK0XqSEW1ujJ9iQxiW7x+HbOVhXSsUpgpbFk+AaGogRT7THsanTBvWcmbsl
 sRGxOt+nkzdZiW7T2YUHyy/UK/DOj7Sm1ZY8spX4bM0FsB7rVsP4+zANRrQWsQfdWNMg
 ezd/89GrPM3xbu58V53YD67C/P2mJefGpL/jiVKpNzrMnYC/AsNOSCUzQPxt1vLjtKy9
 KCCNdMtCsxb5XP+p3g0lL9CNCeOiUlCi9jsaM50B/DdUPOQ5CD205R7dVc/3L8MFQSSt
 Sez56Q6XoYulTNmJymbWk5G7TH2yxrRCFAGk1kRelKBhr10n46VCd8rn4C4aIl0VXOqt
 9QQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a9GurE1xd2LNGVPndpjcP+v/5quQXvNZhRnmB4KANks=;
 b=lsYoa/XEC6/Z61K/0ZKOKhMDX9o5C6fwyRxDVwXiaj+0i5nZHH7ejiW/w+VoQyPzXn
 Hbplp0UgHfIqN4/CTg66ZeATV10rI04TNkBeLOEq4yJ5GD3P1j+VAjyAazRa5AT0UPtu
 AywtufJbLqhOHuq0NVQl4cuihhWkDvJDxSMOFpuGG1QWv8kh0yXnAstDL1YIaRlARSAL
 9zjK3vRbZ4ZphQVgRGVApGVJ2L7ntk58Jltyqxq/7zQHT/PjZ825UrkclF3OeCPASd3B
 t41AwzfQIqldar1/u/0nyQButTLn1GOK4jngfL517GbL8wWBxNDmGxgRTyHYMZi8j389
 mvPw==
X-Gm-Message-State: APjAAAW7oGszOHjgBSzdJEu/HwFX6/CxWUw2wAQVkOLRn84Fygg0hwWh
 cSYSUeBSBDZ8C8kgZIXO7K5G4bnGo8PYWKcv5G/6xrAo
X-Google-Smtp-Source: APXvYqwo74JbEYT67UcEYcG3qS6gQ5kx8y8dbJMRP/WspoRWnNQCA7oIW8+LtdI7Ksg7/cbOquu5fo2HylGgn61bGdM=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr10682660otg.232.1575625984928; 
 Fri, 06 Dec 2019 01:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20191206044134.259488-1-david@gibson.dropbear.id.au>
In-Reply-To: <20191206044134.259488-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 09:52:54 +0000
Message-ID: <CAFEAcA-oGLx+mcgqxC6-QRv9dSdzOqvM8g7q7SzUuAqKSZU-tA@mail.gmail.com>
Subject: Re: [PULL 0/1] ppc-for-4.2 queue 20191206
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Dec 2019 at 04:41, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 1bdc319ab5d289ce6b822e06fb2b13666fd9278e:
>
>   Update version for v4.2.0-rc4 release (2019-12-03 17:56:30 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20191206
>
> for you to fetch changes up to d887a8cfc083bcf3856f9f42352989f3624e0cae:
>
>   pseries: Update SLOF firmware image (2019-12-06 15:33:23 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-12-06
>
> This is a last minute pull request for ppc-for-4.2.  I know it's very
> late in freeze, but this does fix a regression: a bad interaction
> between the new qemu and SLOF device tree construction code means that
> SLOF will crash if PCI to PCI bridges are included in the system.

I really really really don't want to do an rc5. This would
have to be "everybody using ppc gets crashes" for me to
really want to put it in at this point...

thanks
-- PMM

