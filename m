Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79F8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A262071E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4QVVfvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A262071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZGeA-0004IM-62
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 11:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kZGcF-0002rp-4R; Sun, 01 Nov 2020 11:54:04 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:38924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kZGcC-0000Aw-OQ; Sun, 01 Nov 2020 11:54:02 -0500
Received: by mail-io1-xd43.google.com with SMTP id p7so12621239ioo.6;
 Sun, 01 Nov 2020 08:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q3vjChWvWe7JinD45TCoP7FFNdaFMlLd4eBLL6s1YZs=;
 b=P4QVVfvYOh+A+ls9yYosDg+hdKvJIc2KcrsMr+Rn4qKyYkeoBDbmD0gaGGVeSt5XaM
 94LUXH8C701r1X4WCYE9ZOaKFHQRIcnwUgzMtYZd1G3JGnh5oLZPHHgWsDoRiu/cHJje
 MBSoQIz4ULYLiQH33GRnR9PZIU3fQRMkWOgHz8uH3Me7EKCXeNdG0HyLIleYcwaeatGv
 jEDewFdBoqxOL5fuXa0TMY4iKUHm0BQJ6Y2FPvz3OHfHkbx4SkT7tOVskq1DgvSJBDHK
 z9Vj6oDMcOJGy/hi1871rE9krxDK1OiNGarW9UzSW5dtCedhh7o+mjOf6X4nNGC5TxI8
 FkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q3vjChWvWe7JinD45TCoP7FFNdaFMlLd4eBLL6s1YZs=;
 b=kVaJG1+0aC2qX1co2suu51WBrWz19thnerRQuANhPvnFAtIIU2XQRM4m6YrSqsL/d5
 TrqaEn1tqAZXtqZraTwV1ERnBpywAFgZ+jvyjlBkHjWnYzoV9OSew4uyffVLPaUG6mde
 eRZpLXmmrI29KtfUIC0yPvREM6cZWDRvelBC4izBFYdyVgrz5oRCQzrliC6p9dh4gaVA
 4GpPaWzOoynO0iv6ciYpdnfMoPuISj6QMA3FtYLwEYuTeFixghcjz8V9rl6kb9d7W4a2
 OAB1PAnT3drpVjVKcuFL1JBro4uWTagc1WGYNYWeEYyCqPUT29Irq+GS3dVYyU+6nFeg
 UBlw==
X-Gm-Message-State: AOAM532y9sCzjeItS4vGapIPUVzYg/Bj2vMml0bF0cZH4tzKDLjnRAHc
 oloCXUajaYDdGAguoxQWliCrLj8main2okaH6mY=
X-Google-Smtp-Source: ABdhPJwtHsXn7S+W4lJZU1b0cGMcTk2i8UYwDgzqvF6yzso2hM8ZZGyZuyHpJA+JjEWGyhXp7AOJT+WnLxE2SELFbRs=
X-Received: by 2002:a6b:b30b:: with SMTP id c11mr841696iof.175.1604249639286; 
 Sun, 01 Nov 2020 08:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20201101163753.15059-1-bmeng.cn@gmail.com>
 <CAKmqyKMSzNSSOoDtR3w2G-T+AhD6oqSy=9q7Vitvb_VtO+zX2Q@mail.gmail.com>
 <CAEUhbmXjjWM4bfv+DdDSKs6aXheY=91Bvg1P0E9SyoNPrQ3btA@mail.gmail.com>
In-Reply-To: <CAEUhbmXjjWM4bfv+DdDSKs6aXheY=91Bvg1P0E9SyoNPrQ3btA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 1 Nov 2020 08:53:32 -0800
Message-ID: <CAKmqyKONRcbPK7d6uaCxb=DpY_RZFkcuPrDB6OoEnJtLJd9CDg@mail.gmail.com>
Subject: Re: [PATCH v3] hw/riscv: microchip_pfsoc: Correct DDR memory map
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Bin Meng <bin.meng@windriver.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Nov 1, 2020 at 8:51 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Mon, Nov 2, 2020 at 12:46 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Sun, Nov 1, 2020 at 8:42 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > From: Bin Meng <bin.meng@windriver.com>
> > >
> > > When system memory is larger than 1 GiB (high memory), PolarFire SoC
> > > maps it at address 0x10_0000_0000. Address 0xC000_0000 and above is
> > > aliased to the same 1 GiB low memory with different cache attributes.
> > >
> > > At present QEMU maps the system memory contiguously from 0x8000_0000.
> > > This corrects the wrong QEMU logic. Note address 0x14_0000_0000 is
> > > the alias to the high memory, and even physical memory is only 1 GiB,
> > > the HSS codes still tries to probe the high memory alias address.
> > > It seems there is no issue on the real hardware, so we will have to
> > > take that into the consideration in our emulation. Due to this, we
> > > we increase the default system memory size to 2047 MiB (the largest
> > > ram size allowed when running on a 32-bit host) so that user gets
> > > notified an error when less than 2047 MiB is specified.
> >
> > Is this better than just not supporting 32-bit hosts? Or could we make
>
> I am not sure if we have a general rule about discontinuing 32-bit
> hosts support, i.e.: deprecating 32-bit hosts at some time?
>
> > this number even lower (as low as possible that still works with HSS)?
> >
>
> Sure I will figure this out and set this number to meet the minium
> requirement of HSS.

Thanks, that's probably the best bet for both 32 and 64-bit hosts then.

Alistair

>
> Regards,
> Bin

