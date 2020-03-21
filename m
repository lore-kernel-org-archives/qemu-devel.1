Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031F9C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 22:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A4520754
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 22:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x54J11Dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A4520754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFmij-0006vP-Sc
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 18:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFmhy-000671-Ip
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 18:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFmhx-0006P7-3i
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 18:35:10 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36742)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFmhw-0006Or-Ou
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 18:35:09 -0400
Received: by mail-ot1-x344.google.com with SMTP id 39so9746631otu.3
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 15:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qE42XWvgxD24BI8lQjYxSyZcGPy7xszUsV9/hIPzd+M=;
 b=x54J11DnKvGe7QNno+B7yoPf05obFGKwqHz8Yl82hP3pWGZOXj8SuHW5MMckXkUKOH
 9Trl9pTtLW1oqIY2ybDLyaflH25+YJCd/inn8Sw2IYhcdoAEFH6JDhN2Z58aCXawWBkv
 YQnlf/C3a6QkPaiqNYZmUKDqQcXBprMGk8/tCF8U6S/18FQ2bSJrRthf3NIJePB/TQwm
 psMkZF+kSGOZdWgjgyWF1RsT7FSoNQ2Ar6DOz/+bRX5IcDe7gUzz+20hEKJFn7c6/70u
 x7fqY6iWU4nxF4dLAYj3wNJ4V1PBuLsjh3vtv2d7ShBqryEBJqEA0o6kPc2cZUxfUry4
 6BWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qE42XWvgxD24BI8lQjYxSyZcGPy7xszUsV9/hIPzd+M=;
 b=NeAocC6MXmlgyv9IfETWZurdHWIvhOWealvhdyomZnPYN3Oemhg99x2NqO5Ydr3NCu
 zj3njlKJSjVt2GOFfeQBaQceUT2Ue7jMjFHMrh+JKLEh15N41ORbpmA/yMxU4QybsqyC
 2tOaUM4PYClE/gSLuN/NqOs8tJee/r3X45qSY4m8iNFkDfqMsT2wmOK445FzY9EXeboP
 kye3CnQBFCKuyN++JEv6Q7AXhKH4HZLfFgNF/bM4HThmXlPEoUkfSVhlebfx1pi8x0UH
 800EQES3nc2XWaoLmAqUT3OV3yJYRNNgCCWPdd+U+uzN1H3wMM3XvAhoKFInt0XcGW7K
 cq2w==
X-Gm-Message-State: ANhLgQ3KF9zVFjbAZLNyuq7b+YLT9UDpTS+bVb1tcMVJAaLyouC38wEU
 c8oxALz94xIu7ArrsiIha7PM3bVFeyR9KMIrYjHpBQ==
X-Google-Smtp-Source: ADFU+vv39tcXOA7PK6tNXU7aAcG2rlxfxM2ISJ+AMP0eiynPwZxFs/+09am3IW8bXn1GDrcVTfrjT8+H2XB6sHt//CQ=
X-Received: by 2002:a05:6830:20c8:: with SMTP id
 z8mr12521582otq.135.1584830107748; 
 Sat, 21 Mar 2020 15:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200321191311.31537-1-marcel.apfelbaum@gmail.com>
In-Reply-To: <20200321191311.31537-1-marcel.apfelbaum@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 21 Mar 2020 22:34:56 +0000
Message-ID: <CAFEAcA-8e=NLR=x-hXJX=YJZ69Jy0D1uLFW4yxFcRQDMPCQLoQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH PULL 0/4] RDMA queue
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Juan Quintela <quintela@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 21 Mar 2020 at 19:13, Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
>
> The following changes since commit 52a96afaa23d883d281bc7b95b9e69db7d6d3d3f:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pull-request' into staging (2020-03-20 16:00:21 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
>
> for you to fetch changes up to f93cfdc583d4c26b2a878642adf574e11909863c:
>
>   hw/rdma: avoid suspicious strncpy() use (2020-03-21 19:21:20 +0200)
>
> ----------------------------------------------------------------
> RDMA queue
>
> * hw/rdma: fix gcc 9.2 warnings
> * hw/rdma: eliminate data-path processing
> * hw/rdma: Replace strncpy with pstrcpy


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

