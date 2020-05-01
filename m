Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA59C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999C4208D6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjQmmWlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999C4208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUV2q-00088Y-Oo
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 08:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jUV2A-0007LH-Fa
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jUV29-0002S2-Nw
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:44:50 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:40891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jUV29-0002Rq-Ao; Fri, 01 May 2020 08:44:49 -0400
Received: by mail-yb1-xb44.google.com with SMTP id e16so2679893ybn.7;
 Fri, 01 May 2020 05:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xsRlVkBJlJhakWkDuVZgfHFIpNPM8qQVBZg9Sur4jMg=;
 b=tjQmmWlUQqEdshISfTQII09WGv+1yDcwTT1kjEUtD5e0TtxwAqPcN5FfdWq6WQuqQT
 gg6anBLFlxRxjiBjNKm6PZV6PhxhXaU0EGBeG4l1xxUEjfbcEIkmKRCzpj6JoU2i+4V6
 Lqb1Z8ZK+vgbL+UYi4p4HtwYi/zJIpY2Saky3k8iwkKK+KTUapLiFK9U14Dc4R4o3dDC
 3/lbloEV7Dz7CGse9Cprf1dZRoGkax6ON7ShtSfjI0hoGToawXLWRQrDbFX8NKLLKrYv
 tWaWYLaYNTlKHW+4nmHWVxx8QZHErJpLVFSoOeTPRtM6PsUgb+Ra8YtvxzawPTkYZhbS
 3brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xsRlVkBJlJhakWkDuVZgfHFIpNPM8qQVBZg9Sur4jMg=;
 b=HsYhy6GcEFnMVsTSuhCDM+yNWw4kK2imguHaBybLYq7na8xeGOSHTBdv1k5/ReYHe0
 eXaOUKfbh04tA9wreKAmv2RHBTvhOfp/QlK7+QPGU6Azbr0zYciGMtl1B7451UMoGDse
 4DCkFrDPDanoWfBeAdvCgr6AY7gwbBQWKYj53vjev90iCSw6Nj1D3PAX1H7yWuBER6dr
 JBUr8/KzgFPquZK3l64AWMO5VBE0TcQbOH41awIZuvtO+IhXeKKunYznEcV0aLjBO0ba
 VhSpHNnlt7xvf37f7A1lH7r2p7mMTwiDKo/isUItMYDeZO00rkeTU3Hrt0iMux/HoWv0
 xVsw==
X-Gm-Message-State: AGi0PuZjHC9cO1qLhX0HWyIQtb4pjJZBZB1oqAm6Y058KW6Sto0Cyuwi
 EhYKXiXUdtrRE6kbvzN1KU5CaDiN84QpGzqfOt8=
X-Google-Smtp-Source: APiQypIme1JYtLWA6YK9oDoS7WF14g4LFtuo5OI2EAAwWk9EOR/TVmlNT3Hi2I2ERefRN5QPSzXzGm2FVIhY6BtELAI=
X-Received: by 2002:a25:9348:: with SMTP id g8mr6269345ybo.239.1588337087953; 
 Fri, 01 May 2020 05:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <1588336185-1051-1-git-send-email-bmeng.cn@gmail.com>
 <CAAhSdy23Xrjfp4NxbwETsd6gG7mbhT5NOjFza6gpd-Rd=RbHEw@mail.gmail.com>
In-Reply-To: <CAAhSdy23Xrjfp4NxbwETsd6gG7mbhT5NOjFza6gpd-Rd=RbHEw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 1 May 2020 20:44:37 +0800
Message-ID: <CAEUhbmW6BxVoRkKiDn0eJ8+yYmufcs+ou5HvAbb=Ht06NjtiKw@mail.gmail.com>
Subject: Re: [PATCH] riscv/spike: Change the default bios to use plain binary
 image
To: Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::b44
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 1, 2020 at 8:41 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Fri, May 1, 2020 at 6:01 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > To keep sync with other RISC-V machines, change the default bios
> > to use .bin instead of the .elf images.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > ---
> >
> >  hw/riscv/spike.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> > index d0c4843..611a741 100644
> > --- a/hw/riscv/spike.c
> > +++ b/hw/riscv/spike.c
> > @@ -46,9 +46,9 @@
> >  #include <libfdt.h>
> >
> >  #if defined(TARGET_RISCV32)
> > -# define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.elf"
> > +# define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.bin"
> >  #else
> > -# define BIOS_FILENAME "opensbi-riscv64-spike-fw_jump.elf"
> > +# define BIOS_FILENAME "opensbi-riscv64-spike-fw_jump.bin"
> >  #endif
>
> This change breaks the console on the spike machine because
> HTIF emulation depends on ELF parsing.

I think we should add some comments here.

>
> Keeping here ELF files was intentional because BIN files dont
> work for Spike the machine.
>
> Also, now that OpenSBI generic platform is available. We can
> use same OpenSBI firmware binaries/elfs on virt, sifive_u, and
> spike machines of QEMU. I think:
> 1. The QEMU build/makefile scripts for OpenSBI should be
> updated to only build OpenSBI generic platform firmwares
> 2. The default BIOS_FILENAME in for virt, sifive_u, and
> spike machines should be changed to use OpenSBI generic
> platform firmwares.
>
> It would be great if you can drop this patch and instead do
> above two changes. Agree ??

Agree.

Regards,
Bin

