Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2702AC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06BF20896
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/ObEFUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06BF20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46287 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8LZ-0005Fy-30
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:26:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP8GM-0007W4-3C
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP8GK-0004cy-6z
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:20:46 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP8GI-0004Yh-7X
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:20:44 -0400
Received: by mail-ot1-x341.google.com with SMTP id f23so6068682otl.9
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Wopf8hU6TsTfqTMdfnTPZ5bB+FeVPl6R+Gkq3VzJWlM=;
	b=h/ObEFUATw1UEzkiYrCbF20g78PB/kwNEeT9OEiAePVZwtRJNhungmzsgrIVUzrVy0
	ehuv094NI3azKT0S3Bz2AkgpFOMPv8tOPUiwPcJwBq26Y6YdQiiCVFq/dbQnGbqIlDqP
	DxRgT85PqPxf3rhLK1H9d11wNOqZn+CVxbsgxlWJzMzSe+0sMDL8ZU3ghVvQ2GXNCgj0
	EzQFE2qVCQaXtpeGkXL9iu9iU627jtq5BYHPlreuh9fRkQJVOcKgDMdMf0WEzGp15ccn
	0VVIWrRtiUDF9PtTMTwK7vo6MYeWKeDdlE5SmQcb9ExZ05ZisQEjLiwLv+k/hDeA4y1A
	wLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Wopf8hU6TsTfqTMdfnTPZ5bB+FeVPl6R+Gkq3VzJWlM=;
	b=JericMMMN8Qu/faNWDL1wlZWe7472/LuW1xVtpzesE5HCsNUE6qKD9X1wp3swSh01E
	ytC/uTYeaUbk1SbfF/1xD2+4mZQ6CT5D9hl0sGRnYsXrlhSOOvBhreVsiPsiuabEXp1O
	nxXC5tSW/inNBjWH/r6GPz7Qt40gWNal1tHT+pzH9zGW8ONYw0bD/mvXTTveP5fefol3
	MNtPnBSZiLeiiK0eGQ9HteFSwMaJYXPjBspFRiQXUocY0bTIdvN4lNSHSetNAoW+dZ8h
	0mqMtzThKiBHHUKNj/Uu+Adkzo8/AjcYm10qPZ60VWuprJJ2ALA4q0PxibTndggio4I8
	c+UA==
X-Gm-Message-State: APjAAAWe4fb3quRfzzrfep+HN6U9tPGqumeODflLyIhxFrqNjyPZszCr
	aoO90vGfRWa0+9pflYeDQi7/NHX4t5VGnWjoiaqIVA==
X-Google-Smtp-Source: APXvYqzacugSYJlSXDBmg3k95D/X9c5iJ1LBeA2SKVTF+Ec1XkETVfzcjmmJYH6s0Cuw8LSlRH71FrZcYNDJPgnOQyQ=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr7348138otk.316.1557505241052; 
	Fri, 10 May 2019 09:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190510012458.22706-1-richard.henderson@linaro.org>
	<20190510012458.22706-23-richard.henderson@linaro.org>
	<CAFEAcA9uwaev+Q=BgLBz+fgO6C7VGmw4Nxcozg2vm6TOm+LJww@mail.gmail.com>
	<dd180f6d-27e8-2f2b-a7ac-ed1d8bbc9498@linaro.org>
In-Reply-To: <dd180f6d-27e8-2f2b-a7ac-ed1d8bbc9498@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 17:20:30 +0100
Message-ID: <CAFEAcA-wXNKoen0bn8a7D=GzsyM38F1uummVbfVQ=B8haswCDA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v5 22/24] target/arm: Implement ARMv8.5-RNG
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 17:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/10/19 9:01 AM, Peter Maydell wrote:
> > Don't these need to be marked ARM_CP_IO for the benefit
> > of -icount ?
>
> I don't think so.  There's no lock taken, as for mmio devices.  It's not not
> related to time, virtual or otherwise.  There are no possible exceptions.  I
> can't think of anything that would make icount care.
>
> Have I missed something?

If icount decides it needs to replay execution of the TB
which the RNDR access is in, won't it get a different
number back the second time it executes ?

thanks
-- PMM

