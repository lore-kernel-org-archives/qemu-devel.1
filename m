Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63F0C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 05:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A462A20665
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 05:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od/jOMJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A462A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54872 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heCKU-0005aj-UD
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 01:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37951)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1heCJV-0004cT-9R
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 01:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1heCJT-0001t9-P3
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 01:42:17 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:37144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1heCJN-0001jd-Ki; Fri, 21 Jun 2019 01:42:11 -0400
Received: by mail-ed1-x543.google.com with SMTP id w13so8285982eds.4;
 Thu, 20 Jun 2019 22:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S4C7FnR95ZDwDe3AyiXlTFD27Hv0dqjENvk3oIztgU8=;
 b=Od/jOMJx/xuiIqw01JXg6a3UIeIyr3SWT+9QGnbNH7Pv/sZOi6ifZpBLMUy0atS6yo
 MWJ3Z+XuWv/FvCdWhF3Ix/FLKZtKmazF2poaZI7fFCKQNgzx2OBAvqk2M/LjIPC/pr6p
 P1d/6cLP+hdVMPDovIFk17/B7xWslFsRDLgjTu/AOj74jJ8vJzmOIKq2GhXWLQgWmBvH
 ldakp8jsEYhwKOKUr2k1+GH673rBpHO48lNohUpDNVbXXYGIzobhpWA3RMARjtEM68Gt
 5G5ZHmANs7Tb703cplUA+C/ovD+2jqFPxKwG8yWkEMgw7RPNf5wUINHOb9CwMczi424J
 EaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S4C7FnR95ZDwDe3AyiXlTFD27Hv0dqjENvk3oIztgU8=;
 b=SSooIm7RAimkvhyPzSbsMgfj/j2dna4N7FrpSZPYVfjnhO0HMzY6IDZ9d6dn2+93/M
 vyc/s+SfqY5iOx4PPduQxlUzkDM7ZrGN+6gKkQDmFRLPVZf0IMKLIGLw4APO2s75jFx6
 LmIHUTJ6SKgBK50bwddRe8glOVvylqDk//57WHl62OQwm2+ThNbnVd0CQUZbQF2R1FhS
 5eUCMhYuyzf4ZSvIvcYi9iefgcP6X7pU+xKZMh3/Y+C9gtZ7B/PgR33s9bbqdZttsW/9
 RQD1wGjc4xlzYNahg74aC+knOe5Pk515zdTdHk0kPhHYSfpg1hUOgIxllq9f3YVjnNAq
 Qc7g==
X-Gm-Message-State: APjAAAVMG2fu3miS5yLrpzeiLIxjsVwTwR2lUgFmOQhDBsgK/4e54ls9
 P8d4iRGeHCRE793YTw3tp6vj31EdtL/UYYrvUzZtkw==
X-Google-Smtp-Source: APXvYqzHln8/OZqmjwm8fNKFEOFaK5dy1jWW0rcPH7n/uw6Hh25LUay3a18jtgohN4KCffYNhxcp3Kzl6uWZ7qijMOE=
X-Received: by 2002:a50:ad01:: with SMTP id y1mr120752856edc.180.1561095725612; 
 Thu, 20 Jun 2019 22:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <2fd2fa66cf561d8041f75351c28ed025828c56ff.1560904640.git.alistair.francis@wdc.com>
 <CAAhSdy12uKV14cdxvUniSLFw_iF5WNKjoLCanS3Bs=33w-c9xA@mail.gmail.com>
 <CAEUhbmXYfdAojDtNxXz8XYRk0X1jt+qLB6oVP1pFKNcjWjeh5w@mail.gmail.com>
 <CAKmqyKPSsFQw0xoeoP7376UpS6LWN1T5Kc53Q7tStZsgwKiNiQ@mail.gmail.com>
In-Reply-To: <CAKmqyKPSsFQw0xoeoP7376UpS6LWN1T5Kc53Q7tStZsgwKiNiQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 21 Jun 2019 13:41:54 +0800
Message-ID: <CAEUhbmVWYHfRDu+EO_V6OC6kOr2cB8aecyJRQUYZPDoxbB4Wag@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
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

On Thu, Jun 20, 2019 at 2:30 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Wed, Jun 19, 2019 at 8:18 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Wed, Jun 19, 2019 at 1:14 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Wed, Jun 19, 2019 at 6:24 AM Alistair Francis
> > > <alistair.francis@wdc.com> wrote:
> > > >
> > > > Add OpenSBI version 0.3 as a git submodule and as a prebult binary.
> > > >
> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > ---
> > > >  .gitmodules                         |   3 +++
> > > >  Makefile                            |   3 ++-
> > > >  configure                           |   1 +
> > > >  pc-bios/opensbi-riscv32-fw_jump.elf | Bin 0 -> 197988 bytes
> > > >  pc-bios/opensbi-riscv64-fw_jump.elf | Bin 0 -> 200192 bytes
> > > >  roms/Makefile                       |  17 +++++++++++++++++
> > > >  roms/opensbi                        |   1 +
> > > >  7 files changed, 24 insertions(+), 1 deletion(-)
> > > >  create mode 100644 pc-bios/opensbi-riscv32-fw_jump.elf
> > > >  create mode 100644 pc-bios/opensbi-riscv64-fw_jump.elf
> > > >  create mode 160000 roms/opensbi
> > > >
> > >
> > > The OpenSBI firmwares are platform specific so we should have
> > > machine directory under pc-bios/ directory
> > >
> > > So for virt machine we will have:
> > > pc-bios/riscv32/virt/fw_jump.elf
> > > pc-bios/riscv64/virt/fw_jump.elf
>
> I have updated the names to indicate the machine. The pc-bios directly
> appears to be flat (at least for binaries) so I don't want to add
> subdirectories.
>

Should we include pre-built OpenSBI "bios" for "sifive_u" machine too?

> >
> > And we should only integrate plain binary image for "bios" images here.
> >
> > pc-bios/riscv32/virt/fw_jump.bin
> > pc-bios/riscv64/virt/fw_jump.bin
>
> Yep, fixed.
>

Regards,
Bin

