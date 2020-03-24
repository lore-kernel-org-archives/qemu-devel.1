Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82487C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAE9208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wBg4Lzin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAE9208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGfoM-0008PK-FJ
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 05:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGfnL-0007PR-Kx
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGfnK-0001Dh-5i
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:24:23 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:39423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGfnK-0001D5-01
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:24:22 -0400
Received: by mail-oi1-x229.google.com with SMTP id d63so17806114oig.6
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P+FTYtYCc0v//9HpuIDWmTomo5tHnV/rR+WSEamstoo=;
 b=wBg4LzinFeZfmLerO7pWIIbp9XWYmERKRxJ4m3LmrKpQgaMjMytCqVyngeRBwPrZXS
 /8WJTwty05swnER3wsuvcmHfB5Om+ZseNM0raade55a1jYXvpWPeM8HVjvGtNM47ledK
 eDgiuWgklCLVOYmL+IS4EIW3ac1AdVjGTWYLovwjuetbPtC9b/er8eyxzOdWAOw9KIYk
 hgVKNlHiuLl4QcAmurcIIJeFPVTtOsomxvIP9ZhB9ell3U1QxahLi+r4WkSRFGKxIBTe
 k7E3Jpe8Ky9ApAN8DQV33ITob30uSKtnnbrU0TNLExH/AEhI6pK/eQ0yjG1GgLOutDQu
 vJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P+FTYtYCc0v//9HpuIDWmTomo5tHnV/rR+WSEamstoo=;
 b=bzgkOualjwT96PesmWiJuQ40w9wItgwhv/VUtRH6PM6npD36+Wnib2QYOjbt/ZQgYs
 JeeJOB53F8x3Go1NWLusI+9tS0LO3PfmuWeLoyoHc3Lvmqn14MXz8gBFy33UCyHFpci1
 z525XhHiHgDfk4DCsdctPQcxtRQF4gyAFqZm73NugIXEFPdJL24ILB7dG8akoZ7kspLM
 /YVyb3OS8O+PpJgFUinnHQo2hzRr8RKVhlZ3CJ8SljxjbqeNksSJ9Mew/xECV6hEu5q2
 K7+8qm3Ik4I7ftXRWpP5sC4VpX/7H71uL9iMu6iD94Njoa8m5adskF5OUKcVmloQGia8
 3IvQ==
X-Gm-Message-State: ANhLgQ12rq7rkgDimTKqIV7GpBJkk+dmlCYIG/0z5cRNrAkPoT5wMZC7
 zQwMsai8XHPC1Uxjtpekmdc2tDN8h10v8dWDrDwZPw==
X-Google-Smtp-Source: ADFU+vuuuJrZq3grNap1obDAokaMnz4hjL2WubsN7kiZvngg1EfoSylIlUkKr42ElZRSvMS4xpCxEnYsmuTs+Hc743w=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr2593317oih.146.1585041860763; 
 Tue, 24 Mar 2020 02:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAGT9xrDKJQW6HV6OWDDck=H0bGzk=7ZTVn6tTfNnv=tH0sr1nA@mail.gmail.com>
In-Reply-To: <CAGT9xrDKJQW6HV6OWDDck=H0bGzk=7ZTVn6tTfNnv=tH0sr1nA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 09:24:09 +0000
Message-ID: <CAFEAcA-sY_H5s6j4ZEZ+SMvQgyENF+w+v5ajiJOhHDrn_zfjrA@mail.gmail.com>
Subject: Re: Potential missing checks
To: Mansour Ahmadi <ManSoSec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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

On Mon, 23 Mar 2020 at 22:04, Mansour Ahmadi <ManSoSec@gmail.com> wrote:
>
> Hi QEMU developers,
>
> I noticed the following two potential missing checks by static analysis and detecting inconsistencies on the source code of QEMU. here is the result:

Hi. Can you provide more details of your analysis, please? "Maybe
there's an issue
at this line" is not terribly helpful, especially if one has to follow
a bunch of URLs
to even find out which code is being discussed. All static analysers are prone
to false positives, and so the value is in analysing the possible issues, not
in simply dumping raw output with no details onto the mailing list.

> 1)
> Missing check on offset:
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L2728-L2733
>
> While it is checked here:
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L1748-L1752

What in particular do you think should be being checked that is not?

> 2)
> Missing check on bmds->dirty_bitmap:
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/migration/block.c#L377-L378
>
> While it is checked here:
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/migration/block.c#L363-L365

This one looks correct to me -- the second case is the error handling
path for "failure halfway through creating the list of dirty bitmaps",
and so it must handle "this one wasn't created yet". The first
case will only run on data structures where set_dirty_tracking()
succeeded, and so we know that there can't be any NULL pointers.
Why do you think it is incorrect?

thanks
-- PMM

