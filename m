Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298A6C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:49:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF69B2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6mlUHEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF69B2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnSVj-0007Ex-Sk
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 14:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37553)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hnSVZ-0006qT-C5
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hnSVY-0002Ef-CZ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:49:01 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hnSVY-0002CF-5a; Tue, 16 Jul 2019 14:49:00 -0400
Received: by mail-lj1-x243.google.com with SMTP id 16so20991833ljv.10;
 Tue, 16 Jul 2019 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L5ewNmFn3clEl2jzYQ78gGSrbLdHGHBMN7gMqIXwNr4=;
 b=r6mlUHEHiabYR/PDZ7HekTMFSwo/zADHy0cTw/2xuY3tVG92hppooxDUwrQwV0yJlL
 19R+3cuDeszR32Xmu9HIfZ6b4Y/Bmi0rQq4h+c6SYNJvEHViFUWWuAGTlXBu+PaG8mDo
 HxykQeoREVC2gbQ3gpbGtAn0S+sOUr8mr1JVXNA3nrbsWgioxpUZYbLv043hFM+MBBtH
 FkJj8zHoRIONyBAZKn9mGs5zHEVzCVXwb/2t3OA0Oww2XDHerYz61KYX9Rxd4EgX+wS3
 oud9VVZb9mCHv++Y6gE2WpVBIxZxpxu6e5kDvfTj2M2i9tk5D8KOHXVxQHCxQdXljbxC
 yl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L5ewNmFn3clEl2jzYQ78gGSrbLdHGHBMN7gMqIXwNr4=;
 b=YBXpQTJfoBG7DFAGuQMwXSZogMGRhiSQbplBQgOif8gWtwg5VIbciEGdOrKj0yuyqN
 ITAZDmgZO3B5VRgP7bNfWzh98WBprGj7dAoWF6NYHN163YWx4mjdaafUlEEAu72iInTg
 C4NwLslZi305kGFynAWEdQRt+QIQQJ8ABIKxS15qSabkGvlpnMd5QfrV/NDaTdX3yOT0
 +5yU2m8Un9QuPJu/pH6KnsqDwcC5E371FOHWXThLtj/b1JdBo1Tn/JdyeLJc4qdLKc6X
 GSpYEgrCpsHtPqVAwrVSRLj9gDl22CcPMRLCtwG/QCQWS28rJ8vutFi7myS0VFvzzWsG
 yxDg==
X-Gm-Message-State: APjAAAUC6dAqzjue93yrwyDScbhvfY10FVLkgxcz/4OFZI4NDjsA9V3J
 9ESZRmWoxtwyxjy4mHJPOxzk96JVpcIsynLB9H0=
X-Google-Smtp-Source: APXvYqwcNMIzEjmqeeQ3wB2TvmEdKfQrdmhEowSMFhlv48Yv4XUceyW0aMn64wPmyFa885MgFyKItHcIXGj65lAS5oQ=
X-Received: by 2002:a2e:9188:: with SMTP id f8mr18491413ljg.33.1563302936478; 
 Tue, 16 Jul 2019 11:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562803960.git.alistair.francis@wdc.com>
 <20190716135628.GA18691@stefanha-x1.localdomain>
In-Reply-To: <20190716135628.GA18691@stefanha-x1.localdomain>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jul 2019 11:45:38 -0700
Message-ID: <CAKmqyKOvH4FGEPxN1FSJGxxSrRWTegjnWaAgAcWLtPVeQKH8WA@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v2 0/2] RISC-V: Add default OpenSBI ROM
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Jeff Cody <codyprime@gmail.com>,
 Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 6:56 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Wed, Jul 10, 2019 at 05:14:02PM -0700, Alistair Francis wrote:
> > This series includes the OpenSBI firmware for QEMU RISC-V users.
>
> A mirror of the OpenSBI repo has been created here:
> https://git.qemu.org/?p=opensbi.git;a=summary

Thanks for that Stefan

>
> qemu.org hosts all software, including firmware, that goes into QEMU so
> that users can rebuild from source even if the original repository goes
> offline.
>
> Please use the URL https://git.qemu.org/git/opensbi.git if you resend
> the patch.  If this patch is merged unchanged I will send a follow-up
> commit to update the URL for you.

It doesn't look like Palmer has applied the patches yet so I'll send a v3.

Alistair

>
> Thanks,
> Stefan

