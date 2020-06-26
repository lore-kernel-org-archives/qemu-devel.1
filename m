Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D4EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A2B206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqguY54Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A2B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jotCV-0005lC-F0
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jot5p-0005nB-PK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:28:53 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:36773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jot5o-0007RX-1p
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:28:53 -0400
Received: by mail-ot1-x333.google.com with SMTP id 72so9509667otc.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uXD+8j0mSmONGAQEBtM4j2ZqesHLozj7Tl61qO1NF0g=;
 b=CqguY54YEBIrdlk1X3+prTUj2jtC1ChWLSjkH6RLGqaw0k8o7JX/xATyjYGfDoWkyz
 tts3D07hua7jJZ8CPiGwR6EXWTS91KzusuKfy8xGmURy0/CFX2Gu4yiiJ14OqCXK1GHS
 2h1jVmmDcSsNs7QA9KhnKT/FGhyPSZMgTlFsmi29ESHa6G8uf1Co2XrG0Bi6RDXVAKPX
 KOmW3yzoqIPXGDvTOfNuJmMWWJxohT8q7ClS1Al+nCKmBf0BIXVfjUCANgeMQf2yMFO5
 3jptEVUIW+sptEK4yUXlIwmOBNSkLWZ70gkJyl10CAiuc3lrAb8Q9IsjZfLfMZlPg8p6
 4AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uXD+8j0mSmONGAQEBtM4j2ZqesHLozj7Tl61qO1NF0g=;
 b=qY2lEWE5UQUIYSqGzFWVd7V2liz79s+u42lRneWsa84WZJCSgxk3+s6mYtUNlkbpZD
 m5KYQlkmH0++NsIwF2ZqSwjaz0opUHkK17SFkBpZzYqoV4tKKalpJH4KORqApE+VLkXw
 Nr14LuHCNUvjgts6jk/ioEgGz8B4jqbB4hzIpyDAFMmaISk3iRX/AK28z+bUp2cB9BgD
 D5KZskQjTn+PlfJekdKwNhzIujEKMPMJUc0+mEQWogxH03verK6VXk4vgICEpXIxebLp
 EdUGD0ZNU1SGnJKr8amp5yzg2XK3GlamR6JKF+2HHWeXliHACIq5Nyz48B4jYjd/56Rl
 +6xA==
X-Gm-Message-State: AOAM5303P31pxf6SRqaejzy+3POCyNn2z14bEMnQmtNWNIjrMYKVbJTS
 ZP5Mz2oQdMq2WEW+qrAyeEqSjvjfy4czcD7FX3RJeQ==
X-Google-Smtp-Source: ABdhPJz1FReIOmwJT7xOV11Q7ta+Z8kldwZgFvQdJUy2di5Khl2BN5/Gkbxiu7adAhH4uSWC/cXXpUPMmiymcS5fI2U=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr3576025ooi.85.1593196130434; 
 Fri, 26 Jun 2020 11:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200615204008.3069956-1-armbru@redhat.com>
In-Reply-To: <20200615204008.3069956-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 19:28:39 +0100
Message-ID: <CAFEAcA_EnwYq4je-_OQz22zpxeqcSjaZnP7ieN-CyHC3pJp2Zw@mail.gmail.com>
Subject: Re: [PULL 00/84] QOM patches for 2020-06-15
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jun 2020 at 21:43, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qom-2020-06-15
>
> for you to fetch changes up to b77b5b3dc7a4730d804090d359c57d33573cf85a:
>
>   MAINTAINERS: Make section QOM cover hw/core/*bus.c as well (2020-06-15 22:06:04 +0200)
>
> ----------------------------------------------------------------
> QOM patches for 2020-06-15
>
> * Make "info qom-tree" show children sorted
> * Fixes around device realization
> * Rework how we plug into devices into their parent bus

Hi. I've just noticed that this commit added new global-scope
functions to header files without documentation comments, eg

bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);

Please could you provide some follow-up patches that document them?
I don't think we have any hope of getting people to follow whatever
the correct new way to create/configure/realize devices is if we
don't document it :-(   [Concrete example: I now have no idea
how this is supposed to work after this patchset.]

thanks
-- PMM

