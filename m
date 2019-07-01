Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E093CC06510
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11F020B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OCQ1hTRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11F020B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi40f-00023f-Mz
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:38:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45117)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3E6-0001kC-Qm
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3E3-0001aE-59
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3E1-0001SU-3U
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:34 -0400
Received: by mail-oi1-f193.google.com with SMTP id g7so11117705oia.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZQ6pfxkYFbq+3K8p1c7nVAU3NmQSF1zvJ67lZA0hadQ=;
 b=OCQ1hTRZ5j5vWaZdNIO847cN/jfE+NZdCF6iFLHAuaJTn8C05ariaaa5+vv/Gv3Xb2
 ajJ+nbmisE++usBABHKOFGjt7Nq6UpKGHXF205qUYhOVnYm5UHjTWPis3aMOt1+/hGLa
 C4zgWrLWzbvb3vf6wSV162lQ0UINKJn7nMIpuyTCjoRLwjp09Mm4x7jjG50++bBvHnjX
 KMz4Tl5gkHtI1iW7raBuF4jFOVj9FFPIldIPiKTUeRZ6K4JnC9J7wfFrb0vqWR0ZsP8o
 K4oQPUWWDfijjcjY1QX+FPja0Vvg02jPKTAdyeOcK/sbrXt9nLH9LAUDog6KxjNr1vYJ
 f7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZQ6pfxkYFbq+3K8p1c7nVAU3NmQSF1zvJ67lZA0hadQ=;
 b=igBEmVblfgdMryjntIXNCuAR5nII2efissyEF8KRFxJpjgh32Ho/tnOxaJxEJpTSIL
 P//Ktp9KhJLGSuuvrJSnRgAOqvCQga7W5N6PMM4UxVJ2XQXlv5M2cos2SJPnfVawC/v5
 q72PP7QfVILKHJ5OT8Z6BJL8WowyhQV87hbYE2fGff9rXJpAH9/VFJgqdHHgU3bIm2QU
 AafhnaVi3Yj7TY1W48oXq2dLhENqQuBMlDZS7IEUV/EnyxB/maiTwdFgmn2WQ7Hav4Zw
 djvkecRc/UW+AbX+By3ua6bhtFabsJFZmmDyh7SRkdTVm8t4C4Uz9MrvfcfziYuPg0JP
 rtlg==
X-Gm-Message-State: APjAAAVS+DavxnpOQlRm617A0gaZwHXv/mbWLvbxtJxcyHPdMQUK5dUQ
 jgQOabn7fkWTCq8gMmCmxe6jSGlJK+bJ1Ic1DdTtx1YMEJY=
X-Google-Smtp-Source: APXvYqz7c/rdfKJcbG8VPYAkM+vnKr3N+RT61634upV6NjH6Xtc78s2fygFyvOmrX1lfKeiEb31U7Femh0T/2F8NcBg=
X-Received: by 2002:aca:6185:: with SMTP id v127mr75524oib.163.1561998659844; 
 Mon, 01 Jul 2019 09:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
 <CAFEAcA8P-=mbQ4__9OXB078GnrGfm9afH1YBDLkv88mUXmm=PQ@mail.gmail.com>
 <20190701160846.fwjeco3zuobn3pgv@bivouac.eciton.net>
 <CAEK-wK=gV7t8sTnN9dLmJO4ECgAudO-THhtJzHWxMpxf12mPtg@mail.gmail.com>
In-Reply-To: <CAEK-wK=gV7t8sTnN9dLmJO4ECgAudO-THhtJzHWxMpxf12mPtg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 17:30:48 +0100
Message-ID: <CAFEAcA9YFthxS7mDggqwatdc+7Z-ga_eB4XVbqkSWJg=Mui4vw@mail.gmail.com>
To: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.193
Subject: Re: [Qemu-devel] [PATCH v9 0/2] Add Arm SBSA Reference Machine
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
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 17:23, Radoslaw Biernacki
<radoslaw.biernacki@linaro.org> wrote:
>
> Hi Leif and Peter,
>
> We talked with Hongbo about the takeover, so please add me as maintainer.

Thanks for volunteering; I've updated the MAINTAINERS entry
in my target-arm queue as Leif suggests.

thanks
-- PMM

