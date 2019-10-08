Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4037C47404
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 00:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD412133F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 00:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="GhmLdcO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD412133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHdEj-0007C7-00
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 20:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iHdDQ-0005sE-Fy
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 20:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iHdDP-0007Q3-BY
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 20:19:00 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:28172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iHdDP-0007Pn-6c
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 20:18:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1570493938; h=Content-Type: To: Subject: Message-ID: Date: From:
 In-Reply-To: References: MIME-Version: Sender;
 bh=uLHPZ3inYgR0ekzItq37zmHAjInrmkGiIU3vQZUyEGs=;
 b=GhmLdcO++05Xk1cSYAYntGn6q1upHiTsuEA2e+pKHsGoFe+jLwphLCaQb10xV7LKY2dbZVc1
 XMQDBIXpKZEmjlxar+/QUTQTAQ14NC9vcGEun2cPgFyRFAZ8KxCCkXANeKXT97ToJKoufdKZ
 PmKDr9T+PE5cdF07k0J1LcEDlkNUvvT1Czd3U84Mvr7tE5wp4ZVQZar//dPWIXryKq6XSsrt
 yZ1feYq0PVaMzIwtdpkJmht4XF1MAoQ2e5x7oDvObISM0RyTAgpI5U9MjmfZN4AviE7kJM8p
 8AP1MMsAyYQEfcpMuRvM9yTK8cRCNZ/F4fZC4Id/XUjRivVtvlLw1Q==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by mxa.mailgun.org with ESMTP id 5d9bd5f1.7f6d1d5f6070-smtp-out-n02;
 Tue, 08 Oct 2019 00:18:57 -0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id m7so15604050lji.2;
 Mon, 07 Oct 2019 17:18:56 -0700 (PDT)
X-Gm-Message-State: APjAAAXoTVYzzkyjJ7Lyb6KzGQ7Pxqlv80ykC2g0xzxmAoTHefClrxAJ
 ieJjO01NBYKZ1+GLdHSf8R/M2xl2chZHNcyWoyk=
X-Google-Smtp-Source: APXvYqzFYtKZZv/TUGaGywkZPnWF953fsuVfK9s8y2kUpkMLYZxv9t3rAX7U4uFbodaeBtYoI/hcVkd2JPtfIeUl7BQ=
X-Received: by 2002:a2e:6e04:: with SMTP id j4mr17463468ljc.99.1570493934970; 
 Mon, 07 Oct 2019 17:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191008001318.219367-1-jonathan@fintelia.io>
In-Reply-To: <20191008001318.219367-1-jonathan@fintelia.io>
From: Jonathan Behrens <jonathan@fintelia.io>
Date: Mon, 7 Oct 2019 20:17:50 -0400
X-Gmail-Original-Message-ID: <CANnJOVG2cwFtg64xmmVzTWHkLsxLcjshqkb59OhXbkt4mS8R6g@mail.gmail.com>
Message-ID: <CANnJOVG2cwFtg64xmmVzTWHkLsxLcjshqkb59OhXbkt4mS8R6g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] target/riscv: Expose "priv" register for GDB
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.61.151.224
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The first paragraph seems to have gone missing. Repeated below:

> This series adds a new "priv" virtual register that reports the current
> privilege mode. This is helpful for debugging purposes because that information
> is not actually available in any of the real CSRs.


On Mon, Oct 7, 2019 at 8:15 PM Jonathan Behrens <jonathan@fintelia.io> wrote:
>
> The third patch in this series makes the priv virtual register writitable. I'm
> not entirely sure this is a good idea, so I split it out into its own patch. In
> particular, this change will conflict with the hypervisor extension work which
> assumes that the privilege mode does not change in unexpected cases.
>
> As pointed out in a previous version of this series, GDB actually contains some
> support already for the accessing the privilege mode via a virtual "priv"
> register, including to convert the values into human readable forms:
>
> (gdb) info reg priv
> priv           0x3      prv:3 [Machine]
>
> Changlog V3:
> - Break patch into series
> - Make priv a virtual register
>
> Changelog V2:
> - Use PRV_H and PRV_S instead of integer literals
>
> Jonathan Behrens (3)
>   target/riscv: Tell gdbstub the correct number of CSRs
>   target/riscv: Expose priv register for GDB for reads
>   target/riscv: Make the priv register writable by GDB
>
>  configure                       |  4 ++--
>  gdb-xml/riscv-32bit-virtual.xml | 11 +++++++++++
>  gdb-xml/riscv-64bit-virtual.xml | 11 +++++++++++
>  target/riscv/gdbstub.c          | 36 ++++++++++++++++++++++++++++++++++--
>  4 files changed, 58 insertions(+), 4 deletions(-)
>
>

