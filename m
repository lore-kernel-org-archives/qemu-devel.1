Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96329CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 10:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC6920679
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 10:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGuCKCMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC6920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQqrX-0002sw-F5
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 06:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQqnB-0001Vu-I7
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 06:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQqn8-0004Ic-0r
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 06:38:00 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQqn7-00040t-Pw
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 06:37:57 -0400
Received: by mail-oi1-x241.google.com with SMTP id k2so10228896oij.12
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2019 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ii8JBGQ8IDHtTPb42tsT7pHzynIFjetvEE2jTkQp5io=;
 b=WGuCKCMDj6PyJqAApuYVUIJWSow8zyZobJyupJzV969MhUl/eKNZO1RH+d4/NEwVeB
 EI5885uL2AwXKehJdZ+ckKnVEYnf/Rbqky74i6FlgL87Y2ijiDCZR+XxIMQN7TjsBXz3
 XPWYLqM3BXGMeo294BHX7CQ8OWebGAJfMolwnsap8b0iUoGx9OaTfy54Zt9v3EMBBqJ0
 ZNEujAZPwygN4+lkP1eeUPk/W26/m7DG7HN9B4P/hFaPlZYmZEVX25gz8vB9Y/nswjWY
 l5PaqaYaZjYnY46APzn35IXiS4q0TOwvy7YZMT90HT1Z1EVRZC/23BrR4GbL3a1R3Eft
 am8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ii8JBGQ8IDHtTPb42tsT7pHzynIFjetvEE2jTkQp5io=;
 b=BUxH/7geTTSXCaJ5ukhDGHhytxuNNt3pXonLYHDH5++83bznNfqNpFmH2fxJfLnEaB
 TU7eWV1Xyl1QLEFC3AvgF94K48KejPesxGpcc/JR5mx3ZWhe74gs3nelAWhZqag6p1gv
 HWviuwlrN6dLWQT703nWrYO5oDg177YXBa/AOjLDIZARM6SEDuzfN/li/2IfNm+oU8Ni
 cUGGQFA5BJDRewKuJlAmtARxrQtIEVEOr2xWzDZ1g7j8RISaYt2JP6U1xdtz5+zTzcSg
 tSoq8+UKfSJiR/sNot3OrQi6XqTOfvS2b6QNmIBTZCxAndAgiSUTEG46/afy2TqFtWjF
 3whw==
X-Gm-Message-State: APjAAAUwwOC6s7zcoOFomlyjwo7iUZixwloI1DrOXiYedq1fC+Dz1982
 NwvaRzIz66cNZrQ3lwRYIrZ4CqDffnyuQGtC4CKGdw==
X-Google-Smtp-Source: APXvYqxJvHm9McNaYFIqZxFUy4JR7dNOyuTTatYkYhGknOUf5I1NNg38RbvNpsoQtRjXxpbdYr8nJ9U9yZfQnCMpGUs=
X-Received: by 2002:aca:4945:: with SMTP id w66mr3094705oia.98.1572691074432; 
 Sat, 02 Nov 2019 03:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191025042734.69244-1-anup.patel@wdc.com>
 <CAKmqyKMQz-OMFQRTdmpBpGMLiZ_ZM+UL5T5aAWZ5F1fC6vddOQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMQz-OMFQRTdmpBpGMLiZ_ZM+UL5T5aAWZ5F1fC6vddOQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Nov 2019 10:37:42 +0000
Message-ID: <CAFEAcA9bV=-t0+ro6rxu7Atodj6J78aT1aMnz9bjaqyfLDV3_w@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] RTC support for QEMU RISC-V virt machine
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Oct 2019 at 13:25, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Fri, Oct 25, 2019 at 6:28 AM Anup Patel <Anup.Patel@wdc.com> wrote:
> >
> > This series adds RTC device to QEMU RISC-V virt machine. We have
> > selected Goldfish RTC device model for this. It's a pretty simple
> > synthetic device with few MMIO registers and no dependency external
> > clock. The driver for Goldfish RTC is already available in Linux so
> > we just need to enable it in Kconfig for RISCV and also update Linux
> > defconfigs.
> >
> > We have tested this series with Linux-5.4-rc4 plus defconfig changes
> > available in 'goldfish_rtc_v2' branch of:
> > https://github.com/avpatel/linux.git
>
> @Peter Maydell this has been reviewed, do you mind taking this in you
> next PR? I don't see a maintainer for hw/rtc.

Generally devices used by a single architecture should
go via the tree of the maintainer who handles that
architecture -- in this case that's riscv. (The reason
is that it's only riscv folks who can test whether the
device works in the machine model, and only riscv
folks who can reasonably review whether the device
is the right way of implementing the functionality for
them.)

thanks
-- PMM

