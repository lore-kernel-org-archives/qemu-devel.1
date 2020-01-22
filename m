Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C283C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1372A21734
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="qSvIhBuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1372A21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuEQV-0004tU-6a
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 06:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anup@brainfault.org>) id 1iuEPs-0004Pf-Fy
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1iuEPr-0004pI-7H
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:43:24 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1iuEPq-0004nD-RL
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:43:23 -0500
Received: by mail-wr1-x444.google.com with SMTP id q6so6873545wro.9
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 03:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7k2ypFBrwmfZ2ahfVNk76L1vuQSLBWj5UGD+mOuvoBs=;
 b=qSvIhBuZS7vYYfyAqzUABGR/5pc7i8BEK17d6yPKu1f7tPRE+5cybzYW7N/aMYPWAy
 NZDtpEnQ5yG+FkfYhmwVz0JyW1nmcfmkL+j0kcCVB1DNmmwtZJfU8lPlklik6nPK4wgY
 qzGoCQpFuR71Nxb9NynuAnEebIwZsQ3ODVYuFQRVmzW9LiIDNtWGCRRBA/ENkgos7WG0
 UHPJRF3eB+Zr2WcYBqg4wRO0vQFu0FKksjHx1WEYJrHmWvan9QGMLIkDL7Sr1VkYyJcA
 YinKnN0ppLBB4uBINSZgbjaNQRFmpWLyJ2JRKS0BTVBb/AnZzhsi4l/mpvF6zNXrAKQf
 qa3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7k2ypFBrwmfZ2ahfVNk76L1vuQSLBWj5UGD+mOuvoBs=;
 b=D3r5HYUAOB8pzlrBL/WehKKnXrCde911rZeGgF+SLhajyOnPi+nNn7yRNwRH027gui
 JgGVS9WpGVDWxbGuBfnyRzpQ6GrKVLeRK77epHyCWjZ19nguOJj6BeX8n3TAwSB7UX41
 JCKZrwOIGmQbbg2ei1P/mwSNFd8S60Mcs6yiuc63xQcuDBgYLa7UC5SLhtoHBpDQ4EwO
 QGAC5oCff9k0xFGYRa037M5RWtDWx18/I1omgenH/qq00zmw1LLQC6HylTWv+cJjiOg/
 DNrVZj5A70YuHxi8silb7vKBNxcykdq7c+4+K5OiBm6I1Hvq8IdK/dPFw9iyDDRG8OeM
 85pQ==
X-Gm-Message-State: APjAAAXkWjIGkekROCEk2CApWA6TJ8gP/ki+hqDA0xoJQAVBjzsPoqrK
 d9Y0KSlrNoDbrbLtLSm/jFOJNNnjnHDEFlbwBDQMPA==
X-Google-Smtp-Source: APXvYqybkzzsni15bc3C3i1WIxudCnHPSl3Y8UJt0H4ShaN9ynCkMyCRF+4tI1mWiT9uY6RX/bH6xsHHRvG/Bx35JKI=
X-Received: by 2002:a5d:538e:: with SMTP id d14mr11092411wrv.358.1579693400757; 
 Wed, 22 Jan 2020 03:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20191106115602.74299-1-anup.patel@wdc.com>
 <mhng-fceb5aa2-7610-421a-b350-d939ace5fee2@palmer-si-x1c4>
In-Reply-To: <mhng-fceb5aa2-7610-421a-b350-d939ace5fee2@palmer-si-x1c4>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 22 Jan 2020 17:13:08 +0530
Message-ID: <CAAhSdy2QAcRz42uHC+DvBZ5mrzZ8Drz59Ps3_TPKB-8EDeh-uQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] RTC support for QEMU RISC-V virt machine
To: Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anup Patel <Anup.Patel@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 7, 2019 at 10:22 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 06 Nov 2019 03:56:29 PST (-0800), Anup Patel wrote:
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
> >
> > Changes since v7:
> >  - Fix broken "stdout-path" in "/chosen" DT node of virt machine
> >
> > Changes since v6:
> >  - Rebased on latest QEMU master
> >  - Addressed all nit comments from Philippe Mathieu-Daude
> >
> > Changes since v5:
> >  - Rebased on latest QEMU master
> >  - Added maintainer entry for Goldfish RTC
> >
> > Changes since v4:
> >  - Fixed typo in trace event usage
> >  - Moved goldfish_rtc.h to correct location
> >
> > Changes since v3:
> >  - Address all nit comments from Alistair
> >
> > Changes since v2:
> >  - Rebased on RTC code refactoring
> >
> > Changes since v1:
> >  - Implemented VMState save/restore callbacks
> >
> > Anup Patel (3):
> >   hw: rtc: Add Goldfish RTC device
> >   riscv: virt: Use Goldfish RTC device
> >   MAINTAINERS: Add maintainer entry for Goldfish RTC
> >
> >  MAINTAINERS                   |   8 +
> >  hw/riscv/Kconfig              |   1 +
> >  hw/riscv/virt.c               |  16 ++
> >  hw/rtc/Kconfig                |   3 +
> >  hw/rtc/Makefile.objs          |   1 +
> >  hw/rtc/goldfish_rtc.c         | 285 ++++++++++++++++++++++++++++++++++
> >  hw/rtc/trace-events           |   4 +
> >  include/hw/riscv/virt.h       |   2 +
> >  include/hw/rtc/goldfish_rtc.h |  46 ++++++
> >  9 files changed, 366 insertions(+)
> >  create mode 100644 hw/rtc/goldfish_rtc.c
> >  create mode 100644 include/hw/rtc/goldfish_rtc.h
>
> Thanks.  I've updated the patches on my queue, LMK if there are any more
> changes!

Can this series be taken for QEMU 5.0 ?

It's already 2 months since it was reviewed.

Regards,
Anup

