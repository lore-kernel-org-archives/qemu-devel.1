Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E7DC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3E9222C3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3yk3blI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3E9222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR18k-0006yz-Ua
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 18:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kR17d-0006D2-Cv; Fri, 09 Oct 2020 18:44:21 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:40035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kR17b-0000MV-EY; Fri, 09 Oct 2020 18:44:21 -0400
Received: by mail-il1-x143.google.com with SMTP id y16so6609782ila.7;
 Fri, 09 Oct 2020 15:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6JlNophxr07QZAYQYDmAIRDy73nN1wG4j7eAmQEPDFY=;
 b=E3yk3blIy1iPfYeIodca52obg3s0HKMKqXbBTQwFKiA2vAeoPmc4HwZM71tch8JtaH
 phX4D03R6fkiWOMOFTghDeoe54N/anr3xYwLo0eLnXFYqHmickbteHQ/AF98wWobp5sd
 CUB1Ra3UHVhzYgZwX5Y8PMC1ssiIQj+/Ac0IQ2lYdkx0XeKpMAk0xx91aYcIlVRCyDts
 sBCjpuYICMnOLin6EA3hEGfX28bksqbdkt7Rv9rHmCS2hV8yOq3tYGe45MFXRnVA3VJS
 ZcvNHx7LAj62uh7UT5eDSvwwoZExsAgM2OU48nX9Ti+k78S/y1+YSycNn7DA7nKhZ99z
 q6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6JlNophxr07QZAYQYDmAIRDy73nN1wG4j7eAmQEPDFY=;
 b=X9zUFo8UmJrk2f/CuOx0hOO+WC1Hz1eAGF3qPLBhsNazdIBre73AugWw0H18ha/Dou
 ptbw8i5PVpZBbBpOhhUPsWS1IGZD8SkoViijcYszZvGQ7M+pSanhRrFildtxAojyEm3U
 qxd/Q/CNayI0bZLtw9v2vY/Xy/xdOUiNAIl8GwCMoBNAbtLxMdISHtT9g0qF6S87xmTO
 VuOgEO7LGgdthAEaDT/lQAqwme4NFhe1E41wHKv5avDoAborInUHnGee8PGrrxD7wxtk
 LbAQ20SPWxoHA0biygwXutZsoB58krMOUwEjBJ9WufLRi+qCVKCUuOmttUvNuWBmOCdd
 RSyg==
X-Gm-Message-State: AOAM533qTzLrq8kPJXyHsbHP6EuXE3LBzTdrrfc6Db5816YrFiLo+SIO
 rifpwmv3mGLxQJhB4gupaJhfU1KBz7fNX+Y9GNk=
X-Google-Smtp-Source: ABdhPJwNRczg//TSUrHknCJtS66SxtZ8jI9sC/03V7Accw020bj8wdNyWYZWShpJy8JgqvrMT3/Se1RYvz0f37ziQb4=
X-Received: by 2002:a05:6e02:49:: with SMTP id
 i9mr12303929ilr.40.1602283457977; 
 Fri, 09 Oct 2020 15:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601652616.git.alistair.francis@wdc.com>
 <CAEUhbmXhFv8m3uFQ8z7XeEcXnTCJLCVokWp5ZQ-C3PDHdXJn1Q@mail.gmail.com>
In-Reply-To: <CAEUhbmXhFv8m3uFQ8z7XeEcXnTCJLCVokWp5ZQ-C3PDHdXJn1Q@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 9 Oct 2020 15:32:44 -0700
Message-ID: <CAKmqyKPSkso+81kxXMBkJXu9stUTTLb+iH+3=07X+nOYWWi73w@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Allow loading a no MMU kernel
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
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
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 9, 2020 at 2:53 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Fri, Oct 2, 2020 at 11:50 PM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > This series allows loading a noMMU kernel using the -kernel option.
> > Currently if using -kernel QEMU assumes you also have firmware and loads
> > the kernel at a hardcoded offset. This series changes that so we only
> > load the kernel at an offset if a firmware (-bios) was loaded.
> >
> > This series also adds a function to check if the CPU is 32-bit. This is
> > a step towards running 32-bit and 64-bit CPUs on the 64-bit RISC-V build
> > by using run time checks instead of compile time checks. We also allow
> > the user to sepcify a CPU for the sifive_u machine.
>
> Could you please provide test scenarios for this series? I want to
> have a try. Thanks.

Yep.

Build a noMMU kernel (you need the latest master commit a78c6f5956a9):
$ CROSS_COMPILE=riscv64-elf- ARCH=riscv make nommu_virt_defconfig
$ CROSS_COMPILE=riscv64-elf- ARCH=riscv make -j

Build a noMMU RISC-V userspace
$ git clonehttps://github.com/damien-lemoal/buildroot.git
$ make kendryte_k210_defconfig
$ make

Run QEMU:
./build/riscv64-softmmu/qemu-system-riscv64 -machine virt -m 64M \
-cpu rv64,mmu=false \
-serial mon:stdio -serial null -nographic \
-append "root=/dev/vda rw highres=off  console=ttyS0 mem=1G ip=dhcp
earlycon=sbi" \
-device virtio-net-device,netdev=net0,mac=52:54:00:12:34:02 -netdev
user,id=net0 \
-object rng-random,filename=/dev/urandom,id=rng0 -device
virtio-rng-device,rng=rng0 \
-smp 1 -d guest_errors \
-kernel ./Image \
-drive id=disk0,file=./nommu-rootfs.ext2,if=none,format=raw -device
virtio-blk-device,drive=disk0 -bios none

Alistair

>
> >
> > Alistair Francis (4):
> >   hw/riscv: sifive_u: Allow specifying the CPU
> >   hw/riscv: Return the end address of the loaded firmware
> >   hw/riscv: Add a riscv_is_32_bit() function
> >   hw/riscv: Load the kernel after the firmware
> >
> >  include/hw/riscv/boot.h     | 11 +++++----
> >  include/hw/riscv/sifive_u.h |  1 +
> >  hw/riscv/boot.c             | 47 ++++++++++++++++++++++++-------------
> >  hw/riscv/opentitan.c        |  3 ++-
> >  hw/riscv/sifive_e.c         |  3 ++-
> >  hw/riscv/sifive_u.c         | 31 ++++++++++++++++++------
> >  hw/riscv/spike.c            | 14 ++++++++---
> >  hw/riscv/virt.c             | 14 ++++++++---
> >  8 files changed, 89 insertions(+), 35 deletions(-)
>
> Regards,
> Bin

