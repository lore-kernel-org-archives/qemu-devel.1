Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA73EC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822A921941
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH3DlfDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822A921941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRYh-0003m8-It
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kGRCr-0005wc-B3; Thu, 10 Sep 2020 14:22:02 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:33769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kGRCd-00037R-Q1; Thu, 10 Sep 2020 14:22:00 -0400
Received: by mail-il1-x142.google.com with SMTP id x2so6640556ilm.0;
 Thu, 10 Sep 2020 11:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EDPigblih1cjap7Oi4kVPhbl5AZCj10BtXDekneIKSQ=;
 b=UH3DlfDODyCHmCM0+yL8UILR1TN0nA+CDFWE5X/KUnUZTIfVWQO7K9p1OibfTepqam
 tEM5uSxa8hDrA06QVaxWcr4tPJH5qmQQ75IdZi46Gy2+fMtMWuKjfa4jaP31Gq9WDLwQ
 EgUt9AuFKHB3PNZPYZ5M3pX2VimAbmpuafFV7/WTdWmTh+6PcIp00Q9zTRwcRf+j5cPy
 y6GJ8FwX0g4QJ1r2lKGdcS0QLuDMqUImX+LwYGn8hgRpICVqgFBnass23fbQc4m2sh/r
 xdVvErtTPmRX6LMj+QbsgIA05mxCHw9o1Rgh3Twd7WLRRY3tokuh+4L74/QrQqLiE1BC
 44FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EDPigblih1cjap7Oi4kVPhbl5AZCj10BtXDekneIKSQ=;
 b=ACii+CqCi49rzWy6fi/2hyWci0KA4j+4wBEbWSrF3ZqrRSefSiUbXkhC5ca9voIHGy
 /4Bdpoj/KzXVp5JZk34O1h50PLxjWb2q5rf1Sq8WZreW3FLJaOABPXWZlSFL9tY5aAh8
 JAe/FaeOuG6TzLv/I6D+O2JzOGLbO5T3QMQLhkgxkPKppt2yj0Eg03v7obLYtLljp4VM
 6f03yTfXD2Pec9Lu9/eM5Aksj3NxXb+NiJv9yFCy8zkEtbVuwBpJuEDksKAav80qgyN1
 vDo+btsPNQi1d1nuzEVICmfniiKVm60CpMwCHIZ+Z3HdB09QefA5E3uFS8mdMAd0+ZUR
 AJXQ==
X-Gm-Message-State: AOAM530ixOLfXEGqhn5+OlLTqo7/iFEaQh6ktcirhFKi0DNCuTlVR8Qc
 F8KekmyhbWo9iLsAN0glCQ2YgViTc8fvrwFJlXg=
X-Google-Smtp-Source: ABdhPJyYCz/ZUSBXQcrAX6irGOO9WCvzVftUPng7j3JLK20JyHnooG373q70zAgc/QnFt/cEj7D8mvUpI/7X5mOAvZc=
X-Received: by 2002:a92:c8d1:: with SMTP id c17mr2510027ilq.131.1599762105327; 
 Thu, 10 Sep 2020 11:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200901055822.2721209-1-natechancellor@gmail.com>
 <CAKmqyKNRMmJgmZSPK6wqqNQW41QLHwChPi+1cjqao_x1Q_iryQ@mail.gmail.com>
 <159916712670.15432.11504227918284494914@sif>
In-Reply-To: <159916712670.15432.11504227918284494914@sif>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 10 Sep 2020 11:10:43 -0700
Message-ID: <CAKmqyKMYKiM4Q-geEsNR3Us4vOn_u52omr6h2vcodbsr1hFW2g@mail.gmail.com>
Subject: Re: [PATCH] riscv: sifive_test: Allow 16-bit writes to memory region
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 3, 2020 at 2:05 PM Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>
> Quoting Alistair Francis (2020-09-01 18:59:29)
> > On Mon, Aug 31, 2020 at 10:59 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > When shutting down the machine running a mainline Linux kernel, the
> > > following error happens:
> > >
> > > $ build/riscv64-softmmu/qemu-system-riscv64 -bios default -M virt \
> > >     -display none -initrd rootfs.cpio -kernel Image -m 512m \
> > >     -nodefaults -serial mon:stdio
> > > ...
> > > Requesting system poweroff
> > > [    4.999630] reboot: Power down
> > > sbi_trap_error: hart0: trap handler failed (error -2)
> > > sbi_trap_error: hart0: mcause=0x0000000000000007 mtval=0x0000000000100000
> > > sbi_trap_error: hart0: mepc=0x000000008000d4cc mstatus=0x0000000000001822
> > > sbi_trap_error: hart0: ra=0x000000008000999e sp=0x0000000080015c78
> > > sbi_trap_error: hart0: gp=0xffffffe000e76610 tp=0xffffffe0081b89c0
> > > sbi_trap_error: hart0: s0=0x0000000080015c88 s1=0x0000000000000040
> > > sbi_trap_error: hart0: a0=0x0000000000000000 a1=0x0000000080004024
> > > sbi_trap_error: hart0: a2=0x0000000080004024 a3=0x0000000080004024
> > > sbi_trap_error: hart0: a4=0x0000000000100000 a5=0x0000000000005555
> > > sbi_trap_error: hart0: a6=0x0000000000004024 a7=0x0000000080011158
> > > sbi_trap_error: hart0: s2=0x0000000000000000 s3=0x0000000080016000
> > > sbi_trap_error: hart0: s4=0x0000000000000000 s5=0x0000000000000000
> > > sbi_trap_error: hart0: s6=0x0000000000000001 s7=0x0000000000000000
> > > sbi_trap_error: hart0: s8=0x0000000000000000 s9=0x0000000000000000
> > > sbi_trap_error: hart0: s10=0x0000000000000000 s11=0x0000000000000008
> > > sbi_trap_error: hart0: t0=0x0000000000000000 t1=0x0000000000000000
> > > sbi_trap_error: hart0: t2=0x0000000000000000 t3=0x0000000000000000
> > > sbi_trap_error: hart0: t4=0x0000000000000000 t5=0x0000000000000000
> > > sbi_trap_error: hart0: t6=0x0000000000000000
> > >
> > > The kernel does a 16-bit write when powering off the machine, which
> > > was allowed before commit 5d971f9e67 ("memory: Revert "memory: accept
> > > mismatching sizes in memory_region_access_valid""). Make min_access_size
> > > match reality so that the machine can shut down properly now.
> > >
> > > Cc: qemu-stable@nongnu.org
> > > Fixes: 88a07990fa ("SiFive RISC-V Test Finisher")
> > > Fixes: 5d971f9e67 ("memory: Revert "memory: accept mismatching sizes in memory_region_access_valid"")
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >
> > Thanks!
> >
> > Applied to riscv-to-apply.next
>
> FYI, I'm hoping to pull this patch into the upcoming 5.0.1 stable
> release. The freeze is scheduled for 2020-09-20, I will apply this if it
> hits master before then.

I just sent a PR with this patch. Is this still on track to make it into 5.0.1?

Alistair

>
> >
> > Alistair
> >
> > > ---
> > >
> > > Please let me know if the tags are wrong or inappropriate, this is my
> > > first QEMU patch.
> > >
> > >  hw/riscv/sifive_test.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> > > index 0c78fb2c93..8c70dd69df 100644
> > > --- a/hw/riscv/sifive_test.c
> > > +++ b/hw/riscv/sifive_test.c
> > > @@ -59,7 +59,7 @@ static const MemoryRegionOps sifive_test_ops = {
> > >      .write = sifive_test_write,
> > >      .endianness = DEVICE_NATIVE_ENDIAN,
> > >      .valid = {
> > > -        .min_access_size = 4,
> > > +        .min_access_size = 2,
> > >          .max_access_size = 4
> > >      }
> > >  };
> > >
> > > base-commit: 2f4c51c0f384d7888a04b4815861e6d5fd244d75
> > > --
> > > 2.28.0
> > >
> > >
> >

