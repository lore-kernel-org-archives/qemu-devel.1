Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7E6C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E68207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrbJmc+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E68207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDu5G-0004yh-27
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDsYk-0004Qz-Fm
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDsYi-00004y-SF
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:53:29 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:47091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDsYi-0008W8-KQ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:53:28 -0400
Received: by mail-ot1-x32c.google.com with SMTP id f21so2620794otl.13
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3/G7m2otVF7Uqv/8c1hbtrQ7HI2pW3ujjKpfWAXO4NM=;
 b=JrbJmc+58j1RBNZerievp5HY2RXnTkG5QteFwJbQvXYOCdA9SpIl4CBdob2XgTEoJa
 qWopY+X4jhkVsHe9fauyt7WSOLX2qa5bCpX5hi1F/LWmg0hjAVaIPIw4nQol2rkdH2mp
 KTTQZRHegdXvUSN8vOrr7PlWmZ20HBTgcAhNe8Om933VHW+wSfHrjeu2swsVTkZDK/aT
 I6OIvPzGRC8EeBBKiUJ/nm/gWlrHgAZdWQBGnKUD1YO2aSBsjvKVevOBL7eQQ2rhg1/M
 tj0CEQ0mkbICFUWJsY8CQtnZ+hcqpOUJzJSUI7gR9e2W4WMX7PVREEFBG3/JRX+OuhVx
 6EYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3/G7m2otVF7Uqv/8c1hbtrQ7HI2pW3ujjKpfWAXO4NM=;
 b=M7JobV6kNygT+TXsHtR3muFGLQaQmSxRkOfpz3wrEIBD57GcTTknED8kfcWxnGupDm
 c4cBcLUaJYmF9tX4msLITA0k7OvEU8E3LFazVe4cdvumogvZE3rC5PYwThNR/6JOdZ7v
 HXmeryeg72Vp7ZDzNtcDVXksMHWbiDbG5i7VM51GDrWLk9iDB7CGD2GnG6w/2Bvqwx4y
 w+TvDyKOeVJnVJ57KaZNXe3X4gVf7wNAcV4HikvnZVYmzOqaSRXNfhubr37JKGMA5q8M
 jtS03z7g+x0r43RNz0vD2C/i9fuzakbwcfgjjT9x+U8nW5ToA2J0wbNco/4tfppuwv7H
 opKQ==
X-Gm-Message-State: APjAAAU6qEnrIH2jOuRvcdP1jzqvfXkfuMpUpIA5zXv1OAPTndA4KIgR
 RRxr9FGJiPVsibdQCZbyecOsuWm1H/qY7gP7k/DaTg==
X-Google-Smtp-Source: APXvYqxcgLIBTDsJMzb0AwJ8AwyE7K9anbHaT7j2YKBWjzz/chQXBN0nfKR+z5kK5IxBZnXMyDv8UK0K4XcAfZjvOAE=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr3625007ote.97.1569599607555; 
 Fri, 27 Sep 2019 08:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190926183553.13895-1-alex.bennee@linaro.org>
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 16:53:16 +0100
Message-ID: <CAFEAcA8xoku9RWdn4aqHV7Ln0FvdbA+eoGWFvobx2ZF8N0f_Dw@mail.gmail.com>
Subject: Re: [PULL 00/28] testing updates (docker,podman,tcg,alpha)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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

On Thu, 26 Sep 2019 at 19:35, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit eb13d1cf4a0478fc29f80abfbac8209479325f=
35:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2019=
0925a' into staging (2019-09-26 14:23:58 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-next-260919-1
>
> for you to fetch changes up to 80394ccf216da9ff48f23b9b8dab65ef809b7870:
>
>   tests/docker: remove debian-powerpc-user-cross (2019-09-26 19:00:53 +01=
00)
>
> ----------------------------------------------------------------
> Testing updates plus alpha FP fixes:
>
>   - fix alpha handling of FtoI overflow
>   - various docker cleanups
>   - fix docker.py cleanup race
>   - fix podman invocation
>   - tests/tcg: add float and record/replay tests
>   - remove unused docker images
>   - expand documentation for check-tcg


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

