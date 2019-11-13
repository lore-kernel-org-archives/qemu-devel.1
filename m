Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63754C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 00:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2079D21872
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 00:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="iC2rhEIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2079D21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUgsd-0000tJ-2C
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 19:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iUgq9-0000D1-96
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 19:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iUgq8-0004IU-Bd
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 19:48:57 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:41427)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iUgq5-0004Hm-I2; Tue, 12 Nov 2019 19:48:54 -0500
Received: by mail-qt1-x842.google.com with SMTP id o3so625519qtj.8;
 Tue, 12 Nov 2019 16:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AOkVMHRyugJ4RgUmDDq2Lvil/V/zcbkz/Fl3Cm26CY8=;
 b=iC2rhEIOJNWHa6nElIEZvMtgjV0d4zk+7O1A+Dp5qtpvHAFUopr5WijaEfV6RM1HM9
 L8jCMn6ywg6PKSJRYo/X3NUUkG/jIssKlO6uG4QwGfSg3/BgU895RuI2Jm+10BffmwRw
 MnoZPNnLUgx0Hk1BmZ74RMJ8RcsqAbV9xznJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AOkVMHRyugJ4RgUmDDq2Lvil/V/zcbkz/Fl3Cm26CY8=;
 b=dSOoPcwf13cfn2xUVOvkZgvkQSA1iSqOO5G6xJiykbLzOqQgOL18FOzSr29C9BLY/0
 PEKGljSzJYt7PBaIvNufXCEsy0f6wITVzX3qSP29fKmBgYAPUSmYun8ljspSumCye8We
 IqrfAFWMrA+fiXqQkMr1yFrIQmI3xqjxy2sS/PlL1VHKvtukcMOr6+t9MewpMKSnmVbK
 PvcX8JYaYj4QAELETjQ1rejiRET3hS7/SxsZWWdOH2WrSirFUwiorvjwtxtHAs0hpDzq
 6GgVLlcuzCWHS5OZpDZZTWwnzNX5gpJl+FKSb+dYFuUi4/6MUwYAxGy/nHDBaQVZJqSY
 Dzhg==
X-Gm-Message-State: APjAAAVCc8hRmZFZsroFABhm6kkhmXT7xZWlKyXM7bLNM14o0Y81rhUZ
 Jfqy2KJz/nJ425XJX0bjXg8RDZxg7Wf6D2GjTAQ=
X-Google-Smtp-Source: APXvYqzxzS8dq2oeCj0Ox7Oa7XqY4LQznCn/AdJdJKc6g+Oe2HAtFkBo3pDtnN6XYbg6cHbl9IsBMP9j/9MxRCEsLFI=
X-Received: by 2002:aed:3baf:: with SMTP id r44mr161628qte.255.1573606132783; 
 Tue, 12 Nov 2019 16:48:52 -0800 (PST)
MIME-Version: 1.0
References: <20191112064058.13275-1-joel@jms.id.au>
 <20191112064058.13275-5-joel@jms.id.au>
 <87e0a727-bfd5-a485-e986-e26fd4cccfef@kaod.org>
In-Reply-To: <87e0a727-bfd5-a485-e986-e26fd4cccfef@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 13 Nov 2019 00:48:41 +0000
Message-ID: <CACPK8Xd4wePHdeAVstq=JsrfV33QtBXVdhEAZDrQPcQRs=PAHQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] watchdog/aspeed: Fix AST2600 frequency behaviour
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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

On Tue, 12 Nov 2019 at 07:56, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 12/11/2019 07:40, Joel Stanley wrote:
> > The AST2600 control register sneakily changed the meaning of bit 4
> > without anyone noticing. It no longer controls the 1MHz vs APB clock
> > select, and instead always runs at 1MHz.
> >
> > The AST2500 was always 1MHz too, but it retained bit 4, making it read
> > only. We can model both using the same fixed 1MHz calculation.
> >
> > Fixes: ea29711f467f ("watchdog/aspeed: Fix AST2600 control reg behaviou=
r")
>
> which commit is that ^ ? Did you mean :
>
> Fixes: 6b2b2a703cad ("hw: wdt_aspeed: Add AST2600 support")

Yes. Thanks for catching that.

