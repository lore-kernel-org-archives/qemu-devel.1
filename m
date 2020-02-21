Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758ACC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0D2207FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHLZduUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0D2207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j55RQ-0000dt-EV
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 05:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j55Qp-0008RV-Co
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j55Qn-0008M6-UR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:21:15 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j55Qn-0008Ji-HZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:21:13 -0500
Received: by mail-oi1-x244.google.com with SMTP id p125so1075255oif.10
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 02:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VkeHR2X7LWmDxA7o4sJuwqHGKBcc6KWoOwdHUepY2pM=;
 b=fHLZduUe22y1NVstwqWOpzckfi/QtH2t2pp0kHtfb4QAvFuDHQksUzFBFnqkjV2vPs
 cJnlaGSvLezoWxPrmHHM65deNpmt8vt78TsvGROl6rJXqNDdbFFCOO/vtE5/TT02x3oB
 v8vmI1UhZ0Sfjpue2neUY81XSm0U1IYnr8oT75U8O7e2BdMFJYxOFxO3fU9Tp+9fyNzW
 aLeQkbe2LDkWS0gDRRLaHRbY+GmhGg55De0Ix2Mb9aT3ner6CMbSIcE9fh7hSX+MM99w
 HWwc9O3JkJ4gcXhVDlMfe8NDfp8ffEnRr4YEDfrzf6i9HMKXeVqsXhzkBiVq7nxlIyGG
 6dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VkeHR2X7LWmDxA7o4sJuwqHGKBcc6KWoOwdHUepY2pM=;
 b=mFu+Puew5DQp6cBo2LTWrvMwKvorGRIoPDvC4Nzy4MAxzWNl/iVhu8/W9zq0uek4k6
 6Gz7lmbS04lMLnFZkE44jorTagEf5xJ/F4arD3edrB54KJTsJWmudETWarkwwlteg+dl
 8rTnalwbf9SU5wT/KwdCY/ODfJdQaphqVyd1J6C2QvfzX2WvFPtTfsA9g3gjnR08y5fg
 8+ECXsfT1lnNLQiidTfoxD2fBQIoypoGbhu4uzG85UoJeXZMpAqeUhYHCVgPkhG94+64
 GScgQCgK2qO8pMOGBmWeG57UzY+qEe2ys3aeq+eCi9Q5YI4tzmtotVYqkwGfYBGJk6wx
 qOLQ==
X-Gm-Message-State: APjAAAUrJSFy0sBa9yoZ/3MaqvZEqoQjuyuNpsmearGIqHA8SC7s/GYX
 HcEnIedawfQdmQ2H+2tCk6YIufAys67DebIEdqK/9g==
X-Google-Smtp-Source: APXvYqzSIe7urmytPKzvNWDY5ZbX3PV2EQU5vK1r578oNidWBceUk4l1QpQoyn2vDWqBic9b0f/BbKpqfZkic4IK1aw=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr1347955oic.48.1582280471747; 
 Fri, 21 Feb 2020 02:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20200220060108.143668-1-gshan@redhat.com>
 <f3c8adba729d050ba2144cc9c834fe82@kernel.org>
 <CAFEAcA8inLO75XOcCO3bUiiJQyZT+nqmp1be+z6ZtQx2a=68+g@mail.gmail.com>
 <fda602ae-43d5-728c-a5bb-f607f0acd3df@redhat.com>
In-Reply-To: <fda602ae-43d5-728c-a5bb-f607f0acd3df@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 10:21:00 +0000
Message-ID: <CAFEAcA-VB1t2XDuAHgq_p2Fz8NQ+3HFgyNOzRjk8BjixNJb0qg@mail.gmail.com>
Subject: Re: [PATCH] hw/char/pl011: Output characters using best-effort mode
To: Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Marc Zyngier <maz@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 Shan Gavin <shan.gavin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020 at 04:24, Gavin Shan <gshan@redhat.com> wrote:
> If above analysis is correct and the first approach doesn't work out. We have to
> consider the 2nd approach - adding option to backend to allow losing data. I'm
> going to add "allow-data-lost" option for TYPE_CHARDEV_SOCKET. With the option,
> a back-off algorithm in tcp_chr_write(): The channel is consider as broken if
> it fails to transmit data in last continuous 5 times. The transmission is still
> issued when the channel is in broken state and recovered to normal state if
> transmission succeeds for once.

Before you do that, I would suggest investigating:
 * is this a problem we've already had on x86 and that there is a
   standard solution for?
 * should this be applicable to more than just the socket chardev?
   What's special about the socket chardev?

I've added the chardev backend maintainers to the cc list.

thanks
-- PMM

