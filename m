Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745FBC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416E92082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQyTh9EA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416E92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1BLQ-0005UT-Bs
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 10:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j1BKo-00051P-CE
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 10:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j1BKn-00054w-F8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 10:50:54 -0500
Received: from mail-yw1-xc30.google.com ([2607:f8b0:4864:20::c30]:39296)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>) id 1j1BKn-00054Y-9p
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 10:50:53 -0500
Received: by mail-yw1-xc30.google.com with SMTP id h126so3607702ywc.6
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 07:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dOCR7tcu25txfw+Gge+2MKpyOiAxmLhi1Ars9U1SoPU=;
 b=dQyTh9EATIKSrhkqbAlM34dpFYi6fP1nhETtm7C06PekkEvCb8+F2FbU2+4Bq8mNlN
 +B852x0RqWBn+9c5MyZGpDO4yac8VOVuDKeH2G1HAY5liqowEWmZlqwvX6Q7AHFRpNQo
 FZMMRupPc3NIpxYs1sv4u2rEn6tSJv//trm3Oju5A87cGkr8T4bs6uMmmAGRS6nH3mRj
 w5psYJSqinRWx+qUMpMAVDpD7jYHSNS3cvDVOFzhp8oNNhWLF8Gkhi5uronmUAOVCw88
 yBgUqc8zxjZkbqMHn/f2uZEiHPHTU9cGAs+iqorMg847aU2+4LTXrYfMGpSy2ECPGIge
 HTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dOCR7tcu25txfw+Gge+2MKpyOiAxmLhi1Ars9U1SoPU=;
 b=gCxbNkec5Ifdkvq3GHGYTERhjYZcSxuwtp0nkSVr2PBygp8RJZxdBJvwG7NWzPBrUj
 O3gpss1DXZAH5ZeeCsZ35iV9hcUCwHjQO5HBfUqE30DR7dI0E+z6yEOR+GG7YUq/boSD
 5jqgcpBQpipP1I/jKvQ4N9+zFhpW1Vl9S10QQ3+AiyabQDM4zBpnxuTdf61oXBdRu0uU
 oq9+jDLytKAGLGNmcf9JRXcLe+CDTgv/keer/3/s+MTxJZJsOkEaO1LKYQKBh+xcRpKH
 4jy80ra2kLtgOzRCRxowew51rjfLbTI3DoS1o/UK/pGu/sfoQRXPcfdmgWILucQbmUnh
 ahsQ==
X-Gm-Message-State: APjAAAVSzsW7b4QvBElgjI5rMzLRx4uHRjAp/h1lzyQ/fPKp6AZP7FRx
 IkWqwUtqNtp3ejSroHX/SKaP8ftfyE0Z81Bn0f8=
X-Google-Smtp-Source: APXvYqzn2DYRpRC77ds7AbTzIZarJeGp+T+8ifsNOfTnUDb/NAazPKAzRGacU/xI93P3kGWh2qaDw5p532ZmfgJm3AE=
X-Received: by 2002:a81:8606:: with SMTP id w6mr1469377ywf.137.1581349850773; 
 Mon, 10 Feb 2020 07:50:50 -0800 (PST)
MIME-Version: 1.0
References: <CANA1cB+D-Uth0C-6qNE5HcAJkQeDsCbKqmYG7uHsLqbbofSsZQ@mail.gmail.com>
 <CANA1cBKtbYqnxnSacEK3sXOYM987J5+MacpKWHdKHwB5sk672w@mail.gmail.com>
In-Reply-To: <CANA1cBKtbYqnxnSacEK3sXOYM987J5+MacpKWHdKHwB5sk672w@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 10 Feb 2020 23:50:40 +0800
Message-ID: <CAEUhbmUsK7u9ubVH+4vidgQUDmO4oN5AdSUZPXiioMFgMHg-Jg@mail.gmail.com>
Subject: Re: Question: SiFive U SPI and SD
To: Nikita Ermakov <arei@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c30
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Nikita,

On Sun, Feb 9, 2020 at 10:56 PM Nikita Ermakov <arei@altlinux.org> wrote:
>
> Hello!
>
> I am trying to make an SD card working on the sifive_u (hw/riscv/sifive_u.c) SoC machine.
> As far as I understand there is no way to connect an SD card to the SoC with cmdline for now. So, I started to dig in to the QEMU internals and especially sifive_u SoC implementation to try to understand how I could connect SD card to this SoC.
>
> From what I understood I need to:
> 1) Implement SiFive U SPI controller.

This one is definitely needed.

> 2) Implement spi-sd adapter in a way like the hw/sd/ssi-sd.c

I believe we can just use hw/sd/ssi-sd.c.

>
> Probably I should merge 1) and 2) into one hw/riscv/sifive_u_spi.c source file.
>
> Could somebody correct me please if I am wrong at some point?
> I am newbie in the QEMU internals :)
>
> The purpose is why I want to implement this is to boot up the Linux kernel on '-machine sifive_u' and load rootfs from SD.

Regards,
Bin

