Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6554C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D53920658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ryUkDDN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D53920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDpxd-0005eP-Rx
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDoNP-0003SR-6x
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDoNN-0008DK-Tn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:57:46 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDoNN-0007xZ-J1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:57:45 -0400
Received: by mail-oi1-x243.google.com with SMTP id r7so17466454oij.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 04:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4aAr0r//dsrscV+cuD6kmM3PBK2JtnP1KNWblajQrUw=;
 b=ryUkDDN8BZZ9z/VJ8tNPcA7U9GjxcQVnTBPxaUbT40eFyVmJgYmHtUgzE3vBhl8Zaw
 sAZqA8yL1SW6vKmvF4msQWhDJYSYSIbAh7R6XfRRtdYeStgzPC5CY4GEZeLa5YoZme3c
 dIVN7AQLS/M0JQg1JK1dD7HHBmyJxekbhJ61x9AmG7ywbzB9trSHlrmCFfB2Y3gr5N/G
 IuVgjUjgmPXvQNuN9z2rvYiREkHopOY21ibimR6aWP+dqyeasgGX5nOESzddBYYxdEYe
 J4XCpnvrR1bs9vwE2lbN9UW/9FVjrboUUmLw/Sy6/RpQ2z0d8LvdYJCgNBV5X6WrjPnU
 aBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4aAr0r//dsrscV+cuD6kmM3PBK2JtnP1KNWblajQrUw=;
 b=Dfu8dLEBKzJhz5PV7K5E43dGx7uOr+Pz7BMyvpohb2JzeQ16nrPMJRKKPxZf2FIcIa
 y2MDhja7TVzUnA2P9sXfoLba62Vtg9FTe/OmbPtihxO0s2BU/8QByJ4ngvCOJz8Zk0tb
 q8fEIKxb6pObB0+gnODwHG6ST3O/NOXPXqayOt7e0HjOV4dv9nLXvPMGV2tgq8tQiNRA
 MudOqlh4PMSQxSGU5Ab18D4px6ZN9bsvwOOyaArk7o7b4ZFXndmsMvWX3MtjITD2Xo2h
 K7yLF2pDpAreT2vM/yTbfFfLZKnebL2hPrwcEOyVDlFCINm+NweZ+dCI5drPDlvoc/di
 DSlA==
X-Gm-Message-State: ANhLgQ1274KdWIkHQYWxP89gfJDeHOCgg8f44pUMk30OLR+SKt2inyWi
 tQOPpUE5GehcKLgnwu9pWEpU7HmFavZ4JLZNFIGnSg==
X-Google-Smtp-Source: ADFU+vtq0ujzS9llKt3UV4ylR5vsw9qyIWTFrlw6XEyMeY13qjuqrLYgxDuz4yzL/s1q6qDJbTLstX5zSON8Qqfk5dY=
X-Received: by 2002:aca:190f:: with SMTP id l15mr6286589oii.48.1584359864632; 
 Mon, 16 Mar 2020 04:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
 <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
In-Reply-To: <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 11:57:33 +0000
Message-ID: <CAFEAcA8=3zcffu8FYEenyNR5O=kHh8OJmMCJj6Uwh5HJw_b-WA@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 at 22:16, Cleber Rosa <crosa@redhat.com> wrote:
> The quick answer is:
>
>  $ git push git@gitlab.com:qemu-project/qemu.git my-branch:staging

So I did this bit...

> Once that push happens, you could use:
>
>  $ contrib/ci/scripts/gitlab-pipeline-status --verbose --wait

...but this script just says:

$ ./contrib/ci/scripts/gitlab-pipeline-status --verbose --wait
ERROR: No pipeline found
failure

thanks
-- PMM

