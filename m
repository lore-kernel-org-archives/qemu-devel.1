Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3973AC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF71F20665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGKuxA3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF71F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3Vh-0005Wf-0n
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:06:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43944)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3CR-0000Rs-J8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3CM-0000cm-BO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:46:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3CM-0000aH-5q
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:46:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so14851084otl.11
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qdHe1Oq31yOCoJucMHjaFTskKr5Q9qYwy1X0y0ls4Zk=;
 b=FGKuxA3VCsBF0S6UcpVcZAHhaC0+LnF0JyfB6jC5gOv5jo03vdWZCwgJ0OTlBK7SoD
 3Gt0JtkElS7/8OZ1nQKcQiyBrKQUj7am8S78kTZNTJCl0XRSPebo9LPHqiKy/OesHbpI
 HIhudEvZrHFaxOOTvw46yqbajIvZW8X4GBjC/OpMJZhk8W/Cpg7SOrDuK38nG5epQ5Al
 wGMMj9et0tJjLnOLlOdcNX4qYrClDAykj+G3fy9diH/xQrrM5lVQPc2eVOQFy5aF7ytr
 ds5Q+QgGMFFdigCli+TtwYCU0pgwmxQnNRpPKtN8+LFWDTiZB6ThjhqdraLyFjhlG95S
 +Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qdHe1Oq31yOCoJucMHjaFTskKr5Q9qYwy1X0y0ls4Zk=;
 b=leGEGDUnJ+YBarJAUouaUPk1c9AcMilB9CGyrYdQiLJQjtDhEo/TMMLjeFmdsXaiRX
 5bPNO6HkFdTORBcCihSUWuMeFC7Lf1FHx7TvQ/lwNwkuwPtEKfFdOv/GfcAhnhTL6kKD
 7ttI/HxmHpTRiTjsN55OCvRVt5XkdcN1Cvns7kkjLszBQiTvl91e4ZWehOB+nYjAWvuE
 BDbptsuximYUoiMEr4b9QN/aIhZd0i1k4tP7e8puIQhr+vhjS5ZguDgiENK6vCYSoWi0
 jE/J8lQT9smeDVTLox70LTIPh0+N0FB0tGrSOaxX2ZEIY6u6SOiXDYHnQ9ABXJh02aP2
 QCwA==
X-Gm-Message-State: APjAAAUSQaXnMsOtOrij4eT4TYPicJPJEyvb34kFdDVq7VWoD+6lAKr5
 VCiSsM8ilF/W6+pihxz/XDpcpjh2JjR1/f6b971GzCf1PzA=
X-Google-Smtp-Source: APXvYqxvG+XgAb/dhjKArhkj9+8hEMBYMCv00wjKzN6H74PZMavXFU6B9vuTro5F2ksko30qqkQvuDc47iq0lVgnnHY=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr21342636oti.91.1562004661433; 
 Mon, 01 Jul 2019 11:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190627124815.29536-1-minyard@acm.org>
In-Reply-To: <20190627124815.29536-1-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 19:10:50 +0100
Message-ID: <CAFEAcA_YcEtXDMR-7D4R0Tdb0zM7LARpisvV5VjTnoki=9_WPw@mail.gmail.com>
To: Corey Minyard <minyard@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.65
Subject: Re: [Qemu-devel] [PULL 0/2] Add a UUID device property to IPMI
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

On Thu, 27 Jun 2019 at 13:48, <minyard@acm.org> wrote:
>
> I believe we are not in softfreeze yet, and this is the only real
> fix I have for IPMI at the moment.
>
> This was posted Nov 2018 with little commentary.
>
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/cminyard/qemu.git tags/ipmi-for-release-20190627
>
> for you to fetch changes up to bddef5881d0c935a5d9d8e15f822d9d700666ae6:
>
>   ipmi: Add a UUID device property (2019-06-26 15:31:33 -0500)
>
> ----------------------------------------------------------------
> Add a UUID device property to IPMI
>
> This is fairly important for two reasons:
>
> * It allows a BMC to be created with no UUID, returning an error, which
>   is the behavior of many BMCs in the world.
> * It lets the user set the UUID to a fixed value.
>
> Some software using IPMI will get confused if it gets different UUIDs
> from what should be the same device, which is what happens now if qemu
> quits and restarts.
>
> ----------------------------------------------------------------
> Corey Minyard (2):
>       qdev: Add a no default uuid property
>       ipmi: Add a UUID device property

I have to say I'm not entirely happy with applying a pullreq
with patches that are unreviewed and were last posted on list
over six months ago. Can you post a v2 to try to solicit code
review for them before we put them into master, please?

(Sometimes patches don't get review, and we generally take
them anyway; I do that myself from time to time. It's the
combination of the six-months-since-patches-posted plus the
imminent freeze deadline that gives me pause in this case.)

thanks
-- PMM

