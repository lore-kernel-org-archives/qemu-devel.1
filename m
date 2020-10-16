Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7AFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75DAE2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt01a2LV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DAE2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUIp-0004Za-3g
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 14:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kTUFo-0003kw-Um; Fri, 16 Oct 2020 14:15:00 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kTUFZ-0006vG-TY; Fri, 16 Oct 2020 14:14:59 -0400
Received: by mail-io1-xd42.google.com with SMTP id r4so5068791ioh.0;
 Fri, 16 Oct 2020 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dwb5ihYTqb/d3Z/kATsMaRbOI5NT+d9ZY5pwhqdx504=;
 b=Yt01a2LVoq9lmtuXrLzp3gC+qAIDpAUjtD/Dtz2yd821dYmRpPTHgHtNHcGwXTZaJz
 JB+I7KGc8HD8oJrnQ9kZDHvKyRpn5FSKe9hLTne+zsYURKZ33dsHT6sz6E4qAaRl04LS
 pwV+tegPOq+ynCYVXsWnchKmrzM7R5t/Oub17k2VfMocVHD6b8anQnB+SSOiMEQjQxRG
 zHauH78UJkAMS7ptzPrRgkeE4sLwyDnOxpSclZ9XR0gMJw3Cb8qTZUEhES609/kk+unq
 aKwOG65e0H8ORkPl7YatUrkm8r8+rNOJvgsyrdfdGDRvBdpz3JfasPVbCCjYDSwQftxc
 9prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dwb5ihYTqb/d3Z/kATsMaRbOI5NT+d9ZY5pwhqdx504=;
 b=AWZkmEHOo3og5AFFsvVYx3a8hT8wMd96xk1+8YihZZuRSvWcL3Ir1GJTCP0RYzNTEk
 sQZJ0n1Lk3UGKt+DxyalEQyV87xIuSDu442mBdyaIul97L5d7DIa5UOa9v2Du/OVIlEE
 egQ1r+XHDRuVxs6TKXZjK8rtWRgoxltNXaDzITRjrY0smHSpoqnG61Tdh9jAGbi0WIsZ
 ePAtaIsqwqa4hjdK7WKqH4iW8xdzxAAuPgiGkijHslXQobjrhvB1sBl4eX3ENKEM3j69
 nKH8BjUUS8zye/crcFrFHyUHfB11STNqFcNwCHardbh9ZxKj18Fb1TYKASHs/iwtxeWe
 6k6g==
X-Gm-Message-State: AOAM5325bouFKDk85TeXL5il1gpiMMprKxE53ijH2zQl9KrDe8sjFnqC
 W8tyuhF6KJZ1dxOzmmiAIYwdgYFkuRdorY8fMf4=
X-Google-Smtp-Source: ABdhPJyKzZyKY45eqJSmT0AgwdSvvnnDwTvKUdWOJu9jQJAg2TzgceLVpxoBZxLR1Tl5MgnOvm1YZGeI+7sr0ikloFM=
X-Received: by 2002:a05:6638:a90:: with SMTP id
 16mr3713868jas.91.1602872081497; 
 Fri, 16 Oct 2020 11:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <B96DF081-AEDD-470E-A99C-8A9536E0A8CE@hni.upb.de>
In-Reply-To: <B96DF081-AEDD-470E-A99C-8A9536E0A8CE@hni.upb.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 16 Oct 2020 11:03:02 -0700
Message-ID: <CAKmqyKPnnLHuTvosMLs+4A8QqR-XvuxgRU33c0f1Q92LJ_x8CA@mail.gmail.com>
Subject: Re: HTIF tohost symbol size check always fails
To: Peer Adelt <adelt@hni.upb.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 16, 2020 at 7:59 AM Peer Adelt <adelt@hni.upb.de> wrote:
>
> Hi,
>
> I have a problem with the RISC-V HTIF device.
>
> Every binary I have compiled for Spike on riscv32 fails with the following error message: "HTIF tohost must be 8 bytes"
>
> This happens regardless of which program I have translated for Spike. This is also the case with the official riscv-compliance tests, for example.
>
> The query "if (st_size != 8)" in the HTIF device always fails, because st_size seems to be always 0.
>
> To be able to reproduce it:
> - QEMU GIT Hash: d0ed6a69d399ae193959225cdeaa9382746c91cc (tag "v5.1.0")

I just checked with this hash and with the current master and on both
I can run a ELF executable on the Spike machine for RV32.

> - System: Mac OS 10.14.6 (Darwin Kernel Version 18.7.0)
> - Compiler: Latest SiFive Build for GCC under OSX

Maybe try using an official toolchain instead of a vendor fork.

Alistair

> - Command: qemu-system-riscv32 -M spike -nographic -bios none -kernel <ANY_SPIKE_ELF_FILE>
>
> Best regards,
> Peer Adelt

