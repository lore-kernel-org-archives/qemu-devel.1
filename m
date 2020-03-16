Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8834C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FD42051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPcvXVxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FD42051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtJ7-00034R-Mq
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDrCd-0002sc-Be
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDrCc-0004u0-8z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:58:51 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDrCc-0004lK-1V
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:58:50 -0400
Received: by mail-ot1-x344.google.com with SMTP id s15so18131037otq.8
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1t7FGpmu+p7rJZSQuRsOLxDzhRORXyV08+TeZNjvzgY=;
 b=KPcvXVxMA4PkHX0fQ6Y1xdHW4cpr1dTbcISO1f1q6R51RxHUd2aX1J248Pm85+zLtO
 5bwMEuwN8fO/fsoOfavClT8zS3e7fJ/iCLSgMSFBl+xexpEimJbJaZerlX1upBY13G20
 gvx1vdxrrwztGxonXK7HzCDyWoPcm4r2qMyGIyThSr4+u7Pep0YxE3jGh7dKS7bxwdRq
 u+yv5xO+q7Ds7XRpozXJfjhA1VQz3jIiD4sen4VNBlcpUZpX62Wuv4HcvyG7yX3/xWno
 hsMjXbze4td8zzUOxHwTErmQ6xgs3Chfp923AlIJuKGmqIGpg/Ci49IFyc/maNLvlWwg
 jVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1t7FGpmu+p7rJZSQuRsOLxDzhRORXyV08+TeZNjvzgY=;
 b=uW2ZG3ReS3Aai17v8/hZTNa+5rPt29UwsxRpIQkxAiJpL15cWe4zp5+5rZaQaRvTYO
 LLOLZg5vNraAcGMh6G7d1PxWIGvZ9STsIrk8HgBU1SHA7pR5JeNm9C6QWhTZ0q21odNN
 fIKYpG6D003YoJc6gxxQCpQBAQ8gvL8D48VvjXSxMKc7kfQYcyf6eMopPDXCENGYqPdO
 zkVnOVo2NfffxTRtnde36tgr1zxxK44wzKUqXGGIcVCQvuYWA9ilWz67+i6LgKCf4gjG
 h1GRfDY/rHpx99NdFrKcL2h7mkq8EMJZW+RfZgONdg+mXaLCZdeLAF8eH1OOclKOA8Aw
 8Yzg==
X-Gm-Message-State: ANhLgQ2L66vsxWGncOjzwF2nnWzeUwu2SJEDOcVJP5j/Bc6jFug3s7fN
 d4G3u4KB07kTND0zeq9IEcF1cqWigUBgHi9St7syEQ==
X-Google-Smtp-Source: ADFU+vuJvA0WeERkC+O4vC86BtQtjxQGI/gyEt0GWFMf2wqatgX+dbIJ7vFuhCoa00hQrwEAEda7YWb2v1xWU88KWaE=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr21686367ota.221.1584370728237; 
 Mon, 16 Mar 2020 07:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200206183219.3756-1-linux@roeck-us.net>
 <488b3355-4467-e01e-d6a0-a2d5bc959428@kaod.org>
 <5589b5ce-1ff3-bf1e-ceae-fe82e1e1265c@kaod.org>
In-Reply-To: <5589b5ce-1ff3-bf1e-ceae-fe82e1e1265c@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 14:58:36 +0000
Message-ID: <CAFEAcA_Zg65ebyTH+7i8ZGf4jzmf1tRPYdVz590UP0rQoz86pg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] m25p80: Convert to support tracing
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 14:14, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> On 2/17/20 4:47 PM, C=C3=A9dric Le Goater wrote:
> > Hello all,
> >
> > On 2/6/20 7:32 PM, Guenter Roeck wrote:
> >> While at it, add some trace messages to help debug problems
> >> seen when running the latest Linux kernel.
> >
> > Through which tree do you think it is best to merge this patchset ?
> > block or arm ?
>
> It would be nice to have these 4 patches for 5.0. All are reviewed and
> tested.

Do you have a pointer to the cover letter? Not sure
which platforms (and so which tree) they're aiming for...

thanks
-- PMM

