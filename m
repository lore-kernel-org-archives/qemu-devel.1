Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6FCC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155412075D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZMeyC+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155412075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtySo-0002SW-Ca
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 15:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtyS4-0001zN-MP; Fri, 10 Jul 2020 15:12:52 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:38982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtyS2-0002zy-Vm; Fri, 10 Jul 2020 15:12:52 -0400
Received: by mail-io1-xd41.google.com with SMTP id f23so7157820iof.6;
 Fri, 10 Jul 2020 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kGx407GXaaOt+Zru+KL+o9x5NXja48e/VeMu9EI90kQ=;
 b=DZMeyC+E/rXi5ZIfYlQIAF6tMsYHiu2nMvtMOYxwa/XbtWShMCU9452UBzKC+0Zvyx
 gNhXm37vl8nMMPfDH584GRTatqSoK+ZmOl0DwjrFIKCo2tZ8NbTa3TqBe3/WaEJENi75
 LBo8jTwbUk7wiCkjOgw498dcqhoaVfZu23E4QQbVKfPgLDWEf+0uUdK0YPgUfXV/aCip
 HHYSM5P0K3eEQlh/C/rtqfK8AdYXQp+hTEQ11ndkEOuIa+/gg0HzPrIpeflTLjkKYCdZ
 wqpceCQnLzCpXm9khTjP9igYel6dzCvpIPlP6u6Hk/EzL9T1JDJIV/tv3W0qhNn21Gdg
 CANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kGx407GXaaOt+Zru+KL+o9x5NXja48e/VeMu9EI90kQ=;
 b=RbBgK1Gytq/PqSCgZlBnjWm6n1lh4nZ99C4UhuoPS78Lr2XQshGesOUOxRpHe08733
 5MkkE3TjTACIq9spSfHP/GHEZ6hXUENEgIqnz3XzpFzbwFpIP2QnB6SYKPOUiCT3yAm1
 CvB0aM3/EHjzMtCiq+qX3N0mnzG2xF4Bvi180A+b8QX8gyfO19kK7heuD64lE8CEWuBz
 jBTCLuh0+H5gyKC8nQfUPsw83xLLx3RjUymYIIKI6DYwjoFODCa10ZntPdZaI8jwy24p
 e4RtnmbBqPORHLaMm2n35EVdIeo5EQYGqxQ/yhre00RS9SJfDJluZhcHA5wMjbpBNdcW
 q+uQ==
X-Gm-Message-State: AOAM531p2X7awusb7qHixR+IXSPuY6I5b8WCP8mncPsk0NYOWB+boOOm
 F2pVY/NWd6cSrGuZ1uRewydac3Qt77EvoSwTMYA=
X-Google-Smtp-Source: ABdhPJxBeiaPZM3Mmlsj5mqw4JDgJpl8C2A+mBYlSHXq9AyHhDqofBCe3RNe15mWtZL93Wn+/ZNWU+U1OmdOD4l2iV8=
X-Received: by 2002:a6b:640f:: with SMTP id t15mr28844651iog.175.1594408369517; 
 Fri, 10 Jul 2020 12:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKN9QFwo=EFYOSNvrmkHJfJZmZM+SuuiatEEa64_RteGig@mail.gmail.com>
In-Reply-To: <CAKmqyKN9QFwo=EFYOSNvrmkHJfJZmZM+SuuiatEEa64_RteGig@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jul 2020 12:02:54 -0700
Message-ID: <CAKmqyKPSJP=4Obm22x3JGn3yP+VL+=kBDcdqXniAkmTvo9P4iA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] riscv: Switch to use generic platform fw_dynamic
 type opensbi bios images
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 11:59 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Jul 9, 2020 at 10:05 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > The RISC-V generic platform is a flattened device tree (FDT) based
> > platform where all platform specific functionality is provided based
> > on FDT passed by previous booting stage. The support was added in
> > the upstream OpenSBI v0.8 release recently.
> >
> > This series updates QEMU to switch to use generic platform of opensbi
> > bios images. With the recent fw_dynamic image support, let's replace
> > the fw_jump images with fw_dynamic ones too.
> >
> > The patch emails do not contain binary bits, please grab all updates
> > at https://github.com/lbmeng/qemu.git bios branch.
> >
> > Changes in v4:
> > - Remove old binaries in the Makefile for `make install` bisection
> >
> > Changes in v3:
> > - Change fw_jump to fw_dynamic in the make rules
> > - Change to fw_dynamic.bin for virt & sifive_u
> > - Change to fw_dynamic.elf for Spike
> > - Generate fw_dynamic images in the artifacts
> > - change fw_jump to fw_dynamic in the Makefile
> >
> > Changes in v2:
> > - new patch: configure: Create symbolic links for pc-bios/*.elf files
> > - Upgrade OpenSBI to v0.8 release
> > - Copy the ELF images too in the make rules
> > - Include ELF images in the artifacts
> > - new patch: Makefile: Ship the generic platform bios images for RISC-V
> >
> > Bin Meng (7):
> >   configure: Create symbolic links for pc-bios/*.elf files
> >   roms/opensbi: Upgrade from v0.7 to v0.8
> >   roms/Makefile: Build the generic platform for RISC-V OpenSBI firmware
> >   hw/riscv: Use pre-built bios image of generic platform for virt &
> >     sifive_u
> >   hw/riscv: spike: Change the default bios to use generic platform image
> >   gitlab-ci/opensbi: Update GitLab CI to build generic platform
> >   Makefile: Ship the generic platform bios images for RISC-V
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Whoops, wrong canned response.

Thanks!

Applied to riscv-to-apply.next

Alistair

>
> Alistair
>
> >
> >  .gitlab-ci.d/opensbi.yml                       |  28 ++++++++--------------
> >  Makefile                                       |   4 ++--
> >  configure                                      |   1 +
> >  hw/riscv/sifive_u.c                            |   4 ++--
> >  hw/riscv/spike.c                               |   9 +++++--
> >  hw/riscv/virt.c                                |   4 ++--
> >  pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 0 -> 62144 bytes
> >  pc-bios/opensbi-riscv32-generic-fw_dynamic.elf | Bin 0 -> 558668 bytes
> >  pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin   | Bin 49520 -> 0 bytes
> >  pc-bios/opensbi-riscv32-virt-fw_jump.bin       | Bin 49504 -> 0 bytes
> >  pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 0 -> 70792 bytes
> >  pc-bios/opensbi-riscv64-generic-fw_dynamic.elf | Bin 0 -> 620424 bytes
> >  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin   | Bin 57936 -> 0 bytes
> >  pc-bios/opensbi-riscv64-virt-fw_jump.bin       | Bin 57920 -> 0 bytes
> >  roms/Makefile                                  |  32 ++++++++-----------------
> >  roms/opensbi                                   |   2 +-
> >  16 files changed, 35 insertions(+), 49 deletions(-)
> >  create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
> >  create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
> >  delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
> >  delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
> >  create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
> >  create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf
> >  delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> >  delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
> >
> > --
> > 2.7.4
> >
> >

