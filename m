Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE48C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8B9206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJiRQJjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8B9206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5tkK-0002Jv-LH
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i5te6-0005Cd-KC
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i5te5-0000V8-8N
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:26:02 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:46146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i5te4-0000Us-Vv; Thu, 05 Sep 2019 11:26:01 -0400
Received: by mail-ed1-x542.google.com with SMTP id i8so3015150edn.13;
 Thu, 05 Sep 2019 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6G0JlvMUrwOQNBgV7evwiXq6c4f3w/LLRYfXbU572Ec=;
 b=GJiRQJjX7U8labh1veRUnVA/9kuAgONqnX/GuwvBmhQWtDyNa6oaGWrJdhgEibnocD
 u37auTV6jZ8/2ClQfWsfKQa5+IKFaJ9BMBiWH3vsLF1NFpo9beLQwCJv773a9qnlw7bP
 qU4zuyhzXIPAmHJPlpjzuqgwZic4b8KF6OBGkn8/Jp4U+7D+Ro+3MATTsTVj+45YqIv0
 D74wpuy7alJ//kXkwknvZvlr86o5YFkSCHejSBrilJK16tommH0b704j2KcWg64OUHmH
 q64TOFl3jFilQGpnrQPmmngq+kh0aPsULcgX7aDFJVUsjPur9bJ7CVoNGDU2aE5xIc6m
 J+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6G0JlvMUrwOQNBgV7evwiXq6c4f3w/LLRYfXbU572Ec=;
 b=XTNmZD0YGYUvncV8GZe1XaEQ1CdBxSSvh+xv7nke33lJaVjeKNRCS7J5y1EtfKJaCN
 6qiRGI5CrVnWuukVpkK2pyqeYh+mqr7SRzqZ/DOhEEX3J+IoA6UVix8b4KUkCIoVRSoq
 HUIxDvSx2PiFghX0jGprahkMLDzv9WugM6F/pZg5LaMbNin/0E/IJkKZmbCpKQnqHrrX
 RNSkUBuSyIlu5SLXzHB1njGKaiuttBtOIR2lqD247PEVIBDw5+eVnh/cxD/wIYOPYZ+5
 W3txPC4lNqezCFBLhcLXSaWRGogCbA8sTCGI1iAiIpUiMMJdd5bFJfu4SCuizVa3s5T8
 9Xqg==
X-Gm-Message-State: APjAAAWCOGMPc0wGtB5pIiydhG1O6X13SEQabc788vBLmxKmreIAl9Sm
 P0wnC0fQkHu4WbybuxeGdkw1yBoQVjd9ScVIuKo=
X-Google-Smtp-Source: APXvYqzGvMG0hjy+jf1jc4MTlmKO7Nu0ii2P63ah/MwI+h/JLpgiEfG6y2o9fY/rEt/f17vJjQzZaX2xpLnQjT668yE=
X-Received: by 2002:a17:906:57cc:: with SMTP id
 u12mr3408238ejr.170.1567697159276; 
 Thu, 05 Sep 2019 08:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKNrBtZFEp3JCL0N5Kbw2f9cG6gu3YG+b9pTKaprHysjCw@mail.gmail.com>
In-Reply-To: <CAKmqyKNrBtZFEp3JCL0N5Kbw2f9cG6gu3YG+b9pTKaprHysjCw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 5 Sep 2019 23:25:46 +0800
Message-ID: <CAEUhbmWGHbBXO+NtkfxJc1tHNLKY_nLPKQ_L=MVsyuToZ02e9w@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v7 00/30] riscv: sifive_u: Improve the
 emulation fidelity of sifive_u machine
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Thu, Sep 5, 2019 at 3:50 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Sat, Aug 31, 2019 at 7:54 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > As of today, the QEMU 'sifive_u' machine is a special target that does
> > not boot the upstream OpenSBI/U-Boot firmware images built for the real
> > SiFive HiFive Unleashed board. Hence OpenSBI supports a special platform
> > "qemu/sifive_u". For U-Boot, the sifive_fu540_defconfig is referenced
> > in the OpenSBI doc as its payload, but that does not boot at all due
> > to various issues in current QEMU 'sifive_u' machine codes.
> >
> > This series aims to improve the emulation fidelity of sifive_u machine,
> > so that the upstream OpenSBI, U-Boot and kernel images built for the
> > SiFive HiFive Unleashed board can be used out of the box without any
> > special hack.
> >
> > The major changes include:
> > - Heterogeneous harts creation supported, so that we can create a CPU
> >   that exactly mirrors the real hardware: 1 E51 + 4 U54.
> > - Implemented a PRCI model for FU540
> > - Implemented an OTP model for FU540, primarily used for storing serial
> >   number of the board
> > - Fixed GEM support that was seriously broken on sifive_u
> > - Synced device tree with upstream Linux kernel on sifive_u
> >
> > OpenSBI v0.4 image built for sifive/fu540 is included as the default
> > bios image for 'sifive_u' machine.
> >
> > The series is tested against OpenSBI v0.4 image for sifive/fu540
> > paltform, U-Boot v2019.10-rc1 image for sifive_fu540_defconfig,
> > and Linux kernel v5.3-rc3 image with the following patch:
> >
> > macb: Update compatibility string for SiFive FU540-C000 [1]
> >
> > OpenSBI + U-Boot, ping/tftpboot with U-Boot MACB driver works well.
> > Boot Linux 64-bit defconfig image, verified that system console on
> > the serial 0 and ping host work pretty well.
> >
> > An OpenSBI patch [2] was sent to drop the special "qemu/sifive_u" platform
> > support in OpenSBI. The original plan was to get the drop patch applied
> > after this QEMU series is merged. However after discussion in the OpenSBI
> > mailing list, it seems the best option for us is to let OpenSBI continue
> > shipping the special "qemu/sifive_u" platform support to work with QEMU
> > version <= 4.1 and deprecate the support sometime in the future. A patch
> > will need to be sent to OpenSBI mailing list to update its document.
> >
> > v4 is now rebased on Palmer's QEMU RISC-V repo "for-master" branch.
> > Dropped the following v3 patch that was already done by someone else.
> > - riscv: sifive_u: Generate an aliases node in the device tree
> > - riscv: sifive_u: Support loading initramfs
>
> I'm having trouble applying this. Do you mind sharing a public git branch?

So I see Palmer has rebased his "for-master" branch against QEMU
master and now this patch series cannot be applied cleanly.

Even worse, the current "for-master" branch has build errors for QEMU RISC-V.

Regards,
Bin

