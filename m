Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5D2C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 21:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82C52084E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 21:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg9QzQKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82C52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUdj9-0006tO-TN
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 16:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iUdi3-0005pJ-7l
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 16:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iUdi2-0008I8-8X
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 16:28:23 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iUdi2-0008H8-1x; Tue, 12 Nov 2019 16:28:22 -0500
Received: by mail-lj1-x242.google.com with SMTP id q2so80011ljg.7;
 Tue, 12 Nov 2019 13:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OkYIwG8iKsQTBiIO6UELEmwwXOJD4zlsIyx3im0h7cQ=;
 b=lg9QzQKr2PCiOwAY7GYPY+nyKufQXEAVBYLcntDQQHAWo+eMXuunk27kKfO3jbQqhb
 /lnDKUrsAjbGHV5NsTiF11ugZ54KH52iaxzVy/xLyGKbVu9liwLzsYG8xlkZNC0xX9Gs
 ScGGG9fEXNithZ3SQx9hew2dKCBcmfD5Ew9e+0MJMmHB/UKgVZAjU5adLkNoFna8HT1s
 8Ur71g0NC4GGOU8KGzW1xG1ZPkN6XaDmgN67n4Q4a5k8JoN71CP0NUHs1jejJQetCqC0
 MArs4LiKHtLoIQ4wH4qXlful+8FZkcsRgJu9i+eNfEGlJ+xUM9Sj1CtWTGxfkhQFu4+E
 oYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OkYIwG8iKsQTBiIO6UELEmwwXOJD4zlsIyx3im0h7cQ=;
 b=NktcUINfN5WoZk1TKCRR4iD4cvf5rFQTMqfydcVLKW6Jb4GWTMMa6gKOXlTto6NrA0
 wDTSu0A5+zKUudTcFfpm2yRor6kExfNvGUUZ8VifBQks+B5izRf/zAB6tOhj+7+u4g3Z
 ecRT0fidV/OCnZRdhwLb9NvgxJtbQzFyQLaxQGOkbIqr06iy/pTicQC3EtGDzZGAuFJm
 KiOyt5LP/zUeYW0x1eyz5coiNs2jupa9G0B+lcu4d0dR58IQDpfAELOomz6jU9FICRxv
 T1nWF4t3DifuI3Yi8pMa5UJZ5ebDBFGyV68MBEATHGqifHGCgmtWjgkzJdd/vSmMsWVU
 ENqw==
X-Gm-Message-State: APjAAAUT3Vgkt2970Esk8EvKm84WTui3QjWpEVuARm887bASeDK1Y9Wx
 JCYTAQPrfeP5TCMT3xxc00zavrN6VUOcG5s7e9E=
X-Google-Smtp-Source: APXvYqxy+dxpliykzlFUR/c/1ipzwKLRNcMO4rNgp/P+tVXUR3jZlnfggAFKO4xKmvOCCBF/R2EmXLmVWVJUbEdbkDM=
X-Received: by 2002:a2e:b54d:: with SMTP id a13mr22015874ljn.4.1573594098974; 
 Tue, 12 Nov 2019 13:28:18 -0800 (PST)
MIME-Version: 1.0
References: <03c2f42b32fb4e304319c241122ae83584f085e0.1573087610.git.alistair.francis@wdc.com>
 <CAEUhbmWaT06GAdz=d-oVtMsM6bOWR23bZjicgBsJLUHqaVRH7g@mail.gmail.com>
In-Reply-To: <CAEUhbmWaT06GAdz=d-oVtMsM6bOWR23bZjicgBsJLUHqaVRH7g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 12 Nov 2019 13:22:25 -0800
Message-ID: <CAKmqyKPqRqqf0kpyTQ6HvMrCRztyMhRKfupLqXAaXyUkHnaydA@mail.gmail.com>
Subject: Re: [PATCH for 4.2 v1 1/1] riscv/virt: Increase flash size
To: Bin Meng <bmeng.cn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 7:30 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Thu, Nov 7, 2019 at 8:54 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > Coreboot developers have requested that they have at least 32MB of flash
> > to load binaries. We currently have 32MB of flash, but it is split in
> > two to allow loading two flash binaries. Let's increase the flash size
> > from 32MB to 64MB to ensure we have a single region that is 32MB.
> >
> > No QEMU release has include flash in the RISC-V virt machine, so this
> > isn't a breaking change.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/riscv/virt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Thanks!

Ping! I really want this in 4.2. Otherwise we are stuck with a
compatibility issue.

Alistair

