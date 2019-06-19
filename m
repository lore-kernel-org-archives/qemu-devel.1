Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E21C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 18:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C40206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 18:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0jVt/LB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C40206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41060 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdfTA-0000aC-6e
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 14:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34272)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hdfNM-0006ID-7f
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 14:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hdfNI-0007PB-5T
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 14:32:02 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hdfN7-0006Wd-NA; Wed, 19 Jun 2019 14:31:50 -0400
Received: by mail-lj1-x244.google.com with SMTP id r9so178703ljg.5;
 Wed, 19 Jun 2019 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=paIx1MKr5p+JfN/Ung7EX+r3ky7E3NP3QTTX1JKc308=;
 b=F0jVt/LB/MB+t3oOfRVqlcZ1rB3HqHXtaTsYN+5BU5LtxyqFKcrijhm7lsVE1BsQSN
 BP+bQ2EEvYIU4KufdHUW5XQOx/B64v4r+YxZSIdb84A/3AjYLFvesP3db5gULmoUJKhX
 7e6F7X3LfWYA3EdtVFzItQXkqLMEN9eaHp3YMGq+dxxiEArS9WzUNMvugSK0YrCu/ret
 lI3132BpZFQ586hJb0YApGy5QyZzHObDlw5ZRCNH/atQdLTekf6bSQcJatRbiU0HfSpS
 AhyWLq0klEGvLplY0F00+XdjzFXIxGguXWteYb3PQqCZgBKyIcQvI3aY9V2snVeV+/Lm
 Dhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=paIx1MKr5p+JfN/Ung7EX+r3ky7E3NP3QTTX1JKc308=;
 b=m1/5lyov8dOiMjbCjl/477vQd7oMYOofY0lh3+Zb4+FkP2MtIX1jTU703KBzNEbErJ
 loEJ/HmJsZmK1bA69w+6So4fn4nS1v6oOjzkma/AajdIfkH2yIwAjVc9zwc74Skz3oqe
 bDUcspFjaTCiq605y2rgRPw3TNCGXg1ob7AKj1MDf5e+KpyNUkSC1zM7BvqessURHAXq
 7EkSlVwdj/3hUo7kTst5ZOZnDOggBtHwqft+O6QOv4NMuypcWS3uY+KFfKHSfZh8eFs9
 5JdEs2uZ49QQQaCGuv5elDDHHho9szqfZkVwdCriKHKNhK1iPNxZhfYKle4+Gf0sORLd
 j2Gg==
X-Gm-Message-State: APjAAAWTv7FgSCFQ+eXkyLX/gwa5HwABbt5DVPQvJX7ucf3clHTeN7NJ
 GLPxBwoHsFMaqs5GqJuXxFQNwkD7q0KtpEcrEuNnEkoS
X-Google-Smtp-Source: APXvYqx6+u731AaiOqIJ4agXbR6j4fAJgE1/holsCYfc8yKwhdssj53/L3VrQY2OzapdElMrfqAxqM5xar2HpCc8OqE=
X-Received: by 2002:a2e:94ca:: with SMTP id r10mr8294674ljh.196.1560969035692; 
 Wed, 19 Jun 2019 11:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <2fd2fa66cf561d8041f75351c28ed025828c56ff.1560904640.git.alistair.francis@wdc.com>
 <CAAhSdy12uKV14cdxvUniSLFw_iF5WNKjoLCanS3Bs=33w-c9xA@mail.gmail.com>
 <CAEUhbmXYfdAojDtNxXz8XYRk0X1jt+qLB6oVP1pFKNcjWjeh5w@mail.gmail.com>
In-Reply-To: <CAEUhbmXYfdAojDtNxXz8XYRk0X1jt+qLB6oVP1pFKNcjWjeh5w@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Jun 2019 11:27:46 -0700
Message-ID: <CAKmqyKPSsFQw0xoeoP7376UpS6LWN1T5Kc53Q7tStZsgwKiNiQ@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [Qemu-riscv] [RFC v1 4/5] roms: Add OpenSBI
 version 0.3
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
Cc: Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 8:18 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Wed, Jun 19, 2019 at 1:14 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Wed, Jun 19, 2019 at 6:24 AM Alistair Francis
> > <alistair.francis@wdc.com> wrote:
> > >
> > > Add OpenSBI version 0.3 as a git submodule and as a prebult binary.
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  .gitmodules                         |   3 +++
> > >  Makefile                            |   3 ++-
> > >  configure                           |   1 +
> > >  pc-bios/opensbi-riscv32-fw_jump.elf | Bin 0 -> 197988 bytes
> > >  pc-bios/opensbi-riscv64-fw_jump.elf | Bin 0 -> 200192 bytes
> > >  roms/Makefile                       |  17 +++++++++++++++++
> > >  roms/opensbi                        |   1 +
> > >  7 files changed, 24 insertions(+), 1 deletion(-)
> > >  create mode 100644 pc-bios/opensbi-riscv32-fw_jump.elf
> > >  create mode 100644 pc-bios/opensbi-riscv64-fw_jump.elf
> > >  create mode 160000 roms/opensbi
> > >
> >
> > The OpenSBI firmwares are platform specific so we should have
> > machine directory under pc-bios/ directory
> >
> > So for virt machine we will have:
> > pc-bios/riscv32/virt/fw_jump.elf
> > pc-bios/riscv64/virt/fw_jump.elf

I have updated the names to indicate the machine. The pc-bios directly
appears to be flat (at least for binaries) so I don't want to add
subdirectories.

>
> And we should only integrate plain binary image for "bios" images here.
>
> pc-bios/riscv32/virt/fw_jump.bin
> pc-bios/riscv64/virt/fw_jump.bin

Yep, fixed.

Alistair

>
> Regards,
> Bin

