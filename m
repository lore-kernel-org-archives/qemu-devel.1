Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA76DC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 06:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8DB12072C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 06:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="g+m67uUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DB12072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCdNN-0001EM-QE
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 02:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anup@brainfault.org>) id 1jCdMT-0000kX-9s
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 01:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1jCdMS-0007mx-1f
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 01:59:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1jCdMR-0007hU-KW
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 01:59:55 -0400
Received: by mail-wm1-x344.google.com with SMTP id 25so8587412wmk.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 22:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p465tcub9AtF403vel847oSX/UQZFTn1XjkxGFY82+k=;
 b=g+m67uUkzjiEcGfM+zf3yEkTVI0c8GAyaiyH5WaB6WiCzGmeF77AjFCcXulYq108Oi
 wSgodk2+1srQRDsJLIcaZQed5960QGoE7nD+ynBoqcPFjPo+cMR1a/4YTpP2lARkJHCu
 AENPMO0b1KyZ1f1bNvKkxena6f4pI1IlZsffJezzZtXTP0pEk5DzPIVZuFUHBUOcGW6q
 BSYLydmQRI0AaNJJqe6Waq0cyO6BuyJcdrpAZbbzI5v1dmEyl5i4cIOBbWAE9kcLiIx7
 xKHRgn/eSBPQCoEe7WMYfn3Eo0egS3y4Ve/IFQKzfl9OZQlZH84vE9MLvkGE0ypfDJ3/
 yF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p465tcub9AtF403vel847oSX/UQZFTn1XjkxGFY82+k=;
 b=hR1qtNfqhj2HRflKdd8m82KfkuxMGHD4tJ83U31Xa+PriMIPpoJTBw4GWK2lVxMmPq
 1vYtl/xESwJ4ImeMRV35/y80CMooXCTQb9vc00GM+hJXw0HNj1fysqMP6rHfOkG+F+T3
 bN1Gw1nB/nhAcmNi/2UIu7C46xtdjy5myfEpdjJGgElmCHk7cY7RmPqS5gmxnISIIbsH
 HqmkeCxpyk3kYOQtXP1dplnxh2UeDarI8PpdywD0fXmD+78PhTQ/gMfp0yIsUUu4cL5R
 jU/iGx+PWLw87Db7hHVM40/Q3yIS85WY0cW1CZ55h4+hIbOYtmksI6ebU9ON6NM4NAi7
 QxpQ==
X-Gm-Message-State: ANhLgQ0mjzfAoJr1B1KgetypFfpJ/JyakrUoTYiUjw1mAKtlitPvAIfL
 pmRQJWoZg25//OCzBaVrZmy6ni2auCtKP7Yr6ceVSQ==
X-Google-Smtp-Source: ADFU+vuQt9NFWcDjNAnjPs/vg14y9i3Uffm3kMCCH640ZKv2hXYyLGYT7TZSUYeeavFORnTqy2Lmr5b6oMGQjBKZVRw=
X-Received: by 2002:a1c:6146:: with SMTP id v67mr9117387wmb.78.1584079193400; 
 Thu, 12 Mar 2020 22:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200313034949.3028-1-jiangyifei@huawei.com>
In-Reply-To: <20200313034949.3028-1-jiangyifei@huawei.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Mar 2020 11:29:41 +0530
Message-ID: <CAAhSdy3-K5rxiJkjBp8iUnDqVZz0hQkNCVactmamsOcVZv3GOQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] Add riscv64 kvm accel support
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: victor.zhangxiaofeng@huawei.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 zhang.zhanghailiang@huawei.com, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anup Patel <anup.patel@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng1@huawei.com,
 Palmer Dabbelt <palmer@dabbelt.com>, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 9:23 AM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> Hi,
>
> This series adds riscv64 kvm support, It is based on riscv_kvm_master
> branch at https://github.com/kvm-riscv/linux.
>
> This series depends on above pending changes which haven't yet been
> accepted, so this QEMU patch series is blocked until that dependency
> has been dealt with, but is worth reviewing anyway.
>
> Several steps to use this:
>
> 1. Build riscv64 emulation
> $ ./configure --target-list=riscv64-softmmu
> $ make -j$(nproc)
>
> 2. Build kernel
> riscv_kvm_master branch at https://github.com/kvm-riscv/linux
>
> 3. Build QEMU VM
> I cross build in riscv toolchain
> $ PKG_CONFIG_LIBDIR=<toolchain pkgconfig path>
> $ export PKG_CONFIG_SYSROOT_DIR=<toolchain sysroot path>
> $ ./configure --target-list=riscv64-softmmu --enable-kvm \
> --cross-prefix=riscv64-linux-gnu- --disable-libiscsi --disable-glusterfs \
> --disable-libusb --disable-usb-redir --audio-drv-list= --disable-opengl \
> --disable-libxml2
>
> 4. Start riscv64 emulation
> $ ./qemu-system-riscv64 -M virt -m 4096M -cpu rv64,x-h=true -nographic \
>         -name guest=riscv-hyp,debug-threads=on \
>         -smp 4 \
>         -kernel ./fw_jump.elf \
>         -device loader,file=./Image,addr=0x80200000 \
>         -drive file=./hyp.img,format=raw,id=hd0 \
>         -device virtio-blk-device,drive=hd0 \
>         -append "root=/dev/vda rw console=ttyS0 earlycon=sbi"
>
> 5. Start kvm-acceled QEMU VM in riscv64 emulation
> $ ./qemu-system-riscv64 -M virt,accel=kvm -m 1024M -cpu host -nographic \
>         -name guest=riscv-guset \
>          -smp 2 \
>         -kernel ./Image \
>         -drive file=./guest.img,format=raw,id=hd0 \
>         -device virtio-blk-device,drive=hd0 \
>         -append "root=/dev/vda rw console=ttyS0 earlycon=sbi"
>
> Yifei Jiang (9):
>   linux-header: Update linux/kvm.h
>   target/riscv: Add target/riscv/kvm.c to place the public kvm interface
>   target/riscv: Implement function kvm_arch_init_vcpu
>   target/riscv: Implement kvm_arch_get_registers
>   target/riscv: Implement kvm_arch_put_registers
>   target/riscv: Support start kernel directly by KVM
>   hw/riscv: PLIC update external interrupt by KVM when kvm enabled
>   target/riscv: Handler KVM_EXIT_RISCV_SBI exit
>   target/riscv: add host riscv64 cpu type
>
>  configure                  |   1 +
>  hw/riscv/sifive_plic.c     |  31 ++-
>  hw/riscv/virt.c            |  15 +-
>  linux-headers/linux/kvm.h  |   8 +
>  target/riscv/Makefile.objs |   1 +
>  target/riscv/cpu.c         |   9 +
>  target/riscv/cpu.h         |   4 +
>  target/riscv/kvm.c         | 513 +++++++++++++++++++++++++++++++++++++
>  target/riscv/kvm_riscv.h   |  25 ++
>  9 files changed, 596 insertions(+), 11 deletions(-)
>  create mode 100644 target/riscv/kvm.c
>  create mode 100644 target/riscv/kvm_riscv.h
>
> --
> 2.19.1
>
>
>

First of all many thanks for doing QEMU KVM support. It wasted
bit of my time because I was already doing it but I am happy to
see the patches on list sooner.

In future, please CC the KVM RISC-V mailing list for all QEMU KVM
RISC-V work. The KVM RISC-V mailing list for related projects
(QEMU, KVMTOOL, libvirt, etc) and not just Linux KVM RISC-V.

Currently, we can only review this patch series and get it in final
shape but it can only be merged in QEMU after Linux KVM RISC-V
patches are merged in Linux kernel.

I will be sending out KVM RISC-V v11 series today. There is
a crucial bug fix related to HIDELEG CSR programing. This
bug fix is required in both QEMU and KVM RISC-V. Palmer has
already accepted QEMU HIDELEG CSR fix. The KVM RISC-V
v11 series will have this fix as well.

Thanks & Regards,
Anup Patel

