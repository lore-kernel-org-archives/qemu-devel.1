Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B68AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A0120723
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exxtp1y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A0120723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZGaR-0001KL-65
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 11:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kZGZi-0000Xe-8p; Sun, 01 Nov 2020 11:51:26 -0500
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:44919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kZGZg-0008Or-Oe; Sun, 01 Nov 2020 11:51:26 -0500
Received: by mail-yb1-xb42.google.com with SMTP id i186so9633018ybc.11;
 Sun, 01 Nov 2020 08:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TvwOGeTjjb2PaZlQfKeMmu0yHoX8nIWcZqSeLKeyRa4=;
 b=exxtp1y0QK/0+T3PxDkJ4+IZP1etGkMzHK/aknZaqCVC5FXsDLZFGCguPqDgJPA2BL
 TDOmJecfEiuE5PqGTvuUF+dAAytUJ6tsBbJdO8TK8V94UanOr4U1d5kv9PjiE921i3Wt
 5LCOS9fZDcdBhHErsvyyo7I7PtE6tHNr/bbpANsfXqDWrNMlqBKSzEHql3YgSelS7cGQ
 0vXuLp5fIrBy08NLZRTDmDNI8Pid0lE3dE+eWuVn64fLaTOjBZMWApjgv3hAC/RJZtCd
 ZxPE9IgnwPrn7sbQ1i1OG2s3HMAJ9MxVq1TBUwfIoOTNDyapD5C2MmA0YvXWiJZ0Fd0/
 e73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TvwOGeTjjb2PaZlQfKeMmu0yHoX8nIWcZqSeLKeyRa4=;
 b=LxDfiXpFjQyjN2Tw64HjpV012uB7UrILkjCkv+6lRzmlQ1EV2SA2px0R872SZnTPAY
 diLo1XxHq7fffwx2o5KAQFEt44awKuvnvOekh8TgMPDMr2aEAJLDkelSbZRbGTDwHvi6
 gqJiw+0f09epIWXJ1x2hc7xRtoq4FkdjamDcxMAtZEmsxsEKBmZAwu6HFU3h3Y+PW4zx
 yZrCX9pkY57Lng9uMiKmKQKqSC6Htb/jgZZuN7XZgSTAtJXzlqRwyOHDWT+ClWYi9hb1
 90NYf7J3wC9jZbNjGh1oGlLMkAzAGHSS+y/+jO5fNSB5i9SewJLQ9/48SeRvnv6hZEDD
 EyWw==
X-Gm-Message-State: AOAM5334ilCYTg8IQvxJ7W/SWm54YmnnWqvTnRQyM9HNdAmYndepGKxF
 IwB5sZ94Y8gJZyFNy487aMHA0ZAzTWesPL0YIl8=
X-Google-Smtp-Source: ABdhPJwtAT02RuuWhfDUk119I/4QuBmpEzDhXnSp9nE4G/fIz+UUMdJU80QGGWb7Ft763OqAsKBI0Rx4/JNkLD0JcG0=
X-Received: by 2002:a25:bacd:: with SMTP id a13mr17608801ybk.387.1604249483439; 
 Sun, 01 Nov 2020 08:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20201101163753.15059-1-bmeng.cn@gmail.com>
 <CAKmqyKMSzNSSOoDtR3w2G-T+AhD6oqSy=9q7Vitvb_VtO+zX2Q@mail.gmail.com>
In-Reply-To: <CAKmqyKMSzNSSOoDtR3w2G-T+AhD6oqSy=9q7Vitvb_VtO+zX2Q@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 2 Nov 2020 00:50:13 +0800
Message-ID: <CAEUhbmXjjWM4bfv+DdDSKs6aXheY=91Bvg1P0E9SyoNPrQ3btA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/riscv: microchip_pfsoc: Correct DDR memory map
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Alistair,

On Mon, Nov 2, 2020 at 12:46 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Sun, Nov 1, 2020 at 8:42 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > When system memory is larger than 1 GiB (high memory), PolarFire SoC
> > maps it at address 0x10_0000_0000. Address 0xC000_0000 and above is
> > aliased to the same 1 GiB low memory with different cache attributes.
> >
> > At present QEMU maps the system memory contiguously from 0x8000_0000.
> > This corrects the wrong QEMU logic. Note address 0x14_0000_0000 is
> > the alias to the high memory, and even physical memory is only 1 GiB,
> > the HSS codes still tries to probe the high memory alias address.
> > It seems there is no issue on the real hardware, so we will have to
> > take that into the consideration in our emulation. Due to this, we
> > we increase the default system memory size to 2047 MiB (the largest
> > ram size allowed when running on a 32-bit host) so that user gets
> > notified an error when less than 2047 MiB is specified.
>
> Is this better than just not supporting 32-bit hosts? Or could we make

I am not sure if we have a general rule about discontinuing 32-bit
hosts support, i.e.: deprecating 32-bit hosts at some time?

> this number even lower (as low as possible that still works with HSS)?
>

Sure I will figure this out and set this number to meet the minium
requirement of HSS.

Regards,
Bin

