Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B5FC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA092081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r9YYpWRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA092081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40873 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMYNq-0004s3-BZ
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 09:37:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYMS-0003f6-RB
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYMS-0004lu-0s
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:36:24 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYMR-0004l3-Sq
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:36:23 -0400
Received: by mail-oi1-x241.google.com with SMTP id v10so4441806oib.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=y0XWIKWuLcmt/ZDnYmL6cnQJDiWz+6GEr3jPPs3mr1I=;
	b=r9YYpWRQGPMOwqGCbSqQPr1G8UcE7nEDBrR0GJt1HUS9q6a00BEsZmYUZFPTcuDJqk
	tF40xUuz/slFqLO1lBF30EfS/8NrU0baKhUBaskX2Whk9et0sHxRbxAOxc/Ejyx77Lyy
	tg4ctskjSPPMrqjd0yrZHtWGEI5mQdKKESEK+YPhC5ETVntcsGKCV5pUb6QCLorL7rf5
	XiZd63lrar3SyZH4eYfNG8mqOQUfnM5MgC/pY8Aw8TVt5kAwfDsnNU3qlU+55M4XTT6M
	r0H4dPHC/mlodqrlmKNK/Vpgp5UXQwu7hDIKns9RwlkQnpF3s9zBVA9KarEW3LQL+GDN
	TGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=y0XWIKWuLcmt/ZDnYmL6cnQJDiWz+6GEr3jPPs3mr1I=;
	b=Pq4LSAwIxRuAT8I9zA7QzcLUWnyG2R9eAQ1QdEAN/XOgsk83aBiqWPots22Aw/Owqq
	lIqak5sFHo3D3rB9DjmmbOq3XHFkiXa4jkvH0yx9NrBssp8bSnSplHXWO4zO/WKWaAn7
	8gp/IBfN52ndWo5XgybWfJc+Eb1ihPKePc67GKbBUJPT+9rer9MIZd9u5Xgn6CCOnXH6
	UxbaBm34Pc0ElojV47bx2tzjmsxh0zuO47OSJzdalU9ei5Ek1ROAx1VuWXrMocJtLgAv
	ARwpQN3YhXngKyR1l6tySzu6EughY/OpJoaw2D2ApgZw+ZTX4RGQghHVMmFKgS4T0qqV
	kEvQ==
X-Gm-Message-State: APjAAAUINbKD0PyKeMirGhciBv546ReXLaKYGY8T1oy/Go54Lpj6fZTo
	wHnTh5eVmSn8Vx9VSXNkp23OxLcZo0sI7pnVuXLVLA==
X-Google-Smtp-Source: APXvYqxBJOjvw2gYxM8Oysui0+0val4x8sesGgTj8wPF1gyj+6vsc4KL+ILJFMyR4TKJFiBHxSRKweNrNo+dPNNGy6c=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr6238708oif.98.1556890582999; 
	Fri, 03 May 2019 06:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190430044036.1144-1-joel@jms.id.au>
In-Reply-To: <20190430044036.1144-1-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:36:11 +0100
Message-ID:
 <CAFEAcA9qyzHiEY-OudwBUDzCia-jSQ7CkY_L7oC0t4Nu_665uA@mail.gmail.com>
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v3 0/2] arm: aspeed: Add RTC Model
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503133611.kGGi-p2AbXVgKHRp6kzFckCj7FlWRLVDVxUe9baBY7k@z>

On Tue, 30 Apr 2019 at 05:40, Joel Stanley <joel@jms.id.au> wrote:
>
> v3: Add some commit messages, resend as v2 didn't send properly
> v2: Minor fixes, added vmstate and reset, and rebased on C=C3=A9dric's se=
ries
>
> Based-on: 20190411161013.4514-4-clg@kaod.org
> [PATCH 3/3] aspeed: use sysbus_init_child_obj() to initialize children
>
> A model for the ASPEED BMC real time clock (RTC). The model is sufficient
> for running the guest Linux kernel driver, and ticks in time with the
> host when programmed.
>
> It does not implement the alarm functionality, which includes the
> interrupt.

Hi -- I've reviewed this series, but can't apply it yet as
it's based on Cedric's patchset which needs a respin. If
I forget to apply this when I apply the respin of that one,
please ping me...

thanks
-- PMM

