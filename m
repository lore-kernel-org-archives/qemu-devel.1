Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF7EC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 05:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C27120BED
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 05:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="uBJdh4En"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C27120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN8YS-0003V0-2f
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 01:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kN8XP-0002Sp-Cz
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 01:50:55 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kN8XK-0005Y1-C3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 01:50:53 -0400
Received: by mail-oi1-x242.google.com with SMTP id z26so4135879oih.12
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 22:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=n9p5HKRqH3lWpcbVXdHz7U4jk6m8NJ0bELLmpYlme7I=;
 b=uBJdh4En8UbsL7dBLhID5N2+AqAyr+oYrfQVZCparL/ER8h2gGW7vhC5u6nN6tX16G
 1U0y5RUm72sQV72wqPJnpnZ5fAPChwq1NrWSEUZI9+gDJQH5SmzjV4CCyWtKb6Vge3zY
 66P9js4DOhN1QvbM1YOTZwSvIKlYGVFqYme2bjs6flEhbKZAxcbCtRXm8FZuN4qSwDQK
 ruQ11122ETbj9lfP865qHyJ3jmw3maMA2LUhsyEmDk4qCOJkFm8dmkQq5qpjOBlPohtB
 qJcHSJgzyFDv2dlAZZ212K4ZtfKQXYm8KkB04olW1zH5WqlUkwXFvYvOFlr5AP5l14G/
 sN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=n9p5HKRqH3lWpcbVXdHz7U4jk6m8NJ0bELLmpYlme7I=;
 b=ckQVSHhAxbxE8YPxkkXlO4GhYTRD7TFeE2A40uMwBL7+3aZ+rwlE0zpwRlu1zUvyty
 vSSN+LJQhU4UE00H5+91MfP/zFrrJ7ntFHPzRlwY6hPXMmD4B5s3lQEAB8CNaoNdmjXC
 1oVN5BaodW0TVG6ShBBGodyFoZgggXVy1Jp25IPv2kT/2VYLFfU3vFfaUKxjb/GytC7c
 MHRuiYSPMNRUp/2oT2VNVMFvudHsJbgEW6ijW1RVhiwnKR0K3cbWk2Tl1dj7QXFIyoFP
 HCUNuds/2dTUvTM3/bloPm7xsSectshjCK58np6hkvb2C/ZaoZhtGydWeWZUWCTHQXRe
 tquw==
X-Gm-Message-State: AOAM532/8CSIWeY7jUtYbyDZUTYMcgRXN1tuZPkxa+dvI5oxT1MzXgR7
 5GZFWfEVnGvgc4WfbcP0AeYLHbrYCdpo6P1Ut1PMTg==
X-Google-Smtp-Source: ABdhPJz6HH95qS36JpOjPyWWT8odWRSwg4cPnNqX3wWbI/k7bQt3WulVGZ3GtiQoW1g9M3l/AgCA8Un/7qQBAXlkDfI=
X-Received: by 2002:aca:bd8a:: with SMTP id n132mr1525724oif.100.1601358648123; 
 Mon, 28 Sep 2020 22:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200928061201.1601-1-wangzhiqiang.bj@bytedance.com>
 <d6cf7464-a0bf-2748-7e4c-732208881711@kaod.org>
 <CAH0XSJtDEPnf8qLNuT_Ev3TkGQw_68cZ5KGgY_aLBThMQwU9sQ@mail.gmail.com>
 <a4371d4f-0df1-fedb-4f1b-3a29dbeac465@kaod.org>
In-Reply-To: <a4371d4f-0df1-fedb-4f1b-3a29dbeac465@kaod.org>
From: John Wang <wangzhiqiang.bj@bytedance.com>
Date: Tue, 29 Sep 2020 13:50:37 +0800
Message-ID: <CAH0XSJs4kMiVMNzFZTYJseDjDO1PuwRs=FzAxMzAAs0SSJBeUQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] aspeed: Add support for the g220a-bmc board
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=wangzhiqiang.bj@bytedance.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?B?6YOB6Zu3?= <yulei.sh@bytedance.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Lotus Xu <xuxiaohan@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 28, 2020 at 6:11 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> >> Isn't it possible to add some default I2C devices ? temperature sensor=
s ?
> >
> > hmm, G220A BMC uses emc1413 as the temperature sensor. I can not find
> > it in qemu.
>
> Could it be compatible with the tm105 or TM421 ?

It isn't, I think. but I try to model an emc1413, so I will send a patchset=
 :)

>
> > I can't find an i2c chip that qemu has and that the g220a uses. :(
>
> Try to model them ! :)

Yes!

>
> Thanks,
>
> C.

