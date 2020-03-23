Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B54C54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7443C20735
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6x2girg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7443C20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGQXc-0003Zg-LE
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGQW2-0001ye-Da
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGQW0-0002Q9-PP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:05:30 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGQW0-0002Po-CS
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:05:28 -0400
Received: by mail-oi1-x244.google.com with SMTP id p125so15455135oif.10
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ikFFZPfWtROCQpS7Vaq1yREoqym/7V4OvIuMdogtm+g=;
 b=B6x2girgIB7dJC7q8I22jZXNXRl3nXWfMM/jvGvxiR0Vh/ghDXviya7BLIJE7Evaql
 nDZP5H2n/wCgrimrkWNV/rACOzEnxXLKWTGRsvDhaXjAAhvOC5IKEWabK6yDdRVSsboT
 bltI0lL8BClipC5KCNrxPky2LS1lVn31BI+8zQ/dBFeW9CZAGfSJRC1aG7tN0A5+7eCC
 IDJ9HTGZQoGNPD3FmxO78W8ohnbiURnEVZRxDom+2uS0yaWrTJgip9+Z2po3S98zB0VW
 UwPJhJcV222vDL4tLnnaYiRxeyZnqyBucg7mk83e3JpfkTuwbHdUbZYaWpkNA73c61TV
 IPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ikFFZPfWtROCQpS7Vaq1yREoqym/7V4OvIuMdogtm+g=;
 b=phY7+jLj3vgXbp+BHlrUXMql5M33c5sE0yMW+2/MYs94fY3IZ4x0IdFvCZoJ1wAefl
 OBKhRZgnKpyyrN0k3+AC+xwOD1Z6ULvzDIjIVXUvED1bkbw0mXrLVUzIc2hl1XoWG1C3
 fEPIgpQ++kbndEJLxGyVMR8zI4D2E1V+hcWBSQSwkrhrwzZlPAur7BM0tmZfXAg+qljD
 XUy8oHFrH+9oD8gQV/bnY2q41HUmcKev11A0huaYtBChPxgA21FSW/PVoM7oCIzvssNk
 GfvyN921OUT7UlL5DTeZ0kxPNY7fxvwCUMqQnXUTtm1oQRTazB/Loo4svxUVbsxBT2A7
 P1jA==
X-Gm-Message-State: ANhLgQ1XPf7EaolcameqQsBm+1nByJtmPzXtPzQ/UJAF2s3X2s9uoeoR
 gms2DsSo586WDhE8AI4h34Z4QYZPjhagnBwWEZC68Q==
X-Google-Smtp-Source: ADFU+vvjXjptN9bBnT4AuGIee+EzqUwcddad9geXvISTYHGIGXxZybdxjJBk2Sz/RmA98odcDMYHcALU5CNVf2zU170=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr237534oih.146.1584983127216; 
 Mon, 23 Mar 2020 10:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <CADUS3onjS+T-SSYC6ocKNm3oXsCpiQbDa0eJobhOnts3gZ_gEw@mail.gmail.com>
 <CAFEAcA8tU58_Bdpp7tmpF+X4D5zyxpV4pA-wz97EpP41SQ7sqA@mail.gmail.com>
 <CADUS3o=1XSzi-DdK2gNm4-WEwPsEWc8Tfn4j9Fxy92JAg9Lktw@mail.gmail.com>
In-Reply-To: <CADUS3o=1XSzi-DdK2gNm4-WEwPsEWc8Tfn4j9Fxy92JAg9Lktw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2020 17:05:15 +0000
Message-ID: <CAFEAcA94V+8qPyfMyvk8+F3_KpOG7sBcpc5DViDE+jZ1aEwA9A@mail.gmail.com>
Subject: Re: qemu-system-aarch64 windows binary run Arm64 defconfig kernel not
 working
To: yoma sophian <sophian.yoma@gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 at 16:16, yoma sophian <sophian.yoma@gmail.com> wrote:
>
> hi Peter:
> > Is it possible for you to try with a newer version of QEMU? That one
> > is a release candidate snapshot from before a release that we made
> > a year ago.
> With below qemu version, 4.2.0, the latest on the qemu windows download page,
> Synchronous External Abort still happen with the problem still hape

Hi; I can't reproduce this (Linux host) either with QEMU
head-of-git (commit 29e0855c5af62bbb0b) or with QEMU 4.2.0.
I used kernel commit 16fbf79b0f83bc7 (which is 5.6-rc7).

[...]
[    1.875186] io scheduler kyber registered
[    1.980486] pl061_gpio 9030000.pl061: PL061 GPIO chip registered
[    2.004922] pci-host-generic 4010000000.pcie: host bridge
/pcie@10000000 ranges:
[    2.007411] pci-host-generic 4010000000.pcie:       IO
0x003eff0000..0x003effffff -> 0x0000000000
[    2.009533] pci-host-generic 4010000000.pcie:      MEM
0x0010000000..0x003efeffff -> 0x0010000000
[    2.010493] pci-host-generic 4010000000.pcie:      MEM
0x8000000000..0xffffffffff -> 0x8000000000
[    2.013505] pci-host-generic 4010000000.pcie: ECAM at [mem
0x4010000000-0x401fffffff] for [bus 00-ff]
[    2.017734] pci-host-generic 4010000000.pcie: PCI host bridge to bus 0000:00
[    2.018963] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.019655] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    2.020104] pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff]
[    2.020578] pci_bus 0000:00: root bus resource [mem
0x8000000000-0xffffffffff]
[    2.024698] pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
[    2.038319] pci 0000:00:01.0: [1af4:1000] type 00 class 0x020000
[    2.039848] pci 0000:00:01.0: reg 0x10: [io  0x0000-0x001f]
[    2.040365] pci 0000:00:01.0: reg 0x14: [mem 0x00000000-0x00000fff]
[    2.041106] pci 0000:00:01.0: reg 0x20: [mem 0x00000000-0x00003fff
64bit pref]
[    2.041631] pci 0000:00:01.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    2.056259] pci 0000:00:01.0: BAR 6: assigned [mem
0x10000000-0x1003ffff pref]
[    2.057782] pci 0000:00:01.0: BAR 4: assigned [mem
0x8000000000-0x8000003fff 64bit pref]
[    2.058828] pci 0000:00:01.0: BAR 1: assigned [mem 0x10040000-0x10040fff]
[    2.059381] pci 0000:00:01.0: BAR 0: assigned [io  0x1000-0x101f]
[    2.096264] EINJ: ACPI disabled.
[    2.217421] virtio-pci 0000:00:01.0: enabling device (0000 -> 0003)
[    2.307843] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.338768] SuperH (H)SCI(F) driver initialized
[    2.346260] msm_serial: driver initialized
[...]

Your repro instructions said to use the upstream (torvalds)
kernel, but your log file says you were running:

[    0.000000] Linux version 4.14.128-00888-g15ac2b5e934a-dirty
(mtk20533@mtkslt1006) (Android (5220042 based on r346389c) clang
version 8.0.7 (https://android.googlesource.com/toolchain/clang
b55f2d4ebfd35bf643d27dbca1bb228957008617)
(https://android.googlesource.com/toolchain/llvm
3c393fe7a7e13b0fba4ac75a01aa683d7a5b11cd) (based on LLVM 8.0.7svn)) #8
SMP PREEMPT Thu Feb 20 17:45:16 CST 2020

which definitely isn't a recent upstream kernel.
Can you reproduce with an upstream kernel?

thanks
-- PMM

