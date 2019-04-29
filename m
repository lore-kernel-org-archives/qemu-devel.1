Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC77C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70B920675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYUw8Bg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70B920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57100 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL5ZW-0004ut-R8
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 08:39:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5YI-0004Hc-2y
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5YG-0005VO-LP
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:38:33 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL5YG-0005V4-Fi
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:38:32 -0400
Received: by mail-oi1-x243.google.com with SMTP id l1so6273405oib.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=KRvoe4WuSn8P01PV0YYA68ZF0NjM8ZOtQFYrFWziLAM=;
	b=nYUw8Bg4liO0oh9/O33B48N93PC4OkIdVoxPEliLG0g8+xWP18vnvHWQfGycRyzz3T
	l92lvrV3pm7rrBR+YTsyZZBZ9LxEXJqOAiBzHUflvVtqj0uayWj/O2KwKyk3De7d6NfB
	Lm+xZ2IYT2cDHQGlTuSupr/hFwk5g3DjJLEt+nPk3QbbWBTsbdme6DBKc/dR69Ht+pst
	lh9NbzssZZJexU1vqQIKmQIYhRIC/B19e3T3Jt53hR03+SiybnOzBgoycM/jRJKk9R33
	NZPult5s9Rmz7TgSsRJX7CmFb9myXC709b/98d72q89+AtztzJ0NrWt+blWSN/sxmVLj
	BpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=KRvoe4WuSn8P01PV0YYA68ZF0NjM8ZOtQFYrFWziLAM=;
	b=P5SYJlnu6eWWXuCtnWpMzJ6mF7IMnmI/Uz8leG5IotHlsi+qdb1tFWowoSz0Q4F/jp
	tYzoYeauUBlnjft1xdVmVLFwPsmqcg6mme3p8GL+lBsp/l5cYNiq3eCWovo6Ti4ynHB1
	YAkKRdBk/diq2eoGCGCjVBNwc/mf7d+DCrFwkRBkF1i6g/Z74XxJF8qMFGRAJ507hMQ0
	2L9zqK6thk74bSK8gl0cDDcUjbzT9YqmOhq0+AQj0Bzqs4DRLZbLcqENaav5i/crOMN2
	UIvnI6A6liPGtuV0kQR2wliVN0w0HGKIrYiXgA5cZ+w5YHzrVXhN8YzXW4lZyGK20F5Y
	04Ew==
X-Gm-Message-State: APjAAAU5SFhcYoYgEHx1TGIVEPR9WsK5NgpGKTrhowdqoq4gORKQBlBK
	xoSCU5yz/bmegkRoPctFo+uTMrQ/HXQkZcMxUDTPuw==
X-Google-Smtp-Source: APXvYqxXLPTsKAp92rdXb5S+TEhVzexqeunz5kHxOuDAx7BXCb9TLgRjpth8LgzEbDoPKRgehkXjVt7wZ/cZ2TY7rP0=
X-Received: by 2002:aca:4c88:: with SMTP id
	z130mr16021281oia.170.1556541511494; 
	Mon, 29 Apr 2019 05:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <1554321185-2825-1-git-send-email-sandra@codesourcery.com>
	<1554321185-2825-2-git-send-email-sandra@codesourcery.com>
In-Reply-To: <1554321185-2825-2-git-send-email-sandra@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 13:38:20 +0100
Message-ID:
 <CAFEAcA_CGqv+ORxyfDgAQyDhWuZaW3uOQyjqv5uiSppOHJi5_A@mail.gmail.com>
To: Sandra Loosemore <sandra@codesourcery.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v7 1/2] Add generic Nios II board.
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429123820.GEwBRiUKtQGnoqi7iidl56f_2a8c2zZRi1YtHV5VzKY@z>

On Wed, 3 Apr 2019 at 20:53, Sandra Loosemore <sandra@codesourcery.com> wrote:
>
> This patch adds support for a generic MMU-less Nios II board that can
> be used e.g. for bare-metal compiler testing with the linker script
> and startup code provided by libgloss.  Nios II booting is also
> tweaked so that bare-metal binaries start executing in RAM starting at
> 0x00000000, rather than an alias at 0xc0000000, which allows features
> such as unwinding to work when binaries are linked to start at the
> beginning of the address space.
>
> The generic_nommu.c parts are based on code by Andrew Jenner, which was
> in turn based on code by Marek Vasut.
>
> Originally by Marek Vasut and Andrew Jenner.
>
> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
> Signed-off-by: Julian Brown <julian@codesourcery.com>
> Signed-off-by: Andrew Jenner <andrew@codesourcery.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

