Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949C6ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA5020854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5IDf6Q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA5020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK17b-0007ps-JU
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK121-0003z4-Th
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK120-0002xl-Jx
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:09:05 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK120-0002xR-Do
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:09:04 -0400
Received: by mail-ot1-x342.google.com with SMTP id k32so13895363otc.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xq5PnMBpf3Bmds+3iSe4apB/7mn77O6MbCBikiQoLLk=;
 b=A5IDf6Q2l5J2xI37TGU4sZjcsKVZCcRYPl21kYhLwK520y1IMzP9nrgYJ6rJooYWqw
 JfHuqLWI74Ndh+xsA0SDP/qIMM6jKTkzGnOws9AyGig6A/v7LCGUMIqpMYtzjolbRDSq
 ZKhcqV88eMOuwp/SGEUCKWzs1BiavOakouvgLMnAybZGETzV1I4GL/0hNHBimBaNk7AW
 PUQXsWJU0fDJbX7Ql52MqZYaweX/+EQKT2M9GxQpfAFMcWCB6uxnq98+Qs9MbPJmvlVl
 8wIXgeCfDjtbMv6+rsWrKo3kIxPP7M5fqgJkP4/XQCDo2AlfIz0GgchJEZSDKRixDuKx
 thwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xq5PnMBpf3Bmds+3iSe4apB/7mn77O6MbCBikiQoLLk=;
 b=TP4LUdHQzSlZpZMUKG4PDcs8B1zcIoudCF2Wn1/iVetDzs1Ysu4jdLCrd4CGWUlPW2
 OQ1uxfWCFt+Km/a5Gf4sPWxil5/NsZBWTEBfKawHQeD7FEYUQ/tnKfVXXIOZIFjobKsS
 lEKjUC9v/c4QqrjNU6MCXIMMZ+tqJltWHTdA2DQDPklSCw7czBncww6DVljzux2lrF+d
 V0V5wQPZm8HvZRQjGQayBMv1MfEXuMVg29Nh43A2inhlnWIEmecMFWLCKm/ma75Ffdz0
 JPWQj3wZT5U/qFC9gA3uyPzVC/LcYZNgI1nVrF5eVuELAiik+1vD+inhpfVWgRDguNOw
 ABUg==
X-Gm-Message-State: APjAAAX/taP85zPq8ZFEDxo/nYVBc3cJYj6RqQQj7iYfS67f1lMcGFyS
 j4wvrKxhGI5JX2uR6ul6iai1RMSaqRwKJ6nFjxyisITdnjA=
X-Google-Smtp-Source: APXvYqxvFE9WyGayTpakAiv+kX5MjwYVxQaG4G5fXuKMEoIK98Fo9RVlnPL96kVG1586rw2cjSM6Q7DO95GrMkt4grE=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr24894236otg.91.1571062143222; 
 Mon, 14 Oct 2019 07:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191010131809.1284004-1-groug@kaod.org>
In-Reply-To: <20191010131809.1284004-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 15:08:52 +0100
Message-ID: <CAFEAcA8tdhYm0EuVGx5OiPv7NuZvrtrPLnK+tz=xoJ0Gn4DCmw@mail.gmail.com>
Subject: Re: [PULL v2 0/8] 9p patches 2019-10-10
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Thu, 10 Oct 2019 at 14:18, Greg Kurz <groug@kaod.org> wrote:
>
> The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e72d:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-10-08 16:08:35 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/9p-next-2019-10-10
>
> for you to fetch changes up to e410bbc52a7a246858af54ce1842fadf26f39ff7:
>
>   MAINTAINERS: Downgrade status of virtio-9p to "Odd Fixes" (2019-10-10 12:36:28 +0200)
>
> ----------------------------------------------------------------
> The most notable change is that we now detect cross-device setups in the
> host since it may cause inode number collision and mayhem in the guest.
> A new fsdev property is added for the user to choose the appropriate
> policy to handle that: either remap all inode numbers or fail I/Os to
> another host device or just print out a warning (default behaviour).
>
> This is also my last PR as _active_ maintainer of 9pfs.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

Thanks for all your work on the 9pfs code!

-- PMM

